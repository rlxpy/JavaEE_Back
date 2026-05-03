package com.example.test1.mapper;

import com.example.test1.entity.Comment;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface CommentMapper {
    // 1. 插入一条新评论
    public void insertComment(Comment comment);

    // 2. 根据游戏 ID 获取该游戏的所有评论
    public List<Comment> getCommentsByGameId(Integer gameId);

    public List<Comment> getCommentsByPostId(Integer commentId);

    List<Comment> getAllCommentsForAdmin(@Param("keyword") String keyword);

    void deleteCommentByAdmin(Integer id);
}
