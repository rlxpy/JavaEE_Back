package com.example.test1.Service.ServiceImpl;

import com.example.test1.Service.UserService;
import com.example.test1.entity.User;
import com.example.test1.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public User getUserById(int id) {
        User user = new User();
        user=userMapper.getUserById(id);
        return user;
    }

    @Override
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        users=userMapper.getAllUsers();
        return users;
    }

    @Override
    public boolean insertUser(User user) {
        return userMapper.insertUser(user) > 0;
    }

    @Override
    public boolean updateUserById(User user) {
        return userMapper.updateUserById(user) > 0;
    }

    @Override
    public boolean deleteUserById(int id) {
        return userMapper.deleteUserById(id) > 0;
    }

    @Override
    public boolean deleteAllUsers() {
        return userMapper.deleteAllUsers() > 0;
    }

    @Override
    public String register(User user) {
        //1.检查用户名是否已经被注册了
        User existingUser = userMapper.getUserByUsername(user.getUsername());
        if (existingUser != null) {
            return "用户名已存在";
        }
        // 2. 如果没传昵称，默认拿用户名当昵称
        if(user.getNickname()==null || user.getNickname().isEmpty()){
            user.setNickname(user.getUsername());
        }

        //3.强制赋予默认角色：0（普通用户）
        user.setRole(0);

        //存入数据库
        userMapper.insertUser(user);
        return "注册成功！";
    }

    @Override
    public User login(String username, String password) {
        // 1. 先根据用户名查出这个用户
        User user = userMapper.getUserByUsername(username);

        // 2. 如果用户存在，并且数据库里的密码和传进来的密码一样
        if(user!=null && user.getPassword().equals(password)){
            return user;
        }
        return null;
    }

    @Override
    public List<User> getUsersByCondition(String keyword, Integer role) {
        return userMapper.getUsersByCondition(keyword, role);
    }
}
