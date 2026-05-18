package com.example.test1.Service;

public interface EmailService {
    // 异步发送邮件的方法
    void sendAuthCodeEmail(String email, String code);
}