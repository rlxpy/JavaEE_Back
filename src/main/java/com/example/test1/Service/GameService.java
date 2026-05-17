package com.example.test1.Service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.example.test1.entity.Game;

import java.util.List;

public interface GameService {
    List<Game> getAllGames(String keyword);

    // ⭐️ 新增分页获取游戏大厅接口
    IPage<Game> getGamesByPage(int page, int size, String keyword, Integer categoryId, String sortBy);

    Game getGameById(Integer id);
    void addGame(Game game);
    List<Game> getGamesByStatus(Integer status);
    void updateGameStatus(Integer id, Integer status);
    List<Game> getGamesByDeveloperId(Integer developerId);
    void deleteGame(Integer id, Integer developerId);
    void updateGame(Game game);

    // ⭐️ 改为 IPage
    IPage<Game> getAllGamesForAdmin(int page, int size, String keyword);
    void deleteGameByAdmin(Integer id);
}