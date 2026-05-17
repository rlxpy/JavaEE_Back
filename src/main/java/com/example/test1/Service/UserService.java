package com.example.test1.Service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.example.test1.entity.User;

import java.util.List;

public interface UserService {
    public User getUserById(int id);

    List<User> getAllUsers();

    boolean insertUser(User user);

    boolean updateUserById(User user);

    boolean deleteUserById(int id);

    boolean deleteAllUsers();

    //注册方法
    String register(User user);
    //登陆方法
    User login(String username, String password);

    IPage<User> getUsersByCondition(int page,int size,String keyword, Integer role);

    void updateUserStatus(Integer id, Integer status);
}
