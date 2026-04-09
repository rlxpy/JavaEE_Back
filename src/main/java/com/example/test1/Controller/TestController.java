package com.example.test1.Controller;

import com.example.test1.Service.TestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/test")
public class TestController {


    @Autowired
    TestService testService;
    @GetMapping("/get")
    public String test() {

//        testService.getDate();
        return "test";
    }

}
