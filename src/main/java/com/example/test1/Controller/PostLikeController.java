package com.example.test1.Controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.example.test1.Service.PostService;
import com.example.test1.entity.PostLike;
import com.example.test1.mapper.PostLikeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/post/like")
@CrossOrigin
public class PostLikeController {

    @Autowired
    private PostLikeMapper postLikeMapper;

    @Autowired
    private PostService postService; // ⭐️ 直接调 Service，更规范

    // 检查是否已点赞
    @GetMapping("/check")
    public Map<String, Object> checkLike(@RequestParam Integer userId, @RequestParam Integer postId) {
        Map<String, Object> result = new HashMap<>();

        // ⭐️ MP 原生查询，判断是否存在该条点赞记录
        LambdaQueryWrapper<PostLike> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(PostLike::getUserId, userId).eq(PostLike::getPostId, postId);
        boolean isLiked = postLikeMapper.selectCount(wrapper) > 0;

        result.put("code", 200);
        result.put("data", isLiked);
        return result;
    }

    // 切换点赞状态 (加事务保护数据一致性)
    @PostMapping("/toggle")
    @Transactional
    public Map<String, Object> toggleLike(@RequestParam Integer userId, @RequestParam Integer postId) {
        Map<String, Object> result = new HashMap<>();

        LambdaQueryWrapper<PostLike> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(PostLike::getUserId, userId).eq(PostLike::getPostId, postId);
        boolean isLiked = postLikeMapper.selectCount(wrapper) > 0;

        if (isLiked) {
            // ⭐️ MP 原生删除
            postLikeMapper.delete(wrapper);
            postService.decrementLikeCount(postId); // 帖子总赞数 -1
            result.put("data", false);
            result.put("msg", "已取消点赞");
        } else {
            // ⭐️ MP 原生插入
            PostLike newLike = new PostLike(null, userId, postId);
            postLikeMapper.insert(newLike);
            postService.incrementLikeCount(postId); // 帖子总赞数 +1
            result.put("data", true);
            result.put("msg", "点赞成功！");
        }
        result.put("code", 200);
        return result;
    }
}