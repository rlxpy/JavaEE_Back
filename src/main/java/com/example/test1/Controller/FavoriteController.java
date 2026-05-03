package com.example.test1.Controller;

import com.example.test1.Service.FavoriteService;
import com.example.test1.entity.Game;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/favorite")
@CrossOrigin
public class FavoriteController {

    @Autowired
    private FavoriteService favoriteService;

    // 查询当前用户是否收藏了该游戏
    @GetMapping("/check")
    public Map<String, Object> checkFavorite(@RequestParam Integer userId, @RequestParam Integer gameId) {
        Map<String, Object> result = new HashMap<>();
        boolean isFav = favoriteService.checkIsFavorite(userId, gameId);
        result.put("code", 200);
        result.put("data", isFav);
        return result;
    }

    // 智能切换收藏状态
    @PostMapping("/toggle")
    public Map<String, Object> toggleFavorite(@RequestParam Integer userId, @RequestParam Integer gameId) {
        Map<String, Object> result = new HashMap<>();
        boolean currentStatus = favoriteService.toggleFavorite(userId, gameId);
        result.put("code", 200);
        result.put("msg", currentStatus ? "收藏成功！" : "已取消收藏");
        result.put("data", currentStatus);
        return result;
    }

    // 获取某用户的所有收藏游戏列表
    @GetMapping("/list/{userId}")
    public Map<String, Object> getFavoriteList(@PathVariable Integer userId) {
        Map<String, Object> result = new HashMap<>();
        List<Game> list = favoriteService.getUserFavoriteGames(userId);
        result.put("code", 200);
        result.put("msg", "获取成功");
        result.put("data", list);
        return result;
    }
}