package com.example.test1.Controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.example.test1.entity.Comment;
import com.example.test1.Service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/comment")
@CrossOrigin // ⭐ 别忘了允许跨域
public class CommentController {

    @Autowired
    private CommentService commentService;

    // 1. 提交评论接口
    @PostMapping("/add")
    public Map<String, Object> addComment(@RequestBody Comment comment) {
        Map<String, Object> result = new HashMap<>();

        // 简单的后端校验：不能打 0 分，也不能不写内容
        if (comment.getContent() == null || comment.getRating() == null) {
            result.put("code", 400);
            result.put("msg", "评论内容和评分不能为空哦");
            return result;
        }

        commentService.addComment(comment);
        result.put("code", 200);
        result.put("msg", "评论发表成功！");
        return result;
    }

    // 2. 获取某款游戏的所有评论接口
    @GetMapping("/game/{gameId}")
    public Map<String, Object> getGameComments(@PathVariable Integer gameId) {
        Map<String, Object> result = new HashMap<>();
        List<Comment> commentList = commentService.getCommentsByGameId(gameId);

        result.put("code", 200);
        result.put("msg", "获取评论成功");
        result.put("data", commentList);
        return result;
    }

    // 获取某个帖子的所有回复
    @GetMapping("/post/{postId}")
    public Map<String, Object> getCommentsByPost(@PathVariable Integer postId) {
        Map<String, Object> result = new HashMap<>();
        List<Comment> list = commentService.getCommentsByPostId(postId);
        result.put("code", 200);
        result.put("data", list);
        return result;
    }

    // 👑 管理员全站评论巡查 (分页+搜索)
    @GetMapping("/admin/all")
    public Map<String, Object> getAllCommentsForAdmin(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String keyword) {
        Map<String, Object> result = new HashMap<>();
        try {
            // ⭐️ 调用 Service 层（需去 Service 加 page 和 size 参数）
            IPage<Comment> pageInfo = commentService.getAllCommentsForAdmin(page, size, keyword);

            // ⭐️ 伪装成 PageHelper 格式返回给前端
            Map<String, Object> pageData = new HashMap<>();
            pageData.put("total", pageInfo.getTotal());
            pageData.put("list", pageInfo.getRecords());
            pageData.put("pageNum", pageInfo.getCurrent());
            pageData.put("pageSize", pageInfo.getSize());

            result.put("code", 200);
            result.put("data", pageData);
        } catch (Exception e) {
            result.put("code", 500);
            result.put("msg", "分页获取失败：" + e.getMessage());
        }
        return result;
    }

    // 👑 管理员强制删评
    @DeleteMapping("/admin/delete")
    public Map<String, Object> deleteCommentByAdmin(@RequestParam Integer id) {
        Map<String, Object> result = new HashMap<>();
        try {
            commentService.deleteCommentByAdmin(id);
            result.put("code", 200);
            result.put("msg", "评论已被强制清除！");
        } catch (Exception e) {
            result.put("code", 500);
            result.put("msg", "删除失败：" + e.getMessage());
        }
        return result;
    }
}