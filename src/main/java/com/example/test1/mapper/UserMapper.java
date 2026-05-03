package com.example.test1.mapper;

import com.example.test1.entity.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface UserMapper {

    public User getUserById(int id);
    public List<User> getAllUsers();
    public User getUserByUsername(String username);

    public int insertUser(User user);

    public int updateUserById(User user);

    public int deleteUserById(int id);
    public int deleteAllUsers();

    // 根据关键词和身份进行条件查询
    public List<User> getUsersByCondition(@Param("keyword") String keyword, @Param("role") Integer role);

}
