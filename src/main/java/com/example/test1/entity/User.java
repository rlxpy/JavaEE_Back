package com.example.test1.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@TableName("users")
public class User {
    private Integer id;
    private String username;
    private String password;
    private String nickname;
    private String avatar;
    private Integer role;

}
