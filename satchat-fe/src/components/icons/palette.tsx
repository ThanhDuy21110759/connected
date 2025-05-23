import { cn } from "@/lib";
import React from "react";

type Props = {
  className?: string;
};

export default function Palette({ className }: Props) {
  return (
    <svg
      className={cn("h-6 w-6 stroke-secondary", className)}
      width={24}
      height={24}
      viewBox="0 0 24 24"
      fill="none"
      xmlns="http://www.w3.org/2000/svg"
    >
      <path
        d="M21.25 12C21.25 19.1094 13.6572 12.7979 12 16.1176C10.9722 18.1765 14.9058 20.75 12 20.75C6.89137 20.75 2.75 16.8325 2.75 12C2.75 7.16751 6.89137 3.25 12 3.25C17.1086 3.25 21.25 7.16751 21.25 12Z"
        strokeWidth="1.5"
      />
      <path
        d="M11.5 7.75C11.5 8.44036 10.9404 9 10.25 9C9.55964 9 9 8.44036 9 7.75C9 7.05964 9.55964 6.5 10.25 6.5C10.9404 6.5 11.5 7.05964 11.5 7.75Z"
        strokeWidth="1.5"
      />
      <path
        d="M8.5 12C8.5 12.6904 7.94036 13.25 7.25 13.25C6.55964 13.25 6 12.6904 6 12C6 11.3096 6.55964 10.75 7.25 10.75C7.94036 10.75 8.5 11.3096 8.5 12Z"
        strokeWidth="1.5"
      />
      <path
        d="M16.5 9.25C16.5 9.94036 15.9404 10.5 15.25 10.5C14.5596 10.5 14 9.94036 14 9.25C14 8.55964 14.5596 8 15.25 8C15.9404 8 16.5 8.55964 16.5 9.25Z"
        strokeWidth="1.5"
      />
    </svg>
  );
}
