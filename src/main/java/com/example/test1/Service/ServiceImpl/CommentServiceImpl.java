package com.example.test1.Service.ServiceImpl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.test1.entity.Comment;
import com.example.test1.entity.Post;
import com.example.test1.entity.User;
import com.example.test1.mapper.CommentMapper;
import com.example.test1.Service.CommentService;
import com.example.test1.mapper.GameMapper;
import com.example.test1.mapper.PostMapper;
import com.example.test1.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class CommentServiceImpl implements CommentService {

    @Autowired
    private CommentMapper commentMapper;

    @Autowired
    private GameMapper gameMapper;

    @Autowired
    private PostMapper postMapper;

    @Autowired
    private UserMapper userMapper; // ⭐️ 注入 UserMapper，用来查头像和昵称

    // ==========================================
    // ⭐️ 核心工具方法：给评论补全用户的头像和昵称
    // ==========================================
    private void fillUserInfo(Comment comment) {
        if (comment != null && comment.getUserId() != null) {
            User user = userMapper.selectById(comment.getUserId());
            if (user != null) {
                comment.setNickname(user.getNickname());
                comment.setAvatar(user.getAvatar());
            }
        }
    }

    private void fillUserInfo(List<Comment> comments) {
        if (comments != null) {
            for (Comment comment : comments) {
                fillUserInfo(comment);
            }
        }
    }
    // ==========================================

    @Override
    @Transactional
    public void addComment(Comment comment) {
        // 1. MP 原生保存评论
        commentMapper.insert(comment);

        // 2. 如果是游戏页面的评论，更新游戏平均分
        if (comment.getGameId() != null) {
            Double newAvg = gameMapper.getAverageRatingByGameId(comment.getGameId());
            if (newAvg != null) {
                gameMapper.updateGameRating(comment.getGameId(), newAvg);
            }
        }

        // 3. ⭐️ 新增：如果是发在帖子下的评论，让该帖子的 comment_count 字段 +1
        if (comment.getPostId() != null) {
            UpdateWrapper<Post> wrapper = new UpdateWrapper<>();
            wrapper.eq("id", comment.getPostId()).setSql("comment_count = comment_count + 1");
            postMapper.update(null, wrapper);
        }
    }

    @Override
    public List<Comment> getCommentsByGameId(Integer gameId) {
        LambdaQueryWrapper<Comment> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Comment::getGameId, gameId).orderByDesc(Comment::getCreateTime);
        List<Comment> comments = commentMapper.selectList(wrapper);

        fillUserInfo(comments); // ⭐️ 补全数据
        return comments;
    }

    @Override
    public List<Comment> getCommentsByPostId(Integer postId) {
        LambdaQueryWrapper<Comment> wrapper = new LambdaQueryWrapper<>();
        // ⭐️ 注意：帖子的回复一般是按时间正序排列（最早的在最上面），所以用 Asc
        wrapper.eq(Comment::getPostId, postId).orderByAsc(Comment::getCreateTime);
        List<Comment> comments = commentMapper.selectList(wrapper);

        fillUserInfo(comments); // ⭐️ 补全数据
        return comments;
    }

    @Override
    public IPage<Comment> getAllCommentsForAdmin(int page, int size, String keyword) {
        Page<Comment> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<Comment> wrapper = new LambdaQueryWrapper<>();
        if (keyword != null && !keyword.isEmpty()) {
            wrapper.like(Comment::getContent, keyword);
        }
        wrapper.orderByDesc(Comment::getCreateTime);

        IPage<Comment> commentPage = commentMapper.selectPage(pageParam, wrapper);

        fillUserInfo(commentPage.getRecords()); // ⭐️ 补全当前页的数据
        return commentPage;
    }

    @Override
    public void deleteCommentByAdmin(Integer id) {
        commentMapper.deleteById(id);
    }
}