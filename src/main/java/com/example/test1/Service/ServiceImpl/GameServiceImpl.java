package com.example.test1.Service.ServiceImpl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.test1.Service.GameService;
import com.example.test1.entity.Game;
import com.example.test1.mapper.GameMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GameServiceImpl implements GameService {

    @Autowired
    private GameMapper gameMapper;

    @Override
    public List<Game> getAllGames(String keyword) {
        LambdaQueryWrapper<Game> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Game::getStatus, 1); // ⭐️ 只能查已上架的
        if (keyword != null && !keyword.isEmpty()) {
            wrapper.and(w -> w.like(Game::getGameName, keyword).or().like(Game::getDescription, keyword));
        }
        wrapper.orderByDesc(Game::getCreateTime);
        return gameMapper.selectList(wrapper);
    }

    @Override
    public IPage<Game> getGamesByPage(int page, int size, String keyword, Integer categoryId, String sortBy) {
        Page<Game> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<Game> wrapper = new LambdaQueryWrapper<>();

        wrapper.eq(Game::getStatus, 1); // ⭐️ 只能查已上架的

        // 1. 关键字搜索条件
        if (keyword != null && !keyword.isEmpty()) {
            wrapper.and(w -> w.like(Game::getGameName, keyword).or().like(Game::getDescription, keyword));
        }

        // 2. ⭐️ 新增：分类过滤条件 (如果是 0 或 null 代表查全部)
        if (categoryId != null && categoryId != 0) {
            wrapper.eq(Game::getCategoryId, categoryId);
        }

        // 3. ⭐️ 新增：动态排序策略
        if ("hot".equals(sortBy)) {
            // 热度：按评分倒序，如果评分一样，按时间倒序
            wrapper.orderByDesc(Game::getAverageRating).orderByDesc(Game::getCreateTime);
        } else {
            // 默认：最新上架
            wrapper.orderByDesc(Game::getCreateTime);
        }

        return gameMapper.selectPage(pageParam, wrapper);
    }

    @Override
    public Game getGameById(Integer id) {
        return gameMapper.selectById(id);
    }

    @Override
    public void addGame(Game game) {
        // 默认状态设为待审核 (假设 0 是待审核)
        if(game.getStatus() == null){
            game.setStatus(0);
        }
        gameMapper.insert(game);
    }

    @Override
    public List<Game> getGamesByStatus(Integer status) {
        LambdaQueryWrapper<Game> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Game::getStatus, status).orderByDesc(Game::getCreateTime);
        return gameMapper.selectList(wrapper);
    }

    @Override
    public void updateGameStatus(Integer id, Integer status) {
        Game game = new Game();
        game.setId(id);
        game.setStatus(status);
        gameMapper.updateById(game); // ⭐️ 智能只更新 status 字段
    }

    @Override
    public List<Game> getGamesByDeveloperId(Integer developerId) {
        LambdaQueryWrapper<Game> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Game::getDeveloperId, developerId).orderByDesc(Game::getCreateTime);
        return gameMapper.selectList(wrapper);
    }

    @Override
    public void deleteGame(Integer id, Integer developerId) {
        LambdaQueryWrapper<Game> wrapper = new LambdaQueryWrapper<>();
        // ⭐️ 安全校验：必须是该开发者自己的游戏
        wrapper.eq(Game::getId, id).eq(Game::getDeveloperId, developerId);
        gameMapper.delete(wrapper);
    }

    @Override
    public void updateGame(Game game) {
        LambdaQueryWrapper<Game> wrapper = new LambdaQueryWrapper<>();
        // ⭐️ 安全校验：必须是该开发者自己的游戏
        wrapper.eq(Game::getId, game.getId()).eq(Game::getDeveloperId, game.getDeveloperId());
        gameMapper.update(game, wrapper);
    }

    @Override
    public IPage<Game> getAllGamesForAdmin(int page, int size, String keyword) {
        Page<Game> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<Game> wrapper = new LambdaQueryWrapper<>();
        if (keyword != null && !keyword.isEmpty()) {
            wrapper.like(Game::getGameName, keyword).or().like(Game::getDescription, keyword);
        }
        wrapper.orderByDesc(Game::getCreateTime);
        return gameMapper.selectPage(pageParam, wrapper);
    }

    @Override
    public void deleteGameByAdmin(Integer id) {
        gameMapper.deleteById(id);
    }
}