package com.example.test1;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@MapperScan("com.example.test1.mapper")
@EnableScheduling
public class Test1Application {

    public static void main(String[] args) {
        SpringApplication.run(Test1Application.class, args);
    }

}
