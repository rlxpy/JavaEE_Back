package com.example.test1.Controller;

import com.baomidou.mybatisplus.core.metadata.IPage; // ⭐️ 引入 MP 的分页
import com.example.test1.entity.Game;
import com.example.test1.Service.GameService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/game")
@CrossOrigin // ⭐️ 允许前端跨域访问
public class GameController {

    @Autowired
    private GameService gameService;

    @GetMapping("/list")
    public Map<String, Object> getGameList(@RequestParam(required = false) String keyword) {
        Map<String, Object> result = new HashMap<>();
        List<Game> list = gameService.getAllGames(keyword);
        result.put("code", 200);
        result.put("data", list);
        return result;
    }

    @GetMapping("/detail/{id}")
    public Map<String, Object> getGameDetail(@PathVariable Integer id) {
        Map<String, Object> result = new HashMap<>();
        Game game = gameService.getGameById(id);
        if (game != null) {
            result.put("code", 200);
            result.put("msg", "获取游戏详情成功");
            result.put("data", game);
        } else {
            result.put("code", 404);
            result.put("msg", "抱歉，未找到该游戏");
        }
        return result;
    }

    @PostMapping("/add")
    public Map<String, Object> addGame(@RequestBody Game game) {
        Map<String, Object> result = new HashMap<>();
        try {
            gameService.addGame(game);
            result.put("code", 200);
            result.put("msg", "游戏发布成功！");
        } catch (Exception e) {
            result.put("code", 500);
            result.put("msg", "发布失败：" + e.getMessage());
        }
        return result;
    }

    @GetMapping("/page")
    public Map<String, Object> getGamesByPage(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "12") int size,
            @RequestParam(required = false) String keyword) {

        Map<String, Object> result = new HashMap<>();
        try {
            IPage<Game> pageInfo = gameService.getGamesByPage(page, size, keyword);
            Map<String, Object> pageData = new HashMap<>();
            pageData.put("total", pageInfo.getTotal());
            pageData.put("list", pageInfo.getRecords());
            pageData.put("pageNum", pageInfo.getCurrent());
            pageData.put("pageSize", pageInfo.getSize());

            result.put("code", 200);
            result.put("data", pageData);
        } catch (Exception e) {
            result.put("code", 500);
            result.put("msg", "获取游戏列表失败：" + e.getMessage());
        }
        return result;
    }

    @GetMapping("/audit/list")
    public Map<String, Object> getAuditGameList(@RequestParam Integer status) {
        Map<String, Object> result = new HashMap<>();
        List<Game> list = gameService.getGamesByStatus(status);
        result.put("code", 200);
        result.put("data", list);
        return result;
    }

    @PostMapping("/audit/process")
    public Map<String, Object> processGameAudit(@RequestParam Integer id, @RequestParam Integer status) {
        Map<String, Object> result = new HashMap<>();
        try {
            gameService.updateGameStatus(id, status);
            result.put("code", 200);
            result.put("msg", status == 1 ? "游戏已通过审核，正式上架！" : "游戏已被驳回！");
        } catch (Exception e) {
            result.put("code", 500);
            result.put("msg", "审核操作失败：" + e.getMessage());
        }
        return result;
    }

    @GetMapping("/developer/{developerId}")
    public Map<String, Object> getDeveloperGames(@PathVariable Integer developerId) {
        Map<String, Object> result = new HashMap<>();
        List<Game> list = gameService.getGamesByDeveloperId(developerId);
        result.put("code", 200);
        result.put("data", list);
        return result;
    }

    @DeleteMapping("/delete")
    public Map<String, Object> deleteGame(@RequestParam Integer id, @RequestParam Integer developerId) {
        Map<String, Object> result = new HashMap<>();
        try {
            gameService.deleteGame(id, developerId);
            result.put("code", 200);
            result.put("msg", "游戏已成功删除！");
        } catch (Exception e) {
            result.put("code", 500);
            result.put("msg", "删除失败：" + e.getMessage());
        }
        return result;
    }

    @PostMapping("/update")
    public Map<String, Object> updateGame(@RequestBody Game game) {
        Map<String, Object> result = new HashMap<>();
        try {
            gameService.updateGame(game);
            result.put("code", 200);
            result.put("msg", "游戏信息修改成功！");
        } catch (Exception e) {
            result.put("code", 500);
            result.put("msg", "修改失败：" + e.getMessage());
        }
        return result;
    }

    // 👑 管理员获取全站游戏列表 (MP 原生分页)
    @GetMapping("/admin/all")
    public Map<String, Object> getAllGamesForAdmin(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String keyword) {

        Map<String, Object> result = new HashMap<>();
        IPage<Game> pageInfo = gameService.getAllGamesForAdmin(page, size, keyword);

        // ⭐️ 伪装成前端能看懂的结构
        Map<String, Object> pageData = new HashMap<>();
        pageData.put("total", pageInfo.getTotal());
        pageData.put("list", pageInfo.getRecords());
        pageData.put("pageNum", pageInfo.getCurrent());
        pageData.put("pageSize", pageInfo.getSize());

        result.put("code", 200);
        result.put("data", pageData);
        return result;
    }

    @DeleteMapping("/admin/delete")
    public Map<String, Object> deleteGameByAdmin(@RequestParam Integer id) {
        Map<String, Object> result = new HashMap<>();
        try {
            gameService.deleteGameByAdmin(id);
            result.put("code", 200);
            result.put("msg", "已成功强制下架该游戏！");
        } catch (Exception e) {
            result.put("code", 500);
            result.put("msg", "下架失败：" + e.getMessage());
        }
        return result;
    }
}