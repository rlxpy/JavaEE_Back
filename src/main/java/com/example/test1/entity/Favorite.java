package com.example.test1.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Favorite {
    private Integer id;
    private Integer userId;
    private Integer gameId;
    private Date createTime;
}