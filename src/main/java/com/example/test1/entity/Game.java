package com.example.test1.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
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
}