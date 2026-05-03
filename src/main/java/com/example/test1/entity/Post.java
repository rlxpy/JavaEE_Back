package com.example.test1.entity;

import java.util.Date;

public class Post {
    private Integer id;
    private Integer userId;
    private Integer gameId;
    private String title;
    private String content;
    private Integer viewCount;
    private Date createTime;
    private Integer likeCount;

    // ⭐️ 补充两个连表查询用的附加字段
    private String nickname;
    private String avatar;

    public Post() {
    }

    public Post(Integer id, Integer userId, Integer gameId, String title, String content, Integer viewCount, Date createTime) {
        this.id = id;
        this.userId = userId;
        this.gameId = gameId;
        this.title = title;
        this.content = content;
        this.viewCount = viewCount;
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

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Integer getViewCount() {
        return viewCount;
    }

    public void setViewCount(Integer viewCount) {
        this.viewCount = viewCount;
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

    public Integer getLikeCount() {
        return likeCount;
    }

    public void setLikeCount(Integer likeCount) {
        this.likeCount = likeCount;
    }
}