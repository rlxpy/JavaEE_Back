package com.example.test1;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@MapperScan("com.example.test1.mapper")
@EnableScheduling
@EnableAsync //赋予 Spring Boot 多线程能力
public class Test1Application {
    public static void main(String[] args) {
        // ⭐️ 核心网络优化：强制使用 IPv4，解决发邮件、连数据库等网络请求的玄学超时问题！
        System.setProperty("java.net.preferIPv4Stack", "true");

        SpringApplication.run(Test1Application.class, args);
    }
}
