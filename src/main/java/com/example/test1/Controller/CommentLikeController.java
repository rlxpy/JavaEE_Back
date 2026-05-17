package com.example.test1.Controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.example.test1.Service.NotificationService;
import com.example.test1.entity.Comment;
import com.example.test1.entity.CommentLike;
import com.example.test1.entity.Notification;
import com.example.test1.mapper.CommentLikeMapper;
import com.example.test1.mapper.CommentMapper;
import com.example.test1.utils.UserContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

@RestController
@RequestMapping("/comment/like")
@CrossOrigin
public class CommentLikeController {

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @Autowired
    private CommentLikeMapper commentLikeMapper;

    @Autowired
    private NotificationService notificationService;

    @Autowired
    private CommentMapper commentMapper;

    // ==========================================
    // 🧠 核心魔法：评论缓存懒加载 (Cache-Aside)
    // ==========================================
    private void ensureCacheLoaded(Integer commentId) {
        String loadedFlagKey = "comment:cache_loaded:" + commentId;
        String likeSetKey = "comment:like:" + commentId;

        // 1. 如果缓存是热乎的，直接放行
        if (Boolean.TRUE.equals(stringRedisTemplate.hasKey(loadedFlagKey))) {
            return;
        }

        // 2. 缓存丢失，从 MySQL 查出所有点赞过这条评论的人
        LambdaQueryWrapper<CommentLike> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(CommentLike::getCommentId, commentId);
        List<CommentLike> likes = commentLikeMapper.selectList(wrapper);

        // 3. 全量打入 Redis 集合
        if (!likes.isEmpty()) {
            String[] userIds = likes.stream()
                    .map(like -> like.getUserId().toString())
                    .toArray(String[]::new);
            stringRedisTemplate.opsForSet().add(likeSetKey, userIds);
        }

        // 4. 赋予生命周期：2 小时过期
        stringRedisTemplate.opsForValue().set(loadedFlagKey, "1", 2, TimeUnit.HOURS);
        stringRedisTemplate.expire(likeSetKey, 2, TimeUnit.HOURS);
    }

    // ==========================================
    // 接口层
    // ==========================================

    // 1. 检查当前用户是否点赞了这条评论
    @GetMapping("/check")
    public Map<String, Object> checkLike(@RequestParam Integer commentId) {
        Map<String, Object> result = new HashMap<>();
        Integer userId = UserContext.getUserId();

        ensureCacheLoaded(commentId);

        String likeSetKey = "comment:like:" + commentId;
        Boolean isLiked = stringRedisTemplate.opsForSet().isMember(likeSetKey, userId.toString());

        result.put("code", 200);
        result.put("data", isLiked != null && isLiked);
        return result;
    }

    // 2. 切换点赞状态
    @PostMapping("/toggle")
    public Map<String, Object> toggleLike(@RequestParam Integer commentId) {
        Map<String, Object> result = new HashMap<>();
        Integer userId = UserContext.getUserId();

        ensureCacheLoaded(commentId);
        String likeSetKey = "comment:like:" + commentId;

        Long added = stringRedisTemplate.opsForSet().add(likeSetKey, userId.toString());

        if (added != null && added > 0) {
            // 🟢 点赞
            stringRedisTemplate.opsForSet().add("comment:need_sync", commentId.toString());

            // ⭐️ 新增：触发评论点赞通知
            sendCommentLikeNotification(commentId, userId);

            result.put("data", true);
            result.put("msg", "点赞成功！");
        } else {
            // 🔴 取消点赞
            stringRedisTemplate.opsForSet().remove(likeSetKey, userId.toString());
            stringRedisTemplate.opsForSet().add("comment:need_sync", commentId.toString());
            result.put("data", false);
            result.put("msg", "已取消点赞");
        }
        result.put("code", 200);
        return result;
    }

    private void sendCommentLikeNotification(Integer commentId, Integer senderId) {
        Comment comment = commentMapper.selectById(commentId);
        if (comment != null && !comment.getUserId().equals(senderId)) {
            Notification notif = new Notification();
            notif.setSenderId(senderId);
            notif.setReceiverId(comment.getUserId()); // 接收者是评论的人
            notif.setType(1);
            notif.setReferenceType("post"); // 评论通常属于某个帖子，跳转时依然跳到帖子
            notif.setReferenceId(comment.getPostId());
            notif.setContent("赞了你的评论: " + (comment.getContent().length() > 20 ? comment.getContent().substring(0, 20) + "..." : comment.getContent()));

            notificationService.sendNotification(notif);
        }
    }
}