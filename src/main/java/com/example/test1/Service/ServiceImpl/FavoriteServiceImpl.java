package com.example.test1.Service.ServiceImpl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.example.test1.Service.FavoriteService;
import com.example.test1.Service.NotificationService;
import com.example.test1.entity.Favorite;
import com.example.test1.entity.Game;
import com.example.test1.entity.Notification;
import com.example.test1.mapper.FavoriteMapper;
import com.example.test1.mapper.GameMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class FavoriteServiceImpl implements FavoriteService {

    @Autowired
    private FavoriteMapper favoriteMapper;

    @Autowired
    private GameMapper gameMapper; // ⭐️ 注入用来查游戏信息

    @Autowired
    private NotificationService notificationService;

    @Override
    public boolean checkIsFavorite(Integer userId, Integer gameId) {
        // ⭐️ MP 原生查询：用 selectCount 比查出整个对象更高效
        LambdaQueryWrapper<Favorite> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Favorite::getUserId, userId).eq(Favorite::getGameId, gameId);
        return favoriteMapper.selectCount(wrapper) > 0;
    }

    @Override
    @Transactional
    public boolean toggleFavorite(Integer userId, Integer gameId) {
        LambdaQueryWrapper<Favorite> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Favorite::getUserId, userId).eq(Favorite::getGameId, gameId);
        Favorite fav = favoriteMapper.selectOne(wrapper);

        if (fav != null) {
            favoriteMapper.delete(wrapper);
            return false;
        } else {
            Favorite newFav = new Favorite();
            newFav.setUserId(userId);
            newFav.setGameId(gameId);
            favoriteMapper.insert(newFav);

            // ⭐️ 新增：触发收藏通知
            sendGameFavoriteNotification(gameId, userId);

            return true;
        }
    }

    // 📩 辅助方法：发送游戏收藏通知
    private void sendGameFavoriteNotification(Integer gameId, Integer senderId) {
        Game game = gameMapper.selectById(gameId);
        // 如果不是开发者自己收藏自己的游戏
        if (game != null && !game.getDeveloperId().equals(senderId)) {
            Notification notif = new Notification();
            notif.setSenderId(senderId);
            notif.setReceiverId(game.getDeveloperId()); // 接收者是开发者
            notif.setType(2); // 2 代表收藏
            notif.setReferenceType("game");
            notif.setReferenceId(gameId);
            notif.setContent("收藏了你的游戏: " + game.getGameName());

            notificationService.sendNotification(notif);
        }
    }

    @Override
    public List<Game> getUserFavoriteGames(Integer userId) {
        // ⭐️ 复杂的多表联查，继续调用 Mapper 里保留的 XML SQL
        return favoriteMapper.getFavoriteGamesByUserId(userId);
    }
}