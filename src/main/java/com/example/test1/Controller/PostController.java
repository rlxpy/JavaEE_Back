package com.example.test1.Controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.example.test1.Service.PostService;
import com.example.test1.entity.Post;
import com.example.test1.utils.UserContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/post")
@CrossOrigin
public class PostController {

    @Autowired
    private PostService postService;

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    // 分页获取交流大厅的所有帖子 (⭐️ 全面升级版)
    @GetMapping("/page")
    public Map<String, Object> getPostsByPage(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) Integer categoryId,
            @RequestParam(required = false) Integer gameId,
            @RequestParam(defaultValue = "false") Boolean isFollowFeed,
            @RequestParam(defaultValue = "time") String sortBy // ⭐️ 新增：默认按时间排序
    ) {

        Map<String, Object> result = new HashMap<>();
        try {
            // ⭐️ 把 sortBy 传进去
            IPage<Post> pageInfo = postService.getPostsByPage(page, size, keyword, categoryId, gameId, isFollowFeed, sortBy);

            Map<String, Object> pageData = new HashMap<>();
            pageData.put("total", pageInfo.getTotal());
            pageData.put("list", pageInfo.getRecords());
            pageData.put("pageNum", pageInfo.getCurrent());
            pageData.put("pageSize", pageInfo.getSize());

            result.put("code", 200);
            result.put("msg", "获取帖子列表成功");
            result.put("data", pageData);
        } catch (Exception e) {
            result.put("code", 500);
            result.put("msg", "获取失败：" + e.getMessage());
        }
        return result;
    }

    // 2. 发布新帖子
    @PostMapping("/add")
    public Map<String, Object> addPost(@RequestBody Post post) {
        Map<String, Object> result = new HashMap<>();
        try {
            post.setUserId(UserContext.getUserId());

            postService.addPost(post);
            result.put("code", 200);
            result.put("msg", "发帖成功！");
        } catch (Exception e) {
            result.put("code", 500);
            result.put("msg", "发帖失败：" + e.getMessage());
        }
        return result;
    }

    // 3.获取单个帖子详情
    @GetMapping("/detail/{id}")
    public Map<String, Object> getPostDetail(@PathVariable Integer id) {
        Map<String, Object> result = new HashMap<>();
        Post post = postService.getPostById(id);
        result.put("code", 200);
        result.put("data", post);
        return result;
    }

    // 获取我的所有发帖 (带搜索)
    @GetMapping("/my")
    public Map<String, Object> getMyPosts(
            @RequestParam(required = false) String keyword) {
        Map<String, Object> result = new HashMap<>();

        Integer userId = UserContext.getUserId();

        List<Post> list = postService.getPostsByUserId(userId, keyword);
        result.put("code", 200);
        result.put("data", list);
        return result;
    }

    // 删除我的帖子 (带上 userId 做安全校验)
    @DeleteMapping("/delete")
    public Map<String, Object> deleteMyPost(@RequestParam Integer id) {
        Map<String, Object> result = new HashMap<>();

        Integer userId = UserContext.getUserId();

        try {
            postService.deletePost(id, userId);
            result.put("code", 200);
            result.put("msg", "删除成功");
        } catch (Exception e) {
            result.put("code", 500);
            result.put("msg", "删除失败：" + e.getMessage());
        }
        return result;
    }

    // 👑 管理员强制删帖
    @DeleteMapping("/admin/delete")
    public Map<String, Object> deletePostByAdmin(@RequestParam Integer id) {
        Map<String, Object> result = new HashMap<>();
        try {
            postService.deletePostByAdmin(id);
            result.put("code", 200);
            result.put("msg", "帖子已成功强制删除！");
        } catch (Exception e) {
            result.put("code", 500);
            result.put("msg", "删除失败：" + e.getMessage());
        }
        return result;
    }
}