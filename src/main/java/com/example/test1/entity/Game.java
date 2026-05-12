package com.example.test1.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@TableName("games")
public class Game {
    @TableId(type = IdType.AUTO)
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
}