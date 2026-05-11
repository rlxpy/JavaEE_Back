package com.example.test1.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.test1.entity.Favorite;
import com.example.test1.entity.Game;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface FavoriteMapper extends BaseMapper<Favorite> {
    // ⭐️ 核心连表：根据用户ID，去关联查出所有的游戏详情！
    List<Game> getFavoriteGamesByUserId(Integer userId);
}