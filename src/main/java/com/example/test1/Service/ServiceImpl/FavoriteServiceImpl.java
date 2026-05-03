package com.example.test1.Service.ServiceImpl;

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
        Favorite fav = favoriteMapper.checkFavorite(userId, gameId);
        return fav != null; // 如果查到了说明已收藏，返回 true
    }

    @Override
    public boolean toggleFavorite(Integer userId, Integer gameId) {
        Favorite fav = favoriteMapper.checkFavorite(userId, gameId);
        if (fav != null) {
            // 已经收藏了，那就执行取消（删除）
            favoriteMapper.removeFavorite(userId, gameId);
            return false; // 返回 false 表示当前状态是未收藏
        } else {
            // 还没收藏，执行添加
            Favorite newFav = new Favorite();
            newFav.setUserId(userId);
            newFav.setGameId(gameId);
            favoriteMapper.addFavorite(newFav);
            return true; // 返回 true 表示当前状态是已收藏
        }
    }

    @Override
    public List<Game> getUserFavoriteGames(Integer userId) {
        return favoriteMapper.getFavoriteGamesByUserId(userId);
    }
}