package com.example.test1.entity;

import java.util.Date;

public class Comment {
    private Integer id;
    private Integer userId;
    private Integer gameId;
    private Integer postId;
    private String content;
    private Integer rating;
    private Date createTime;

    // ⭐ 新增：这两个字段数据库里没有，是专门用来接收连表查询结果的
    private String nickname;
    private String avatar;

    public Comment() {
    }

    public Comment(Integer id, Integer userId, Integer gameId, Integer postId, String content, Integer rating, Date createTime) {
        this.id = id;
        this.userId = userId;
        this.gameId = gameId;
        this.postId = postId;
        this.content = content;
        this.rating = rating;
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

    public Integer getPostId() {
        return postId;
    }

    public void setPostId(Integer postId) {
        this.postId = postId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Integer getRating() {
        return rating;
    }

    public void setRating(Integer rating) {
        this.rating = rating;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }
}