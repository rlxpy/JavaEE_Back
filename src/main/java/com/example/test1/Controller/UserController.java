package com.example.test1.Controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.example.test1.Service.UserService;
import com.example.test1.entity.User;
import com.example.test1.utils.JwtUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@RestController
@RequestMapping("/user")
@CrossOrigin
public class UserController {

    @Autowired
    public UserService userService;

    @GetMapping("/get/{id}")
    public User getUser(@PathVariable int id) {
        User user = userService.getUserById(id);
        if(user == null) {
            return null;
        }
        return user;
    }

    @GetMapping("/getAll")
    public List<User> getAll() {
        List<User> students = new ArrayList<User>();
        students = userService.getAllUsers();
        return students;
    }

    @PostMapping("/update") // 推荐用 POST 统一前后端调用习惯，或者你保留 PutMapping 也可以
    public Map<String, Object> updateUserInfo(@RequestBody User user) {
        Map<String, Object> result = new HashMap<>();

        // 校验是否传入了 ID
        if(user.getId() == null){
            result.put("code", 400);
            result.put("msg", "用户ID不能为空");
            return result;
        }

        // 调用你之前的 Service 执行更新
        boolean success = userService.updateUserById(user);

        if(success) {
            result.put("code", 200);
            result.put("msg", "个人信息保存成功！");

            // ⭐️ 核心细节：更新成功后，重新从数据库查出最新的用户信息返回给前端
            // 这样前端就能立刻更新页面上的头像和昵称了
            User updatedUser = userService.getUserById(user.getId());
            // 出于安全考虑，不要把密码返回给前端
            updatedUser.setPassword(null);

            result.put("data", updatedUser);
        } else {
            result.put("code", 400);
            result.put("msg", "保存失败，请稍后重试");
        }

        return result;
    }

    @PostMapping("/insert")
    public String insertUser(@RequestBody User student) {
        boolean success = userService.insertUser(student);
        return success ? "yes" : "no";
    }

    @DeleteMapping("/delete/{id}")
    public String deleteUser(@PathVariable int id) {
        boolean success = userService.deleteUserById(id);
        return success ? "yes" : "no";
    }

    @DeleteMapping("/deleteAll")
    public String deleteAll() {
        boolean success = userService.deleteAllUsers();
        return success ? "yes" : "no";
    }

    /*登陆注册区域*/
    // 注册接口：使用 POST 请求
    @PostMapping("/register")
    public Map<String, Object> register(@RequestBody User user) {
        Map<String, Object> result = new HashMap<>();

        // ⭐️ 安全防御：如果前端传来的 role 是 2（超级管理员）或者为空，强制降级为 0（普通玩家）
        if (user.getRole() == null || user.getRole() == 2) {
            user.setRole(0);
        }

        String msg = userService.register(user);
        if("注册成功".equals(msg)) {
            result.put("code", 200); // 200 表示成功
            result.put("msg", msg);
        }else{
            result.put("code", 400); // 400 表示失败（比如用户名已存在）
            result.put("msg", msg);
        }
        return result;
    }

    // 登录接口：使用 POST 请求
    @PostMapping("/login")
    public Map<String, Object> login(@RequestBody User user) {
        Map<String, Object> result = new HashMap<>();
        User loginUser = userService.login(user.getUsername(), user.getPassword());

        if(loginUser != null) {
            //2. 登录成功！立刻调用机器生成专属的“电子护照”\
            String token = JwtUtils.generateToken(loginUser.getId(),loginUser.getRole());
            //3. 安全规范：脱敏处理！把密码抹掉再发给前端，防止被黑客抓包
            loginUser.setPassword(null);
            result.put("code", 200);
            result.put("msg", "登录成功！");
            result.put("data", loginUser);
            result.put("token", token);
        }else{
            result.put("code", 400);
            result.put("msg", "账号或密码错误");
        }
        return result;
    }

    // ⭐️ 高级分页与条件查询接口
    @GetMapping("/page")
    public Map<String, Object> getUsersByPage(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) Integer role) {

        Map<String, Object> result = new HashMap<>();

        try {
            // ⭐️ 直接调用 Service，拿到 MP 的分页结果
            IPage<User> pageInfo = userService.getUsersByCondition(page, size, keyword, role);

            // ⭐️ 完美伪装成 PageHelper 的返回格式，保证前端不崩！
            Map<String, Object> pageData = new HashMap<>();
            pageData.put("total", pageInfo.getTotal());        // 总条数
            pageData.put("list", pageInfo.getRecords());       // 当前页的数据列表
            pageData.put("pageNum", pageInfo.getCurrent());    // 当前页码
            pageData.put("pageSize", pageInfo.getSize());      // 每页条数

            result.put("code", 200);
            result.put("msg", "查询成功");
            result.put("data", pageData);
        } catch (Exception e) {
            result.put("code", 500);
            result.put("msg", "分页查询失败：" + e.getMessage());
        }

        return result;
    }
}
