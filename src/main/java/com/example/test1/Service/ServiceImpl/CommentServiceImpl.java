package com.example.test1.Service.ServiceImpl;

import com.example.test1.entity.Comment;
import com.example.test1.mapper.CommentMapper;
import com.example.test1.Service.CommentService;
import com.example.test1.mapper.GameMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class CommentServiceImpl implements CommentService {

    @Autowired
    private CommentMapper commentMapper;

    @Autowired
    private GameMapper gameMapper; // 注入 GameMapper

    @Override
    @Transactional
    public void addComment(Comment comment) {
        // 1. 保存新评论 (无论是评价游戏还是回复帖子，都要执行)
        commentMapper.insertComment(comment);

        // 2. ⭐️ 加上安全锁：只有当 gameId 有值时，才去更新游戏平均分！
        if (comment.getGameId() != null) {
            Double newAvg = gameMapper.getAverageRatingByGameId(comment.getGameId());
            if (newAvg != null) {
                gameMapper.updateGameRating(comment.getGameId(), newAvg);
            }
        }
    }

    @Override
    public List<Comment> getCommentsByGameId(Integer gameId) {
        return commentMapper.getCommentsByGameId(gameId);
    }

    @Override
    public List<Comment> getCommentsByPostId(Integer postId) {
        return commentMapper.getCommentsByPostId(postId);
    }

    @Override
    public List<Comment> getAllCommentsForAdmin(String keyword) {
        return commentMapper.getAllCommentsForAdmin(keyword);
    }

    @Override
    public void deleteCommentByAdmin(Integer id) {
        commentMapper.deleteCommentByAdmin(id);
    }

}