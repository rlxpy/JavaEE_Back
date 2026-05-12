package com.example.test1.utils;

public class UserContext {
    // ThreadLocal 就是当前线程的私有变量，别的线程（别的用户请求）绝对拿不到。
    private static final ThreadLocal<Integer> userThreadLocal = new ThreadLocal<>();

    // 存入当前登录用户的 ID
    public static void setUserId(Integer userId) {
        userThreadLocal.set(userId);
    }

    // 在 Controller/Service 中随时获取当前用户 ID
    public static Integer getUserId() {
        return userThreadLocal.get();
    }

    // ⭐️ 极其重要：请求结束后必须清空柜子！
    // 否则因为 Tomcat 的线程池机制，会发生内存泄漏或拿错上一个人的数据。
    public static void remove(){
        userThreadLocal.remove();
    }
}
