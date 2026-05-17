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
import org.springframework.data.redis.core.StringRedisTemplate;
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
    private UserMapper userMapper;
    @Autowired
    private com.example.test1.Service.NotificationService notificationService;
    @Autowired
    private StringRedisTemplate stringRedisTemplate;

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

    @Override
    @Transactional
    public void addComment(Comment comment) {
        // 1. MP 原生保存评论
        commentMapper.insert(comment);

        // ==========================================
        // 2. ⭐️ 游戏页面的评论：更新评分 + 发送消息通知
        // ==========================================
        if (comment.getGameId() != null) {

            if (comment.getParentId() == null || comment.getParentId() == 0) {
                Double newAvg = gameMapper.getAverageRatingByGameId(comment.getGameId());
                if (newAvg != null) {
                    gameMapper.updateGameRating(comment.getGameId(), newAvg);
                }
            }

            // (2) 触发消息机制
            com.example.test1.entity.Notification notif = new com.example.test1.entity.Notification();
            notif.setSenderId(comment.getUserId());
            notif.setType(3); // 3 代表评论/回复
            notif.setReferenceType("game");
            notif.setReferenceId(comment.getGameId());

            String preview = comment.getContent();
            if (preview != null && preview.length() > 50) preview = preview.substring(0, 50) + "...";
            notif.setContent(preview);

            if (comment.getParentId() == null || comment.getParentId() == 0) {
                // 找游戏开发者
                com.example.test1.entity.Game game = gameMapper.selectById(comment.getGameId());
                if (game != null) notif.setReceiverId(game.getDeveloperId());
            } else {
                // 找被回复的层主
                Comment parentComment = commentMapper.selectById(comment.getParentId());
                if (parentComment != null) notif.setReceiverId(parentComment.getUserId());
            }

            if (notif.getReceiverId() != null && !notif.getReceiverId().equals(comment.getUserId())) {
                notificationService.sendNotification(notif);
            }
        }

        // ==========================================
        // 3. ⭐️ 帖子页面的评论：更新回复数 + 发送消息通知
        // ==========================================
        if (comment.getPostId() != null) {
            // 触发帖子消息
            com.example.test1.entity.Notification notif = new com.example.test1.entity.Notification();
            notif.setSenderId(comment.getUserId());
            notif.setType(3);
            notif.setReferenceType("post");
            notif.setReferenceId(comment.getPostId());

            String preview = comment.getContent();
            if (preview != null && preview.length() > 50) preview = preview.substring(0, 50) + "...";
            notif.setContent(preview);

            if (comment.getParentId() == null || comment.getParentId() == 0) {
                Post post = postMapper.selectById(comment.getPostId());
                if (post != null) notif.setReceiverId(post.getUserId());
            } else {
                Comment parentComment = commentMapper.selectById(comment.getParentId());
                if (parentComment != null) notif.setReceiverId(parentComment.getUserId());
            }

            if (notif.getReceiverId() != null && !notif.getReceiverId().equals(comment.getUserId())) {
                notificationService.sendNotification(notif);
            }

            // 更新帖子的 comment_count
            UpdateWrapper<Post> wrapper = new UpdateWrapper<>();
            wrapper.eq("id", comment.getPostId()).setSql("comment_count = comment_count + 1");
            postMapper.update(null, wrapper);
        }
    }

    @Override
    public List<Comment> getCommentsByGameId(Integer gameId) {
        // ⭐️ 核心改造：引入游戏页的楼中楼树形组装算法！
        LambdaQueryWrapper<Comment> wrapper = new LambdaQueryWrapper<>();
        // 为了楼中楼组装，查询时按时间正序排列
        wrapper.eq(Comment::getGameId, gameId).orderByAsc(Comment::getCreateTime);
        List<Comment> allComments = commentMapper.selectList(wrapper);

        fillUserInfo(allComments);
        fillRealTimeLikeCount(allComments); // ⭐️ 3. 新增：在此处打上实时点赞补丁！

        List<Comment> rootComments = new java.util.ArrayList<>();
        for (Comment comment : allComments) {
            if (comment.getParentId() == null || comment.getParentId() == 0) {
                comment.setChildren(new java.util.ArrayList<>());
                rootComments.add(comment);
            } else {
                for (Comment root : rootComments) {
                    if (root.getId().equals(comment.getParentId())) {
                        root.getChildren().add(comment);
                        break;
                    }
                }
            }
        }
        return rootComments;
    }

    @Override
    public List<Comment> getCommentsByPostId(Integer postId) {
        LambdaQueryWrapper<Comment> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Comment::getPostId, postId).orderByAsc(Comment::getCreateTime);
        List<Comment> allComments = commentMapper.selectList(wrapper);
        fillUserInfo(allComments);
        fillRealTimeLikeCount(allComments); // ⭐️ 3. 新增：在此处打上实时点赞补丁！
        List<Comment> rootComments = new java.util.ArrayList<>();
        for (Comment comment : allComments) {
            if (comment.getParentId() == null || comment.getParentId() == 0) {
                comment.setChildren(new java.util.ArrayList<>());
                rootComments.add(comment);
            } else {
                for (Comment root : rootComments) {
                    if (root.getId().equals(comment.getParentId())) {
                        root.getChildren().add(comment);
                        break;
                    }
                }
            }
        }
        return rootComments;
    }

    @Override
    public IPage<Comment> getAllCommentsForAdmin(int page, int size, String keyword) {
        Page<Comment> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<Comment> wrapper = new LambdaQueryWrapper<>();
        if (keyword != null && !keyword.isEmpty()) wrapper.like(Comment::getContent, keyword);
        wrapper.orderByDesc(Comment::getCreateTime);
        IPage<Comment> commentPage = commentMapper.selectPage(pageParam, wrapper);
        fillUserInfo(commentPage.getRecords());
        return commentPage;
    }

    @Override
    public void deleteCommentByAdmin(Integer id) {
        commentMapper.deleteById(id);
    }

    // ==========================================
    // ⭐️ 2. 新增：从 Redis 获取实时点赞数，强行覆盖滞后的 MySQL 数据
    // ==========================================
    private void fillRealTimeLikeCount(List<Comment> comments) {
        if (comments == null || comments.isEmpty()) return;
        for (Comment comment : comments) {
            String loadedFlagKey = "comment:cache_loaded:" + comment.getId();
            String likeSetKey = "comment:like:" + comment.getId();

            // 算法精髓：只在 Redis 缓存处于“热乎”状态时，才去拿 Redis 的数据。
            // 否则（比如缓存已过期），依然以 MySQL 里的持久化数据为准！
            if (Boolean.TRUE.equals(stringRedisTemplate.hasKey(loadedFlagKey))) {
                Long realTimeCount = stringRedisTemplate.opsForSet().size(likeSetKey);
                if (realTimeCount != null) {
                    comment.setLikeCount(realTimeCount.intValue()); // 用最新数据覆盖！
                }
            }
        }
    }

    // ⭐️ 新增：普通用户删除自己的评论
    // ⭐️ 普通用户删除自己的评论 (采用方案 B：软删除伪装)
    @Override
    public void deleteMyComment(Integer commentId, Integer userId) {
        // 1. 从数据库查出这条评论
        Comment comment = commentMapper.selectById(commentId);
        if (comment == null) {
            throw new RuntimeException("评论不存在！");
        }

        // 2. 🛡️ 绝对防线：判断这条评论的作者，是不是当前登录的人！
        if (!comment.getUserId().equals(userId)) {
            throw new RuntimeException("🛑 越权警告：你不能删除别人的评论！");
        }

        // 3. ⭐️ 核心魔法：不使用 deleteById，而是用 update 制作一个“墓碑”
        Comment tombstone = new Comment();
        tombstone.setId(commentId);
        tombstone.setContent("🚫 该评论已被作者删除"); // 强制覆盖原内容

        // (可选) 如果你不想让别人看到是“谁”删了这条评论，可以加上这行把用户ID抹除：
        // tombstone.setUserId(0); // 前提是数据库允许设为0或null

        commentMapper.updateById(tombstone);
    }
}