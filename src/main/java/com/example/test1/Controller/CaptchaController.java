package com.example.test1.Controller;

import cn.hutool.captcha.CaptchaUtil;
import cn.hutool.captcha.LineCaptcha;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

@RestController
@RequestMapping("/api")
@CrossOrigin
public class CaptchaController {
    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    /**
     * 获取图形验证码接口
     */
    @GetMapping("/captcha")
    public Map<String,Object> getCaptcha(){
        Map<String,Object> result = new HashMap<>();

        // 1. 使用 Hutool 生成一张带干扰线的图形验证码 (宽 120, 高 40, 4 位字符, 5 条干扰线)
        LineCaptcha lineCaptcha = CaptchaUtil.createLineCaptcha(120,40,4,5);

        // 2. 获取这四位真实的答案（比如 "a4b9"）
        String code = lineCaptcha.getCode();

        // 3. 生成一个独一无二的身份证号 UUID，去掉里面的横杠
        String uuid = UUID.randomUUID().toString().replace("-","");

        // 4.核心防御：把 <UUID, 真实答案> 存入 Redis，并设置 2 分钟过期！
        // 也就是说，这个验证码 2 分钟内没用就作废了
        stringRedisTemplate.opsForValue().set("captcha:" + uuid, code, 2, TimeUnit.MINUTES);

        // 5. 将图片的 Base64 编码和 UUID 返回给前端
        result.put("code", 200);
        result.put("msg", "获取验证码成功");
        Map<String, String> data = new HashMap<>();
        data.put("uuid", uuid);
        data.put("image", lineCaptcha.getImageBase64Data()); // Hutool 自带转 Base64 的方法，极其方便

        result.put("data", data);
        return result;

    }
}
