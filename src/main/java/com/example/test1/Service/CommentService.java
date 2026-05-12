package com.example.test1.Service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.example.test1.entity.Comment;
import java.util.List;

public interface CommentService {
    void addComment(Comment comment);
    List<Comment> getCommentsByGameId(Integer gameId);
    List<Comment> getCommentsByPostId(Integer postId);

    // ⭐️ 返回值改为 IPage，并接收分页参数
    IPage<Comment> getAllCommentsForAdmin(int page, int size, String keyword);

    void deleteCommentByAdmin(Integer id);
}