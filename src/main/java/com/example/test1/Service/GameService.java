package com.example.test1.Service;

import com.example.test1.entity.Game;
import com.github.pagehelper.PageInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface GameService {
    List<Game> getAllGames(String keyword);
    public Game getGameById(Integer id);
    public void addGame(Game game);
    public List<Game> getGamesByStatus(Integer status);
    void updateGameStatus(@Param("id") Integer id, @Param("status") Integer status);
    List<Game> getGamesByDeveloperId(Integer developerId);
    void deleteGame(Integer id,Integer developerId);
    void updateGame(Game game);
    PageInfo<Game> getAllGamesForAdmin(int page, int size, String keyword);
    void deleteGameByAdmin(Integer id);
}