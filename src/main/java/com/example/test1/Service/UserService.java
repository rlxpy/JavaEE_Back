package com.example.test1.Service;

import com.example.test1.entity.User;

import java.util.List;

public interface UserService {
    public User getUserById(int id);

    List<User> getAllUsers();

    boolean insertUser(User user);

    boolean updateUserById(User user);

    boolean deleteUserById(int id);

    boolean deleteAllUsers();

}
