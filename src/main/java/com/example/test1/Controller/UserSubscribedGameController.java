package com.example.test1.Controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.example.test1.entity.Game;
import com.example.test1.entity.UserSubscribedGame;
import com.example.test1.mapper.GameMapper;
import com.example.test1.mapper.UserSubscribedGameMapper;
import com.example.test1.utils.UserContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/subscribe")
@CrossOrigin
public class UserSubscribedGameController {

    @Autowired
    private UserSubscribedGameMapper subscribedGameMapper;

    @Autowired
    private GameMapper gameMapper; // 注入游戏表的 Mapper，用来拿游戏名字

    // 1. 获取当前登录玩家关注的游戏列表
    @GetMapping("/my")
    public Map<String, Object> getMySubscribedGames() {
        Map<String, Object> result = new HashMap<>();
        Integer userId = UserContext.getUserId();

        // 去中间表查记录
        LambdaQueryWrapper<UserSubscribedGame> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserSubscribedGame::getUserId, userId);
        List<UserSubscribedGame> subList = subscribedGameMapper.selectList(wrapper);

        // 如果有关注记录，就把具体的游戏详情查出来发给前端
        if (subList != null && !subList.isEmpty()) {
            List<Integer> gameIds = subList.stream().map(UserSubscribedGame::getGameId).collect(Collectors.toList());
            List<Game> games = gameMapper.selectBatchIds(gameIds);
            result.put("data", games);
        } else {
            result.put("data", java.util.Collections.emptyList());
        }

        result.put("code", 200);
        return result;
    }

    // 2. 关注 / 取消关注游戏 (无缝切换)
    @PostMapping("/toggle")
    public Map<String, Object> toggleSubscribe(@RequestParam Integer gameId) {
        Map<String, Object> result = new HashMap<>();
        Integer userId = UserContext.getUserId();

        LambdaQueryWrapper<UserSubscribedGame> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserSubscribedGame::getUserId, userId).eq(UserSubscribedGame::getGameId, gameId);
        UserSubscribedGame existRecord = subscribedGameMapper.selectOne(wrapper);

        if (existRecord != null) {
            // 查到了，说明已经关注了 -> 执行取关！
            subscribedGameMapper.deleteById(existRecord.getId());
            result.put("msg", "已取消关注");
            result.put("data", false); // 告诉前端现在是未关注状态
        } else {
            // 没查到，说明没关注 -> 执行关注！
            UserSubscribedGame newSub = new UserSubscribedGame();
            newSub.setUserId(userId);
            newSub.setGameId(gameId);
            subscribedGameMapper.insert(newSub);
            result.put("msg", "关注成功！");
            result.put("data", true); // 告诉前端现在是已关注状态
        }
        result.put("code", 200);
        return result;
    }
}