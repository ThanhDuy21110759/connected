--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2 (Debian 17.2-1.pgdg120+1)
-- Dumped by pg_dump version 17.0

-- Started on 2025-04-21 15:31:03

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 3601 (class 1262 OID 33522)
-- Name: satchat; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE satchat WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE satchat OWNER TO postgres;

\connect satchat

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 3602 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 244 (class 1259 OID 237699)
-- Name: address; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.address (
    id uuid NOT NULL,
    created_at timestamp(6) with time zone,
    updated_at timestamp(6) with time zone,
    address character varying(255),
    district_id integer NOT NULL,
    district_name character varying(255),
    is_default boolean,
    phone character varying(255),
    province_id integer NOT NULL,
    province_name character varying(255),
    ward_code character varying(255),
    ward_name character varying(255),
    user_id uuid NOT NULL
);


ALTER TABLE public.address OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 196843)
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id uuid NOT NULL,
    created_at timestamp(6) with time zone,
    updated_at timestamp(6) with time zone,
    description character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 131293)
-- Name: comment_liked; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comment_liked (
    id uuid NOT NULL,
    created_at timestamp(6) with time zone,
    updated_at timestamp(6) with time zone,
    author uuid NOT NULL,
    comment uuid NOT NULL
);


ALTER TABLE public.comment_liked OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 131275)
-- Name: comments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comments (
    id uuid NOT NULL,
    created_at timestamp(6) with time zone,
    updated_at timestamp(6) with time zone,
    content text NOT NULL,
    liked_count integer,
    status smallint,
    author uuid NOT NULL,
    post uuid NOT NULL,
    CONSTRAINT comments_status_check CHECK (((status >= 0) AND (status <= 4)))
);


ALTER TABLE public.comments OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 57520)
-- Name: conversation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conversation (
    id uuid NOT NULL,
    content text,
    conv_id text,
    delivery_status text,
    from_user uuid,
    last_modified timestamp(6) without time zone,
    "time" timestamp(6) without time zone,
    to_user uuid
);


ALTER TABLE public.conversation OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 65660)
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 65665)
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 155791)
-- Name: file; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.file (
    id uuid NOT NULL,
    created_at timestamp(6) with time zone,
    updated_at timestamp(6) with time zone,
    content_type character varying(255) NOT NULL,
    file_size bigint NOT NULL,
    filename character varying(255) NOT NULL,
    author uuid NOT NULL,
    status character varying(255),
    CONSTRAINT file_status_check CHECK (((status)::text = ANY ((ARRAY['ACTIVE'::character varying, 'DELETED'::character varying])::text[])))
);


ALTER TABLE public.file OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 131308)
-- Name: follow; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.follow (
    id uuid NOT NULL,
    created_at timestamp(6) with time zone,
    updated_at timestamp(6) with time zone,
    follower uuid NOT NULL,
    following uuid NOT NULL
);


ALTER TABLE public.follow OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 139404)
-- Name: friend; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.friend (
    id uuid NOT NULL,
    created_at timestamp(6) with time zone,
    updated_at timestamp(6) with time zone,
    status character varying(255) NOT NULL,
    receiver uuid NOT NULL,
    requester uuid NOT NULL,
    CONSTRAINT friend_status_check CHECK (((status)::text = ANY ((ARRAY['PENDING'::character varying, 'ACCEPTED'::character varying, 'REJECTED'::character varying, 'BLOCKED'::character varying])::text[])))
);


ALTER TABLE public.friend OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 213130)
-- Name: line_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.line_items (
    id uuid NOT NULL,
    created_at timestamp(6) with time zone,
    updated_at timestamp(6) with time zone,
    price numeric(38,2),
    quantity integer,
    total numeric(38,2),
    order_id uuid NOT NULL,
    product_id uuid NOT NULL
);


ALTER TABLE public.line_items OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 147580)
-- Name: notification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notification (
    id uuid NOT NULL,
    created_at timestamp(6) with time zone,
    updated_at timestamp(6) with time zone,
    content character varying(255) NOT NULL,
    is_read boolean NOT NULL,
    is_sent boolean NOT NULL,
    message_type character varying(255) NOT NULL,
    actor uuid NOT NULL,
    receiver uuid NOT NULL,
    CONSTRAINT notification_message_type_check CHECK (((message_type)::text = ANY ((ARRAY['CHAT'::character varying, 'UNSEEN'::character varying, 'FRIEND_ONLINE'::character varying, 'FRIEND_OFFLINE'::character varying, 'MESSAGE_DELIVERY_UPDATE'::character varying, 'LIKE_POST'::character varying, 'LIKE_COUNT'::character varying, 'POST_COUNT'::character varying, 'COMMENT_POST'::character varying, 'COMMENT_POST_COUNT'::character varying, 'COMMENT_LIKED'::character varying, 'COMMENT_LIKED_COUNT'::character varying, 'FOLLOW_USER'::character varying, 'FOLLOW_COUNT'::character varying, 'FRIEND_COUNT'::character varying, 'FRIEND_REQUEST'::character varying, 'FRIEND_REQUEST_ACCEPTED'::character varying])::text[])))
);


ALTER TABLE public.notification OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 204931)
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id uuid NOT NULL,
    created_at timestamp(6) with time zone,
    updated_at timestamp(6) with time zone,
    order_code character varying(255),
    shipping_fee numeric(38,2),
    address character varying(255),
    district_id integer,
    estimated_delivery_date timestamp(6) with time zone,
    ghn_order_code character varying(255),
    receiver_name character varying(255),
    receiver_phone character varying(255),
    shipping_status character varying(255),
    ward_code character varying(255),
    status character varying(255),
    total_amount numeric(38,2),
    customer uuid NOT NULL,
    service_id character varying(255),
    service_type_id character varying(255),
    weight character varying(255),
    CONSTRAINT orders_shipping_status_check CHECK (((shipping_status)::text = ANY ((ARRAY['PENDING'::character varying, 'PICKED_UP'::character varying, 'IN_TRANSIT'::character varying, 'DELIVERED'::character varying, 'FAILED'::character varying])::text[]))),
    CONSTRAINT orders_status_check CHECK (((status)::text = ANY ((ARRAY['PENDING'::character varying, 'SHIPPED'::character varying, 'DELIVERED'::character varying, 'FAILED'::character varying, 'CANCELLED'::character varying])::text[])))
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 204940)
-- Name: payment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment (
    id uuid NOT NULL,
    created_at timestamp(6) with time zone,
    updated_at timestamp(6) with time zone,
    amount_paid numeric(38,2),
    method character varying(255),
    status character varying(255),
    transaction_id character varying(255),
    order_id uuid NOT NULL,
    CONSTRAINT payment_method_check CHECK (((method)::text = ANY ((ARRAY['PAYPAL'::character varying, 'VNPAY'::character varying, 'COD'::character varying])::text[]))),
    CONSTRAINT payment_status_check CHECK (((status)::text = ANY ((ARRAY['PENDING'::character varying, 'SUCCESS'::character varying, 'FAILED'::character varying])::text[])))
);


ALTER TABLE public.payment OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 90308)
-- Name: post; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.post (
    id uuid NOT NULL,
    created_at timestamp(6) with time zone,
    updated_at timestamp(6) with time zone,
    comment_count integer,
    content text NOT NULL,
    images text,
    liked_count integer,
    status smallint,
    type smallint,
    author uuid NOT NULL,
    topic uuid NOT NULL,
    post_status smallint,
    CONSTRAINT post_post_status_check CHECK (((post_status >= 0) AND (post_status <= 1))),
    CONSTRAINT post_status_check CHECK (((status >= 0) AND (status <= 1))),
    CONSTRAINT post_type_check CHECK (((type >= 0) AND (type <= 1)))
);


ALTER TABLE public.post OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 163971)
-- Name: post_images; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.post_images (
    post_entity_id uuid NOT NULL,
    images_id uuid NOT NULL
);


ALTER TABLE public.post_images OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 131202)
-- Name: post_liked; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.post_liked (
    id uuid NOT NULL,
    created_at timestamp(6) with time zone,
    updated_at timestamp(6) with time zone,
    author uuid NOT NULL,
    post uuid NOT NULL
);


ALTER TABLE public.post_liked OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 131207)
-- Name: post_saved; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.post_saved (
    id uuid NOT NULL,
    created_at timestamp(6) with time zone,
    updated_at timestamp(6) with time zone,
    author uuid NOT NULL,
    post uuid NOT NULL
);


ALTER TABLE public.post_saved OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 221315)
-- Name: product_comment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_comment (
    id uuid NOT NULL,
    created_at timestamp(6) with time zone,
    updated_at timestamp(6) with time zone,
    author character varying(255) NOT NULL,
    comment text NOT NULL,
    product uuid NOT NULL,
    rating integer NOT NULL
);


ALTER TABLE public.product_comment OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 221322)
-- Name: product_liked; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_liked (
    id uuid NOT NULL,
    created_at timestamp(6) with time zone,
    updated_at timestamp(6) with time zone,
    author uuid NOT NULL,
    product uuid NOT NULL
);


ALTER TABLE public.product_liked OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 221418)
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id uuid NOT NULL,
    created_at timestamp(6) with time zone,
    updated_at timestamp(6) with time zone,
    currency smallint NOT NULL,
    description character varying(255),
    height numeric(38,2),
    is_deleted boolean NOT NULL,
    is_liked boolean NOT NULL,
    length numeric(38,2),
    name character varying(255) NOT NULL,
    price numeric(38,2),
    rating numeric(38,2) NOT NULL,
    sales_count integer NOT NULL,
    stock_quantity integer NOT NULL,
    visible boolean NOT NULL,
    weight numeric(38,2) NOT NULL,
    width numeric(38,2),
    category uuid,
    CONSTRAINT products_currency_check CHECK (((currency >= 0) AND (currency <= 11)))
);


ALTER TABLE public.products OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 221426)
-- Name: products_images; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products_images (
    product_entity_id uuid NOT NULL,
    images_id uuid NOT NULL
);


ALTER TABLE public.products_images OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 57535)
-- Name: refreshtoken; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.refreshtoken (
    id bigint NOT NULL,
    expiry_date timestamp(6) with time zone NOT NULL,
    token character varying(255) NOT NULL,
    user_id uuid
);


ALTER TABLE public.refreshtoken OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 57555)
-- Name: refreshtoken_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.refreshtoken_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.refreshtoken_seq OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 57540)
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id uuid NOT NULL,
    name character varying(20),
    CONSTRAINT roles_name_check CHECK (((name)::text = ANY ((ARRAY['ROLE_USER'::character varying, 'ROLE_ADMIN'::character varying])::text[])))
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 82058)
-- Name: topic; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.topic (
    id uuid NOT NULL,
    created_at timestamp(6) with time zone,
    updated_at timestamp(6) with time zone,
    color text,
    name text,
    post_count integer
);


ALTER TABLE public.topic OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 57546)
-- Name: user_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_roles (
    user_id uuid NOT NULL,
    role_id uuid NOT NULL
);


ALTER TABLE public.user_roles OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 57527)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id uuid NOT NULL,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    avatar character varying(255),
    bio character varying(255),
    cover character varying(255),
    email character varying(255),
    first_name character varying(255),
    follower_count integer,
    last_name character varying(255),
    password character varying(255),
    post_count integer,
    status smallint,
    username character varying(100),
    website_url character varying(255),
    friends_count integer,
    CONSTRAINT users_status_check CHECK (((status >= 0) AND (status <= 3)))
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 3595 (class 0 OID 237699)
-- Dependencies: 244
-- Data for Name: address; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.address VALUES ('1335f8f9-eb79-4d0a-8ba1-6a1b489836eb', '2025-04-15 08:51:59.329391+00', '2025-04-16 07:00:28.16068+00', '699, tổ 17, Mỹ Phó, Mỹ Đức, Châu Phú, AG', 1758, 'Huyện Châu Phú', true, '0364484261', 217, 'An Giang', '510809', 'Xã Mỹ Đức', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');


--
-- TOC entry 3587 (class 0 OID 196843)
-- Dependencies: 236
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.categories VALUES ('78676b4c-a55e-45b6-af3e-225aac73876f', '2025-04-04 16:38:43.417635+00', '2025-04-04 16:38:43.417635+00', 'Latest gadgets, devices, and consumer electronics including smartphones, laptops, and accessories.', 'Electronics');
INSERT INTO public.categories VALUES ('939d5dcc-faad-4263-b761-ac63e3cccf6b', '2025-04-12 02:35:32.83668+00', '2025-04-12 02:35:32.83668+00', 'Trendy clothing, shoes, and accessories for men, women, and children.', 'Fashion');
INSERT INTO public.categories VALUES ('9851ad84-d39b-40bd-922e-c046c0cf71e3', '2025-04-12 02:35:49.659009+00', '2025-04-12 02:35:49.659009+00', 'Skincare, cosmetics, personal care products, and wellness items.', 'Health & Beauty');
INSERT INTO public.categories VALUES ('87f7c1bc-4bda-4e2b-9faa-b3dc6abd0e8c', '2025-04-12 02:35:57.659317+00', '2025-04-12 02:35:57.659317+00', 'Furniture, appliances, kitchenware, and home decor essentials.', 'Home & Kitchen');


--
-- TOC entry 3581 (class 0 OID 131293)
-- Dependencies: 230
-- Data for Name: comment_liked; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.comment_liked VALUES ('8b459a04-e89a-4cf4-b35b-d8c795f6b0d1', '2025-03-26 17:14:41.145156+00', '2025-03-26 17:14:41.145156+00', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '938045e7-b609-485d-8b08-b4813d7c68d6');
INSERT INTO public.comment_liked VALUES ('a802e574-0e55-4196-8561-8ffbee0c157b', '2025-03-26 17:15:57.44255+00', '2025-03-26 17:15:57.44255+00', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '86c03127-3f2e-446f-b7b4-154b31274e9e');
INSERT INTO public.comment_liked VALUES ('63e5a003-0d8a-4b23-9498-7bc9c3292c94', '2025-03-27 09:25:10.129521+00', '2025-03-27 09:25:10.129521+00', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '43800b4f-2460-401f-b66a-13f26eb44492');
INSERT INTO public.comment_liked VALUES ('7652eaf7-2f89-49c8-94bc-c0c2ffe7cf7f', '2025-03-27 17:19:00.358272+00', '2025-03-27 17:19:00.358272+00', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '788f275a-2fc3-45af-bc02-f8f26655af96');
INSERT INTO public.comment_liked VALUES ('00ed4ecf-62fd-4886-b923-74e3a9d9229f', '2025-03-27 17:19:24.486032+00', '2025-03-27 17:19:24.486032+00', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '76bfd177-ded3-4903-92fb-37ce9508aa65');
INSERT INTO public.comment_liked VALUES ('ab02b260-346b-4fb9-9e68-0fcf3f199bff', '2025-04-01 15:37:17.394352+00', '2025-04-01 15:37:17.394352+00', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '9143ef88-2ab0-4c3d-bcce-ca2a90ff544a');
INSERT INTO public.comment_liked VALUES ('d8c9a01b-9f77-4842-8f98-54a54bce3146', '2025-04-01 15:38:52.101149+00', '2025-04-01 15:38:52.101149+00', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'f125c196-535a-4819-ab09-8f24aac18cf4');
INSERT INTO public.comment_liked VALUES ('5d78126a-ed93-4ae8-9b14-c6cceeff49e5', '2025-04-01 17:21:02.727819+00', '2025-04-01 17:21:02.727819+00', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '884c05f9-e8ae-4117-8fce-ed75743ba24f');
INSERT INTO public.comment_liked VALUES ('d6aba117-c7ac-477a-ae2f-1499a2cb0ce7', '2025-04-01 17:21:21.744105+00', '2025-04-01 17:21:21.744105+00', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '884c05f9-e8ae-4117-8fce-ed75743ba24f');
INSERT INTO public.comment_liked VALUES ('6fea94b2-b8c1-4884-92b3-e4d8d64ad145', '2025-04-12 03:12:03.054626+00', '2025-04-12 03:12:03.054626+00', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '937f9213-e71e-4d29-9cfb-402246e7339f');


--
-- TOC entry 3580 (class 0 OID 131275)
-- Dependencies: 229
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.comments VALUES ('2d94c863-4d9e-4d98-9ffc-c9062db37463', '2025-03-26 16:20:56.002482+00', '2025-03-27 03:49:55.667248+00', 'Hello world', 0, 3, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '64e572b0-e642-43da-942c-ad396362b992');
INSERT INTO public.comments VALUES ('76e505f1-7773-4144-8c35-e43a96b6240f', '2025-03-27 04:16:34.913937+00', '2025-03-27 04:16:36.223559+00', 'test del comment', 0, 3, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '64e572b0-e642-43da-942c-ad396362b992');
INSERT INTO public.comments VALUES ('cbff8d30-a668-4dc5-b675-b40f2ef77515', '2025-03-27 04:16:59.990973+00', '2025-03-27 04:17:09.050116+00', 'test del', 0, 3, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '64e572b0-e642-43da-942c-ad396362b992');
INSERT INTO public.comments VALUES ('f125c196-535a-4819-ab09-8f24aac18cf4', '2025-03-28 12:08:23.092754+00', '2025-03-28 12:08:23.092754+00', 'chủ tọa LowG tới chơi...', 1, 1, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '16fb0ef3-7b9f-4868-9ea0-eaa98bda0130');
INSERT INTO public.comments VALUES ('49203166-0dda-49ee-901c-ca3e3145df63', '2025-03-27 09:11:06.884442+00', '2025-03-27 09:11:12.629242+00', 'test xóa post nè', 0, 3, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '64e572b0-e642-43da-942c-ad396362b992');
INSERT INTO public.comments VALUES ('778713a7-5e27-4c15-8a83-e5e205e7b00b', '2025-03-27 09:14:49.497827+00', '2025-03-27 09:14:55.309797+00', 'test lại comment', 0, 3, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '64e572b0-e642-43da-942c-ad396362b992');
INSERT INTO public.comments VALUES ('aca64ed7-957e-4115-b33c-2d17230a945a', '2025-03-27 09:18:22.698756+00', '2025-03-27 09:18:28.891306+00', 'test lại nè', 0, 3, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '64e572b0-e642-43da-942c-ad396362b992');
INSERT INTO public.comments VALUES ('4352064f-65be-4dcc-9ba5-99e29e4474b7', '2025-03-27 09:19:01.041953+00', '2025-03-27 09:19:03.842842+00', 'aaa', 0, 3, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '64e572b0-e642-43da-942c-ad396362b992');
INSERT INTO public.comments VALUES ('7e1cc7f5-0ba2-49e1-9069-d5970819011d', '2025-03-27 09:19:13.504589+00', '2025-03-27 09:19:14.757884+00', '111', 0, 3, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '64e572b0-e642-43da-942c-ad396362b992');
INSERT INTO public.comments VALUES ('43800b4f-2460-401f-b66a-13f26eb44492', '2025-03-26 17:14:37.444739+00', '2025-03-26 17:14:37.444739+00', 'Convert AuthContext & SocketContext sang Redux-Saga.', 1, 1, 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '64e572b0-e642-43da-942c-ad396362b992');
INSERT INTO public.comments VALUES ('884c05f9-e8ae-4117-8fce-ed75743ba24f', '2025-04-01 17:21:00.345302+00', '2025-04-01 17:21:00.345302+00', 'Test done trending post', 2, 1, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '4b4c7689-f154-4898-9398-28a164d9eeef');
INSERT INTO public.comments VALUES ('fb23727b-9aab-4206-ad16-bdeae6ee76d5', '2025-04-02 03:20:14.914124+00', '2025-04-02 03:22:23.021366+00', 'Hello world', 0, 3, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '16fb0ef3-7b9f-4868-9ea0-eaa98bda0130');
INSERT INTO public.comments VALUES ('788f275a-2fc3-45af-bc02-f8f26655af96', '2025-03-27 15:34:21.705214+00', '2025-03-27 17:19:01.965353+00', 'Hoàn thành Image Cover cho bài viết mới nhất', 1, 3, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '19cb14f2-cf63-40e3-bc0d-60e405abb64f');
INSERT INTO public.comments VALUES ('76bfd177-ded3-4903-92fb-37ce9508aa65', '2025-03-27 17:19:22.518788+00', '2025-03-27 17:19:28.17878+00', 'test xóa comment khi liked.', 1, 3, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '19cb14f2-cf63-40e3-bc0d-60e405abb64f');
INSERT INTO public.comments VALUES ('fa6b624c-59b5-4537-9e65-368c12427795', '2025-03-28 10:33:41.293272+00', '2025-03-28 10:33:41.293272+00', 'Hello world.', 0, 1, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '19cb14f2-cf63-40e3-bc0d-60e405abb64f');
INSERT INTO public.comments VALUES ('4c80164a-1f83-47fd-8454-dad7ec4a2d6a', '2025-03-26 16:06:54.047661+00', '2025-03-26 17:09:29.242216+00', 'Test lại comment features', 0, 3, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '64e572b0-e642-43da-942c-ad396362b992');
INSERT INTO public.comments VALUES ('938045e7-b609-485d-8b08-b4813d7c68d6', '2025-03-26 17:13:31.702262+00', '2025-03-26 17:13:31.702262+00', 'Hoàn thành fetch cơ bản post comment.', 1, 1, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '64e572b0-e642-43da-942c-ad396362b992');
INSERT INTO public.comments VALUES ('664e77e2-d561-420c-a707-b4fb14789568', '2025-03-28 13:07:11.351695+00', '2025-03-28 13:14:29.655852+00', 'Test lại comment nè', 0, 3, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '16fb0ef3-7b9f-4868-9ea0-eaa98bda0130');
INSERT INTO public.comments VALUES ('86c03127-3f2e-446f-b7b4-154b31274e9e', '2025-03-26 17:15:41.42462+00', '2025-03-26 17:16:53.483132+00', 'test delete comment', 1, 3, 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '64e572b0-e642-43da-942c-ad396362b992');
INSERT INTO public.comments VALUES ('59dd2108-100f-40ee-b155-0c56429304f3', '2025-03-28 12:09:49.787565+00', '2025-03-28 13:15:03.845019+00', 'Hello chủ tọa nhaaa :)))', 0, 3, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '16fb0ef3-7b9f-4868-9ea0-eaa98bda0130');
INSERT INTO public.comments VALUES ('41c84428-f683-4cdd-b57f-a00bad3779b6', '2025-04-12 03:10:42.968198+00', '2025-04-12 03:10:42.968198+00', 'Lâu rồi không thấy ah làm concert', 0, 1, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '16fb0ef3-7b9f-4868-9ea0-eaa98bda0130');
INSERT INTO public.comments VALUES ('6bccc7ab-cec4-4d68-bb85-9fc1ad0f3a05', '2025-03-29 12:17:06.418844+00', '2025-04-12 03:11:09.671585+00', 'Load account không lỗi thành công.', 0, 3, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '04eef85b-ce0e-40d5-9ceb-33bb39fa0c65');
INSERT INTO public.comments VALUES ('50585293-e16b-40b8-aee5-ef41fef63a4a', '2025-03-28 13:19:20.443974+00', '2025-03-28 14:33:38.616122+00', 'Hoàn thành refactor component cho post/:Id', 0, 3, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '16fb0ef3-7b9f-4868-9ea0-eaa98bda0130');
INSERT INTO public.comments VALUES ('e769c2fe-bfb5-47b5-8427-446163314803', '2025-03-29 11:36:33.527344+00', '2025-03-29 11:36:33.527344+00', 'Chủ tọa mãi đỉnh!!', 0, 1, 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '16fb0ef3-7b9f-4868-9ea0-eaa98bda0130');
INSERT INTO public.comments VALUES ('e5593fc4-0637-4d5b-a327-aeb03df6a4dd', '2025-04-01 02:07:00.209752+00', '2025-04-01 02:07:00.209752+00', 'Test lại comment nè', 0, 1, '71c88d6f-4bbe-41d7-b4d9-ed1e705f7bf5', '04eef85b-ce0e-40d5-9ceb-33bb39fa0c65');
INSERT INTO public.comments VALUES ('9143ef88-2ab0-4c3d-bcce-ca2a90ff544a', '2025-03-29 11:38:23.810868+00', '2025-03-29 11:38:23.810868+00', 'Quá đỉnh anh ơi =)))', 1, 1, '71c88d6f-4bbe-41d7-b4d9-ed1e705f7bf5', '16fb0ef3-7b9f-4868-9ea0-eaa98bda0130');
INSERT INTO public.comments VALUES ('7d7d4187-8174-41e4-b4a9-d8c2aae61fbe', '2025-04-05 14:07:05.700102+00', '2025-04-12 03:11:33.005422+00', 'new comment test nè', 0, 3, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '19cb14f2-cf63-40e3-bc0d-60e405abb64f');
INSERT INTO public.comments VALUES ('937f9213-e71e-4d29-9cfb-402246e7339f', '2025-03-28 10:34:51.502662+00', '2025-03-28 10:34:51.502662+00', 'Hello Alice', 1, 1, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '19cb14f2-cf63-40e3-bc0d-60e405abb64f');
INSERT INTO public.comments VALUES ('dd81b0ad-3756-47df-8f43-df9875fcb877', '2025-04-12 03:10:18.808089+00', '2025-04-12 03:10:18.808089+00', 'Bài viết tuyệt vời quá', 0, 1, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '4b4c7689-f154-4898-9398-28a164d9eeef');
INSERT INTO public.comments VALUES ('ba2a1fbe-fbd1-4cb9-b432-dcfda327b4e4', '2025-04-01 07:15:48.418887+00', '2025-04-01 07:15:48.418887+00', 'Test thành công là hay r á.', 0, 1, 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '04eef85b-ce0e-40d5-9ceb-33bb39fa0c65');


--
-- TOC entry 3568 (class 0 OID 57520)
-- Dependencies: 217
-- Data for Name: conversation; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.conversation VALUES ('d12ff1d6-3513-4818-b16a-690bd98970eb', '234234234', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '2025-04-06 21:12:18.500638', '2025-04-06 21:12:18.500638', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.conversation VALUES ('1005d09f-70d2-455c-937e-ffbaa8de7ad0', '234234', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '2025-04-06 21:12:21.024408', '2025-04-06 21:12:21.024408', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.conversation VALUES ('b0872b7f-747a-4a52-8470-be1db9267a60', '234234', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '2025-04-06 21:12:27.019721', '2025-04-06 21:12:27.019721', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023');
INSERT INTO public.conversation VALUES ('50982938-6d8e-4f88-b882-de5575fe0e13', '23423', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '2025-04-06 21:12:31.987848', '2025-04-06 21:12:31.987848', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023');
INSERT INTO public.conversation VALUES ('67f7c629-9055-4f26-ad02-0d5b5f9f276f', '23423', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '2025-04-06 21:12:36.066006', '2025-04-06 21:12:36.066006', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023');
INSERT INTO public.conversation VALUES ('59be6603-40d7-4947-9d92-83f5c701b869', '2222', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '2025-04-08 12:19:01.240116', '2025-04-08 12:19:01.240116', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.conversation VALUES ('e1631a0d-f259-40c9-814d-630fee2b0dca', '23423234', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '2025-04-08 12:19:18.904785', '2025-04-08 12:19:18.904785', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.conversation VALUES ('2cc8460f-f15b-47e6-98ca-5bcf699e7dcd', '23423', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '2025-04-08 12:19:23.416229', '2025-04-08 12:19:23.416229', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023');
INSERT INTO public.conversation VALUES ('c22acb25-8b74-4ba5-8f5d-800948d7b2c4', '23423', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '2025-04-08 12:19:29.026898', '2025-04-08 12:19:29.026898', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.conversation VALUES ('918c8bab-87b3-4d28-95e6-56f778e46166', '23423', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '2025-04-08 12:19:41.518974', '2025-04-08 12:19:38.25088', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023');
INSERT INTO public.conversation VALUES ('e427bcba-f891-4d49-9820-fa5b1c6a35fd', '23423', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '2025-04-08 12:19:50.537589', '2025-04-08 12:19:50.537589', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.conversation VALUES ('bf68e9b1-91e2-4f9f-9850-044d23760b79', '222', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '2025-04-12 20:55:28.065077', '2025-04-12 20:55:28.065077', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.conversation VALUES ('3a895f1f-71d3-4f18-8c7e-fc94c894d257', 'hello bob, you''re really on time', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '2025-04-12 20:55:42.357638', '2025-04-12 20:55:42.357638', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023');
INSERT INTO public.conversation VALUES ('42e3a626-32dc-4ae5-8304-4b254cbbd889', 'Thank you, how''re you', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '2025-04-12 20:56:00.317923', '2025-04-12 20:56:00.317923', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.conversation VALUES ('696f5bae-8757-435f-b4a1-dbc82a9b9812', 'I''m good, and you', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '2025-04-12 20:56:10.555925', '2025-04-12 20:56:10.555925', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023');
INSERT INTO public.conversation VALUES ('cad02cff-56c5-4a50-a8b0-635b5d42d315', 'i''ll be fine', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '2025-04-12 20:56:20.593145', '2025-04-12 20:56:20.593145', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.conversation VALUES ('93c67957-374e-4a44-b828-cc2a9094ecc9', 'you done capstone project ??', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '2025-04-12 20:56:32.2623', '2025-04-12 20:56:32.2623', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023');
INSERT INTO public.conversation VALUES ('fb02aa23-87b1-4740-8b2e-1bb45ddec5a9', 'not yet, just a little bit to make this perfect', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '2025-04-12 20:56:47.173746', '2025-04-12 20:56:47.173746', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.conversation VALUES ('fdaf874f-e6dd-4b3b-88cd-edb52aac0452', 'ohh thank you for your help', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '2025-04-12 20:57:05.736521', '2025-04-12 20:57:05.736521', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.conversation VALUES ('9f3b1d28-0dfe-4555-982a-0ee1782bac3f', 'ohh no problem', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '2025-04-12 20:57:13.526732', '2025-04-12 20:57:13.526732', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023');
INSERT INTO public.conversation VALUES ('d79d03b7-24bb-420b-8bb2-45fa55a7340b', 'good bye alice', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '2025-04-12 20:57:25.942116', '2025-04-12 20:57:25.942116', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.conversation VALUES ('6ec326e2-9447-49ce-824f-2ae84c68a1eb', 'bye bob have a nice weekend', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '2025-04-12 20:57:36.469715', '2025-04-12 20:57:36.469715', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023');
INSERT INTO public.conversation VALUES ('d48e8544-f939-4d42-8e73-6126abf49422', 'Hello e', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '2025-04-12 22:51:25.795169', '2025-04-12 22:51:25.795169', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.conversation VALUES ('8a99e637-4e87-40b7-9967-989cb89a421d', 'quài z cha', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '2025-04-12 22:51:33.929706', '2025-04-12 22:51:33.929706', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023');
INSERT INTO public.conversation VALUES ('ee12e9b2-d4cd-4e9d-bed7-1a78e6129bcd', 'sao ko cho nhắn ak', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '2025-04-12 22:51:41.579404', '2025-04-12 22:51:41.579404', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.conversation VALUES ('2e5265b9-d31e-4f57-9ef6-41b9239b28b8', 'ghét z tr', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '2025-04-12 22:51:47.690295', '2025-04-12 22:51:47.690295', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.conversation VALUES ('2bf2d91e-a685-48ec-bdba-6127efd320f9', 'gòi cho nhắn hem', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '2025-04-12 22:51:56.666281', '2025-04-12 22:51:56.666281', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.conversation VALUES ('7d304ec5-6be3-4b98-b38d-e4661e770d86', 'hả trả lời đi', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '2025-04-12 22:52:07.515961', '2025-04-12 22:52:07.515961', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.conversation VALUES ('52d0fe4e-2b4a-414f-815e-c47c44f5f5f5', 'sao??', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '2025-04-12 22:52:17.588542', '2025-04-12 22:52:17.588542', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.conversation VALUES ('266172c5-9581-4e2f-8ba7-0475b8d07018', 'ko thấy j z', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '2025-04-12 22:52:25.770392', '2025-04-12 22:52:25.770392', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.conversation VALUES ('503cc5a9-2b7d-4b8b-a753-58ccb8ca71f2', 'kì ta', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '2025-04-12 22:52:30.409971', '2025-04-12 22:52:30.409971', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.conversation VALUES ('3e25c3a6-2814-44c0-8a5a-5606201614ea', 'sao kì z ta', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '2025-04-12 22:52:54.568633', '2025-04-12 22:52:37.060744', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.conversation VALUES ('69178ce9-500e-472e-bd3f-5fd13a58fcaf', 't hơi ghét ghét con bug này r', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '2025-04-12 22:52:54.569147', '2025-04-12 22:52:46.305829', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.conversation VALUES ('341ac7ca-27c6-4d35-aeeb-54ac52187524', 'hiểu ko', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '2025-04-12 22:52:54.569147', '2025-04-12 22:52:52.926277', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.conversation VALUES ('9b3ab919-51cb-4e9f-87d7-ac499ebdb2c5', 'okie hiểu mà lưu lại lịch sử conv nữa nha', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '2025-04-12 22:53:16.287563', '2025-04-12 22:53:16.287563', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023');
INSERT INTO public.conversation VALUES ('e6746ac4-60d8-4c30-a979-9fb6c2d99f53', 'hello bob here', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '2025-04-15 20:53:11.387525', '2025-04-15 20:53:11.387525', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.conversation VALUES ('f83fc80f-2f44-4c0e-94f7-3b90224b2547', 'hi bob im alice nè', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '2025-04-15 20:53:20.968869', '2025-04-15 20:53:20.968869', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023');
INSERT INTO public.conversation VALUES ('db3ab5be-e388-4366-abe4-61cdf10a7206', '2232323', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '2025-04-15 21:36:39.492206', '2025-04-15 21:36:39.492206', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.conversation VALUES ('6f628c20-ef76-4f11-8854-ee7819e76118', 'Hello alice nha', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '2025-04-16 14:29:39.12679', '2025-04-16 14:29:39.12679', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.conversation VALUES ('b250cdc3-2bce-4c8a-950f-cb96b0db31ae', 'Hello eve', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_71c88d6f-4bbe-41d7-b4d9-ed1e705f7bf5', 'NOT_DELIVERED', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '2025-04-16 14:29:47.246221', '2025-04-16 14:29:47.246221', '71c88d6f-4bbe-41d7-b4d9-ed1e705f7bf5');
INSERT INTO public.conversation VALUES ('be90f8da-4495-4d76-a3e8-0dfc748c6367', 'hello alice nè bạn có online mà nhỉ', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '2025-04-16 14:30:01.661706', '2025-04-16 14:30:01.661706', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.conversation VALUES ('55ba13e3-8943-4d08-915c-ebfc5095e8e2', '222', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '2025-04-16 14:30:10.831434', '2025-04-16 14:30:10.831434', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.conversation VALUES ('bfc7967a-7186-415c-9c4b-07d698aaa6e8', '222', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '2025-04-16 14:30:12.47112', '2025-04-16 14:30:12.47112', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.conversation VALUES ('1291076f-5c80-4414-9d63-7dde35b1246e', '444', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '2025-04-16 14:30:28.841222', '2025-04-16 14:30:21.332717', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.conversation VALUES ('74e720ca-6515-4197-86ab-f115787723e4', '4545', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '2025-04-16 14:30:28.841222', '2025-04-16 14:30:23.185559', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.conversation VALUES ('9f57bcf5-2822-4972-9a12-0f8e1429d984', '32423', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '2025-04-16 14:30:28.841222', '2025-04-16 14:30:24.724224', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.conversation VALUES ('461fa2e6-abbe-4394-9413-d5bdd6e8f73f', '234234', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '2025-04-16 14:30:28.841757', '2025-04-16 14:30:25.984306', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.conversation VALUES ('ad8d4dc0-62b2-43b0-abb0-98f671a0c6ec', '23423', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '2025-04-16 14:30:28.841757', '2025-04-16 14:30:27.213673', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.conversation VALUES ('bb6c15e8-663c-4597-a09c-5740b9deca8f', 'chào bạn nha', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '2025-04-16 14:30:43.717632', '2025-04-16 14:30:43.717632', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023');
INSERT INTO public.conversation VALUES ('6c983b0d-79c0-482c-a216-39c3cc3b4d39', '222', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '2025-04-16 14:31:01.036438', '2025-04-16 14:30:55.278686', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023');
INSERT INTO public.conversation VALUES ('9feb94ac-6039-423a-b61d-d5b345ee7130', '23423', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '2025-04-16 14:31:01.036986', '2025-04-16 14:30:58.938098', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023');
INSERT INTO public.conversation VALUES ('faf1bb2e-419d-4cf8-820c-ca7a6cdf8343', '222', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '2025-04-16 23:45:50.499865', '2025-04-16 23:45:50.499865', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.conversation VALUES ('22f3e3ca-84ed-4685-8608-2863c8b6500a', '333', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '2025-04-16 23:45:53.292222', '2025-04-16 23:45:53.292222', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023');
INSERT INTO public.conversation VALUES ('eda3fd9a-9248-4eb1-b913-69a02ff03bbf', '333', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '2025-04-16 23:46:06.846521', '2025-04-16 23:46:03.971526', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.conversation VALUES ('82e8c7eb-f36b-4efe-ae02-2ba141e49257', '2323423', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec_dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'SEEN', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '2025-04-16 23:46:06.846521', '2025-04-16 23:46:05.458629', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');


--
-- TOC entry 3574 (class 0 OID 65660)
-- Dependencies: 223
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3575 (class 0 OID 65665)
-- Dependencies: 224
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.databasechangeloglock VALUES (1, false, NULL, NULL);


--
-- TOC entry 3585 (class 0 OID 155791)
-- Dependencies: 234
-- Data for Name: file; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.file VALUES ('c19a68b4-28b1-462e-b78b-a9c47a9d7861', '2025-03-25 10:34:22.784544+00', '2025-03-25 10:34:22.784544+00', 'image/jpg', 619278, '2f084e8021404b659c7d6ddcef78e027.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'DELETED');
INSERT INTO public.file VALUES ('04f80dac-99e3-4126-9893-f06b079eca91', '2025-03-25 16:22:17.803993+00', '2025-03-25 16:22:17.803993+00', 'image/jpg', 619278, 'f25d9126b0a8478bb66bf86f82ca11ca.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('4ab49e94-384d-4450-bcdb-0e1b8380601d', '2025-03-25 16:22:17.854403+00', '2025-03-25 16:22:17.854403+00', 'image/jpg', 515786, 'b096acf4ae0348218fd275ae66130a6c.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('886c3977-db0e-44bf-a7c2-a4eaf526327f', '2025-03-25 10:31:54.918388+00', '2025-03-25 10:31:54.918388+00', 'image/jpg', 512635, 'cba1cecd257e4947bdbc29e119b8a442.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'DELETED');
INSERT INTO public.file VALUES ('8ae90e17-3b56-46eb-9dfa-b153d549ca99', '2025-03-25 10:52:28.206637+00', '2025-03-25 11:03:13.220022+00', 'image/jpg', 512635, 'cb60520fc3a44acdac56c98d09a7bbea.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'DELETED');
INSERT INTO public.file VALUES ('c31184d5-fe52-4753-9eb5-9657a9eb9e26', '2025-03-25 10:34:22.837183+00', '2025-03-25 10:34:22.837183+00', 'image/jpg', 245773, '165d0e01be874bb8b65bcfdcddd1a74a.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('a142a0db-9f0e-4fde-b8c7-58808751d9c5', '2025-03-25 12:04:05.515755+00', '2025-03-25 12:04:05.515755+00', 'image/jpg', 245773, 'aaebcaa1b7474410987df7d6a11d7591.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('3dd8e3fa-8493-4cb4-8136-47d46742a428', '2025-03-25 12:04:05.579222+00', '2025-03-25 12:04:05.579222+00', 'image/jpg', 515786, '8e30e4e56c93410f8edc67f75e13842c.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('32655aae-24ab-47fe-b124-81f9a8f1b30f', '2025-03-25 12:04:05.626459+00', '2025-03-25 12:04:05.626459+00', 'image/jpg', 512635, '5f6d7fc530fa4e81bc64b6140e898a32.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('f6265d3b-8d6c-45aa-af8f-2bcc97888fff', '2025-03-25 16:21:14.857126+00', '2025-03-25 16:21:14.857126+00', 'image/jpg', 245773, 'ce66375d995e47a4afe4ef37ae1389a6.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('5bcdcad0-816e-4371-94a7-b8e946d7fb3e', '2025-03-25 16:21:19.500452+00', '2025-03-25 16:21:19.500452+00', 'image/jpg', 512635, '78d9d8f76726470486c13f1fdab552ba.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('64f3b5ab-f1cd-4808-902e-3f6eb0e6a943', '2025-03-25 16:21:23.700114+00', '2025-03-25 16:21:23.700114+00', 'image/jpg', 619278, '4d7f78db906042ada7ef252edeffaacf.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('72924ce8-9a99-46e8-bd19-f8409b3b384c', '2025-03-25 16:21:27.630707+00', '2025-03-25 16:21:27.630707+00', 'image/jpg', 515786, '49ddfe10174049c591bc16c2220cf377.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('1a107940-9736-4217-afc4-9c0efb246d17', '2025-03-25 16:21:31.178363+00', '2025-03-25 16:21:31.178363+00', 'image/jpg', 515786, '58016b728a1640e9b282a711e3ffb80f.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('dcb5a06a-efbe-456c-ba37-9aa865abe467', '2025-03-25 16:21:31.223876+00', '2025-03-25 16:21:31.223876+00', 'image/jpg', 245773, 'f88c7181423440d5b1d12f353bab1266.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('5ef5d610-8d25-4d8b-ad6d-cf51c9ad38c0', '2025-03-25 16:21:52.94507+00', '2025-03-25 16:21:52.94507+00', 'image/jpg', 515786, '190f8c14650141fa9881defdd2634b00.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('f4a7a05e-2b37-48ab-a4ee-1102790ee27c', '2025-03-25 16:21:52.994027+00', '2025-03-25 16:21:52.994027+00', 'image/jpg', 245773, 'e4932a0663b64c74ba9103e9e2b317a3.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('c99ae2fd-06f1-4b8b-8930-353a733d4e89', '2025-03-25 16:21:53.066943+00', '2025-03-25 16:21:53.066943+00', 'image/jpg', 619278, 'eb16455040a04d8393b92eef7359d884.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('b288244c-e626-4898-b6c9-c0f01ff21317', '2025-03-25 16:21:55.647677+00', '2025-03-25 16:21:55.647677+00', 'image/jpg', 515786, '91c52215bcf54479a29aefa14ef41dc7.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('ec391660-9907-47cb-9c5d-053d332387d7', '2025-03-25 16:21:55.698868+00', '2025-03-25 16:21:55.698868+00', 'image/jpg', 619278, 'ae487c81fc814c3193a2e2535e18b1a5.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('ead11f06-c27c-412c-b54e-b1934150fc61', '2025-03-25 16:22:14.584962+00', '2025-03-25 16:22:14.584962+00', 'image/jpg', 515786, '07de2f1b13e54fbab004990f081c3512.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('371baef5-32d6-483c-8091-396bd52ee53a', '2025-03-25 16:22:14.641743+00', '2025-03-25 16:22:14.641743+00', 'image/jpg', 619278, '0dbdef5d987548b5a5ba4c84b59b6bc4.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('145735e7-eaef-494f-b2b7-a3e69e2ccbea', '2025-03-25 16:22:14.692817+00', '2025-03-25 16:22:14.692817+00', 'image/jpg', 515786, 'b27e0b94968544488b29d351cbb25366.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('57318ecf-1e94-45f2-85b2-48b4b2a0572e', '2025-03-25 16:22:15.917636+00', '2025-03-25 16:22:15.917636+00', 'image/jpg', 515786, '9a8c070f479f4849b4ae6089410ee02c.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('58f616a6-122a-42c3-b16a-380b67e002bd', '2025-03-25 16:22:15.966375+00', '2025-03-25 16:22:15.966375+00', 'image/jpg', 619278, '61dd49112d714494be3aee8b16c596b5.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('5c8c759e-2be5-4e31-8aa3-7adaf0cb11e3', '2025-03-25 16:22:16.015113+00', '2025-03-25 16:22:16.015113+00', 'image/jpg', 515786, '185a2ac814d445eba6e79e59fc152e1a.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('50e6d4cb-7246-41d4-a921-4f74a7f7219b', '2025-03-25 16:22:16.879979+00', '2025-03-25 16:22:16.879979+00', 'image/jpg', 515786, '459f1de17cbe4532bf06f753a6b74640.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('5c102b29-fa58-4190-a5e6-10b836d3ec6a', '2025-03-25 16:22:16.933376+00', '2025-03-25 16:22:16.933376+00', 'image/jpg', 619278, '4ace5225bd5f4365b8967843c818b8c4.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('14a3928a-cb36-4298-a192-b95028b56255', '2025-03-25 16:22:16.983698+00', '2025-03-25 16:22:16.983698+00', 'image/jpg', 515786, 'b2e3e741c4324b37812a8ad8c9890e78.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('2771e0e2-65e4-473d-8cde-3947e80b1145', '2025-03-25 16:22:17.751961+00', '2025-03-25 16:22:17.751961+00', 'image/jpg', 515786, '1d4f6c3af38c4338892af8284e94bdd1.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('faae26bf-9931-4551-815f-f0663d2c7c18', '2025-03-27 12:34:47.198463+00', '2025-03-27 12:34:47.198463+00', 'image/jpg', 245773, '3814c2d038ce4285af89f3d3ed84c691.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('ec15fcc7-f42e-49b9-8760-e773b2a2097d', '2025-03-27 12:34:47.290219+00', '2025-03-27 12:34:47.290219+00', 'image/jpg', 512635, '3e092717d3dc4285aca0a59a188d138e.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('a83c52ea-fcb2-4529-8871-5fa2ac2c6a8b', '2025-03-27 12:41:27.36648+00', '2025-03-27 12:41:27.36648+00', 'image/jpg', 619278, '261fe3ea72024439b46a6371b5950ca3.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('3d7baa82-dc29-4cca-b6e2-b70a3f9fb8bb', '2025-03-27 12:41:48.645501+00', '2025-03-27 12:41:48.645501+00', 'image/jpg', 619278, 'b27fe8de15ef4c6e9a20a9d429a852bd.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('44f06695-0b3a-449a-9a53-a3ea632fa0cd', '2025-03-27 12:41:51.10249+00', '2025-03-27 12:41:51.10249+00', 'image/jpg', 515786, '0db6816e0c914dbfb6074c95edcbc439.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('c8492515-a4c9-4253-af5b-90d41f75c12a', '2025-03-27 13:19:07.00638+00', '2025-03-27 13:19:07.00638+00', 'image/jpg', 515786, 'ec24f4195c304e2784fd0455b5a45bb9.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('4cc150ec-afcd-4122-a291-193f5245a809', '2025-03-27 14:33:46.029205+00', '2025-03-27 14:33:46.029205+00', 'image/jpg', 245773, '529faaa9d97f477dbaeb5f4122f686a5.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('42a99c0b-e90c-40f3-97ab-b0dfb2128f9e', '2025-03-27 14:56:18.780971+00', '2025-03-27 14:56:18.780971+00', 'image/jpg', 132008, '4a14048e9dcd47baaab049799a43da3f.jpg', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'ACTIVE');
INSERT INTO public.file VALUES ('3edf62cb-7ab9-4173-ae6e-4bafc65dd296', '2025-03-27 14:56:18.8103+00', '2025-03-27 14:56:18.8103+00', 'image/jpg', 94017, '291a945c3eab4300926f77e1b4958e88.jpg', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'ACTIVE');
INSERT INTO public.file VALUES ('539549d7-2794-4373-8b23-39f47f458230', '2025-03-27 13:22:49.591026+00', '2025-03-27 17:15:41.383974+00', 'image/jpg', 105262, '1766754afa4048ecb28fc2ae2ead6466.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'DELETED');
INSERT INTO public.file VALUES ('d3ca9668-dbd5-4f35-9b45-6eff27551be4', '2025-03-27 13:22:49.66635+00', '2025-03-27 17:15:41.383974+00', 'image/jpg', 619278, '236dd5d6170f46d8afb35787431a1768.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'DELETED');
INSERT INTO public.file VALUES ('8f9e6b03-9995-4235-9ada-af8459fac013', '2025-03-27 13:22:49.714428+00', '2025-03-27 17:15:41.383974+00', 'image/jpg', 245773, '3aecc62fe9704da590037d421fab3e70.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'DELETED');
INSERT INTO public.file VALUES ('7256a382-f342-4a54-816f-1d107c7dfb9f', '2025-03-27 13:20:41.457934+00', '2025-03-28 01:58:08.992342+00', 'image/jpg', 515786, '7e91bb7c95d845daa101c2a450a27a60.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'DELETED');
INSERT INTO public.file VALUES ('a6f888a7-8c5a-4d63-b767-1c7812dca6ba', '2025-03-27 13:20:41.504596+00', '2025-03-28 01:58:08.995477+00', 'image/jpg', 512635, '21bf1063d3e742e88ce5ed9e688a9d7a.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'DELETED');
INSERT INTO public.file VALUES ('1296e233-57d0-491d-b134-d0d10756d46d', '2025-03-28 03:54:45.616555+00', '2025-03-28 03:54:45.616555+00', 'image/jpg', 515786, '2bf899bdab82402e8b4832272cb383b6.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('ba273eb5-80e4-4754-ac01-1a9c2718c26c', '2025-03-28 03:54:45.689874+00', '2025-03-28 03:54:45.689874+00', 'image/jpg', 512635, '9d850e0f1a8d4f36a3f7b8c0aeb7cb47.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('d1c74b37-fd8a-44ec-951f-d03913f8744c', '2025-03-28 04:00:13.66021+00', '2025-03-28 04:00:13.66021+00', 'image/jpg', 515786, '29514abf017742a39d8a778de3c1f84d.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('57111ee7-fc95-49e1-9955-f40e3edcb7d0', '2025-03-28 04:01:08.544043+00', '2025-03-28 04:01:08.544043+00', 'image/jpg', 245773, '4d14ffa999be4aecbc9fee8dee6496ae.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('b9a7aca9-a4a8-4253-bd2c-089d5f1903c2', '2025-03-28 04:01:08.58701+00', '2025-03-28 04:01:08.58701+00', 'image/jpg', 512635, '26abfebf29aa454b97ece78806b5ff60.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('d50a67f3-d7c6-470a-b5e6-efc728dd5221', '2025-03-28 04:01:25.484384+00', '2025-03-28 04:01:25.484384+00', 'image/jpg', 245773, '7033bd612e274eb9ba32fe77a7c078ed.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('a5485b09-40d9-4598-b529-b4c8e23586e5', '2025-03-28 04:01:25.531434+00', '2025-03-28 04:01:25.531434+00', 'image/jpg', 512635, 'df390a342bfc47a5ba12aac4167ef9dc.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('85620f56-74eb-4b00-b82c-36b985d1a6e2', '2025-03-28 04:05:06.793375+00', '2025-03-28 04:05:06.793375+00', 'image/jpg', 515786, '1173cf43693f4253ae37ee61389598cc.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('22814d94-b077-41e3-ada8-dcc9c66d4bbd', '2025-03-28 04:05:06.839455+00', '2025-03-28 04:05:06.839455+00', 'image/jpg', 512635, '3e871308637a4bf8a05524fd4ea3008e.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('e24fd699-4b9b-486f-a8be-528a8cbab5ab', '2025-03-28 04:05:16.21235+00', '2025-03-28 04:05:16.21235+00', 'image/jpg', 515786, 'd80996d121c5432d9a0fc57d276cb8b0.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('db59f1d5-61aa-4211-9d7a-d85b9de15864', '2025-03-28 04:05:16.258153+00', '2025-03-28 04:05:16.258153+00', 'image/jpg', 512635, '01c59f9a62ab4752aabc8cf2d9ad678b.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('5b8a28cf-2114-42f0-98e1-5b12f1da39a3', '2025-03-28 04:06:35.354201+00', '2025-03-28 04:06:35.354201+00', 'image/jpg', 515786, '6be4564d33cd4ac08e0ef06d04d8e7a8.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('765af3f4-454e-4bb3-a4a2-44f0d96c4f7f', '2025-03-28 04:06:35.398377+00', '2025-03-28 04:06:35.398377+00', 'image/jpg', 512635, '6eedd4bbc5474863b90bf5401767c96a.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('b9931cb0-a37c-4bcb-9cdc-9efe60eb2f29', '2025-03-28 04:09:32.295461+00', '2025-03-28 04:09:32.295461+00', 'image/jpg', 515786, 'f3f23ecca4c245f78bfbafb0a45a0b18.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('8eae563e-93ed-45b1-b6e0-79d60794920d', '2025-03-28 04:27:09.288056+00', '2025-03-28 04:27:09.288056+00', 'image/jpg', 515786, '29fff5fc05014a2dbb686341fd48fcb6.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('b69c2a5c-9efb-44a0-b39e-a09255d2f8f3', '2025-03-28 04:27:09.334973+00', '2025-03-28 04:27:09.334973+00', 'image/jpg', 245773, '24f24a4220e0483fa490a378e151bfb5.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('4d08d6ba-78bd-4651-b04b-2903b4d84fce', '2025-03-28 04:27:09.381228+00', '2025-03-28 04:27:09.381228+00', 'image/jpg', 512635, '30a8d1007a164b93b5666f7d06195443.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('6bde4d55-dfa5-4ca4-a9bf-a445aa87529a', '2025-03-28 07:24:17.403882+00', '2025-03-28 07:24:17.403882+00', 'image/jpg', 515786, 'fa95f625e32b4705ac55cf39b6d0ea8c.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('97b2d1cc-5a8c-4f55-99ad-106396982e07', '2025-03-28 07:24:17.478263+00', '2025-03-28 07:24:17.478263+00', 'image/jpg', 512635, '83ae3cd95df54ea3855b760fd97f1e93.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('f5f5548b-31ad-40ab-86be-c85c8609d425', '2025-03-28 07:24:25.433344+00', '2025-03-28 07:24:25.433344+00', 'image/jpg', 619278, '5fbc9b65c283453aa6967e7ed0f37eaf.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('f06ade3d-41e5-4312-aa28-9437645fd10f', '2025-03-28 07:24:25.475212+00', '2025-03-28 07:24:25.475212+00', 'image/jpg', 245773, '7bbc2b1a823641c3b54749656f820c70.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('2de47223-9ecb-4186-9bde-3a576a800514', '2025-03-28 07:24:30.859947+00', '2025-03-28 07:24:30.859947+00', 'image/jpg', 619278, 'd8812a1db06644c097acfd4fa0268f39.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('e6bfec1b-9a3c-47e0-a186-f7f211a91b45', '2025-03-28 07:24:30.899242+00', '2025-03-28 07:24:30.899242+00', 'image/jpg', 245773, '9fe630026c03429ea47cedafc83ece43.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('834bc147-183d-44a5-ab2b-00973db2882a', '2025-03-28 07:25:20.277275+00', '2025-03-28 07:25:20.277275+00', 'image/jpg', 619278, '89b6c19e463242d484ccd0d1f42a7ad8.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('cf41f5f1-2bc6-4caa-a792-24dc30128785', '2025-03-28 07:25:20.318177+00', '2025-03-28 07:25:20.318177+00', 'image/jpg', 245773, 'ca1bf7e29b884fe4bbcff128330bfe18.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('1315bfdb-9dca-497b-9bbc-b190bcdd1a9d', '2025-03-28 07:29:50.718413+00', '2025-03-28 07:30:57.735469+00', 'image/jpg', 245773, '380feb5016554a14a33579e6eaaac34b.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'DELETED');
INSERT INTO public.file VALUES ('e3fc0072-5c46-4fc4-8aa4-f80eb348c4f5', '2025-03-28 08:05:41.367874+00', '2025-03-28 08:05:41.367874+00', 'image/jpg', 515786, 'fc04dcbddb25406caf70e010f6f8a2a3.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('8cedfc39-e21c-40c5-bb74-1f73ee8364b7', '2025-03-28 08:05:41.442118+00', '2025-03-28 08:05:41.442118+00', 'image/jpg', 512635, '609102a165654a569af6a8572592b8e5.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('0f8f386b-68c4-448d-9072-4d58a161b394', '2025-03-28 08:06:26.669464+00', '2025-03-28 08:06:26.669464+00', 'image/jpg', 619278, '210d55a6aadf4397bf8d1fc309bb8846.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('2d80f584-d3b4-4468-a5cc-b3f5d005f092', '2025-03-28 08:06:26.710428+00', '2025-03-28 08:06:26.710428+00', 'image/jpg', 245773, '11c86e9d44c94887a4e77ebf36a81c24.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('6b7393fa-52ea-48e2-af93-d12294031742', '2025-03-28 08:07:55.339999+00', '2025-03-28 08:07:55.339999+00', 'image/jpg', 515786, '0c0339b68b414070b724dae006fa0401.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('77674719-b95c-4193-aa84-620c6aef129f', '2025-03-28 08:07:55.390042+00', '2025-03-28 08:07:55.390042+00', 'image/jpg', 512635, 'ec583460a3e94ab6876506d71e26804d.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('8ffebe24-cf4a-4561-a740-48c898eb64c2', '2025-03-28 08:08:23.771771+00', '2025-03-28 08:08:23.771771+00', 'image/jpg', 515786, 'bbb5b4dc73154f40aaf6841721f3fc17.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('032376d2-8708-4f4e-ad06-922a48fce7de', '2025-03-28 08:08:23.820057+00', '2025-03-28 08:08:23.820057+00', 'image/jpg', 512635, '1fbffc30db4c4400bd9e78b871166e97.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('04cb4ffc-5e5b-436b-9424-119bdc34e4d1', '2025-03-28 08:08:33.687393+00', '2025-03-28 08:08:33.687393+00', 'image/jpg', 515786, 'dc7f3e5c96c049db8853581ba8dcb586.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('24460795-222b-47fc-b83e-f1ec218a22e5', '2025-03-28 08:08:33.730913+00', '2025-03-28 08:08:33.730913+00', 'image/jpg', 512635, '16971d8670fb495d9c1cd4e5c2846de7.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('f5173559-8377-4796-8fa6-907c4e8ed206', '2025-03-28 08:17:26.05121+00', '2025-03-28 08:17:26.05121+00', 'image/jpg', 515786, 'e34d79468788493fa65e717c5a13d927.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('0300173f-2bc4-497a-815d-780c3a509d8d', '2025-03-28 08:17:26.097741+00', '2025-03-28 08:17:26.097741+00', 'image/jpg', 512635, '1e5f29eee0604e329fae4b1f6466a0ee.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('9ce73f2f-e227-4c24-8e97-b259fbdb3abe', '2025-03-28 08:37:39.697102+00', '2025-03-28 08:37:39.697102+00', 'image/jpg', 515786, 'a22a247798ad455abf859a43ed596963.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('cedf3520-7db3-44d6-a2f4-2184dbfe4fb2', '2025-03-28 08:37:39.763292+00', '2025-03-28 08:37:39.763292+00', 'image/jpg', 512635, '90e30c2582354186bc3fb57e5f5f7475.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('88c5dc4d-33d8-4b78-8992-a505fbe3aad7', '2025-03-28 09:01:50.519166+00', '2025-03-28 09:01:50.519166+00', 'image/jpg', 224199, 'd820810177c54fa8b2afe11077b33c7f.png', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('df1e5995-0d51-4671-a8b4-3fb2be32fa76', '2025-03-28 09:04:00.596115+00', '2025-03-28 09:04:00.596115+00', 'image/jpg', 224199, 'faf00e3ba82342a9bef2e6463005284c.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('3192850c-c354-4c09-a98c-9596f049488d', '2025-03-28 09:04:06.998449+00', '2025-03-28 09:04:06.998449+00', 'image/jpg', 224199, '44daed7466714a1caa4838dc0f0597bf.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('47a55172-e6f4-4890-8f2e-bfcaa03448a9', '2025-03-28 09:13:25.470309+00', '2025-03-28 09:13:25.470309+00', 'image/jpg', 224199, '7ea36851173c4ee992af0076a1889310.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('683983e4-02c7-47a2-b903-80ee1a84c15a', '2025-03-28 14:46:41.898971+00', '2025-03-28 14:46:41.898971+00', 'image/jpg', 224199, '25b3a25c98564a59a2b2882c03c20dc8.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('c6aba854-dc76-4d82-8d9c-562ef0fdef3c', '2025-03-28 10:16:06.951012+00', '2025-03-28 11:26:20.827358+00', 'image/jpg', 224199, '85a709e2b68d4a9f8e1c26beec5b864c.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('3fba5a9b-eb03-49f2-95bc-01ce962c7d7e', '2025-03-28 12:07:25.404166+00', '2025-03-28 12:07:25.404166+00', 'image/jpg', 224199, '50c8541070c64395b3af37280eed8262.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('631f80ab-0f0c-4517-995b-c7714e179af3', '2025-03-28 12:07:50.844504+00', '2025-03-28 12:07:56.476044+00', 'image/jpg', 245773, 'f341211e819e4f598885549aac1873a8.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'DELETED');
INSERT INTO public.file VALUES ('1a0c36bf-e407-4a31-8f6b-6515d4a1b984', '2025-03-28 12:07:50.90736+00', '2025-03-28 12:07:56.476044+00', 'image/jpg', 515786, '5461fdaea77c4465a3a977a030c184a8.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'DELETED');
INSERT INTO public.file VALUES ('aa98ad9c-be55-4c33-b29f-fec54d714d65', '2025-03-28 12:09:27.993819+00', '2025-03-28 12:09:27.993819+00', 'image/jpg', 224199, '45ae40a6668044b783d0868a369b2030.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('8f3e8a4a-9ba0-4c79-91a1-67d13a9e0eb9', '2025-03-28 12:09:28.056921+00', '2025-03-28 12:09:28.056921+00', 'image/jpg', 512635, 'e2bf6e8f58c740ffa435bf26487eae70.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('67cad99f-2297-458e-856e-b1b0dfc4650b', '2025-03-28 12:20:30.057398+00', '2025-03-28 12:20:30.057398+00', 'image/jpg', 619278, '0dd008a92530459f9fa2f54f6ab7823f.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('d3ab5227-450e-41a9-bb07-5e7b4b570a5e', '2025-03-28 12:20:30.105091+00', '2025-03-28 12:20:30.105091+00', 'image/jpg', 245773, '4e934c10b21e4a6f9f3de8359be598d8.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('2b3ec22c-3eed-4b3e-8015-335512f20ab5', '2025-03-28 12:21:32.888644+00', '2025-03-28 12:21:32.888644+00', 'image/jpg', 224199, '6ef92c1788a649e099bcb096e4401d0d.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('56e720b6-8da6-4e2f-869c-0209ed863992', '2025-03-28 12:21:32.946849+00', '2025-03-28 12:21:32.946849+00', 'image/jpg', 512635, 'eb36bcf7a2964aadb4c327e8c38e7c1b.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('c58a68a0-9632-4986-9033-698969bd6256', '2025-03-28 14:34:00.172744+00', '2025-03-28 14:34:00.172744+00', 'image/jpg', 224199, '8ff096ea570e4c91ae3baca20ed15c44.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('87e2ce68-439e-420d-9f48-a4660a9e6e51', '2025-03-28 14:34:00.240961+00', '2025-03-28 14:34:00.240961+00', 'image/jpg', 512635, '61e3abaac14b4f36a90d725ae9c0630a.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('73ee337a-e373-486f-bdea-b39748ce40c0', '2025-03-28 14:34:00.281816+00', '2025-03-28 14:34:00.281816+00', 'image/jpg', 245773, '0d0fc2ab88c246e3a880d9d7cf08c683.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('5b26f98a-cce2-431d-b35a-5e88aa92f3c3', '2025-03-28 14:45:58.482077+00', '2025-03-28 14:45:58.482077+00', 'image/jpg', 132008, 'd19725b933d44b9cadb1d0e0d98b6f06.jpg', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'ACTIVE');
INSERT INTO public.file VALUES ('38486c2f-e861-4de6-80f9-b0f4611bbd0b', '2025-03-28 14:46:41.953827+00', '2025-03-28 14:46:41.953827+00', 'image/jpg', 512635, '726ed3d652e84f21af8e94048c7e9c50.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('a7ddd9c3-807a-4b55-b25e-b159384a7463', '2025-03-29 09:08:57.510252+00', '2025-03-29 09:08:57.510252+00', 'image/jpg', 515786, '1b44e9572d3147cbae3b1ebc1bd9006d.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('7d09a770-c384-4f7a-8740-ae23b5211724', '2025-03-29 09:10:25.285676+00', '2025-03-29 09:10:25.285676+00', 'image/jpg', 515786, '1d0d4bd2ad464f01876152800aa8ece5.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('a1ab7f30-5f4f-4bbd-8b98-1d4a0c470cf6', '2025-03-29 09:10:48.285301+00', '2025-03-29 09:10:48.285301+00', 'image/jpg', 619278, '06c1eea4899849e5a85ff31da6fd00cb.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('9f0543aa-587c-430c-9eeb-5d7f361f5172', '2025-03-30 03:29:21.777042+00', '2025-03-30 03:29:21.777042+00', 'image/jpg', 885989, 'cce3b3bbc77d4f17bc10288d1878149e.jpg', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'ACTIVE');
INSERT INTO public.file VALUES ('b6974406-0915-4295-9373-f06636609f91', '2025-03-30 07:22:12.984188+00', '2025-03-30 07:22:12.984188+00', 'image/jpg', 512635, '5debc3f23a7043f98d3dcd0cd7f88052.jpg', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'ACTIVE');
INSERT INTO public.file VALUES ('dc42532f-a809-4252-bfbe-545308072158', '2025-03-30 07:51:55.344691+00', '2025-03-30 07:51:55.344691+00', 'image/jpg', 512635, 'e83f86051ba943cb8688518ecc972fbf.jpg', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'ACTIVE');
INSERT INTO public.file VALUES ('2eb571e2-536f-4bfd-9784-24e9b4690fd7', '2025-04-01 14:41:58.04831+00', '2025-04-01 14:41:58.04831+00', 'image/jpg', 224199, '1ce77c75ae6c4145b3ee153d7ce8e28a.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('56b0c09e-93f7-4aa8-8b94-9855416736a4', '2025-04-01 15:37:00.339328+00', '2025-04-01 15:37:00.339328+00', 'image/jpg', 224199, '7dbc39f962bc4479a508f805ffeac816.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('bdd7cef3-dc22-46a0-bbfb-7fa4ff1013dd', '2025-04-01 15:37:00.415895+00', '2025-04-01 15:37:00.415895+00', 'image/jpg', 515786, 'bcb9bd298bfa454ea9ac4f8494396d98.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('6e9d8bfd-3af3-4ad3-a59d-8a946106fac8', '2025-04-01 15:37:00.487389+00', '2025-04-01 15:37:00.487389+00', 'image/jpg', 512635, 'f5a72c8b10f84b3a96b0e8dacabe98c6.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('e029b047-d8ab-4b00-bf14-4457e0135d03', '2025-04-06 09:21:04.060209+00', '2025-04-06 09:21:04.060209+00', 'image/jpg', 245773, '77672beac027493499a9f45b6f072667.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('a26405e7-299e-4307-9f20-dc8b4a51a584', '2025-04-06 09:21:11.285763+00', '2025-04-06 09:21:11.285763+00', 'image/jpg', 224199, '054b563448b547519cce9d90f45e6c00.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('410e866f-2c36-44d3-a618-ebbffca168a1', '2025-04-06 09:21:11.330693+00', '2025-04-06 09:21:11.330693+00', 'image/jpg', 512635, '5cb2339fba0a4d31a2df8b97229adf43.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('1c4c6f99-a963-41b3-8f0a-ed47ae2d6398', '2025-04-09 13:27:05.720925+00', '2025-04-09 13:27:05.720925+00', 'image/jpg', 86600, '369e95633eaa473282f3595e2ef2b0f8.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('bfcea79c-900f-458f-affc-deb66d3cf0e9', '2025-04-09 13:31:56.313534+00', '2025-04-09 13:31:56.313534+00', 'image/jpg', 515786, '1eb7bdc0da96422b9b2da9a461cba9b4.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('1df07f69-7b7f-4c5c-9626-80ba077a5a70', '2025-04-09 13:31:56.398895+00', '2025-04-09 13:31:56.398895+00', 'image/jpg', 512635, 'cd61b298248d435cb93176761802df6a.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('6a2abb86-37f1-4e35-926c-c017eed80bcf', '2025-04-09 13:40:19.254472+00', '2025-04-09 13:40:19.254472+00', 'image/png', 427911, 'a5f61ac1b4934fee86ca7e938354f2be.png', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('aab9884d-229b-4d03-bcbc-04337b3790dd', '2025-04-09 13:43:23.666637+00', '2025-04-09 13:43:23.666637+00', 'image/png', 427911, '28ce966e6cd1410889fd79c434108e15.png', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'DELETED');
INSERT INTO public.file VALUES ('108627f5-61be-4491-bda7-3dc5bdb34a00', '2025-04-09 13:50:25.207787+00', '2025-04-09 13:50:25.207787+00', 'image/png', 427911, '64344ee3ac094f21afbfc92396869994.png', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'DELETED');
INSERT INTO public.file VALUES ('bbced4b8-ba2e-4038-a117-bd3d59b3e0a8', '2025-04-10 09:11:41.983868+00', '2025-04-10 09:11:41.983868+00', 'image/png', 246569, '9e176fe8e2524e00a840af4fece7a126.png', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('e69bdf18-572d-42dd-b783-393eab22e536', '2025-04-10 09:11:42.064054+00', '2025-04-10 09:11:42.064054+00', 'image/png', 427911, 'e2bd5d4af5d54ec983b58863412bc82c.png', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('29873283-c2f7-48d2-838e-ea793eadaa88', '2025-04-12 02:44:05.506091+00', '2025-04-12 02:44:05.506091+00', 'image/jpg', 220087, 'c63becb5565948969e3fdd4830aa46d0.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('b1cca06a-b9dc-477f-93f4-a5db2a4b26ea', '2025-04-12 02:44:05.595271+00', '2025-04-12 02:44:05.595271+00', 'image/jpg', 678668, 'bb63392ef1bb4a27a71f548ac8231fa8.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('2276aa8b-47d4-46ad-8f62-c8c54792226f', '2025-04-12 02:45:05.809993+00', '2025-04-12 02:45:05.809993+00', 'image/jpg', 292226, '0d9f281cb425410e83505120bac35606.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('5c702229-004c-443e-b33d-0aa208616cbe', '2025-04-14 03:01:54.526776+00', '2025-04-14 03:01:54.526776+00', 'image/jpg', 224199, '7adedbb7fd6c4f7088c68d117b6f9f5e.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('c1942016-7025-4123-8145-5d3d9c8c7d00', '2025-04-16 16:46:43.345985+00', '2025-04-16 16:46:43.345985+00', 'image/jpg', 245773, '1bcf95b490bd4c668e2fd373e869f513.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('7cbc9ba4-f792-42e8-b056-0b97de6fa9b8', '2025-04-16 16:46:43.408322+00', '2025-04-16 16:46:43.408322+00', 'image/jpg', 619278, '0d45236b29da41958dd350ad06004dba.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('f9f31b68-3f46-436a-b45e-c1f4af6b3eaa', '2025-04-16 16:47:02.138888+00', '2025-04-16 16:47:02.138888+00', 'image/jpg', 245773, 'd0b347be00ea4875909052c0456a311f.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('cc7d7d54-74af-4cc0-b416-b5f51ccdd7a9', '2025-04-18 18:45:11.043873+00', '2025-04-18 18:45:11.043873+00', 'image/jpg', 515786, 'cb4f778ef89c45d6813607044e0303d6.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('a1300736-d1ff-46b6-9249-d8ec8270f1b8', '2025-04-18 18:45:11.096787+00', '2025-04-18 18:45:11.096787+00', 'image/jpg', 512635, '03f3b8fa33764970929d9db7fa443836.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');
INSERT INTO public.file VALUES ('9d0cf573-eee5-485d-8678-6392be93283f', '2025-04-18 18:45:11.142398+00', '2025-04-18 18:45:11.142398+00', 'image/jpg', 245773, '57a83ef634e1495581a7a79724f9bdbc.jpg', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'ACTIVE');


--
-- TOC entry 3582 (class 0 OID 131308)
-- Dependencies: 231
-- Data for Name: follow; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.follow VALUES ('45b13fcd-1297-4290-b494-9734243a57ed', '2025-03-16 19:40:18.529957+00', '2025-03-16 19:40:18.529957+00', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023');


--
-- TOC entry 3583 (class 0 OID 139404)
-- Dependencies: 232
-- Data for Name: friend; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.friend VALUES ('4ccb1ff3-97ed-440e-bb14-f13132b7dc24', '2025-04-01 07:12:23.72014+00', '2025-04-01 07:12:23.72014+00', 'ACCEPTED', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '71c88d6f-4bbe-41d7-b4d9-ed1e705f7bf5');
INSERT INTO public.friend VALUES ('9d8e4700-45bc-4049-8071-d0f00b00a840', '2025-04-01 07:12:27.308427+00', '2025-04-01 07:12:27.308427+00', 'ACCEPTED', '71c88d6f-4bbe-41d7-b4d9-ed1e705f7bf5', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.friend VALUES ('5a5543be-f715-4f39-8ce9-9d488499a1fb', '2025-04-01 03:05:47.833866+00', '2025-04-01 03:05:47.833866+00', 'ACCEPTED', '71c88d6f-4bbe-41d7-b4d9-ed1e705f7bf5', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023');
INSERT INTO public.friend VALUES ('07becf24-35c7-47b2-8a9c-ba458a17b0ec', '2025-04-01 03:06:04.618684+00', '2025-04-01 03:06:04.618684+00', 'ACCEPTED', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '71c88d6f-4bbe-41d7-b4d9-ed1e705f7bf5');
INSERT INTO public.friend VALUES ('94f7d49f-7cbe-4a38-9420-0f98b59185cd', '2025-04-02 03:32:14.702777+00', '2025-04-02 03:32:14.702777+00', 'PENDING', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '6432b612-3b2f-4575-8e58-8d49e95455db');


--
-- TOC entry 3590 (class 0 OID 213130)
-- Dependencies: 239
-- Data for Name: line_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.line_items VALUES ('d077fcd6-a149-4206-9826-a871a4eecf8a', '2025-04-16 15:25:28.078844+00', '2025-04-16 15:25:28.078844+00', 1450000.00, 1, 1450000.00, '9d8b0533-26d2-4cbe-b5d7-dd5580cd8b41', 'f12e3f97-8ee4-4959-9611-5e572af6f224');
INSERT INTO public.line_items VALUES ('a9959d12-b076-4960-b01e-666eeb07d726', '2025-04-16 16:02:22.306126+00', '2025-04-16 16:02:22.306126+00', 1450000.00, 2, 2900000.00, 'bd78f2ca-3d4c-4d00-8758-7339628ed2c5', 'f12e3f97-8ee4-4959-9611-5e572af6f224');
INSERT INTO public.line_items VALUES ('19b5879f-5313-485f-8f23-6d4d8ad8ffb1', '2025-04-16 16:32:20.740547+00', '2025-04-16 16:32:20.740547+00', 34999000.00, 1, 34999000.00, 'c099dcb7-be14-4f64-b7af-f95f44806b7c', '78f62f3c-0f34-49be-8353-60502966b56c');
INSERT INTO public.line_items VALUES ('603f1d63-04a8-4bfa-829f-160797794c40', '2025-04-16 16:40:05.814954+00', '2025-04-16 16:40:05.814954+00', 1450000.00, 2, 2900000.00, '29e2744e-f772-4823-928c-ac9073eea52b', 'f12e3f97-8ee4-4959-9611-5e572af6f224');
INSERT INTO public.line_items VALUES ('16a68586-6a9e-44cf-9f57-d6cd1e2f983b', '2025-04-17 07:53:13.416864+00', '2025-04-17 07:53:13.416864+00', 1450000.00, 1, 1450000.00, 'aa15ee5f-f202-43db-bd57-7f6f10d11682', 'f12e3f97-8ee4-4959-9611-5e572af6f224');
INSERT INTO public.line_items VALUES ('1bbf3d2a-e0ac-4e26-8a5b-0b71389c2b5a', '2025-04-17 07:53:13.421556+00', '2025-04-17 07:53:13.421556+00', 950000.00, 1, 950000.00, 'aa15ee5f-f202-43db-bd57-7f6f10d11682', '585d5ca6-7051-4c67-b269-7480c0612fdd');
INSERT INTO public.line_items VALUES ('96cbd150-555d-4aed-9b9c-dfd44b5facfb', '2025-04-17 08:23:25.541185+00', '2025-04-17 08:23:25.541185+00', 950000.00, 1, 950000.00, 'a180b205-20b8-4781-8b1d-4d617465f260', '585d5ca6-7051-4c67-b269-7480c0612fdd');
INSERT INTO public.line_items VALUES ('9d50878e-7d17-4818-b94f-bf7bd12946bc', '2025-04-17 08:23:25.543814+00', '2025-04-17 08:23:25.543814+00', 1450000.00, 1, 1450000.00, 'a180b205-20b8-4781-8b1d-4d617465f260', 'f12e3f97-8ee4-4959-9611-5e572af6f224');
INSERT INTO public.line_items VALUES ('66367bca-b424-4b27-be0d-600c40e87149', '2025-04-17 08:23:25.545931+00', '2025-04-17 08:23:25.545931+00', 34999000.00, 1, 34999000.00, 'a180b205-20b8-4781-8b1d-4d617465f260', '78f62f3c-0f34-49be-8353-60502966b56c');
INSERT INTO public.line_items VALUES ('d051a874-3d02-434a-9716-e60d6f53a7f5', '2025-04-17 08:48:13.353432+00', '2025-04-17 08:48:13.353432+00', 1450000.00, 3, 4350000.00, 'd8d6c70f-31d7-4c40-8acc-9d5d57b9dc00', 'f12e3f97-8ee4-4959-9611-5e572af6f224');
INSERT INTO public.line_items VALUES ('7ef5d1e6-ffa5-4ea3-97c0-a5c2bf69c7f6', '2025-04-17 08:52:05.393012+00', '2025-04-17 08:52:05.393012+00', 1450000.00, 1, 1450000.00, 'ec3f4230-58c4-47a6-bc25-a60935d748e1', 'f12e3f97-8ee4-4959-9611-5e572af6f224');
INSERT INTO public.line_items VALUES ('1a260c21-72e1-4bbe-81ac-b3da75d2b198', '2025-04-17 08:53:47.826522+00', '2025-04-17 08:53:47.826522+00', 34999000.00, 1, 34999000.00, 'fe96f029-005c-4b71-b14b-acb5162c9492', '78f62f3c-0f34-49be-8353-60502966b56c');
INSERT INTO public.line_items VALUES ('fde9a9a3-bf44-4451-988a-2c5581d854a2', '2025-04-17 08:54:27.656639+00', '2025-04-17 08:54:27.656639+00', 34999000.00, 1, 34999000.00, 'd2733844-c185-4eba-8425-1aa92643ace6', '78f62f3c-0f34-49be-8353-60502966b56c');
INSERT INTO public.line_items VALUES ('10e1b86d-b2e1-44a5-8e65-46a3c23613b5', '2025-04-17 08:54:27.658754+00', '2025-04-17 08:54:27.658754+00', 1450000.00, 1, 1450000.00, 'd2733844-c185-4eba-8425-1aa92643ace6', 'f12e3f97-8ee4-4959-9611-5e572af6f224');
INSERT INTO public.line_items VALUES ('6f33840b-551c-4a10-87d4-b5856ada1761', '2025-04-20 13:57:24.683261+00', '2025-04-20 13:57:24.683261+00', 950000.00, 2, 1900000.00, 'b45f66eb-e712-4889-83d8-94f6942580f1', '585d5ca6-7051-4c67-b269-7480c0612fdd');
INSERT INTO public.line_items VALUES ('714fb129-9c25-4af0-9ead-f023a8fedd80', '2025-04-20 14:01:37.754206+00', '2025-04-20 14:01:37.754206+00', 34999000.00, 1, 34999000.00, '90671a37-d422-4fae-b9b4-8742237d377f', '78f62f3c-0f34-49be-8353-60502966b56c');
INSERT INTO public.line_items VALUES ('79b8e3ce-975b-4a3e-8145-16be7a1f4f1a', '2025-04-20 14:56:06.043384+00', '2025-04-20 14:56:06.043384+00', 1450000.00, 1, 1450000.00, '4ba5a76f-142e-447e-b444-0d171549d1f1', 'f12e3f97-8ee4-4959-9611-5e572af6f224');


--
-- TOC entry 3584 (class 0 OID 147580)
-- Dependencies: 233
-- Data for Name: notification; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.notification VALUES ('08ed8ef0-48e1-4ea7-805f-eb543f9efcd7', '2025-04-01 07:15:33.027576+00', '2025-04-01 07:16:07.66008+00', 'Robert Doe liked your post', true, false, 'LIKE_POST', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.notification VALUES ('64be8736-bc46-40d7-954c-d3e48d0a82b6', '2025-04-01 07:15:48.438937+00', '2025-04-01 07:16:07.663222+00', 'Robert Doe commented on your post', true, false, 'COMMENT_POST', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.notification VALUES ('493fa787-ee49-482b-a4c8-4d47f759d206', '2025-04-01 11:54:18.174283+00', '2025-04-01 11:54:18.174283+00', 'Alice Thompson sent you a friend request', false, false, 'FRIEND_REQUEST', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '6dbb011a-2beb-4fc4-97c3-666c1bef560d');
INSERT INTO public.notification VALUES ('b9daf4d3-25ed-4d49-8ab5-69e4e3113a13', '2025-04-01 11:54:18.228672+00', '2025-04-01 11:54:18.228672+00', 'Alice Thompson accepted your friend request', false, false, 'FRIEND_REQUEST_ACCEPTED', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '6dbb011a-2beb-4fc4-97c3-666c1bef560d');
INSERT INTO public.notification VALUES ('cdcd0f83-4cb1-48b2-b538-b8a5415887db', '2025-04-01 14:42:19.164945+00', '2025-04-01 14:42:19.164945+00', 'Alice Thompson sent you a friend request', false, false, 'FRIEND_REQUEST', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '6dbb011a-2beb-4fc4-97c3-666c1bef560d');
INSERT INTO public.notification VALUES ('e5654a18-7468-40ff-a407-ea269d3fc343', '2025-04-01 14:42:19.177189+00', '2025-04-01 14:42:19.177189+00', 'Alice Thompson accepted your friend request', false, false, 'FRIEND_REQUEST_ACCEPTED', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '6dbb011a-2beb-4fc4-97c3-666c1bef560d');
INSERT INTO public.notification VALUES ('342c6320-0ec8-4409-b786-d312c06031c6', '2025-04-01 15:37:17.43595+00', '2025-04-01 15:37:40.106226+00', 'Alice Thompson liked your comment', true, false, 'COMMENT_LIKED', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '71c88d6f-4bbe-41d7-b4d9-ed1e705f7bf5');
INSERT INTO public.notification VALUES ('b06b6abb-69e5-426c-a1a1-e4ea2c0b8656', '2025-04-01 07:16:41.192765+00', '2025-04-01 15:39:06.04671+00', 'Robert Doe sent you a friend request', true, false, 'FRIEND_REQUEST', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.notification VALUES ('0630fcf9-8646-43e5-b7b1-aac554816200', '2025-04-01 07:17:45.64573+00', '2025-04-01 15:39:06.059011+00', 'Jane Miller sent you a friend request', true, false, 'FRIEND_REQUEST', '6dbb011a-2beb-4fc4-97c3-666c1bef560d', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.notification VALUES ('5c7a747c-4fce-46e3-bab2-38d82a2f117a', '2025-04-01 12:13:10.975108+00', '2025-04-01 15:39:06.063312+00', 'Jane Miller sent you a friend request', true, false, 'FRIEND_REQUEST', '6dbb011a-2beb-4fc4-97c3-666c1bef560d', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.notification VALUES ('b66bc50a-d592-4bd6-9d99-0200ee14ad85', '2025-04-01 15:38:52.139786+00', '2025-04-01 15:39:06.067074+00', 'Alice Thompson liked your comment', true, false, 'COMMENT_LIKED', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.notification VALUES ('b916ab89-b7a5-4423-962c-9e08464ee27d', '2025-04-02 03:31:13.672972+00', '2025-04-02 03:31:13.672972+00', 'Alice Thompson sent you a friend request', false, false, 'FRIEND_REQUEST', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '6432b612-3b2f-4575-8e58-8d49e95455db');
INSERT INTO public.notification VALUES ('579af9db-d51e-402a-8893-765a283e863b', '2025-04-01 17:21:02.768889+00', '2025-04-02 03:34:00.038027+00', 'Alice Thompson liked your comment', true, false, 'COMMENT_LIKED', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.notification VALUES ('9fc304f4-8243-4512-8766-52b44e7519e4', '2025-04-01 17:21:21.788419+00', '2025-04-02 03:34:00.052103+00', 'Robert Doe liked your comment', true, false, 'COMMENT_LIKED', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.notification VALUES ('440b5ebb-0f3b-440c-8009-655b30a73855', '2025-04-02 03:20:14.98225+00', '2025-04-02 03:34:00.056416+00', 'Alice Thompson commented on your post', true, false, 'COMMENT_POST', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.notification VALUES ('bdc76a4b-77f2-4e4f-9640-702831001194', '2025-04-02 03:31:56.25554+00', '2025-04-02 03:34:00.061013+00', 'Adam Newman sent you a friend request', true, false, 'FRIEND_REQUEST', '6432b612-3b2f-4575-8e58-8d49e95455db', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.notification VALUES ('c4f32e20-044e-41b6-b38c-4cb64d4041ef', '2025-04-02 03:31:56.277416+00', '2025-04-02 03:34:00.065916+00', 'Adam Newman accepted your friend request', true, false, 'FRIEND_REQUEST_ACCEPTED', '6432b612-3b2f-4575-8e58-8d49e95455db', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.notification VALUES ('cb94466b-056b-4611-ab53-cf606cc114e1', '2025-04-02 03:32:14.720523+00', '2025-04-02 03:34:00.070554+00', 'Adam Newman sent you a friend request', true, false, 'FRIEND_REQUEST', '6432b612-3b2f-4575-8e58-8d49e95455db', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.notification VALUES ('68f199ec-0437-4af2-94c7-92d3fcc4204a', '2025-04-02 03:33:11.20773+00', '2025-04-02 03:34:00.075785+00', 'Robert Doe sent you a friend request', true, false, 'FRIEND_REQUEST', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.notification VALUES ('c0a89bbf-e888-4ae5-86a4-1387f60d65ac', '2025-04-02 03:33:11.224352+00', '2025-04-02 03:34:00.080341+00', 'Robert Doe accepted your friend request', true, false, 'FRIEND_REQUEST_ACCEPTED', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.notification VALUES ('b43f42a5-6cd7-494c-8517-83f58b12ff77', '2025-04-01 12:13:28.274467+00', '2025-04-05 15:26:07.539128+00', 'Alice Thompson sent you a friend request', true, false, 'FRIEND_REQUEST', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023');
INSERT INTO public.notification VALUES ('ca71bee9-38b1-4624-9d54-0f8be4d9cadf', '2025-04-01 12:13:28.292918+00', '2025-04-05 15:26:07.545953+00', 'Alice Thompson accepted your friend request', true, false, 'FRIEND_REQUEST_ACCEPTED', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023');
INSERT INTO public.notification VALUES ('c398541f-9910-42a6-8756-9589f3f0da02', '2025-04-01 14:40:50.936728+00', '2025-04-05 15:26:07.549624+00', 'Alice Thompson liked your post', true, false, 'LIKE_POST', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023');
INSERT INTO public.notification VALUES ('5ee77fa4-a920-4984-9e99-3efa09bbf131', '2025-04-01 17:21:00.394439+00', '2025-04-05 15:26:07.552756+00', 'Alice Thompson commented on your post', true, false, 'COMMENT_POST', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023');
INSERT INTO public.notification VALUES ('d4392f5f-4225-4a91-bd58-9e824b4da65f', '2025-04-02 03:32:54.587947+00', '2025-04-05 15:26:07.555957+00', 'Alice Thompson sent you a friend request', true, false, 'FRIEND_REQUEST', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023');
INSERT INTO public.notification VALUES ('9a003a9a-f393-4def-ab24-a31c7a332e3d', '2025-04-02 06:22:30.342633+00', '2025-04-05 15:26:07.560099+00', 'Alice Thompson liked your comment', true, false, 'COMMENT_LIKED', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023');
INSERT INTO public.notification VALUES ('c88a6fa7-e354-4b31-86a0-355e5439f0ea', '2025-04-05 14:07:04.383195+00', '2025-04-05 15:26:07.563234+00', 'Alice Thompson liked your post', true, false, 'LIKE_POST', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023');
INSERT INTO public.notification VALUES ('9783acd5-5d94-424f-8c55-c1b38e5170c4', '2025-04-05 14:07:05.722162+00', '2025-04-05 15:26:07.566343+00', 'Alice Thompson commented on your post', true, false, 'COMMENT_POST', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023');
INSERT INTO public.notification VALUES ('672a28c2-567b-4140-9bd5-49f03b11180f', '2025-04-05 16:30:07.092452+00', '2025-04-05 16:30:07.092452+00', 'Alice Thompson sent you a friend request', false, false, 'FRIEND_REQUEST', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023');
INSERT INTO public.notification VALUES ('c405744e-bb07-4e61-ab46-5a29f239da7a', '2025-04-02 03:34:24.906862+00', '2025-04-05 16:31:10.076293+00', 'Robert Doe liked your post', true, false, 'LIKE_POST', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.notification VALUES ('576596a6-f130-4891-bbe7-c26bc95e8723', '2025-04-05 15:26:22.117345+00', '2025-04-05 16:31:10.079932+00', 'Robert Doe liked your post', true, false, 'LIKE_POST', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.notification VALUES ('197a4d5b-cfd9-4e63-91d4-183af353f0c6', '2025-04-05 16:30:27.860066+00', '2025-04-05 16:31:10.08256+00', 'Robert Doe sent you a friend request', true, false, 'FRIEND_REQUEST', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.notification VALUES ('d09fcfd6-9ff9-4b59-b63b-b53c674ee4ac', '2025-04-05 16:30:27.874183+00', '2025-04-05 16:31:10.084641+00', 'Robert Doe accepted your friend request', true, false, 'FRIEND_REQUEST_ACCEPTED', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.notification VALUES ('3454d5c2-a468-4baa-88a1-92ab6280505f', '2025-04-09 13:32:03.552441+00', '2025-04-09 13:32:03.552441+00', 'Alice Thompson liked your post', false, false, 'LIKE_POST', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.notification VALUES ('f71ebf69-b7d9-4d88-9b01-0e2d23ced157', '2025-04-12 03:10:18.873671+00', '2025-04-12 03:10:18.873671+00', 'Alice Thompson commented on your post', false, false, 'COMMENT_POST', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023');
INSERT INTO public.notification VALUES ('fcf4876e-d9c0-4f59-9574-5a2f057c862a', '2025-04-12 03:10:20.458537+00', '2025-04-12 03:10:20.458537+00', 'Alice Thompson liked your comment', false, false, 'COMMENT_LIKED', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.notification VALUES ('b5b0fa9a-2e9c-4e52-9645-43bfb9023d10', '2025-04-12 03:10:42.988676+00', '2025-04-12 03:10:42.988676+00', 'Alice Thompson commented on your post', false, false, 'COMMENT_POST', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.notification VALUES ('fd9fb6cb-9505-4065-a87c-a21d30c499fd', '2025-04-12 03:11:34.386183+00', '2025-04-12 03:11:34.386183+00', 'Alice Thompson liked your post', false, false, 'LIKE_POST', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023');
INSERT INTO public.notification VALUES ('a95b7ba5-62d9-48bc-92c4-9b873bd72757', '2025-04-12 03:12:03.092633+00', '2025-04-12 03:12:03.092633+00', 'Alice Thompson liked your comment', false, false, 'COMMENT_LIKED', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.notification VALUES ('8e29cf62-7ef1-4d4c-81c1-ff7023a03aae', '2025-04-12 03:12:13.099016+00', '2025-04-12 03:12:13.099016+00', 'Alice Thompson liked your post', false, false, 'LIKE_POST', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023');
INSERT INTO public.notification VALUES ('b2c50c39-7413-417b-9783-90a92c4d34b5', '2025-04-12 14:00:50.627459+00', '2025-04-12 14:00:50.627459+00', 'Alice Thompson liked your post', false, false, 'LIKE_POST', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.notification VALUES ('fc6d1bdc-7241-49ab-adff-48751aff4451', '2025-04-16 16:46:51.358127+00', '2025-04-16 16:46:51.358127+00', 'Alice Thompson liked your post', false, false, 'LIKE_POST', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.notification VALUES ('aa0234f5-a905-47cd-9a2d-499a68d3b262', '2025-04-16 16:47:17.253192+00', '2025-04-16 16:47:17.253192+00', 'Alice Thompson liked your post', false, false, 'LIKE_POST', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');
INSERT INTO public.notification VALUES ('3f2d84a6-e375-462c-ba50-5d30bde683b9', '2025-04-17 03:15:56.672828+00', '2025-04-17 03:15:56.672828+00', 'Alice Thompson liked your post', false, false, 'LIKE_POST', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');


--
-- TOC entry 3588 (class 0 OID 204931)
-- Dependencies: 237
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.orders VALUES ('ec3f4230-58c4-47a6-bc25-a60935d748e1', '2025-04-17 08:52:05.393012+00', '2025-04-17 08:52:07.064392+00', 'LBC74E', 20500.00, '699, tổ 17, Mỹ Phó, Mỹ Đức, Châu Phú, AG', 1758, '2025-04-19 16:59:59+00', 'LBC74E', 'Alice Thompson', '0364484261', 'PENDING', '510809', 'PENDING', 1450000.00, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '53321', '2', '50');
INSERT INTO public.orders VALUES ('fe96f029-005c-4b71-b14b-acb5162c9492', '2025-04-17 08:53:47.826522+00', '2025-04-17 08:53:48.828194+00', 'LBC7KQ', 20500.00, '699, tổ 17, Mỹ Phó, Mỹ Đức, Châu Phú, AG', 1758, '2025-04-19 16:59:59+00', 'LBC7KQ', 'Alice Thompson', '0364484261', 'PENDING', '510809', 'PENDING', 34999000.00, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '53321', '2', '100');
INSERT INTO public.orders VALUES ('d2733844-c185-4eba-8425-1aa92643ace6', '2025-04-17 08:54:27.656639+00', '2025-04-17 08:54:28.847871+00', 'LBC7KL', 20500.00, '699, tổ 17, Mỹ Phó, Mỹ Đức, Châu Phú, AG', 1758, '2025-04-19 16:59:59+00', 'LBC7KL', 'Alice Thompson', '0364484261', 'PENDING', '510809', 'PENDING', 36449000.00, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '53321', '2', '150');
INSERT INTO public.orders VALUES ('b45f66eb-e712-4889-83d8-94f6942580f1', '2025-04-20 13:57:24.679547+00', '2025-04-20 13:57:26.063286+00', 'LBCPQK', 20500.00, '699, tổ 17, Mỹ Phó, Mỹ Đức, Châu Phú, AG', 1758, '2025-04-23 16:59:59+00', 'LBCPQK', 'Alice Thompson', '0364484261', 'PENDING', '510809', 'PENDING', 1900000.00, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '53321', '2', '1600');
INSERT INTO public.orders VALUES ('9d8b0533-26d2-4cbe-b5d7-dd5580cd8b41', '2025-04-16 15:25:28.078844+00', '2025-04-16 15:25:29.634904+00', 'LBUYGE', 20500.00, '699, tổ 17, Mỹ Phó, Mỹ Đức, Châu Phú, AG', 1758, '2025-04-19 16:59:59+00', 'LBUYGE', 'Alice Thompson', '0364484261', 'PENDING', '510809', 'PENDING', 1450000.00, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '53321', '2', '50');
INSERT INTO public.orders VALUES ('bd78f2ca-3d4c-4d00-8758-7339628ed2c5', '2025-04-16 16:02:22.297739+00', '2025-04-16 16:02:23.625556+00', 'LBUYUD', 20500.00, '699, tổ 17, Mỹ Phó, Mỹ Đức, Châu Phú, AG', 1758, '2025-04-19 16:59:59+00', 'LBUYUD', 'Alice Thompson', '0364484261', 'PENDING', '510809', 'PENDING', 2900000.00, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '53321', '2', '100');
INSERT INTO public.orders VALUES ('c099dcb7-be14-4f64-b7af-f95f44806b7c', '2025-04-16 16:32:20.739992+00', '2025-04-16 16:32:22.45991+00', 'LBUYUB', 20500.00, '699, tổ 17, Mỹ Phó, Mỹ Đức, Châu Phú, AG', 1758, '2025-04-19 16:59:59+00', 'LBUYUB', 'Alice Thompson', '0364484261', 'PENDING', '510809', 'PENDING', 34999000.00, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '53321', '2', '100');
INSERT INTO public.orders VALUES ('29e2744e-f772-4823-928c-ac9073eea52b', '2025-04-16 16:40:05.814437+00', '2025-04-16 16:40:07.538409+00', 'LBUYU3', 20500.00, '699, tổ 17, Mỹ Phó, Mỹ Đức, Châu Phú, AG', 1758, '2025-04-19 16:59:59+00', 'LBUYU3', 'Alice Thompson', '0364484261', 'PENDING', '510809', 'PENDING', 2900000.00, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '53321', '2', '100');
INSERT INTO public.orders VALUES ('aa15ee5f-f202-43db-bd57-7f6f10d11682', '2025-04-17 07:53:13.406632+00', '2025-04-17 07:53:14.956646+00', 'LBCLPC', 20500.00, '699, tổ 17, Mỹ Phó, Mỹ Đức, Châu Phú, AG', 1758, '2025-04-19 16:59:59+00', 'LBCLPC', 'Alice Thompson', '0364484261', 'PENDING', '510809', 'PENDING', 2400000.00, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '53321', '2', '850');
INSERT INTO public.orders VALUES ('a180b205-20b8-4781-8b1d-4d617465f260', '2025-04-17 08:23:25.540664+00', '2025-04-17 08:23:26.680127+00', 'LBCFTC', 20500.00, '699, tổ 17, Mỹ Phó, Mỹ Đức, Châu Phú, AG', 1758, '2025-04-19 16:59:59+00', 'LBCFTC', 'Alice Thompson', '0364484261', 'PENDING', '510809', 'PENDING', 37399000.00, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '53321', '2', '950');
INSERT INTO public.orders VALUES ('d8d6c70f-31d7-4c40-8acc-9d5d57b9dc00', '2025-04-17 08:48:13.352913+00', '2025-04-17 08:48:14.661116+00', 'LBC74M', 20500.00, '699, tổ 17, Mỹ Phó, Mỹ Đức, Châu Phú, AG', 1758, '2025-04-19 16:59:59+00', 'LBC74M', 'Alice Thompson', '0364484261', 'PENDING', '510809', 'PENDING', 4350000.00, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '53321', '2', '150');
INSERT INTO public.orders VALUES ('90671a37-d422-4fae-b9b4-8742237d377f', '2025-04-20 14:01:37.753683+00', '2025-04-20 14:01:39.364641+00', 'LBCPQW', 20500.00, '699, tổ 17, Mỹ Phó, Mỹ Đức, Châu Phú, AG', 1758, '2025-04-23 16:59:59+00', 'LBCPQW', 'Alice Thompson', '0364484261', 'PENDING', '510809', 'PENDING', 34999000.00, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '53321', '2', '100');
INSERT INTO public.orders VALUES ('4ba5a76f-142e-447e-b444-0d171549d1f1', '2025-04-20 14:56:06.042856+00', '2025-04-20 14:56:07.704246+00', 'LBCPQA', 20500.00, '699, tổ 17, Mỹ Phó, Mỹ Đức, Châu Phú, AG', 1758, '2025-04-23 16:59:59+00', 'LBCPQA', 'Alice Thompson', '0364484261', 'PENDING', '510809', 'PENDING', 1450000.00, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '53321', '2', '50');


--
-- TOC entry 3589 (class 0 OID 204940)
-- Dependencies: 238
-- Data for Name: payment; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.payment VALUES ('9534ff46-fc51-43f3-bac6-5865620c136b', '2025-04-17 08:52:05.394054+00', '2025-04-17 08:52:07.064392+00', 1586500.00, 'COD', 'PENDING', NULL, 'ec3f4230-58c4-47a6-bc25-a60935d748e1');
INSERT INTO public.payment VALUES ('1bd81c0f-a558-4fcb-87eb-39f43dbd5624', '2025-04-17 08:53:47.827575+00', '2025-04-17 08:53:48.828194+00', 37819420.00, 'COD', 'PENDING', NULL, 'fe96f029-005c-4b71-b14b-acb5162c9492');
INSERT INTO public.payment VALUES ('7c79d8b5-36fa-459b-a279-5195e6f6e8d9', '2025-04-17 08:54:27.660317+00', '2025-04-17 08:54:28.84842+00', 39385420.00, 'COD', 'PENDING', NULL, 'd2733844-c185-4eba-8425-1aa92643ace6');
INSERT INTO public.payment VALUES ('a7768008-8375-4474-9931-a77ae538d7f0', '2025-04-20 13:57:24.690061+00', '2025-04-20 13:58:50.059432+00', 2072500.00, 'VNPAY', 'SUCCESS', '14916971', 'b45f66eb-e712-4889-83d8-94f6942580f1');
INSERT INTO public.payment VALUES ('878e3de6-8fd9-4b41-aefb-c53a94a1471b', '2025-04-20 14:01:37.755778+00', '2025-04-20 14:01:39.364641+00', 37819420.00, 'COD', 'PENDING', NULL, '90671a37-d422-4fae-b9b4-8742237d377f');
INSERT INTO public.payment VALUES ('532db2c4-6ee8-4c47-8ac7-81eb33daef2b', '2025-04-20 14:56:06.046009+00', '2025-04-20 14:56:22.470274+00', 1586500.00, 'VNPAY', 'FAILED', '0', '4ba5a76f-142e-447e-b444-0d171549d1f1');
INSERT INTO public.payment VALUES ('9201ae6c-eed9-4746-a4e5-285d5f0157af', '2025-04-16 15:25:28.080406+00', '2025-04-16 15:28:01.251455+00', 1586500.00, 'VNPAY', 'SUCCESS', '14910821', '9d8b0533-26d2-4cbe-b5d7-dd5580cd8b41');
INSERT INTO public.payment VALUES ('a2bd549d-0235-4a10-accb-3f9e6d6592b5', '2025-04-16 16:02:22.311556+00', '2025-04-16 16:02:23.625556+00', 3152500.00, 'COD', 'PENDING', NULL, 'bd78f2ca-3d4c-4d00-8758-7339628ed2c5');
INSERT INTO public.payment VALUES ('a188e3a3-e550-449f-bb35-deefd5683f7e', '2025-04-16 16:32:20.742669+00', '2025-04-16 16:32:22.45991+00', 37819420.00, 'COD', 'PENDING', NULL, 'c099dcb7-be14-4f64-b7af-f95f44806b7c');
INSERT INTO public.payment VALUES ('09abe5b6-b645-4acb-ab1d-d01f709cc1b6', '2025-04-16 16:40:05.816514+00', '2025-04-16 16:40:44.287264+00', 3152500.00, 'VNPAY', 'SUCCESS', '14910952', '29e2744e-f772-4823-928c-ac9073eea52b');
INSERT INTO public.payment VALUES ('c8a88218-75f0-4171-af64-aad7fbbfdd5f', '2025-04-17 07:53:13.425766+00', '2025-04-17 07:53:49.049268+00', 2612500.00, 'VNPAY', 'SUCCESS', '14911858', 'aa15ee5f-f202-43db-bd57-7f6f10d11682');
INSERT INTO public.payment VALUES ('d404b9f2-b5ba-4e53-ad4d-5119244ec868', '2025-04-17 08:23:25.548015+00', '2025-04-17 08:23:26.68065+00', 40411420.00, 'COD', 'PENDING', NULL, 'a180b205-20b8-4781-8b1d-4d617465f260');
INSERT INTO public.payment VALUES ('d942d081-2253-4e2e-9e40-16221f12e8c3', '2025-04-17 08:48:13.355006+00', '2025-04-17 08:48:14.661116+00', 4718500.00, 'COD', 'PENDING', NULL, 'd8d6c70f-31d7-4c40-8acc-9d5d57b9dc00');


--
-- TOC entry 3577 (class 0 OID 90308)
-- Dependencies: 226
-- Data for Name: post; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.post VALUES ('e1a41217-d1d5-4729-950d-da89226d3668', '2025-03-27 14:33:46.04716+00', '2025-03-28 04:01:25.535618+00', 0, 'Tạo bài viết vào 3/27/2025 9:33, cố gắng hoàn thành xong post..', NULL, 0, 1, 0, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'b8e2c6c2-aab6-488e-bf00-a88f0c998bb3', 0);
INSERT INTO public.post VALUES ('4d4e565c-c6fb-47b8-9bbd-96d9b581c5fc', '2025-03-28 07:17:12.801466+00', '2025-03-28 12:20:30.108728+00', 0, '[Updated] Test lại update bài viết..', NULL, 1, 1, 0, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '7b30a1cd-b808-4b2a-b7bf-770011b5ae8c', 0);
INSERT INTO public.post VALUES ('e1ebae5a-75ae-4a67-abff-2fe960a96f28', '2025-03-28 07:25:43.556568+00', '2025-03-28 07:30:57.735469+00', 0, 'Bài viết mới nhất, mới nhất', NULL, 0, 1, 0, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '7b30a1cd-b808-4b2a-b7bf-770011b5ae8c', 1);
INSERT INTO public.post VALUES ('4ef86bf1-8ae4-4360-858c-b3b07af5edfd', '2025-03-27 17:30:46.316907+00', '2025-03-28 01:25:54.335955+00', 0, 'Test lại delete sau khi thực hiện set status thay vì xóa trực tiếp.', NULL, 0, 1, 0, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'b8e2c6c2-aab6-488e-bf00-a88f0c998bb3', 1);
INSERT INTO public.post VALUES ('7ab56123-33fc-4067-b5fa-7e513c6bc865', '2025-03-27 13:20:41.508788+00', '2025-03-28 01:58:08.98967+00', 0, 'Hoàn thành Instant.now() to get value of Date when creating Post onbject và thực hiện insert có Images', NULL, 0, 1, 0, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '6b308001-c009-4897-b0fa-bd8f7668adb9', 1);
INSERT INTO public.post VALUES ('3c42346c-8eba-4b05-947d-6915aecbf4c0', '2025-03-28 14:47:41.753595+00', '2025-03-28 14:47:47.073821+00', 0, 'Thêm bài viết và xóa bài viết', NULL, 0, 1, 0, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'e02d98de-b3d4-4497-801a-1be32fdb6442', 1);
INSERT INTO public.post VALUES ('7168c964-ffb3-4f17-a66c-8bafee3c2434', '2025-03-28 02:18:29.70491+00', '2025-03-28 03:09:17.271664+00', 0, 'Test create new post', NULL, 0, 1, 0, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'b8e2c6c2-aab6-488e-bf00-a88f0c998bb3', 1);
INSERT INTO public.post VALUES ('147d7a63-716a-4d89-b4b6-0b6c6b81a163', '2025-03-28 08:08:23.824756+00', '2025-03-28 08:37:39.767485+00', 0, 'Bài viết mới tinh nè!!', NULL, 1, 1, 0, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'b8e2c6c2-aab6-488e-bf00-a88f0c998bb3', 0);
INSERT INTO public.post VALUES ('1b4c8f65-8ecf-481b-900a-a3285f9ae066', '2025-03-27 12:41:51.107728+00', '2025-03-27 12:41:51.108243+00', 0, 'Fix new post creation', NULL, 0, 1, 0, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '7b30a1cd-b808-4b2a-b7bf-770011b5ae8c', 0);
INSERT INTO public.post VALUES ('87820a0e-362b-45bc-a4cd-63fe85fa05db', '2025-04-09 13:31:56.412689+00', '2025-04-09 13:31:56.431989+00', 0, 'Test lại post bài mới nè', NULL, 1, 1, 0, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'e02d98de-b3d4-4497-801a-1be32fdb6442', 0);
INSERT INTO public.post VALUES ('64e572b0-e642-43da-942c-ad396362b992', '2025-03-25 16:22:17.859139+00', '2025-03-25 16:22:17.859659+00', 2, 'Test post_count topic of redis pub-sub 4', NULL, 0, 1, 0, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '6b308001-c009-4897-b0fa-bd8f7668adb9', 0);
INSERT INTO public.post VALUES ('56c87905-81cf-4cbb-87e2-7622fcbc783b', '2025-03-28 04:26:44.847347+00', '2025-03-28 04:26:46.844908+00', 0, 'sdfsdf', NULL, 0, 1, 0, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '7b30a1cd-b808-4b2a-b7bf-770011b5ae8c', 1);
INSERT INTO public.post VALUES ('724c0815-0a61-43ff-9084-13f3967ea821', '2025-04-01 14:41:48.114403+00', '2025-04-01 15:34:25.15457+00', 0, 'content', NULL, 0, 1, 0, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '18d68504-4a27-40f8-a92b-535112340ed9', 1);
INSERT INTO public.post VALUES ('8b4aaa31-187b-4e76-9a3a-e167da94eaca', '2025-03-25 16:21:27.635415+00', '2025-03-25 16:21:27.635942+00', 0, 'Test post_count topic of redis pub-sub 4', NULL, 0, 1, 0, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '6b308001-c009-4897-b0fa-bd8f7668adb9', 0);
INSERT INTO public.post VALUES ('fcf12600-584b-45d9-ba00-97e027555289', '2025-03-29 09:51:36.130152+00', '2025-03-29 09:51:38.073856+00', 0, 'asdasdasd', NULL, 0, 1, 0, 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'e02d98de-b3d4-4497-801a-1be32fdb6442', 1);
INSERT INTO public.post VALUES ('91933df0-1993-4303-ae8e-a0ec797990e6', '2025-03-25 16:21:19.506172+00', '2025-03-25 16:21:19.507219+00', 0, 'Test post_count topic of redis pub-sub 4', NULL, 0, 1, 0, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '6b308001-c009-4897-b0fa-bd8f7668adb9', 0);
INSERT INTO public.post VALUES ('fab6e97f-960b-4a2f-baa1-c9814a31f67d', '2025-03-25 16:22:16.019838+00', '2025-03-25 16:22:16.020361+00', 0, 'Test post_count topic of redis pub-sub 4', NULL, 0, 1, 0, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '6b308001-c009-4897-b0fa-bd8f7668adb9', 0);
INSERT INTO public.post VALUES ('8ca73f17-66bb-4c5d-8d6b-dd897b01b510', '2025-03-16 19:13:38.362963+00', '2025-03-16 19:13:38.362963+00', 0, 'Test post_count topic of redis pub-sub', '', 0, 1, 0, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '6b308001-c009-4897-b0fa-bd8f7668adb9', 0);
INSERT INTO public.post VALUES ('638ef8bc-ff2c-4475-8f1d-0f8e5ad6fb93', '2025-03-27 13:19:07.042096+00', '2025-03-27 13:19:07.066349+00', 0, 'Fix new post creation', NULL, 0, 1, 0, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '7b30a1cd-b808-4b2a-b7bf-770011b5ae8c', 0);
INSERT INTO public.post VALUES ('2a9e6f38-c82f-4212-a064-0c8b35326d67', '2025-03-25 16:21:55.704181+00', '2025-03-25 16:21:55.705221+00', 0, 'Test post_count topic of redis pub-sub 4', NULL, 0, 1, 0, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '6b308001-c009-4897-b0fa-bd8f7668adb9', 0);
INSERT INTO public.post VALUES ('e86e7d2d-a3b2-4c02-a672-b5a662906bbc', '2025-03-25 12:04:05.633779+00', '2025-03-25 12:04:05.637446+00', 0, 'Test post_count topic of redis pub-sub 4', NULL, 0, 1, 0, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '6b308001-c009-4897-b0fa-bd8f7668adb9', 0);
INSERT INTO public.post VALUES ('cb8f5bb1-1a52-430c-a53c-6cb39ad714de', '2025-03-25 16:21:23.704811+00', '2025-03-25 16:21:23.705334+00', 0, 'Test post_count topic of redis pub-sub 4', NULL, 0, 1, 0, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '6b308001-c009-4897-b0fa-bd8f7668adb9', 0);
INSERT INTO public.post VALUES ('fdc852a9-e3d8-4da3-877f-3c27c0a71286', '2025-03-27 12:41:27.404552+00', '2025-03-27 12:41:27.410321+00', 0, 'Fix new post creation', NULL, 0, 1, 0, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '7b30a1cd-b808-4b2a-b7bf-770011b5ae8c', 0);
INSERT INTO public.post VALUES ('2ef15eb7-94f4-4fbd-86dd-2141a7196ce8', '2025-03-25 16:21:14.870203+00', '2025-03-25 16:21:14.874944+00', 0, 'Test post_count topic of redis pub-sub 4', NULL, 0, 1, 0, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '6b308001-c009-4897-b0fa-bd8f7668adb9', 0);
INSERT INTO public.post VALUES ('466d1b2d-9388-4e85-ad15-eb0288ca3f23', '2025-03-25 16:21:53.072263+00', '2025-03-25 16:21:53.072791+00', 0, 'Test post_count topic of redis pub-sub 4', NULL, 0, 1, 0, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '6b308001-c009-4897-b0fa-bd8f7668adb9', 0);
INSERT INTO public.post VALUES ('22bc06d0-f04b-4cb9-9015-0cea7afd3b06', '2025-03-25 16:22:14.696998+00', '2025-03-25 16:22:14.698056+00', 0, 'Test post_count topic of redis pub-sub 4', NULL, 0, 1, 0, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '6b308001-c009-4897-b0fa-bd8f7668adb9', 0);
INSERT INTO public.post VALUES ('1515934e-192e-401d-a9bf-b9d71b19bf0c', '2025-03-21 17:58:57.140765+00', '2025-03-21 17:58:57.140765+00', 0, 'Test post_count topic of redis pub-sub 4', '', 0, 1, 0, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '6b308001-c009-4897-b0fa-bd8f7668adb9', 0);
INSERT INTO public.post VALUES ('8cfb6584-8ac4-4ae7-a831-b55c63555ff8', '2025-03-27 12:34:47.300169+00', '2025-03-27 12:34:47.305975+00', 0, 'Fix new post creation', NULL, 0, 1, 0, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '6b308001-c009-4897-b0fa-bd8f7668adb9', 0);
INSERT INTO public.post VALUES ('2059a489-d5b0-45b0-b289-5e29ff04d718', '2025-03-25 16:22:16.988448+00', '2025-03-25 16:22:16.988971+00', 0, 'Test post_count topic of redis pub-sub 4', NULL, 0, 1, 0, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '6b308001-c009-4897-b0fa-bd8f7668adb9', 0);
INSERT INTO public.post VALUES ('a44782c5-9c51-412c-91f4-15a7a847e9b6', '2025-03-27 13:20:13.890369+00', '2025-03-27 13:20:13.89876+00', 0, 'Hoàn thành Instant.now() to get value of Date when creating Post onbject', NULL, 0, 1, 0, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '7b30a1cd-b808-4b2a-b7bf-770011b5ae8c', 0);
INSERT INTO public.post VALUES ('9df60ee1-81d7-4266-b61d-a5e1be9b7760', '2025-03-16 19:32:31.05823+00', '2025-03-16 19:32:31.05823+00', 0, 'Test post_count topic of redis pub-sub 2', '', 0, 1, 0, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '6b308001-c009-4897-b0fa-bd8f7668adb9', 0);
INSERT INTO public.post VALUES ('14cb3ffa-c451-4b46-bd23-cddf066d8e0c', '2025-03-25 16:21:31.228058+00', '2025-03-25 16:21:31.229094+00', 0, 'Test post_count topic of redis pub-sub 4', NULL, 0, 1, 0, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '6b308001-c009-4897-b0fa-bd8f7668adb9', 0);
INSERT INTO public.post VALUES ('d806d86b-1215-428b-bd52-024949addff4', '2025-03-28 12:07:50.912639+00', '2025-03-28 12:07:56.476044+00', 0, 'Test bài viết mới nhất nè', NULL, 0, 1, 0, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '68ed71e2-8e0f-43fd-a049-991594ebedc2', 1);
INSERT INTO public.post VALUES ('4b4c7689-f154-4898-9398-28a164d9eeef', '2025-03-30 06:54:59.514086+00', '2025-03-30 07:51:55.351576+00', 2, 'Bài viết mới nhất của Robert Doe.', NULL, 2, 1, 0, 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '7b30a1cd-b808-4b2a-b7bf-770011b5ae8c', 0);
INSERT INTO public.post VALUES ('04eef85b-ce0e-40d5-9ceb-33bb39fa0c65', '2025-03-29 12:16:53.138741+00', '2025-04-16 16:47:02.142548+00', 2, 'test load account nè', NULL, 2, 1, 0, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '7b30a1cd-b808-4b2a-b7bf-770011b5ae8c', 0);
INSERT INTO public.post VALUES ('16fb0ef3-7b9f-4868-9ea0-eaa98bda0130', '2025-03-28 09:00:44.464964+00', '2025-04-14 03:01:54.556009+00', 4, 'Low G from the one to the three.. LowGG', NULL, 2, 1, 0, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '12722c8b-8ab1-4bd5-9be4-1fcd3af373e7', 0);
INSERT INTO public.post VALUES ('133581bf-a841-4ab0-8a8b-18d5d38ffcce', '2025-03-30 03:29:21.79388+00', '2025-03-30 03:29:21.805124+00', 0, 'Test profile page load hình ảnh', NULL, 2, 1, 0, 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '12722c8b-8ab1-4bd5-9be4-1fcd3af373e7', 0);
INSERT INTO public.post VALUES ('19cb14f2-cf63-40e3-bc0d-60e405abb64f', '2025-03-27 14:56:18.815027+00', '2025-03-28 14:45:58.487846+00', 2, 'Bob test bài viết mới đây. 
Thực trạng đáng buồn: Sang Campuchia bị lừa, giải cứu đưa về nước lần 1. Tiếp tục sang lại bị lừa, giải cứu lần 2...', NULL, 2, 1, 0, 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '6b308001-c009-4897-b0fa-bd8f7668adb9', 0);
INSERT INTO public.post VALUES ('05c3b3de-e46a-4f0d-90cd-faea14924c56', '2025-03-28 01:10:54.204963+00', '2025-04-18 18:45:11.151772+00', 0, 'Test lại new post.', NULL, 1, 1, 0, '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '6b308001-c009-4897-b0fa-bd8f7668adb9', 0);


--
-- TOC entry 3586 (class 0 OID 163971)
-- Dependencies: 235
-- Data for Name: post_images; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.post_images VALUES ('e86e7d2d-a3b2-4c02-a672-b5a662906bbc', 'a142a0db-9f0e-4fde-b8c7-58808751d9c5');
INSERT INTO public.post_images VALUES ('e86e7d2d-a3b2-4c02-a672-b5a662906bbc', '3dd8e3fa-8493-4cb4-8136-47d46742a428');
INSERT INTO public.post_images VALUES ('e86e7d2d-a3b2-4c02-a672-b5a662906bbc', '32655aae-24ab-47fe-b124-81f9a8f1b30f');
INSERT INTO public.post_images VALUES ('2ef15eb7-94f4-4fbd-86dd-2141a7196ce8', 'f6265d3b-8d6c-45aa-af8f-2bcc97888fff');
INSERT INTO public.post_images VALUES ('91933df0-1993-4303-ae8e-a0ec797990e6', '5bcdcad0-816e-4371-94a7-b8e946d7fb3e');
INSERT INTO public.post_images VALUES ('cb8f5bb1-1a52-430c-a53c-6cb39ad714de', '64f3b5ab-f1cd-4808-902e-3f6eb0e6a943');
INSERT INTO public.post_images VALUES ('8b4aaa31-187b-4e76-9a3a-e167da94eaca', '72924ce8-9a99-46e8-bd19-f8409b3b384c');
INSERT INTO public.post_images VALUES ('14cb3ffa-c451-4b46-bd23-cddf066d8e0c', '1a107940-9736-4217-afc4-9c0efb246d17');
INSERT INTO public.post_images VALUES ('14cb3ffa-c451-4b46-bd23-cddf066d8e0c', 'dcb5a06a-efbe-456c-ba37-9aa865abe467');
INSERT INTO public.post_images VALUES ('466d1b2d-9388-4e85-ad15-eb0288ca3f23', '5ef5d610-8d25-4d8b-ad6d-cf51c9ad38c0');
INSERT INTO public.post_images VALUES ('466d1b2d-9388-4e85-ad15-eb0288ca3f23', 'f4a7a05e-2b37-48ab-a4ee-1102790ee27c');
INSERT INTO public.post_images VALUES ('466d1b2d-9388-4e85-ad15-eb0288ca3f23', 'c99ae2fd-06f1-4b8b-8930-353a733d4e89');
INSERT INTO public.post_images VALUES ('2a9e6f38-c82f-4212-a064-0c8b35326d67', 'b288244c-e626-4898-b6c9-c0f01ff21317');
INSERT INTO public.post_images VALUES ('2a9e6f38-c82f-4212-a064-0c8b35326d67', 'ec391660-9907-47cb-9c5d-053d332387d7');
INSERT INTO public.post_images VALUES ('22bc06d0-f04b-4cb9-9015-0cea7afd3b06', 'ead11f06-c27c-412c-b54e-b1934150fc61');
INSERT INTO public.post_images VALUES ('22bc06d0-f04b-4cb9-9015-0cea7afd3b06', '371baef5-32d6-483c-8091-396bd52ee53a');
INSERT INTO public.post_images VALUES ('22bc06d0-f04b-4cb9-9015-0cea7afd3b06', '145735e7-eaef-494f-b2b7-a3e69e2ccbea');
INSERT INTO public.post_images VALUES ('fab6e97f-960b-4a2f-baa1-c9814a31f67d', '57318ecf-1e94-45f2-85b2-48b4b2a0572e');
INSERT INTO public.post_images VALUES ('fab6e97f-960b-4a2f-baa1-c9814a31f67d', '58f616a6-122a-42c3-b16a-380b67e002bd');
INSERT INTO public.post_images VALUES ('fab6e97f-960b-4a2f-baa1-c9814a31f67d', '5c8c759e-2be5-4e31-8aa3-7adaf0cb11e3');
INSERT INTO public.post_images VALUES ('2059a489-d5b0-45b0-b289-5e29ff04d718', '50e6d4cb-7246-41d4-a921-4f74a7f7219b');
INSERT INTO public.post_images VALUES ('2059a489-d5b0-45b0-b289-5e29ff04d718', '5c102b29-fa58-4190-a5e6-10b836d3ec6a');
INSERT INTO public.post_images VALUES ('2059a489-d5b0-45b0-b289-5e29ff04d718', '14a3928a-cb36-4298-a192-b95028b56255');
INSERT INTO public.post_images VALUES ('64e572b0-e642-43da-942c-ad396362b992', '2771e0e2-65e4-473d-8cde-3947e80b1145');
INSERT INTO public.post_images VALUES ('64e572b0-e642-43da-942c-ad396362b992', '04f80dac-99e3-4126-9893-f06b079eca91');
INSERT INTO public.post_images VALUES ('64e572b0-e642-43da-942c-ad396362b992', '4ab49e94-384d-4450-bcdb-0e1b8380601d');
INSERT INTO public.post_images VALUES ('8cfb6584-8ac4-4ae7-a831-b55c63555ff8', 'faae26bf-9931-4551-815f-f0663d2c7c18');
INSERT INTO public.post_images VALUES ('8cfb6584-8ac4-4ae7-a831-b55c63555ff8', 'ec15fcc7-f42e-49b9-8760-e773b2a2097d');
INSERT INTO public.post_images VALUES ('fdc852a9-e3d8-4da3-877f-3c27c0a71286', 'a83c52ea-fcb2-4529-8871-5fa2ac2c6a8b');
INSERT INTO public.post_images VALUES ('1b4c8f65-8ecf-481b-900a-a3285f9ae066', '3d7baa82-dc29-4cca-b6e2-b70a3f9fb8bb');
INSERT INTO public.post_images VALUES ('1b4c8f65-8ecf-481b-900a-a3285f9ae066', '44f06695-0b3a-449a-9a53-a3ea632fa0cd');
INSERT INTO public.post_images VALUES ('638ef8bc-ff2c-4475-8f1d-0f8e5ad6fb93', 'c8492515-a4c9-4253-af5b-90d41f75c12a');
INSERT INTO public.post_images VALUES ('7ab56123-33fc-4067-b5fa-7e513c6bc865', '7256a382-f342-4a54-816f-1d107c7dfb9f');
INSERT INTO public.post_images VALUES ('7ab56123-33fc-4067-b5fa-7e513c6bc865', 'a6f888a7-8c5a-4d63-b767-1c7812dca6ba');
INSERT INTO public.post_images VALUES ('e1a41217-d1d5-4729-950d-da89226d3668', 'd50a67f3-d7c6-470a-b5e6-efc728dd5221');
INSERT INTO public.post_images VALUES ('e1a41217-d1d5-4729-950d-da89226d3668', 'a5485b09-40d9-4598-b529-b4c8e23586e5');
INSERT INTO public.post_images VALUES ('e1ebae5a-75ae-4a67-abff-2fe960a96f28', '1315bfdb-9dca-497b-9bbc-b190bcdd1a9d');
INSERT INTO public.post_images VALUES ('147d7a63-716a-4d89-b4b6-0b6c6b81a163', '9ce73f2f-e227-4c24-8e97-b259fbdb3abe');
INSERT INTO public.post_images VALUES ('147d7a63-716a-4d89-b4b6-0b6c6b81a163', 'cedf3520-7db3-44d6-a2f4-2184dbfe4fb2');
INSERT INTO public.post_images VALUES ('d806d86b-1215-428b-bd52-024949addff4', '631f80ab-0f0c-4517-995b-c7714e179af3');
INSERT INTO public.post_images VALUES ('d806d86b-1215-428b-bd52-024949addff4', '1a0c36bf-e407-4a31-8f6b-6515d4a1b984');
INSERT INTO public.post_images VALUES ('4d4e565c-c6fb-47b8-9bbd-96d9b581c5fc', '67cad99f-2297-458e-856e-b1b0dfc4650b');
INSERT INTO public.post_images VALUES ('4d4e565c-c6fb-47b8-9bbd-96d9b581c5fc', 'd3ab5227-450e-41a9-bb07-5e7b4b570a5e');
INSERT INTO public.post_images VALUES ('19cb14f2-cf63-40e3-bc0d-60e405abb64f', '5b26f98a-cce2-431d-b35a-5e88aa92f3c3');
INSERT INTO public.post_images VALUES ('133581bf-a841-4ab0-8a8b-18d5d38ffcce', '9f0543aa-587c-430c-9eeb-5d7f361f5172');
INSERT INTO public.post_images VALUES ('4b4c7689-f154-4898-9398-28a164d9eeef', 'dc42532f-a809-4252-bfbe-545308072158');
INSERT INTO public.post_images VALUES ('87820a0e-362b-45bc-a4cd-63fe85fa05db', 'bfcea79c-900f-458f-affc-deb66d3cf0e9');
INSERT INTO public.post_images VALUES ('87820a0e-362b-45bc-a4cd-63fe85fa05db', '1df07f69-7b7f-4c5c-9626-80ba077a5a70');
INSERT INTO public.post_images VALUES ('16fb0ef3-7b9f-4868-9ea0-eaa98bda0130', '5c702229-004c-443e-b33d-0aa208616cbe');
INSERT INTO public.post_images VALUES ('04eef85b-ce0e-40d5-9ceb-33bb39fa0c65', 'f9f31b68-3f46-436a-b45e-c1f4af6b3eaa');
INSERT INTO public.post_images VALUES ('05c3b3de-e46a-4f0d-90cd-faea14924c56', 'cc7d7d54-74af-4cc0-b416-b5f51ccdd7a9');
INSERT INTO public.post_images VALUES ('05c3b3de-e46a-4f0d-90cd-faea14924c56', 'a1300736-d1ff-46b6-9249-d8ec8270f1b8');
INSERT INTO public.post_images VALUES ('05c3b3de-e46a-4f0d-90cd-faea14924c56', '9d0cf573-eee5-485d-8678-6392be93283f');


--
-- TOC entry 3578 (class 0 OID 131202)
-- Dependencies: 227
-- Data for Name: post_liked; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.post_liked VALUES ('d53f782b-780c-4136-be44-89a8b6e680c7', '2025-03-29 09:50:32.929262+00', '2025-03-29 09:50:32.929262+00', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '16fb0ef3-7b9f-4868-9ea0-eaa98bda0130');
INSERT INTO public.post_liked VALUES ('a3c7e1d2-f39b-49bc-a0bb-503b4e8cc09c', '2025-03-30 03:29:42.899189+00', '2025-03-30 03:29:42.899189+00', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '133581bf-a841-4ab0-8a8b-18d5d38ffcce');
INSERT INTO public.post_liked VALUES ('b1ea5c82-b48e-48e6-97a8-f6c6fa4412ad', '2025-03-30 07:17:12.662365+00', '2025-03-30 07:17:12.662365+00', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '19cb14f2-cf63-40e3-bc0d-60e405abb64f');
INSERT INTO public.post_liked VALUES ('4ed82f52-64fa-44e9-9355-db7e758e18ee', '2025-03-30 07:22:40.354538+00', '2025-03-30 07:22:40.354538+00', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '4b4c7689-f154-4898-9398-28a164d9eeef');
INSERT INTO public.post_liked VALUES ('f0629ac7-8c88-424b-9724-e92c2c76548c', '2025-04-01 01:55:36.580468+00', '2025-04-01 01:55:36.580468+00', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '147d7a63-716a-4d89-b4b6-0b6c6b81a163');
INSERT INTO public.post_liked VALUES ('1d0a450e-645a-44b5-b3a1-ad9f321a8ca5', '2025-04-01 07:15:33.002972+00', '2025-04-01 07:15:33.002972+00', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '04eef85b-ce0e-40d5-9ceb-33bb39fa0c65');
INSERT INTO public.post_liked VALUES ('093bb128-8754-4357-abab-16040987e8f1', '2025-04-01 14:40:50.86892+00', '2025-04-01 14:40:50.86892+00', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '133581bf-a841-4ab0-8a8b-18d5d38ffcce');
INSERT INTO public.post_liked VALUES ('969eedd0-7c8b-4714-9ee2-329316718f7f', '2025-04-02 03:34:24.872385+00', '2025-04-02 03:34:24.872385+00', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '05c3b3de-e46a-4f0d-90cd-faea14924c56');
INSERT INTO public.post_liked VALUES ('f1821d3b-9b3b-45a4-afdd-8894832c5bb5', '2025-04-05 15:26:22.094291+00', '2025-04-05 15:26:22.094291+00', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '4d4e565c-c6fb-47b8-9bbd-96d9b581c5fc');
INSERT INTO public.post_liked VALUES ('c7506b30-695a-409c-9fe9-528034b88475', '2025-04-09 13:32:03.506239+00', '2025-04-09 13:32:03.506239+00', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '87820a0e-362b-45bc-a4cd-63fe85fa05db');
INSERT INTO public.post_liked VALUES ('25325c46-016c-4544-8a69-2e0ae54ef756', '2025-04-12 03:11:34.350123+00', '2025-04-12 03:11:34.350123+00', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '19cb14f2-cf63-40e3-bc0d-60e405abb64f');
INSERT INTO public.post_liked VALUES ('b54e11c6-18bf-43dc-a9f7-697facd26b87', '2025-04-12 03:12:13.068281+00', '2025-04-12 03:12:13.068281+00', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '4b4c7689-f154-4898-9398-28a164d9eeef');
INSERT INTO public.post_liked VALUES ('b4e3635b-61a1-461a-a57f-3c0d9d8a4a5b', '2025-04-16 16:47:17.227057+00', '2025-04-16 16:47:17.227057+00', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '04eef85b-ce0e-40d5-9ceb-33bb39fa0c65');
INSERT INTO public.post_liked VALUES ('3d023e97-a083-4771-a29a-e92268f6d82e', '2025-04-17 03:15:56.578606+00', '2025-04-17 03:15:56.578606+00', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '16fb0ef3-7b9f-4868-9ea0-eaa98bda0130');


--
-- TOC entry 3579 (class 0 OID 131207)
-- Dependencies: 228
-- Data for Name: post_saved; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.post_saved VALUES ('70a747ad-2bcd-4a5e-bb21-614dd204484b', '2025-04-01 03:08:15.54514+00', '2025-04-01 03:08:15.54514+00', '71c88d6f-4bbe-41d7-b4d9-ed1e705f7bf5', '16fb0ef3-7b9f-4868-9ea0-eaa98bda0130');
INSERT INTO public.post_saved VALUES ('f58208b0-b088-4be5-b213-7a9db42a5af5', '2025-04-01 12:51:53.907105+00', '2025-04-01 12:51:53.907105+00', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '19cb14f2-cf63-40e3-bc0d-60e405abb64f');
INSERT INTO public.post_saved VALUES ('92fff68d-4fc6-42be-95b5-a51c49fc6946', '2025-04-12 03:13:16.288192+00', '2025-04-12 03:13:16.288192+00', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '16fb0ef3-7b9f-4868-9ea0-eaa98bda0130');
INSERT INTO public.post_saved VALUES ('4dcbf7d9-d2f4-4971-8216-09cb595e485c', '2025-04-16 16:46:55.504311+00', '2025-04-16 16:46:55.504311+00', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '04eef85b-ce0e-40d5-9ceb-33bb39fa0c65');


--
-- TOC entry 3591 (class 0 OID 221315)
-- Dependencies: 240
-- Data for Name: product_comment; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.product_comment VALUES ('1c0305ab-f2a4-456b-af13-ca497c257df5', '2025-04-12 06:40:21.572698+00', '2025-04-12 06:40:21.572698+00', 'Hồ Thanh Duy', 'Quần áo quá đẹp', '585d5ca6-7051-4c67-b269-7480c0612fdd', 5);
INSERT INTO public.product_comment VALUES ('fc99be0b-ff10-4afa-ae61-6373d85cd41f', '2025-04-12 06:41:51.256083+00', '2025-04-12 06:41:51.256083+00', 'Hồ Thanh Duy', 'Quần áo chán quá nhưng mà mặc tạm được nha', 'f12e3f97-8ee4-4959-9611-5e572af6f224', 2);
INSERT INTO public.product_comment VALUES ('d0ec5e52-8896-4725-a7bf-8e64bd8da101', '2025-04-12 06:42:20.053911+00', '2025-04-12 06:42:20.053911+00', 'Hồ Thanh Duy', 'Iphone nhà samsung à ?? mượt quãi', '78f62f3c-0f34-49be-8353-60502966b56c', 4);
INSERT INTO public.product_comment VALUES ('d7dad3d9-7043-4233-8b17-945d2d591d7d', '2025-04-12 06:47:45.6262+00', '2025-04-12 06:47:45.6262+00', 'John Doe', 'Buff bẩn pr sản phẩm mà quá tệ', '78f62f3c-0f34-49be-8353-60502966b56c', 1);
INSERT INTO public.product_comment VALUES ('2ee5e2c9-9ef6-4f86-899a-c64d4f122dd7', '2025-04-12 15:47:32.808653+00', '2025-04-12 15:47:32.808653+00', 'Hồ Thanh Duy', 'Sản phẩm tốt mà nói gì vậy??', '78f62f3c-0f34-49be-8353-60502966b56c', 5);
INSERT INTO public.product_comment VALUES ('c47f4ec5-3c96-4f93-88d9-26e3990926d0', '2025-04-14 07:16:35.797814+00', '2025-04-14 07:16:35.797814+00', 'Hồ Thanh Duy', 'Sản phẩm tốt lắm', 'f12e3f97-8ee4-4959-9611-5e572af6f224', 4);
INSERT INTO public.product_comment VALUES ('e0533c1c-ec98-4cb2-9d01-e82c18558d28', '2025-04-15 14:16:14.527851+00', '2025-04-15 14:16:14.527851+00', 'Nguyễn Văn  A', 'Đánh giá 5 sao', '78f62f3c-0f34-49be-8353-60502966b56c', 5);
INSERT INTO public.product_comment VALUES ('7a6e0260-a7d9-4800-bd31-45ec055bc0d6', '2025-04-15 14:38:22.230951+00', '2025-04-15 14:38:22.230951+00', 'Hồ Thanh Duy', 'AAASASA', '585d5ca6-7051-4c67-b269-7480c0612fdd', 3);
INSERT INTO public.product_comment VALUES ('77f14044-884e-4f98-afa7-94b1193e808b', '2025-04-17 18:23:26.419174+00', '2025-04-17 18:23:26.419174+00', 'Nguyễn Thị A', 'Tốt', 'f12e3f97-8ee4-4959-9611-5e572af6f224', 4);
INSERT INTO public.product_comment VALUES ('292add1b-8234-4d4d-84ec-56f5af5abce1', '2025-04-20 13:44:01.47129+00', '2025-04-20 13:44:01.47129+00', 'Nguyễn Văn A', 'okie quá tốt', '78f62f3c-0f34-49be-8353-60502966b56c', 3);


--
-- TOC entry 3592 (class 0 OID 221322)
-- Dependencies: 241
-- Data for Name: product_liked; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.product_liked VALUES ('cb0b808c-42c9-480b-bd19-770db0f88667', '2025-04-18 18:34:42.658238+00', '2025-04-18 18:34:42.658238+00', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', 'f12e3f97-8ee4-4959-9611-5e572af6f224');
INSERT INTO public.product_liked VALUES ('2bc988ed-1fe1-4019-8a44-0479f13a5797', '2025-04-20 13:42:12.999519+00', '2025-04-20 13:42:12.999519+00', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '78f62f3c-0f34-49be-8353-60502966b56c');


--
-- TOC entry 3593 (class 0 OID 221418)
-- Dependencies: 242
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.products VALUES ('585d5ca6-7051-4c67-b269-7480c0612fdd', '2025-04-12 02:45:05.816607+00', '2025-04-15 14:38:22.2388+00', 11, 'Quần kaki co giãn, dáng ôm, phù hợp mặc đi chơi hoặc đi làm.', 100.00, false, false, 35.00, 'Quần Kaki Slim Fit', 950000.00, 4.00, 0, 85, true, 800.00, 4.00, '939d5dcc-faad-4263-b761-ac63e3cccf6b');
INSERT INTO public.products VALUES ('f12e3f97-8ee4-4959-9611-5e572af6f224', '2025-04-12 02:44:05.609816+00', '2025-04-17 18:23:26.440242+00', 11, 'A timeless blue denim jacket with button-down closure and chest pockets.', 70.00, false, false, 55.00, 'Classic Denim Jacket', 1450000.00, 3.30, 0, 120, true, 50.00, 50.00, '939d5dcc-faad-4263-b761-ac63e3cccf6b');
INSERT INTO public.products VALUES ('78f62f3c-0f34-49be-8353-60502966b56c', '2025-04-10 09:11:42.074518+00', '2025-04-20 13:44:01.486573+00', 11, 'Điện thoại flagship với chip A17 Pro, màn hình Super Retina XDR 6.7 inch, RAM 8GB, dung lượng 256GB.', 30.00, false, false, 15.90, 'iPhone 15 Pro Max', 34999000.00, 3.60, 0, 50, true, 100.00, 7.76, '78676b4c-a55e-45b6-af3e-225aac73876f');


--
-- TOC entry 3594 (class 0 OID 221426)
-- Dependencies: 243
-- Data for Name: products_images; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.products_images VALUES ('78f62f3c-0f34-49be-8353-60502966b56c', 'bbced4b8-ba2e-4038-a117-bd3d59b3e0a8');
INSERT INTO public.products_images VALUES ('78f62f3c-0f34-49be-8353-60502966b56c', 'e69bdf18-572d-42dd-b783-393eab22e536');
INSERT INTO public.products_images VALUES ('f12e3f97-8ee4-4959-9611-5e572af6f224', '29873283-c2f7-48d2-838e-ea793eadaa88');
INSERT INTO public.products_images VALUES ('f12e3f97-8ee4-4959-9611-5e572af6f224', 'b1cca06a-b9dc-477f-93f4-a5db2a4b26ea');
INSERT INTO public.products_images VALUES ('585d5ca6-7051-4c67-b269-7480c0612fdd', '2276aa8b-47d4-46ad-8f62-c8c54792226f');


--
-- TOC entry 3570 (class 0 OID 57535)
-- Dependencies: 219
-- Data for Name: refreshtoken; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.refreshtoken VALUES (6202, '2025-04-02 03:33:47.660531+00', '1c3b4fa6-9eb5-435c-9dd8-7ca503c0340c', '6432b612-3b2f-4575-8e58-8d49e95455db');
INSERT INTO public.refreshtoken VALUES (6052, '2025-04-06 02:31:44.85295+00', '25f7f3a8-eebd-410a-91e0-d886d8a422c4', '6dbb011a-2beb-4fc4-97c3-666c1bef560d');
INSERT INTO public.refreshtoken VALUES (6407, '2025-04-06 08:58:32.856317+00', '7f25bb5c-5842-4690-ad15-ba2520123710', '71c88d6f-4bbe-41d7-b4d9-ed1e705f7bf5');
INSERT INTO public.refreshtoken VALUES (6702, '2025-04-16 16:47:45.110292+00', '40ee9e51-66d9-4c37-b316-30a37654e617', 'dd01ecbe-f798-4fb5-a56a-184c4ba9e023');
INSERT INTO public.refreshtoken VALUES (7203, '2025-04-20 14:57:53.183174+00', '4f9b6c14-7477-4204-9f74-834d0b15bd2b', '0a22c812-f19e-4848-8bc7-3fdb69ea5bec');


--
-- TOC entry 3571 (class 0 OID 57540)
-- Dependencies: 220
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.roles VALUES ('fe1b0503-1060-4492-9035-1a0ae00c9eca', 'ROLE_USER');
INSERT INTO public.roles VALUES ('758bb546-8585-4089-96d2-302bfe83e82c', 'ROLE_ADMIN');


--
-- TOC entry 3576 (class 0 OID 82058)
-- Dependencies: 225
-- Data for Name: topic; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.topic VALUES ('6b308001-c009-4897-b0fa-bd8f7668adb9', '2025-03-01 06:00:50.731814+00', '2025-03-27 11:31:00.704443+00', '#FF0000', 'Technology', 0);
INSERT INTO public.topic VALUES ('b8e2c6c2-aab6-488e-bf00-a88f0c998bb3', '2025-03-27 11:31:43.805697+00', '2025-03-27 11:31:43.805697+00', '#00FF00', 'Health', 0);
INSERT INTO public.topic VALUES ('7b30a1cd-b808-4b2a-b7bf-770011b5ae8c', '2025-03-27 11:32:29.7177+00', '2025-03-27 11:32:29.7177+00', '#00008B', 'Computer', 0);
INSERT INTO public.topic VALUES ('68ed71e2-8e0f-43fd-a049-991594ebedc2', '2025-03-28 08:40:37.483389+00', '2025-03-28 08:40:37.483389+00', '#00ff00', 'Photography', 0);
INSERT INTO public.topic VALUES ('e02d98de-b3d4-4497-801a-1be32fdb6442', '2025-03-28 08:41:23.588027+00', '2025-03-28 08:41:23.588027+00', '#ffaa00', 'Food & Recipes', 0);
INSERT INTO public.topic VALUES ('18d68504-4a27-40f8-a92b-535112340ed9', '2025-03-28 08:41:43.223007+00', '2025-03-28 08:41:43.223007+00', '#5500ff', 'Books', 0);
INSERT INTO public.topic VALUES ('12722c8b-8ab1-4bd5-9be4-1fcd3af373e7', '2025-03-28 08:42:43.872204+00', '2025-03-28 08:42:43.872204+00', '#ff8800', 'FC LowG', 0);


--
-- TOC entry 3572 (class 0 OID 57546)
-- Dependencies: 221
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.user_roles VALUES ('71c88d6f-4bbe-41d7-b4d9-ed1e705f7bf5', 'fe1b0503-1060-4492-9035-1a0ae00c9eca');
INSERT INTO public.user_roles VALUES ('0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '758bb546-8585-4089-96d2-302bfe83e82c');
INSERT INTO public.user_roles VALUES ('dd01ecbe-f798-4fb5-a56a-184c4ba9e023', 'fe1b0503-1060-4492-9035-1a0ae00c9eca');
INSERT INTO public.user_roles VALUES ('6dbb011a-2beb-4fc4-97c3-666c1bef560d', 'fe1b0503-1060-4492-9035-1a0ae00c9eca');
INSERT INTO public.user_roles VALUES ('6432b612-3b2f-4575-8e58-8d49e95455db', 'fe1b0503-1060-4492-9035-1a0ae00c9eca');


--
-- TOC entry 3569 (class 0 OID 57527)
-- Dependencies: 218
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users VALUES ('dd01ecbe-f798-4fb5-a56a-184c4ba9e023', '2025-02-22 17:41:34.662433', '2025-02-22 17:41:34.662433', 'http://localhost:8080/minio/download/commons/cb60520fc3a44acdac56c98d09a7bbea.jpg', 'A passionate developer and tech enthusiast.', 'https://example.com/cover.jpg', 'bob@gmail.com', 'Robert', 1, 'Doe', '$2a$10$vST21EqnOUp1uSprh4OJxeFeCqyziEyEpa67Qc7BYNNI1j2Dc5lpa', 3, 0, 'Bob', 'https://bob.com', 1);
INSERT INTO public.users VALUES ('0a22c812-f19e-4848-8bc7-3fdb69ea5bec', '2025-02-22 17:41:34.464072', '2025-02-22 17:41:34.464072', 'http://localhost:8080/minio/download/commons/165d0e01be874bb8b65bcfdcddd1a74a.jpg', 'A passionate developer and tech enthusiast.', 'https://example.com/cover.jpg', 'alice@gmail.com', 'Alice', 0, 'Thompson', '$2a$10$VjuwvGu2jzL.dKsWlguc2OCy8nFM5gOGmzyvZZyskGwYmkeW0sK4W', 25, 0, 'Alice', 'https://alice.com', 1);
INSERT INTO public.users VALUES ('6dbb011a-2beb-4fc4-97c3-666c1bef560d', '2025-02-22 17:41:34.860904', '2025-02-22 17:41:34.860904', 'http://localhost:8080/minio/download/commons/1d0d4bd2ad464f01876152800aa8ece5.jpg', NULL, NULL, 'jane@gmail.com', 'Jane', 0, 'Miller', '$2a$10$CpN8lpMJSboeJ0sthSQ/uuaWLN3NZ056l8ASb/yRC1twj3mjiNvSW', 0, 0, 'Jane', NULL, 0);
INSERT INTO public.users VALUES ('6432b612-3b2f-4575-8e58-8d49e95455db', '2025-02-22 17:41:50.208711', '2025-02-22 17:41:50.208711', 'http://localhost:8080/minio/download/commons/1b44e9572d3147cbae3b1ebc1bd9006d.jpg', NULL, NULL, 'admin@example.com', 'Adam', 0, 'Newman', '$2a$10$tBn2FlrQrFFB4SXKz8/qO.T5gRa.ZtLuXEWvOF0P00KpWOdFnzrEG', 0, 0, 'admin', NULL, 0);
INSERT INTO public.users VALUES ('71c88d6f-4bbe-41d7-b4d9-ed1e705f7bf5', '2025-02-22 17:41:34.218197', '2025-02-22 17:41:34.218197', 'http://localhost:8080/minio/download/commons/06c1eea4899849e5a85ff31da6fd00cb.jpg', NULL, NULL, 'eve@gmail.com', 'Eve', 0, 'Richardson', '$2a$10$ZhMlYM0tUiCaJjRHTg5XlewHW04oRWpxpdGU5FvReaTFjcfUyl/mS', 0, 0, 'Eve', NULL, 2);


--
-- TOC entry 3603 (class 0 OID 0)
-- Dependencies: 222
-- Name: refreshtoken_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.refreshtoken_seq', 7251, true);


--
-- TOC entry 3389 (class 2606 OID 237705)
-- Name: address address_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_pkey PRIMARY KEY (id);


--
-- TOC entry 3367 (class 2606 OID 196849)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- TOC entry 3355 (class 2606 OID 131297)
-- Name: comment_liked comment_liked_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment_liked
    ADD CONSTRAINT comment_liked_pkey PRIMARY KEY (id);


--
-- TOC entry 3353 (class 2606 OID 131282)
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- TOC entry 3329 (class 2606 OID 57526)
-- Name: conversation conversation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversation
    ADD CONSTRAINT conversation_pkey PRIMARY KEY (id);


--
-- TOC entry 3343 (class 2606 OID 65669)
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- TOC entry 3363 (class 2606 OID 155797)
-- Name: file file_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file
    ADD CONSTRAINT file_pkey PRIMARY KEY (id);


--
-- TOC entry 3357 (class 2606 OID 131312)
-- Name: follow follow_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.follow
    ADD CONSTRAINT follow_pkey PRIMARY KEY (id);


--
-- TOC entry 3359 (class 2606 OID 139409)
-- Name: friend friend_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friend
    ADD CONSTRAINT friend_pkey PRIMARY KEY (id);


--
-- TOC entry 3379 (class 2606 OID 213134)
-- Name: line_items line_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.line_items
    ADD CONSTRAINT line_items_pkey PRIMARY KEY (id);


--
-- TOC entry 3361 (class 2606 OID 147587)
-- Name: notification notification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_pkey PRIMARY KEY (id);


--
-- TOC entry 3371 (class 2606 OID 204939)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- TOC entry 3375 (class 2606 OID 204948)
-- Name: payment payment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_pkey PRIMARY KEY (id);


--
-- TOC entry 3349 (class 2606 OID 131206)
-- Name: post_liked post_liked_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_liked
    ADD CONSTRAINT post_liked_pkey PRIMARY KEY (id);


--
-- TOC entry 3347 (class 2606 OID 90316)
-- Name: post post_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post
    ADD CONSTRAINT post_pkey PRIMARY KEY (id);


--
-- TOC entry 3351 (class 2606 OID 131211)
-- Name: post_saved post_saved_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_saved
    ADD CONSTRAINT post_saved_pkey PRIMARY KEY (id);


--
-- TOC entry 3381 (class 2606 OID 221321)
-- Name: product_comment product_comment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_comment
    ADD CONSTRAINT product_comment_pkey PRIMARY KEY (id);


--
-- TOC entry 3383 (class 2606 OID 221326)
-- Name: product_liked product_liked_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_liked
    ADD CONSTRAINT product_liked_pkey PRIMARY KEY (id);


--
-- TOC entry 3385 (class 2606 OID 221425)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- TOC entry 3333 (class 2606 OID 57539)
-- Name: refreshtoken refreshtoken_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refreshtoken
    ADD CONSTRAINT refreshtoken_pkey PRIMARY KEY (id);


--
-- TOC entry 3339 (class 2606 OID 57545)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 3345 (class 2606 OID 82064)
-- Name: topic topic_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.topic
    ADD CONSTRAINT topic_pkey PRIMARY KEY (id);


--
-- TOC entry 3387 (class 2606 OID 221430)
-- Name: products_images uk_68u3rm4tfmsixwa8nyfjg36xa; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_images
    ADD CONSTRAINT uk_68u3rm4tfmsixwa8nyfjg36xa UNIQUE (images_id);


--
-- TOC entry 3335 (class 2606 OID 57554)
-- Name: refreshtoken uk_81otwtvdhcw7y3ipoijtlb1g3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refreshtoken
    ADD CONSTRAINT uk_81otwtvdhcw7y3ipoijtlb1g3 UNIQUE (user_id);


--
-- TOC entry 3373 (class 2606 OID 204950)
-- Name: orders uk_dhk2umg8ijjkg4njg6891trit; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT uk_dhk2umg8ijjkg4njg6891trit UNIQUE (order_code);


--
-- TOC entry 3365 (class 2606 OID 163975)
-- Name: post_images uk_m78offcf9uxb8jox1hpjfcftf; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_images
    ADD CONSTRAINT uk_m78offcf9uxb8jox1hpjfcftf UNIQUE (images_id);


--
-- TOC entry 3377 (class 2606 OID 204952)
-- Name: payment uk_mf7n8wo2rwrxsd6f3t9ub2mep; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT uk_mf7n8wo2rwrxsd6f3t9ub2mep UNIQUE (order_id);


--
-- TOC entry 3337 (class 2606 OID 57552)
-- Name: refreshtoken uk_or156wbneyk8noo4jstv55ii3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refreshtoken
    ADD CONSTRAINT uk_or156wbneyk8noo4jstv55ii3 UNIQUE (token);


--
-- TOC entry 3369 (class 2606 OID 196877)
-- Name: categories uk_t8o6pivur7nn124jehx7cygw5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT uk_t8o6pivur7nn124jehx7cygw5 UNIQUE (name);


--
-- TOC entry 3341 (class 2606 OID 57550)
-- Name: user_roles user_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (user_id, role_id);


--
-- TOC entry 3331 (class 2606 OID 57534)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3410 (class 2606 OID 163981)
-- Name: post_images fk1ergq8p8j7rkuagxpiedrlhoh; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_images
    ADD CONSTRAINT fk1ergq8p8j7rkuagxpiedrlhoh FOREIGN KEY (post_entity_id) REFERENCES public.post(id);


--
-- TOC entry 3407 (class 2606 OID 147593)
-- Name: notification fk2htxu2byfn4tptatm2tda0hmd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT fk2htxu2byfn4tptatm2tda0hmd FOREIGN KEY (receiver) REFERENCES public.users(id);


--
-- TOC entry 3416 (class 2606 OID 221431)
-- Name: product_comment fk2oqu13ahut1x4289h8p5hi39g; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_comment
    ADD CONSTRAINT fk2oqu13ahut1x4289h8p5hi39g FOREIGN KEY (product) REFERENCES public.products(id);


--
-- TOC entry 3405 (class 2606 OID 139415)
-- Name: friend fk40ocdgodbftacyjhdw4193sgm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friend
    ADD CONSTRAINT fk40ocdgodbftacyjhdw4193sgm FOREIGN KEY (requester) REFERENCES public.users(id);


--
-- TOC entry 3422 (class 2606 OID 237706)
-- Name: address fk6i66ijb8twgcqtetl8eeeed6v; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT fk6i66ijb8twgcqtetl8eeeed6v FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 3417 (class 2606 OID 221436)
-- Name: product_liked fk9ud59hixkntr6kb68ubmi72gn; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_liked
    ADD CONSTRAINT fk9ud59hixkntr6kb68ubmi72gn FOREIGN KEY (product) REFERENCES public.products(id);


--
-- TOC entry 3390 (class 2606 OID 57556)
-- Name: refreshtoken fka652xrdji49m4isx38pp4p80p; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refreshtoken
    ADD CONSTRAINT fka652xrdji49m4isx38pp4p80p FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 3420 (class 2606 OID 221456)
-- Name: products_images fka9cssui4g3kvyl3rred68q8xj; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_images
    ADD CONSTRAINT fka9cssui4g3kvyl3rred68q8xj FOREIGN KEY (product_entity_id) REFERENCES public.products(id);


--
-- TOC entry 3409 (class 2606 OID 155798)
-- Name: file fka9fi7g1qlxhd1g4aj7kt7eve8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file
    ADD CONSTRAINT fka9fi7g1qlxhd1g4aj7kt7eve8 FOREIGN KEY (author) REFERENCES public.users(id);


--
-- TOC entry 3403 (class 2606 OID 131323)
-- Name: follow fkao9nuo6wos23rxdee80jvh1vw; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.follow
    ADD CONSTRAINT fkao9nuo6wos23rxdee80jvh1vw FOREIGN KEY (following) REFERENCES public.users(id);


--
-- TOC entry 3414 (class 2606 OID 221446)
-- Name: line_items fkb3hu7cw8o38248a3pr3o1aety; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.line_items
    ADD CONSTRAINT fkb3hu7cw8o38248a3pr3o1aety FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- TOC entry 3406 (class 2606 OID 139410)
-- Name: friend fkbod6at6b4e2bb1js3vwl06yvk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friend
    ADD CONSTRAINT fkbod6at6b4e2bb1js3vwl06yvk FOREIGN KEY (receiver) REFERENCES public.users(id);


--
-- TOC entry 3397 (class 2606 OID 131237)
-- Name: post_saved fkcag2awupbaq1vx1gtddrsww2v; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_saved
    ADD CONSTRAINT fkcag2awupbaq1vx1gtddrsww2v FOREIGN KEY (post) REFERENCES public.post(id);


--
-- TOC entry 3415 (class 2606 OID 213145)
-- Name: line_items fkcfmx8jqmqu18hhasfdf3w1m9u; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.line_items
    ADD CONSTRAINT fkcfmx8jqmqu18hhasfdf3w1m9u FOREIGN KEY (order_id) REFERENCES public.orders(id);


--
-- TOC entry 3401 (class 2606 OID 131298)
-- Name: comment_liked fkcsnsl0122jia48e4e0r7gnpeb; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment_liked
    ADD CONSTRAINT fkcsnsl0122jia48e4e0r7gnpeb FOREIGN KEY (author) REFERENCES public.users(id);


--
-- TOC entry 3421 (class 2606 OID 221451)
-- Name: products_images fke874mxm5vyv57x7bqaojxmby7; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_images
    ADD CONSTRAINT fke874mxm5vyv57x7bqaojxmby7 FOREIGN KEY (images_id) REFERENCES public.file(id);


--
-- TOC entry 3411 (class 2606 OID 163976)
-- Name: post_images fkgdcgu3q2qmic7tmnbwd6us6wy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_images
    ADD CONSTRAINT fkgdcgu3q2qmic7tmnbwd6us6wy FOREIGN KEY (images_id) REFERENCES public.file(id);


--
-- TOC entry 3412 (class 2606 OID 204958)
-- Name: orders fkgfjfo8cj5jej0jldx5of54tja; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fkgfjfo8cj5jej0jldx5of54tja FOREIGN KEY (customer) REFERENCES public.users(id);


--
-- TOC entry 3391 (class 2606 OID 57561)
-- Name: user_roles fkh8ciramu9cc9q3qcqiv4ue8a6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT fkh8ciramu9cc9q3qcqiv4ue8a6 FOREIGN KEY (role_id) REFERENCES public.roles(id);


--
-- TOC entry 3392 (class 2606 OID 57566)
-- Name: user_roles fkhfh9dx7w3ubf1co1vdev94g3f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT fkhfh9dx7w3ubf1co1vdev94g3f FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 3395 (class 2606 OID 131227)
-- Name: post_liked fkhs0gy9dqulxouybcabd29k4sn; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_liked
    ADD CONSTRAINT fkhs0gy9dqulxouybcabd29k4sn FOREIGN KEY (post) REFERENCES public.post(id);


--
-- TOC entry 3393 (class 2606 OID 90326)
-- Name: post fki8ih8hohm6g8bot1sithxy813; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post
    ADD CONSTRAINT fki8ih8hohm6g8bot1sithxy813 FOREIGN KEY (topic) REFERENCES public.topic(id);


--
-- TOC entry 3394 (class 2606 OID 90321)
-- Name: post fkinucdxpy3u52cyjujoswaf6jq; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post
    ADD CONSTRAINT fkinucdxpy3u52cyjujoswaf6jq FOREIGN KEY (author) REFERENCES public.users(id);


--
-- TOC entry 3408 (class 2606 OID 147588)
-- Name: notification fkj36t50jhmu07he5lr1inlstdd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT fkj36t50jhmu07he5lr1inlstdd FOREIGN KEY (actor) REFERENCES public.users(id);


--
-- TOC entry 3399 (class 2606 OID 131288)
-- Name: comments fkkr5gx0t00em6ocht1sgujaa9o; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT fkkr5gx0t00em6ocht1sgujaa9o FOREIGN KEY (post) REFERENCES public.post(id);


--
-- TOC entry 3413 (class 2606 OID 204963)
-- Name: payment fklouu98csyullos9k25tbpk4va; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT fklouu98csyullos9k25tbpk4va FOREIGN KEY (order_id) REFERENCES public.orders(id);


--
-- TOC entry 3402 (class 2606 OID 131303)
-- Name: comment_liked fkna8oeqny5w7vdvjaw9btcmjr4; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment_liked
    ADD CONSTRAINT fkna8oeqny5w7vdvjaw9btcmjr4 FOREIGN KEY (comment) REFERENCES public.comments(id);


--
-- TOC entry 3400 (class 2606 OID 131283)
-- Name: comments fkp6ilf8rosuwl497khjofovggk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT fkp6ilf8rosuwl497khjofovggk FOREIGN KEY (author) REFERENCES public.users(id);


--
-- TOC entry 3418 (class 2606 OID 221345)
-- Name: product_liked fkrnxfn0h90anf84k4elh0l0n11; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_liked
    ADD CONSTRAINT fkrnxfn0h90anf84k4elh0l0n11 FOREIGN KEY (author) REFERENCES public.users(id);


--
-- TOC entry 3404 (class 2606 OID 131318)
-- Name: follow fkroel3ecs669qrrhrtfi3ta0yr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.follow
    ADD CONSTRAINT fkroel3ecs669qrrhrtfi3ta0yr FOREIGN KEY (follower) REFERENCES public.users(id);


--
-- TOC entry 3396 (class 2606 OID 131222)
-- Name: post_liked fkt7270uhkp1ec6kp5isxmplvjc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_liked
    ADD CONSTRAINT fkt7270uhkp1ec6kp5isxmplvjc FOREIGN KEY (author) REFERENCES public.users(id);


--
-- TOC entry 3398 (class 2606 OID 131232)
-- Name: post_saved fktjy30l8ckd6351or1l5h4g87s; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_saved
    ADD CONSTRAINT fktjy30l8ckd6351or1l5h4g87s FOREIGN KEY (author) REFERENCES public.users(id);


--
-- TOC entry 3419 (class 2606 OID 221441)
-- Name: products fktng6hvelpjyy7el0f5eq93nq4; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT fktng6hvelpjyy7el0f5eq93nq4 FOREIGN KEY (category) REFERENCES public.categories(id);


-- Completed on 2025-04-21 15:31:03

--
-- PostgreSQL database dump complete
--

