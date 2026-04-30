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
}
