package com.example.test1.Controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.example.test1.Service.NotificationService;
import com.example.test1.entity.Notification;
import com.example.test1.entity.Post;
import com.example.test1.entity.PostFavorite;
import com.example.test1.mapper.PostFavoriteMapper;
import com.example.test1.mapper.PostMapper;
import com.example.test1.utils.UserContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/post/favorite")
@CrossOrigin
public class PostFavoriteController {

    @Autowired
    private PostFavoriteMapper postFavoriteMapper;

    @Autowired
    private PostMapper postMapper;

    @Autowired
    private NotificationService notificationService; // 需要用到 PostMapper 来查帖子的具体内容

    // 1. 检查当前用户是否收藏了该帖子 (用于点亮星星)
    @GetMapping("/check")
    public Map<String, Object> checkFavorite(@RequestParam Integer postId) {
        Map<String, Object> result = new HashMap<>();
        Integer userId = UserContext.getUserId();

        LambdaQueryWrapper<PostFavorite> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(PostFavorite::getUserId, userId).eq(PostFavorite::getPostId, postId);

        // 如果查出来的记录大于0，说明收藏了
        boolean isFavorited = postFavoriteMapper.selectCount(wrapper) > 0;

        result.put("code", 200);
        result.put("data", isFavorited);
        return result;
    }

    // 2. 切换收藏状态 (收藏 / 取消收藏)
    @PostMapping("/toggle")
    public Map<String, Object> toggleFavorite(@RequestParam Integer postId) {
        Map<String, Object> result = new HashMap<>();
        Integer userId = UserContext.getUserId();

        LambdaQueryWrapper<PostFavorite> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(PostFavorite::getUserId, userId).eq(PostFavorite::getPostId, postId);
        PostFavorite existRecord = postFavoriteMapper.selectOne(wrapper);

        if (existRecord != null) {
            postFavoriteMapper.deleteById(existRecord.getId());
            result.put("msg", "已取消收藏");
            result.put("data", false);
        } else {
            PostFavorite favorite = new PostFavorite();
            favorite.setUserId(userId);
            favorite.setPostId(postId);
            postFavoriteMapper.insert(favorite);

            // ⭐️ 新增：触发帖子收藏通知
            sendPostFavoriteNotification(postId, userId);

            result.put("msg", "已加入收藏夹⭐");
            result.put("data", true);
        }
        result.put("code", 200);
        return result;
    }

    // 📩 辅助方法：发送帖子收藏通知
    private void sendPostFavoriteNotification(Integer postId, Integer senderId) {
        Post post = postMapper.selectById(postId);
        // 如果不是自己收藏自己的帖子
        if (post != null && !post.getUserId().equals(senderId)) {
            Notification notif = new Notification();
            notif.setSenderId(senderId);
            notif.setReceiverId(post.getUserId()); // 接收者是楼主
            notif.setType(2); // 2 代表收藏
            notif.setReferenceType("post");
            notif.setReferenceId(postId);
            notif.setContent("收藏了你的帖子: " + (post.getTitle().length() > 20 ? post.getTitle().substring(0, 20) + "..." : post.getTitle()));

            notificationService.sendNotification(notif);
        }
    }

    // 3. ⭐️ 获取我的收藏夹列表 (带出帖子详情)
    @GetMapping("/my")
    public Map<String, Object> getMyFavorites() {
        Map<String, Object> result = new HashMap<>();
        Integer userId = UserContext.getUserId();

        // Step 1: 查出当前用户收藏的所有记录 (按时间倒序，最新收藏的在最前面)
        LambdaQueryWrapper<PostFavorite> favWrapper = new LambdaQueryWrapper<>();
        favWrapper.eq(PostFavorite::getUserId, userId).orderByDesc(PostFavorite::getCreateTime);
        List<PostFavorite> favorites = postFavoriteMapper.selectList(favWrapper);

        if (favorites == null || favorites.isEmpty()) {
            result.put("code", 200);
            result.put("data", new ArrayList<>());
            return result;
        }

        // Step 2: 提取出所有的 postId
        List<Integer> postIds = favorites.stream()
                .map(PostFavorite::getPostId)
                .collect(Collectors.toList());

        // Step 3: 根据 postId 去帖子表查出具体的帖子信息
        List<Post> posts = postMapper.selectBatchIds(postIds);

        // Step 4: 为了保证页面展示顺序是“收藏的时间顺序”，我们要根据 postIds 的顺序给 posts 重新排个序
        // (大厂细节：批量查询出来的数据顺序可能和 IN 里面的顺序不一致)
        List<Post> sortedPosts = new ArrayList<>();
        for (Integer pid : postIds) {
            for (Post p : posts) {
                if (p.getId().equals(pid)) {
                    sortedPosts.add(p);
                    break;
                }
            }
        }

        result.put("code", 200);
        result.put("data", sortedPosts);
        return result;
    }
}