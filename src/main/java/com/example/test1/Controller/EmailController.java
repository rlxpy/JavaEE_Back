package com.example.test1.Controller;

import com.example.test1.Service.EmailService;
import com.example.test1.Service.UserService;
import com.example.test1.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.concurrent.TimeUnit;

@RestController
@RequestMapping("/email")
@CrossOrigin
public class EmailController {

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @Autowired
    private EmailService emailService;

    // ⭐️ 新增：注入 UserService，用来去数据库核对邮箱
    @Autowired
    private UserService userService;

    // ⭐️ 新增：接收 type 参数（1代表注册，2代表找回密码）
    @PostMapping("/sendCode")
    public Map<String, Object> sendCode(@RequestParam String email, @RequestParam(defaultValue = "1") Integer type) {
        Map<String, Object> result = new HashMap<>();

        if (email == null || email.trim().isEmpty()) {
            result.put("code", 400);
            result.put("msg", "邮箱不能为空");
            return result;
        }

        // ================= ⭐️ 核心防御：业务场景核对 =================
        User user = userService.getUserByEmail(email); // 用咱们之前写的“老办法”查用户

        if (type == 1) {
            // 场景 1：注册。如果数据库里已经有这个人了，直接拦截！
            if (user != null) {
                result.put("code", 400);
                result.put("msg", "该邮箱已被注册，请直接登录或找回密码！");
                return result;
            }
        } else if (type == 2) {
            // 场景 2：找回密码。如果数据库里根本没这个人，直接拦截！
            if (user == null) {
                result.put("code", 400);
                result.put("msg", "该邮箱尚未注册通行证，请检查是否输入有误！");
                return result;
            }
        }
        // =========================================================

        // 防刷机制
        String redisKey = "email:code:" + email;
        Long expire = stringRedisTemplate.getExpire(redisKey, TimeUnit.MINUTES);
        if (expire != null && expire > 4) {
            result.put("code", 400);
            result.put("msg", "验证码发送太频繁，请稍后再试！");
            return result;
        }

        String code = String.valueOf(new Random().nextInt(899999) + 100000);
        stringRedisTemplate.opsForValue().set(redisKey, code, 5, TimeUnit.MINUTES);

        // 异步发邮件
        emailService.sendAuthCodeEmail(email, code);

        result.put("code", 200);
        result.put("msg", "验证码发送指令已下达，请注意查收邮件！");
        return result;
    }
}