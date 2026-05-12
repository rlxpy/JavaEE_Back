package com.example.test1.config;

import com.example.test1.interceptor.JwtInterceptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.io.File;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Autowired
    private JwtInterceptor jwtInterceptor;

    // ==========================================
    // 1. 静态资源映射 (保留你原来的心血，处理图片上传)
    // ==========================================
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // 获取当前项目的根目录
        String path = System.getProperty("user.dir") + "/uploads/";
        File file = new File(path);
        if (!file.exists()) {
            file.mkdirs(); // 如果 uploads 文件夹不存在，系统会自动创建
        }

        // 核心魔法：将网络路径 /uploads/** 映射到本地的 uploads 文件夹
        registry.addResourceHandler("/uploads/**")
                .addResourceLocations("file:" + path);
    }

    // ==========================================
    // 2. ⭐️ 新增：部署 JWT 全局安检门
    // ==========================================

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(jwtInterceptor).
                // 1. 拦截所有请求
                addPathPatterns("/**")
                // 2. ⭐️ 设置白名单（坚决不能拦截的路径）
                .excludePathPatterns("/user/login", "/user/register") // 登录、注册必须放行
                .excludePathPatterns("/api/captcha")
                .excludePathPatterns("/uploads/**")                   // ⭐️ 极其重要：放行图片资源，否则前端图片全挂！
                // 3. 游客可以公开查看的数据接口（根据业务需求放行）
                .excludePathPatterns("/game/page", "/game/list", "/game/detail/**")
                .excludePathPatterns("/post/page", "/post/detail/**")
                .excludePathPatterns("/comment/game/**", "/comment/post/**");

    }
}

