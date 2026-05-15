package com.example.test1.Controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.example.test1.entity.Post;
import com.example.test1.entity.PostLike;
import com.example.test1.mapper.PostLikeMapper;
import com.example.test1.mapper.PostMapper;
import com.example.test1.utils.UserContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

@RestController
@RequestMapping("/post/like")
@CrossOrigin
public class PostLikeController {

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @Autowired
    private PostLikeMapper postLikeMapper;

    @Autowired
    private PostMapper postMapper; // ⭐️ 新增注入：用来查帖子的真实热度

    // ==========================================
    // 🧠 核心魔法：缓存预热与懒加载 (Cache-Aside)
    // ==========================================
    private void ensureCacheLoaded(Integer postId) {
        String loadedFlagKey = "post:cache_loaded:" + postId;
        String likeSetKey = "post:like:" + postId;
        String trendingZSetKey = "post:trending:";

        // 1. 如果标记键存在，说明缓存是热乎的，直接放行！
        if (Boolean.TRUE.equals(stringRedisTemplate.hasKey(loadedFlagKey))) {
            return;
        }

        System.out.println("⚠️ 缓存未命中，正在从 MySQL 预热帖子 " + postId + " 的数据到 Redis...");

        // 2. 从 MySQL 查出原有的热度
        Post post = postMapper.selectById(postId);
        if (post != null) {
            Double dbHotScore = post.getHotScore() != null ? post.getHotScore() : 0.0;
            // 写入 Redis 全局热度榜
            stringRedisTemplate.opsForZSet().add(trendingZSetKey, postId.toString(), dbHotScore);
        }

        // 3. 从 MySQL 查出所有点赞过这篇帖子的人
        LambdaQueryWrapper<PostLike> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(PostLike::getPostId, postId);
        List<PostLike> likes = postLikeMapper.selectList(wrapper);

        // 4. 将点赞名单全量打入 Redis 集合
        if (!likes.isEmpty()) {
            String[] userIds = likes.stream()
                    .map(like -> like.getUserId().toString())
                    .toArray(String[]::new);
            stringRedisTemplate.opsForSet().add(likeSetKey, userIds);
        }

        // 5. ⭐️ 赋予生命周期：设置缓存已加载标记，并设定 2 小时过期！
        stringRedisTemplate.opsForValue().set(loadedFlagKey, "1", 2, TimeUnit.HOURS);
        stringRedisTemplate.expire(likeSetKey, 2, TimeUnit.HOURS);
    }


    // ==========================================
    // 接口层
    // ==========================================

    @GetMapping("/check")
    public Map<String, Object> checkLike(@RequestParam Integer postId) {
        Map<String, Object> result = new HashMap<>();
        Integer userId = UserContext.getUserId();

        // ⭐️ 先发制人：在检查之前，保证这篇帖子的缓存已被加载
        ensureCacheLoaded(postId);

        String likeSetKey = "post:like:" + postId;
        Boolean isLiked = stringRedisTemplate.opsForSet().isMember(likeSetKey, userId.toString());

        result.put("code", 200);
        result.put("data", isLiked != null && isLiked);
        return result;
    }

    @PostMapping("/toggle")
    public Map<String, Object> toggleLike(@RequestParam Integer postId) {
        Map<String, Object> result = new HashMap<>();
        Integer userId = UserContext.getUserId();

        // ⭐️ 先发制人：在点赞修改前，保证 Redis 里的点赞名单是全的！防止数据被覆盖清空！
        ensureCacheLoaded(postId);

        String likeSetKey = "post:like:" + postId;
        String trendingZSetKey = "post:trending:";

        Long added = stringRedisTemplate.opsForSet().add(likeSetKey, userId.toString());

        if (added != null && added > 0) {
            // 点赞
            stringRedisTemplate.opsForZSet().incrementScore(trendingZSetKey, postId.toString(), 1);
            stringRedisTemplate.opsForSet().add("post:need_sync", postId.toString());
            result.put("data", true);
            result.put("msg", "点赞成功！");
        } else {
            // 取消点赞
            stringRedisTemplate.opsForSet().remove(likeSetKey, userId.toString());
            stringRedisTemplate.opsForZSet().incrementScore(trendingZSetKey, postId.toString(), -1);
            stringRedisTemplate.opsForSet().add("post:need_sync", postId.toString());
            result.put("data", false);
            result.put("msg", "已取消点赞");
        }
        result.put("code", 200);
        return result;
    }
}