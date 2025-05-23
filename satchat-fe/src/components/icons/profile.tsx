import { cn } from "@/lib/utils";

export default function Profile({ className }: { className?: string }) {
  return (
    <svg
      id="profile-icon"
      className={cn("h-6 w-6 stroke-secondary", className)}
      xmlns="http://www.w3.org/2000/svg"
      viewBox="0 0 24 24"
      fill="none"
    >
      <g opacity="0.8">
        <path
          d="M15.7499 6.5C15.7499 8.57107 14.071 10.25 11.9999 10.25C9.92886 10.25 8.24993 8.57107 8.24993 6.5C8.24993 4.42893 9.92886 2.75 11.9999 2.75C14.071 2.75 15.7499 4.42893 15.7499 6.5Z"
          strokeWidth="1.5"
          strokeLinejoin="round"
        />
        <path
          d="M11.9999 13.25C9.02147 13.25 6.67426 14.8039 5.43328 17.1121C4.59617 18.6691 6.02742 20.25 7.79518 20.25H16.2047C17.9724 20.25 19.4037 18.6691 18.5666 17.1121C17.3256 14.8039 14.9784 13.25 11.9999 13.25Z"
          strokeWidth="1.5"
          strokeLinejoin="round"
        />
      </g>
    </svg>
  );
}
