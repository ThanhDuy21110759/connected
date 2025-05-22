"use client";

import { MainLayout } from "@/layouts";
import { postStore } from "@/store/reducers";
import { getPageTitle } from "@/utils/pathNameUtils";
import React, { useEffect, useState } from "react";
import styled from "styled-components";
import { useDispatch, useSelector } from "react-redux";
import { Divider } from "@mui/material";
import { PostComment, PostContentDetail } from "@/sections/post/index";
import { CommentBar } from "@/sections/post/index";
import { useParams, usePathname } from "next/navigation";
import { Helmet } from "react-helmet-async";
import { NewPostDialog } from "@/components/new-post-dialog";

export default function PostDetail() {
  const { id } = useParams();
  const dispatch = useDispatch();
  const pathname = usePathname();
  const post = useSelector(postStore.selectCurrentPost);
  const postComments = useSelector(postStore.selectCurrentPostComments);
  const [edit, setEdit] = useState(false);

  useEffect(() => {
    dispatch(postStore.getPostComments(id));
  }, []);

  // Styled components
  const Card = styled.div`
    background-color: var(--background-component);
    border-radius: 0.5rem;
    box-shadow: 1px 2px 4px 4px rgba(0, 0, 0, 0.1);
    padding: 1rem;
    margin: 1rem 0;
  `;

  const postContent = (
    <>
      <PostContentDetail post={post} setEdit={setEdit} />
      <>
        <Divider sx={{ bgcolor: "var(--foreground)", marginBottom: 3 }} />
        <CommentBar post={post} />
        {postComments.map((comment: any) => (
          <PostComment
            key={comment?.id}
            id={comment?.id}
            avatarUrl={comment?.author?.avatar ?? ""}
            authorId={comment?.author?.id ?? ""}
            author={
              comment?.author
                ? `${comment.author.firstName ?? ""} ${
                    comment.author.lastName ?? ""
                  }`
                : "Ẩn danh"
            }
            content={comment?.content ?? ""}
            hasLiked={comment?.hasLiked ?? false}
            likedCount={comment?.likedCount ?? 0}
          />
        ))}
      </>
      {edit && (
        <NewPostDialog
          key={post.id}
          open={edit}
          setOpen={setEdit}
          post={post}
          isEdit={true}
        />
      )}
    </>
  );

  return (
    <MainLayout>
      <Helmet>
        <title>{getPageTitle(pathname)} | satchat</title>
      </Helmet>
      <Card>{postContent}</Card>
    </MainLayout>
  );
}
