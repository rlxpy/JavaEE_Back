package com.example.test1.mapper;

import com.example.test1.entity.Game;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface GameMapper {
    List<Game> getAllGames(@Param("keyword") String keyword);
    public Game getGameById(int id);
    public int insertGame(Game game);
    // 更新指定游戏的平均分
    public void updateGameRating(@Param("gameId") Integer gameId, @Param("avgRating") Double avgRating);
    // 计算指定游戏的所有评论平均分
    public Double getAverageRatingByGameId(Integer gameId);
    List<Game> getGamesByStatus(Integer status);
    void updateGameStatus(@Param("id") Integer id, @Param("status") Integer status);
    List<Game> getGamesByDeveloperId(Integer developerId);
    void deleteGame(Integer id,Integer developerId);
    void updateGame(Game game);
    List<Game> getAllGamesForAdmin(@Param("keyword") String keyword);
    void deleteGameByAdmin(Integer id);
}
