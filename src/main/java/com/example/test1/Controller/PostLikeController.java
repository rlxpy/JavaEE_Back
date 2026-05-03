package com.example.test1.Controller;

import com.example.test1.mapper.PostLikeMapper;
import com.example.test1.mapper.PostMapper;
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
    private PostMapper postMapper;

    // 检查是否已点赞
    @GetMapping("/check")
    public Map<String, Object> checkLike(@RequestParam Integer userId, @RequestParam Integer postId) {
        Map<String, Object> result = new HashMap<>();
        boolean isLiked = postLikeMapper.checkLike(userId, postId) != null;
        result.put("code", 200);
        result.put("data", isLiked);
        return result;
    }

    // 切换点赞状态 (加事务保护数据一致性)
    @PostMapping("/toggle")
    @Transactional
    public Map<String, Object> toggleLike(@RequestParam Integer userId, @RequestParam Integer postId) {
        Map<String, Object> result = new HashMap<>();
        boolean isLiked = postLikeMapper.checkLike(userId, postId) != null;

        if (isLiked) {
            postLikeMapper.removeLike(userId, postId);
            postMapper.decrementLikeCount(postId); // 帖子总赞数 -1
            result.put("data", false);
            result.put("msg", "已取消点赞");
        } else {
            postLikeMapper.addLike(userId, postId);
            postMapper.incrementLikeCount(postId); // 帖子总赞数 +1
            result.put("data", true);
            result.put("msg", "点赞成功！");
        }
        result.put("code", 200);
        return result;
    }
}