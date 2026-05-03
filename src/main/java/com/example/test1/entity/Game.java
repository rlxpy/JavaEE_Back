package com.example.test1.entity;

import java.util.Date;

public class Game {
    private Integer id;
    private Integer developerId;
    private Integer categoryId;
    private String gameName;
    private String description;
    private String coverImage;
    private String downloadLink;
    private Double averageRating; // 对应 DECIMAL(3,2)
    private Date createTime;
    private Integer status;

    public Game() {
    }

    public Game(Integer id, Integer developerId, Integer categoryId, String gameName, String description, String coverImage, String downloadLink, Double averageRating, Date createTime) {
        this.id = id;
        this.developerId = developerId;
        this.categoryId = categoryId;
        this.gameName = gameName;
        this.description = description;
        this.coverImage = coverImage;
        this.downloadLink = downloadLink;
        this.averageRating = averageRating;
        this.createTime = createTime;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getDeveloperId() {
        return developerId;
    }

    public void setDeveloperId(Integer developerId) {
        this.developerId = developerId;
    }

    public Integer getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    public String getGameName() {
        return gameName;
    }

    public void setGameName(String gameName) {
        this.gameName = gameName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCoverImage() {
        return coverImage;
    }

    public void setCoverImage(String coverImage) {
        this.coverImage = coverImage;
    }

    public String getDownloadLink() {
        return downloadLink;
    }

    public void setDownloadLink(String downloadLink) {
        this.downloadLink = downloadLink;
    }

    public Double getAverageRating() {
        return averageRating;
    }

    public void setAverageRating(Double averageRating) {
        this.averageRating = averageRating;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
}