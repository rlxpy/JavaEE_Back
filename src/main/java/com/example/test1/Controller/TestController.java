package com.example.test1.Controller;

import com.example.test1.Service.TestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController("/test")
public class TestController {


    @Autowired
    TestService testService;
    @PostMapping("/post")
    public String test() {

        testService.getDate();
        return "test";
    }

}
