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

import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public User getUserById(int id) {
        return userMapper.selectById(id);
    }

    // ⭐️ 新增：根据邮箱精准捞人
    @Override
    public User getUserByEmail(String email) {
        LambdaQueryWrapper<User> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(User::getEmail, email);
        return userMapper.selectOne(queryWrapper);
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
        // 1. 查用户名是否重复
        LambdaQueryWrapper<User> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(User::getUsername, user.getUsername());
        if (userMapper.selectOne(queryWrapper) != null) {
            return "用户名已存在";
        }

        // ⭐️ 2. 新增：查邮箱是否重复 (防止一个邮箱无限白嫖账号)
        LambdaQueryWrapper<User> emailWrapper = new LambdaQueryWrapper<>();
        emailWrapper.eq(User::getEmail, user.getEmail());
        if (userMapper.selectOne(emailWrapper) != null) {
            return "该邮箱已被其他账号绑定";
        }

        if(user.getNickname() == null || user.getNickname().isEmpty()){
            user.setNickname(user.getUsername());
        }

        if (user.getRole() == null) {
            user.setRole(0);
        }

        // BCrypt 密码加盐
        String hashPass = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
        user.setPassword(hashPass);

        userMapper.insert(user);
        return "注册成功";
    }

    @Override
    public User login(String username, String password) {
        LambdaQueryWrapper<User> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(User::getUsername, username);
        User user = userMapper.selectOne(queryWrapper);

        if (user == null) {
            throw new RuntimeException("用户名或密码错误！");
        }

        if (user.getStatus() != null && user.getStatus() == 1) {
            throw new RuntimeException("🚫 您的账号已被永久封停，请联系客服处理！");
        }

        if(user != null && BCrypt.checkpw(password, user.getPassword())){
            return user;
        }
        return null;
    }

    @Override
    public IPage<User> getUsersByCondition(int page, int size, String keyword, Integer role) {
        Page<User> pageParam = new Page<>(page, size);

        LambdaQueryWrapper<User> wrapper = new LambdaQueryWrapper<>();

        if(keyword != null && !keyword.isEmpty()){
            wrapper.and(w -> w.like(User::getUsername, keyword).or().like(User::getNickname, keyword));
        }

        if(role != null){
            wrapper.eq(User::getRole, role);
        }

        return userMapper.selectPage(pageParam, wrapper);
    }

    @Override
    public void updateUserStatus(Integer id, Integer status) {
        com.example.test1.entity.User user = new com.example.test1.entity.User();
        user.setId(id);
        user.setStatus(status);
        userMapper.updateById(user);
    }
}