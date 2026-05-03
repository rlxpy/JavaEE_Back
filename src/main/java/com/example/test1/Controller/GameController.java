package com.example.test1.Controller;

import com.example.test1.entity.Game;
import com.example.test1.Service.GameService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
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

    /// 获取所有已发布的游戏 (支持搜索)
    @GetMapping("/list")
    public Map<String, Object> getGameList(@RequestParam(required = false) String keyword) { // ⭐️ 加上可选的 keyword 参数
        Map<String, Object> result = new HashMap<>();
        List<Game> list = gameService.getAllGames(keyword);
        result.put("code", 200);
        result.put("data", list);
        return result;
    }

    // ⭐ 新增：获取游戏详情接口
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

    // ⭐️ 新增：分页获取游戏大厅列表 (支持搜索)
    @GetMapping("/page")
    public Map<String, Object> getGamesByPage(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "12") int size, // 每页12个（一行4个，正好3行）
            @RequestParam(required = false) String keyword) {

        Map<String, Object> result = new HashMap<>();
        try {
            // ⭐️ 开启分页魔法
            PageHelper.startPage(page, size);
            List<Game> list = gameService.getAllGames(keyword);
            PageInfo<Game> pageInfo = new PageInfo<>(list);

            result.put("code", 200);
            result.put("data", pageInfo);
        } catch (Exception e) {
            result.put("code", 500);
            result.put("msg", "获取游戏列表失败：" + e.getMessage());
        }
        return result;
    }

    // ================== 下面是超级管理员的审核专属接口 ==================

    // 获取特定状态的游戏列表（比如传 0 获取待审核列表）
    @GetMapping("/audit/list")
    public Map<String, Object> getAuditGameList(@RequestParam Integer status) {
        Map<String, Object> result = new HashMap<>();
        List<Game> list = gameService.getGamesByStatus(status);
        result.put("code", 200);
        result.put("data", list);
        return result;
    }

    // 审核游戏（通过或驳回）
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

    // ================== 下面是开发者专属接口 ==================

    // 获取开发者自己发布的所有游戏
    @GetMapping("/developer/{developerId}")
    public Map<String, Object> getDeveloperGames(@PathVariable Integer developerId) {
        Map<String, Object> result = new HashMap<>();
        List<Game> list = gameService.getGamesByDeveloperId(developerId);
        result.put("code", 200);
        result.put("data", list);
        return result;
    }

    // 开发者删除自己的游戏
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

    // 开发者修改游戏信息
    @PostMapping("/update")
    public Map<String, Object> updateGame(@RequestBody Game game) {
        Map<String, Object> result = new HashMap<>();
        try {
            // 注意：前端传来的 game 对象里必须包含 id 和 developerId
            gameService.updateGame(game);
            result.put("code", 200);
            result.put("msg", "游戏信息修改成功！");
        } catch (Exception e) {
            result.put("code", 500);
            result.put("msg", "修改失败：" + e.getMessage());
        }
        return result;
    }

    // 管理员获取全站游戏列表 (分页+搜索)
    @GetMapping("/admin/all")
    public Map<String, Object> getAllGamesForAdmin(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String keyword) {
        Map<String, Object> result = new HashMap<>();
        PageInfo<Game> pageInfo = gameService.getAllGamesForAdmin(page, size, keyword);
        result.put("code", 200);
        result.put("data", pageInfo); // ⭐️ 把查询到的分页数据放进 data 里
        return result; // ⭐️ 返回给前端
    }

    // 👑 管理员强制下架（彻底删除）游戏
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