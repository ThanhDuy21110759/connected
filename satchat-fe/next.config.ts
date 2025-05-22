import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  /* config options here */
  devIndicators: false,
  reactStrictMode: false,
  images: {
    remotePatterns: [
      {
        protocol: "http",
        hostname: "127.0.0.1",
        port: "8280",
        pathname: "/minio/download/commons/**",
      },
      {
        protocol: "http",
        hostname: "localhost",
        port: "8280",
        pathname: "/minio/download/commons/**",
      },
      {
        protocol: "http",
        hostname: "34.126.161.244",
        port: "8280",
        pathname: "/minio/download/commons/**",
      },
      {
        protocol: "http",
        hostname: "34.126.161.244.nip.io",
        port: "8280",
        pathname: "/minio/download/commons/**",
      },
    ],
  },
};

export default nextConfig;
