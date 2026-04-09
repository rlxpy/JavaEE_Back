package com.example.test1.Service.ServiceImpl;

import com.example.test1.Service.TestService;
import com.example.test1.mapper.TestMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class FirstServiceImpl implements TestService {

    @Autowired
    TestMapper testMapper;

    @Override
    public void getDate() {
        /*String date=testMapper.getDate();*/
    }
}
