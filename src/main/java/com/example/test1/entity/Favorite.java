package com.example.test1.entity;

import java.util.Date;

public class Favorite {
    private Integer id;
    private Integer userId;
    private Integer gameId;
    private Date createTime;

    public Favorite() {
    }

    public Favorite(Integer id, Integer userId, Integer gameId, Date createTime) {
        this.id = id;
        this.userId = userId;
        this.gameId = gameId;
        this.createTime = createTime;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getGameId() {
        return gameId;
    }

    public void setGameId(Integer gameId) {
        this.gameId = gameId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

}