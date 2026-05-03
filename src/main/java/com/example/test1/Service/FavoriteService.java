package com.example.test1.Service;

import com.example.test1.entity.Game;
import org.springframework.stereotype.Service;
import java.util.List;

public interface FavoriteService {
    public boolean checkIsFavorite(Integer userId, Integer gameId);
    public boolean toggleFavorite(Integer userId, Integer gameId);
    public List<Game> getUserFavoriteGames(Integer userId);
}