package com.example.test1.mapper;

import com.example.test1.entity.User;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface UserMapper {
    public User getUserById(int id);
    public List<User> getAllUsers();
    public int insertUser(User user);
    public int updateUserById(User user);
    public int deleteUserById(int id);
    public int deleteAllUsers();
}
