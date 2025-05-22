package com.satvik.satchat.service;

import com.satvik.satchat.common.ErrorCode;
import com.satvik.satchat.common.PageResponse;
import com.satvik.satchat.dto.OrderFilter;
import com.satvik.satchat.entity.Ecommerce.*;
import com.satvik.satchat.entity.UserEntity;
import com.satvik.satchat.handler.AppException;
import com.satvik.satchat.mapper.GhnResponseMapper;
import com.satvik.satchat.mapper.OrderMapper;
import com.satvik.satchat.mapper.UserMapper;
import com.satvik.satchat.model.Enum.OrderStatus;
import com.satvik.satchat.model.Enum.PaymentMethod;
import com.satvik.satchat.model.Enum.PaymentStatus;
import com.satvik.satchat.model.Enum.ShippingStatus;
import com.satvik.satchat.payload.order.ghn.ShippingOrder;
import com.satvik.satchat.payload.order.request.CreateOrderRequest;
import com.satvik.satchat.payload.order.response.OrderResponse;
import com.satvik.satchat.payload.user.UserProfileResponse;
import com.satvik.satchat.repository.*;
import com.satvik.satchat.utils.JsonHelper;
import jakarta.transaction.Transactional;
import java.math.BigDecimal;
import java.time.Instant;
import java.util.List;
import java.util.UUID;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

@Service
public class OrderService {
  private final GHNService ghnService;
  private final VNPayService vnPayService;
  private final OrderRepository orderRepository;
  private final UserRepository userRepository;
  private final ProductRepository productRepository;
  private final PaymentRepository paymentRepository;
  private final LineItemRepository lineItemRepository;
  private final UserMapper userMapper;
  private final OrderMapper orderMapper;

  public OrderService(
      GHNService ghnService,
      VNPayService vnPayService,
      OrderRepository orderRepository,
      UserRepository userRepository,
      ProductRepository productRepository,
      PaymentRepository paymentRepository,
      LineItemRepository lineItemRepository,
      UserMapper userMapper,
      OrderMapper orderMapper) {
    this.ghnService = ghnService;
    this.vnPayService = vnPayService;
    this.orderRepository = orderRepository;
    this.userRepository = userRepository;
    this.productRepository = productRepository;
    this.paymentRepository = paymentRepository;
    this.lineItemRepository = lineItemRepository;
    this.userMapper = userMapper;
    this.orderMapper = orderMapper;
  }

  @Transactional
  public String createOrder(CreateOrderRequest req) throws Exception {
    // Customer checking
    UserEntity customer =
        userRepository
            .findById(req.getCustomerId())
            .orElseThrow(() -> new AppException(ErrorCode.USER_NOT_EXISTED));

    BigDecimal shippingFee = req.getShippingInfo().getShippingFee();
    OrderEntity order =
        OrderEntity.builder()
            .id(UUID.randomUUID())
            .customer(customer)
            .shippingInfo(
                ShippingInfo.builder()
                    .receiverName(req.getShippingInfo().getReceiverName())
                    .receiverPhone(req.getShippingInfo().getReceiverPhone())
                    .address(req.getShippingInfo().getAddress())
                    .wardCode(req.getShippingInfo().getWardCode())
                    .districtId(req.getShippingInfo().getDistrictId())
                    .serviceId(req.getShippingInfo().getServiceId())
                    .serviceTypeId(req.getShippingInfo().getServiceTypeId())
                    .weight(req.getShippingInfo().getWeight())
                    .build())
            .totalAmount(BigDecimal.ZERO)
            .shippingFee(shippingFee)
            .build();

    // Items
    List<LineItemEntity> items =
        req.getItems().stream()
            .map(
                item -> {
                  ProductEntity product =
                      productRepository
                          .findById(item.getProductId())
                          .orElseThrow(() -> new AppException(ErrorCode.PRODUCT_NOT_FOUND));
                  return LineItemEntity.builder()
                      .id(UUID.randomUUID())
                      .order(order)
                      .product(product)
                      .quantity(item.getQuantity())
                      .price(item.getPrice())
                      .total(item.getPrice().multiply(BigDecimal.valueOf(item.getQuantity())))
                      .build();
                })
            .toList();
    lineItemRepository.saveAll(items);

    // Payment
    BigDecimal totalAmount =
        items.stream().map(LineItemEntity::getTotal).reduce(BigDecimal.ZERO, BigDecimal::add);

    order.setTotalAmount(totalAmount);
    PaymentEntity payment =
        PaymentEntity.builder()
            .id(UUID.randomUUID())
            .method(req.getPayment().getMethod())
            .order(order)
            // transactionId: VNPay transactionId
            .amountPaid(new BigDecimal(req.getPayment().getAmountPaid()))
            .build();

    paymentRepository.save(payment);
    order.setPayment(payment);
    orderRepository.save(order);

    // Payment & giaohangnhanh
    String paymentMethod = String.valueOf(req.getPayment().getMethod());
    String orderId = String.valueOf(order.getId());
    ShippingOrder shipping = GhnResponseMapper.toShippingOrder(req.getShippingInfo(), items);

    // Call to GHN API
    Object jsonResponse = ghnService.createOrder(shipping);
    String orderCode = JsonHelper.extractValue(String.valueOf(jsonResponse), "order_code");
    String expected_delivery_time =
        JsonHelper.extractValue(String.valueOf(jsonResponse), "expected_delivery_time");

    order.setOrderCode(orderCode);
    order.getShippingInfo().setEstimatedDeliveryDate(Instant.parse(expected_delivery_time));
    order.getShippingInfo().setGhnOrderCode(orderCode);
    orderRepository.save(order);

    switch (paymentMethod) {
      case "VNPAY" -> {
        // return url to VNPay
        int amountPaid = req.getPayment().getAmountPaid();
        String baseUrl = "http://localhost:8280";
        return vnPayService.createOrder(amountPaid, orderId, baseUrl);
      }
      case "COD" -> {
        return orderId;
      }
      default -> {
        return null;
      }
    }
  }

  public PageResponse<OrderResponse> getOrders(int page, int size, OrderFilter orderFilter) {
    if (page < 0 || size < 0) {
      throw new AppException(ErrorCode.INVALID_PAGINATION_PARAMS);
    }

    Sort sort = Sort.by("createdAt").descending();
    Pageable pageable = PageRequest.of(page - 1, size, sort);
    var orders = orderRepository.findAllOrders(pageable, orderFilter);

    // response modify
    List<OrderResponse> responseList =
        orders.getContent().stream()
            .map(
                order ->
                    OrderResponse.builder()
                        .id(order.getId())
                        .orderCode(order.getOrderCode())
                        .status(order.getStatus())
                        .totalAmount(order.getTotalAmount())
                        .shippingFee(order.getShippingFee())
                        .customer(userMapper.map(order.getCustomer(), UserProfileResponse.class))
                        .items(
                            order.getItems().stream()
                                .map(item -> orderMapper.toItemsResponse(item))
                                .toList())
                        .shippingInfo(order.getShippingInfo())
                        .payment(order.getPayment())
                        .createdAt(order.getCreatedAt().toString())
                        .updatedAt(order.getUpdatedAt().toString())
                        .build())
            .toList();

    return PageResponse.<OrderResponse>builder()
        .currentPage(page)
        .pageSize(orders.getSize())
        .totalPages(orders.getTotalPages())
        .totalElements(orders.getTotalElements())
        .data(responseList)
        .build();
  }

  // update Payment VNPay: transactionId; PaymentStatus;
  public OrderEntity updatePayment(UUID orderId, String transactionId, PaymentStatus status) {
    OrderEntity order =
        orderRepository
            .findById(orderId)
            .orElseThrow(() -> new AppException(ErrorCode.ORDER_NOT_FOUND));
    PaymentEntity payment = order.getPayment();
    payment.setTransactionId(transactionId);
    payment.setStatus(status);
    paymentRepository.save(payment);
    return order;
  }

  // update Order: OrderStatus
  public OrderEntity updateShippingInfo(UUID orderId, ShippingStatus shippingStatus) {
    OrderEntity order =
        orderRepository
            .findById(orderId)
            .orElseThrow(() -> new AppException(ErrorCode.ORDER_NOT_FOUND));

    order.getShippingInfo().setShippingStatus(shippingStatus);
    OrderStatus newOrderStatus = mapShippingStatusToOrderStatus(shippingStatus);
    if (newOrderStatus != null) {
      order.setStatus(newOrderStatus);

      // nếu success cập nhật payment status
      if (shippingStatus == ShippingStatus.DELIVERED
          && order.getPayment().getMethod().equals(PaymentMethod.COD)) {
        order.getPayment().setStatus(PaymentStatus.SUCCESS);
        this.updatePayment(orderId, order.getPayment().getTransactionId(), PaymentStatus.SUCCESS);
      }
    }

    orderRepository.save(order);
    return order;
  }

  // Hàm mapping ShippingStatus -> OrderStatus
  private OrderStatus mapShippingStatusToOrderStatus(ShippingStatus shippingStatus) {
    switch (shippingStatus) {
      case PENDING:
        return OrderStatus.PENDING;
      case PICKED_UP:
      case IN_TRANSIT:
        return OrderStatus.SHIPPED;
      case DELIVERED:
        return OrderStatus.DELIVERED;
      case FAILED:
        return OrderStatus.FAILED;
      default:
        return null;
    }
  }

  public OrderEntity getOrderById(UUID orderId) {
    return orderRepository
        .findById(orderId)
        .orElseThrow(() -> new AppException(ErrorCode.ORDER_NOT_FOUND));
  }
}
