package com.example.test1.Service.ServiceImpl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.example.test1.Service.FavoriteService;
import com.example.test1.entity.Favorite;
import com.example.test1.entity.Game;
import com.example.test1.mapper.FavoriteMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FavoriteServiceImpl implements FavoriteService {

    @Autowired
    private FavoriteMapper favoriteMapper;

    @Override
    public boolean checkIsFavorite(Integer userId, Integer gameId) {
        // ⭐️ MP 原生查询：用 selectCount 比查出整个对象更高效
        LambdaQueryWrapper<Favorite> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Favorite::getUserId, userId).eq(Favorite::getGameId, gameId);
        return favoriteMapper.selectCount(wrapper) > 0;
    }

    @Override
    public boolean toggleFavorite(Integer userId, Integer gameId) {
        LambdaQueryWrapper<Favorite> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Favorite::getUserId, userId).eq(Favorite::getGameId, gameId);
        Favorite fav = favoriteMapper.selectOne(wrapper);

        if (fav != null) {
            // ⭐️ MP 原生删除：已经收藏了，那就执行取消
            favoriteMapper.delete(wrapper);
            return false; // 返回 false 表示当前状态是未收藏
        } else {
            // ⭐️ MP 原生插入：还没收藏，执行添加
            Favorite newFav = new Favorite();
            newFav.setUserId(userId);
            newFav.setGameId(gameId);
            favoriteMapper.insert(newFav);
            return true; // 返回 true 表示当前状态是已收藏
        }
    }

    @Override
    public List<Game> getUserFavoriteGames(Integer userId) {
        // ⭐️ 复杂的多表联查，继续调用 Mapper 里保留的 XML SQL
        return favoriteMapper.getFavoriteGamesByUserId(userId);
    }
}