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
@TableName("comments")
public class Comment {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private Integer userId;
    private Integer gameId;
    private Integer postId;
    private String content;
    private Integer rating;
    private Date createTime;

    // ⭐ 告诉 MyBatis-Plus：这个字段数据库里没有，执行 CRUD 时别管它！
    @TableField(exist = false)
    private String nickname;

    @TableField(exist = false)
    private String avatar;
}