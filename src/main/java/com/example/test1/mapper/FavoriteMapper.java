package com.example.test1.mapper;

import com.example.test1.entity.Favorite;
import com.example.test1.entity.Game;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface FavoriteMapper {
    // 检查是否已收藏
    Favorite checkFavorite(@Param("userId") Integer userId, @Param("gameId") Integer gameId);

    // 添加收藏
    int addFavorite(Favorite favorite);

    // 取消收藏
    int removeFavorite(@Param("userId") Integer userId, @Param("gameId") Integer gameId);

    // ⭐️ 核心连表：根据用户ID，去关联查出所有的游戏详情！
    List<Game> getFavoriteGamesByUserId(Integer userId);
}