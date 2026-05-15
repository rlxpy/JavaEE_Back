package com.example.test1.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField; // ⭐️ 引入 MP 的注解
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@TableName("post")
public class Post {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private Integer userId;
    private Integer gameId;
    private Integer categoryId;
    private String title;

    private Integer viewCount;
    private Integer likeCount;
    private Integer commentCount;
    private Integer collectCount;
    private Double hotScore;

    private Date createTime;
    private Date updateTime;

    @TableField(exist = false)
    private String nickname;

    @TableField(exist = false)
    private String avatar;

    @TableField(exist = false)
    private String content;

    @TableField(exist = false)
    private String gameName;
}