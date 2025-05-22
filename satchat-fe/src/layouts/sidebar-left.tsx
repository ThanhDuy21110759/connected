"use client";

import { Box, Typography } from "@mui/material";
import "./styles.css";
import { JSX, useEffect, useState } from "react";
import Link from "next/link";
import { ProfileCard } from "@/components/profile-card";
import { useDispatch, useSelector } from "react-redux";
import { profileStore } from "@/store/reducers";
import { useAuth } from "@/context/auth-context";
import { title } from "process";
import { IMGAES_URL } from "@/global-config";
import { useTranslation } from "react-i18next";

export const SideBarLeft = () => {
  const dispatch = useDispatch();
  const { t } = useTranslation();
  const { isAuthenticated, isLoading } = useAuth();
  const userProfile = useSelector(profileStore.selectCurrentUser);
  const [selected, setSelected] = useState<string>("");

  const ITEMS = [
    {
      title: t("sideBarLeft.Friends"),
      icon: "🧑‍🤝‍🧑",
      href: "/friends",
    },
    {
      title: t("sideBarLeft.Notifications"),
      icon: "🔔",
      href: "/notifications",
    },
    {
      title: t("sideBarLeft.Bookmarks"),
      icon: "🔖",
      href: "/bookmarks",
    },
    {
      title: t("sideBarLeft.Messages"),
      icon: "💭",
      href: "/messages",
    },
    {
      title: t("sideBarLeft.Marketplace"),
      icon: "🛍️",
      href: "/marketplace",
    },
    {
      title: t("sideBarLeft.Tracking"),
      icon: "📦",
      href: "/tracking",
    },
    {
      title: t("sideBarLeft.Favorites"),
      icon: "⭐",
      href: "/favourites",
    },
  ];

  const fetchUserProfile = async () => {
    dispatch(profileStore.getCurrentUser());
  };

  useEffect(() => {
    fetchUserProfile();
  }, [dispatch]);

  return (
    <>
      {userProfile && (
        <Box sx={{ p: 2 }}>
          <ProfileCard
            name={`${userProfile?.firstName} ${userProfile?.lastName}`}
            email={`@${userProfile.username}`}
            followers={userProfile.followerCount}
            friends={userProfile.friendsCount}
            posts={userProfile.postCount}
            avatar={userProfile.avatar}
          />
          <div className="left-sidebar">
            {ITEMS.map((item) => (
              <Link href={item.href} key={item.title}>
                <div
                  className={`menu-item ${
                    selected === item.title ? "active" : ""
                  } flex items-center gap-3 p-2`}
                  onClick={() => setSelected(item.title)}
                >
                  <div className="post-avatar">
                    <h1 className="text-4xl m-0">{item.icon}</h1>
                  </div>
                  <Typography>{item.title}</Typography>
                </div>
              </Link>
            ))}
          </div>
        </Box>
      )}
    </>
  );
};
