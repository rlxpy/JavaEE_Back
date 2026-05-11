package com.example.test1.Service.ServiceImpl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.test1.Service.UserService;
import com.example.test1.entity.User;
import com.example.test1.mapper.UserMapper;
import org.mindrot.jbcrypt.BCrypt;
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
        return userMapper.selectById(id);
    }

    @Override
    public List<User> getAllUsers() {
        return userMapper.selectList(null);
    }

    @Override
    public boolean insertUser(User user) {
        return userMapper.insert(user) > 0;
    }

    @Override
    public boolean updateUserById(User user) {
        return userMapper.updateById(user) > 0;
    }

    @Override
    public boolean deleteUserById(int id) {
        return userMapper.deleteById(id) > 0;
    }

    @Override
    public boolean deleteAllUsers() {
        return userMapper.delete(null) > 0;
    }

    @Override
    public String register(User user) {
        LambdaQueryWrapper<User> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(User::getUsername, user.getUsername());
        User exitingUser = userMapper.selectOne(queryWrapper);

        if(exitingUser != null) {
            return "用户名已存在";
        }

        if(user.getNickname() == null || user.getNickname().isEmpty()){
            user.setNickname(user.getUsername());
        }
        user.setRole(0);

        //BCrypt 密码加盐
        String hashPass = BCrypt.hashpw(user.getPassword(),BCrypt.gensalt());
        user.setPassword(hashPass);

        userMapper.insert(user);
        return "注册成功";
    }

    @Override
    public User login(String username, String password) {
        LambdaQueryWrapper<User> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(User::getUsername, username);
        User user = userMapper.selectOne(queryWrapper);

        if(user != null && BCrypt.checkpw(password,user.getPassword())){
            return user;
        }
        return null;
    }

    @Override
    public IPage<User> getUsersByCondition(int page, int size,String keyword, Integer role) {
        Page<User> pageParam = new Page<>(page, size);

        LambdaQueryWrapper<User> wrapper = new LambdaQueryWrapper<>();

        if(keyword != null && !keyword.isEmpty()){
            wrapper.and(w -> w.like(User::getUsername,keyword).or().like(User::getNickname,keyword));
        }

        if(role != null){
            wrapper.eq(User::getRole,role);
        }

        return userMapper.selectPage(pageParam,wrapper);
    }
}
