package com.example.test1.Service;

import com.example.test1.entity.Comment;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CommentService {
    void addComment(Comment comment);
    List<Comment> getCommentsByGameId(Integer gameId);
    List<Comment> getCommentsByPostId(Integer postId);
    List<Comment> getAllCommentsForAdmin(String keyword);

    void deleteCommentByAdmin(Integer id);
}