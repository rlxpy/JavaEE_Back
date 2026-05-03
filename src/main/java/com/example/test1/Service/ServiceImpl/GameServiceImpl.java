package com.example.test1.Service.ServiceImpl;

import com.example.test1.Service.GameService;
import com.example.test1.entity.Game;
import com.example.test1.mapper.GameMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GameServiceImpl implements GameService {

    @Autowired
    private GameMapper gameMapper;

    @Override
    public List<Game> getAllGames(String keyword) {
        return gameMapper.getAllGames(keyword);
    }

    @Override
    public Game getGameById(Integer id) {
        return gameMapper.getGameById(id);
    }

    @Override
    public void addGame(Game game) {
        gameMapper.insertGame(game);
    }

    @Override
    public List<Game> getGamesByStatus(Integer status) {
        return gameMapper.getGamesByStatus(status);
    }

    @Override
    public void updateGameStatus(Integer id, Integer status) {
        gameMapper.updateGameStatus(id, status);
    }

    @Override
    public List<Game> getGamesByDeveloperId(Integer developerId) {
        return gameMapper.getGamesByDeveloperId(developerId);
    }

    @Override
    public void deleteGame(Integer id, Integer developerId) {
        gameMapper.deleteGame(id, developerId);
    }

    @Override
    public void updateGame(Game game) {
        gameMapper.updateGame(game);
    }

    @Override
    public PageInfo<Game> getAllGamesForAdmin(int page, int size, String keyword) {
        PageHelper.startPage(page, size);
        List<Game> list = gameMapper.getAllGamesForAdmin(keyword);
        return new PageInfo<>(list);
    }

    @Override
    public void deleteGameByAdmin(Integer id) {
        gameMapper.deleteGameByAdmin(id);
    }


}
