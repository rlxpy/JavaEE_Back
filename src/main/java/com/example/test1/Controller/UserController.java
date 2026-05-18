package com.example.test1.Controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.example.test1.Service.UserService;
import com.example.test1.entity.User;
import com.example.test1.utils.JwtUtils;
import jakarta.validation.Valid;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@RestController
@RequestMapping("/user")
@CrossOrigin
public class UserController {

    @Autowired
    public UserService userService;

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

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
    public Map<String, Object> register(@Valid @RequestBody User user, @RequestParam(required = false) String emailCode) {
        Map<String, Object> result = new HashMap<>();

        String uuid = user.getUuid();
        String userCode = user.getCode();

        // 1. 检查邮箱和验证码有没有传
        if (user.getEmail() == null || user.getEmail().isEmpty() || emailCode == null || emailCode.isEmpty()) {
            result.put("code", 400);
            result.put("msg", "邮箱或邮箱验证码缺失！");
            return result;
        }

        // 2. 去 Redis 核对邮箱验证码
        String redisKey = "email:code:" + user.getEmail();
        String realCode = stringRedisTemplate.opsForValue().get(redisKey);

        stringRedisTemplate.delete(redisKey);

        if (realCode == null) {
            result.put("code", 400);
            result.put("msg", "验证码已过期，请重新获取！");
            return result;
        }

        if (!realCode.equals(emailCode)) {
            result.put("code", 400);
            result.put("msg", "邮箱验证码错误！");
            return result;
        }

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
    public Map<String, Object> login(@Valid @RequestBody User user) {
        Map<String, Object> result = new HashMap<>();

        String uuid = user.getUuid();
        String userCode = user.getCode();

        // 1. 基本参数防漏检查
        if (uuid == null || userCode == null || uuid.isEmpty() || userCode.isEmpty()) {
            result.put("code", 400);
            result.put("msg", "验证码或暗号缺失！");
            return result; // 🚨 直接阻断，绝不放行！
        }

        // 2. 去 Redis 拿真实的答案（根据前端给的暗号）
        // 注意：这里你的 redis key 名字要和你生成验证码存进去时保持一致！比如如果是 "captcha:" + uuid
        String redisKey = "captcha:" + uuid;
        String realCode = stringRedisTemplate.opsForValue().get(redisKey);

        // 3. 绝杀技：阅后即焚（防止重放攻击）
        // 只要我查过了，不管接下来是对是错，立刻把 Redis 里的验证码炸毁！
        stringRedisTemplate.delete(redisKey);

        // 4. 防过期检查
        if (realCode == null) {
            result.put("code", 400);
            result.put("msg", "验证码已过期，请点击图片重新获取！");
            return result; // 阻断！
        }

        // 5. 对比答案（equalsIgnoreCase 表示忽略大小写，a 和 A 都算对）
        if (!realCode.equalsIgnoreCase(userCode)) {
            result.put("code", 400);
            result.put("msg", "验证码输入错误！");
            return result; // 阻断！
        }

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

    // ⭐️ 只有超级管理员可以调用的封禁接口
    @PostMapping("/admin/ban")
    public Map<String, Object> banUser(@RequestParam Integer id, @RequestParam Integer status) {
        Map<String, Object> result = new HashMap<>();
        try {
            // 调用你刚在 Service 里写的方法
            userService.updateUserStatus(id, status);
            result.put("code", 200);
            result.put("msg", status == 1 ? "🚫 该玩家已被成功封禁！" : "✅ 该玩家已解除封禁！");
        } catch (Exception e) {
            result.put("code", 500);
            result.put("msg", "操作失败：" + e.getMessage());
        }
        return result;
    }

    // ⭐️ 新增：忘记密码 / 重置密码接口 (修复了没加密的致命 Bug)
    @PostMapping("/resetPassword")
    public Map<String, Object> resetPassword(@RequestParam String email, @RequestParam String code, @RequestParam String newPassword) {
        Map<String, Object> result = new HashMap<>();

        if (email == null || code == null || newPassword == null) {
            result.put("code", 400);
            result.put("msg", "参数不能为空");
            return result;
        }

        // 1. 去 Redis 核对邮箱验证码
        String redisKey = "email:code:" + email;
        String realCode = stringRedisTemplate.opsForValue().get(redisKey);

        if (realCode == null || !realCode.equals(code)) {
            result.put("code", 400);
            result.put("msg", "验证码错误或已过期");
            return result;
        }

        // 2. 调用咱们“老办法”写的 getUserByEmail
        User user = userService.getUserByEmail(email);

        if (user == null) {
            result.put("code", 400);
            result.put("msg", "该邮箱尚未注册账号！");
            return result;
        }

        // ⭐️ 3. 极其重要的修正：新密码必须走 BCrypt 加密！否则无法登录！
        String hashPass = BCrypt.hashpw(newPassword, BCrypt.gensalt());
        user.setPassword(hashPass);

        // 调用咱们“老办法”的 update 方法
        boolean success = userService.updateUserById(user);

        if (success) {
            // 阅后即焚
            stringRedisTemplate.delete(redisKey);
            result.put("code", 200);
            result.put("msg", "密码重置成功，请使用新密码登录！");
        } else {
            result.put("code", 500);
            result.put("msg", "密码重置失败，请联系管理员");
        }

        return result;
    }

    // ==========================================
    // ⭐️ 新增：个人中心专属 - 修改密码接口（带旧密码校验）
    // ==========================================
    @PostMapping("/changePassword")
    public Map<String, Object> changePassword(
            @RequestParam Integer id,
            @RequestParam String oldPassword,
            @RequestParam String newPassword) {

        Map<String, Object> result = new HashMap<>();

        // 1. 基本参数校验
        if (id == null || oldPassword == null || newPassword == null || newPassword.trim().isEmpty()) {
            result.put("code", 400);
            result.put("msg", "参数不完整");
            return result;
        }

        // 2. 去数据库里查出当前用户
        User user = userService.getUserById(id);
        if (user == null) {
            result.put("code", 400);
            result.put("msg", "未找到该账号信息！");
            return result;
        }

        // 3. ⭐️ 核心防御：校验旧密码是否正确 (用 BCrypt 核对)
        if (!BCrypt.checkpw(oldPassword, user.getPassword())) {
            result.put("code", 400);
            result.put("msg", "原密码输入错误，请重新输入！");
            return result;
        }

        // 4. 校验通过，给新密码加盐加密
        String hashPass = BCrypt.hashpw(newPassword, BCrypt.gensalt());
        user.setPassword(hashPass);

        // 5. 执行更新
        boolean success = userService.updateUserById(user);
        if (success) {
            result.put("code", 200);
            result.put("msg", "密码修改成功，安全凭证已失效，请重新登录！");
        } else {
            result.put("code", 500);
            result.put("msg", "服务器异常，修改失败");
        }

        return result;
    }
}
