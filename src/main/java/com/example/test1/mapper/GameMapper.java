package com.example.test1.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.test1.entity.Game;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface GameMapper extends BaseMapper<Game> {
    // 更新指定游戏的平均分
    public void updateGameRating(@Param("gameId") Integer gameId, @Param("avgRating") Double avgRating);
    // 计算指定游戏的所有评论平均分
    public Double getAverageRatingByGameId(Integer gameId);
}
