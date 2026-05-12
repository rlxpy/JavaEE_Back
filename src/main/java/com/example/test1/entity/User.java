package com.example.test1.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@TableName("users")
public class User {
    @TableId(type = IdType.AUTO)
    private Integer id;
    @NotBlank(message = "用户名不能为空！")
    @Size(min = 4, max = 20, message = "为了您的账号安全，用户名长度必须在 4 到 20 个字符之间")
    private String username;
    @NotBlank(message = "密码不能为空！")
    @Size(min = 6, max = 30, message = "密码长度必须在 6 到 30 个字符之间")
    private String password;
    private String nickname;
    private String avatar;
    private Integer role;

}
