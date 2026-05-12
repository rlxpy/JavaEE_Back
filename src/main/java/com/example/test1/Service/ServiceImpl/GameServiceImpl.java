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
    public IPage<Game> getGamesByPage(int page, int size, String keyword) {
        Page<Game> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<Game> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Game::getStatus, 1); // ⭐️ 只能查已上架的
        if (keyword != null && !keyword.isEmpty()) {
            wrapper.and(w -> w.like(Game::getGameName, keyword).or().like(Game::getDescription, keyword));
        }
        wrapper.orderByDesc(Game::getCreateTime);
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