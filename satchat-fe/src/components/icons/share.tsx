import { Icon } from "@/interfaces/icon";

export default function Share({ ...props }: Icon) {
  return (
    <svg
      xmlns="http://www.w3.org/2000/svg"
      width={props.width}
      height={props.height}
      viewBox="0 0 24 24"
      fill="none"
      className="cursor-pointer"
    >
      <g opacity="0.8">
        <path
          d="M21.689 11.2748L14.1409 4.10414C13.5039 3.499 12.4521 3.95054 12.4521 4.82914V7.99983C12.4521 8.27597 12.2241 8.49938 11.948 8.50377C3.86276 8.63236 1.70215 11.9204 1.70215 20.2498C3.17188 17.3104 3.92158 15.5709 11.9471 15.502C12.2232 15.4996 12.4521 15.7237 12.4521 15.9998V19.1705C12.4521 20.0491 13.5039 20.5006 14.1409 19.8955L21.689 12.7248C22.104 12.3306 22.104 11.6691 21.689 11.2748Z"
          stroke={props.color}
          strokeOpacity="0.5"
          strokeWidth="1.5"
          strokeLinejoin="round"
        />
      </g>
    </svg>
  );
}
