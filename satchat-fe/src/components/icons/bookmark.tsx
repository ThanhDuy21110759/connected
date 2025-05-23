import { Icon } from "@/interfaces/icon";
import React from "react";

//--------------------------------------------------------------------------------------------------

export default function Bookmark({ ...props }: Icon) {
  return (
    <svg
      xmlns="http://www.w3.org/2000/svg"
      width={props.width}
      height={props.height}
      viewBox="0 0 24 24"
      fill={props.isActive ? "#F8F8F8" : "none"}
      className="cursor-pointer"
    >
      <g opacity="0.8">
        <path
          d="M19.25 20.2515V5.75C19.25 4.09315 17.9069 2.75 16.25 2.75H7.75C6.09315 2.75 4.75 4.09315 4.75 5.75V20.2515C4.75 21.0522 5.64414 21.5281 6.30839 21.081L10.3248 18.3776C11.3376 17.6959 12.6624 17.6959 13.6752 18.3776L17.6916 21.081C18.3559 21.5282 19.25 21.0522 19.25 20.2515Z"
          stroke="#F8F8F8"
          strokeOpacity="0.5"
          strokeWidth="1.5"
          strokeLinecap="round"
          strokeLinejoin="round"
        />
      </g>
    </svg>
  );
}
