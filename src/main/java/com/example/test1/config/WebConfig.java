package com.example.test1.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.io.File;

@Configuration
public class WebConfig implements WebMvcConfigurer {

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
}