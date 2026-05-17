package com.example.test1.Controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page; // ⭐️ 引入 MP 的 Page
import com.example.test1.entity.Notification;
import com.example.test1.mapper.NotificationMapper;
import com.example.test1.utils.UserContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/notification")
@CrossOrigin
public class NotificationController {

    @Autowired
    private NotificationMapper notificationMapper;

    @Autowired
    private com.example.test1.mapper.UserMapper userMapper;

    // 1. 获取当前用户的未读消息总数
    @GetMapping("/unread")
    public Map<String, Object> getUnreadCount() {
        Map<String, Object> result = new HashMap<>();
        Integer userId = UserContext.getUserId();

        LambdaQueryWrapper<Notification> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Notification::getReceiverId, userId).eq(Notification::getIsRead, 0);
        Long count = notificationMapper.selectCount(wrapper);

        result.put("code", 200);
        result.put("data", count);
        return result;
    }

    // 2. ⭐️ 升级版：获取分页和分类的消息列表
    @GetMapping("/page")
    public Map<String, Object> getNotificationPage(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) Integer type) { // ⭐️ 动态分类参数

        Map<String, Object> result = new HashMap<>();
        Integer userId = UserContext.getUserId();

        Page<Notification> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<Notification> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Notification::getReceiverId, userId);

        // ⭐️ 核心：如果前端传了分类 type，就加上过滤条件
        if (type != null) {
            wrapper.eq(Notification::getType, type);
        }
        wrapper.orderByDesc(Notification::getCreateTime);

        // 执行分页查询
        Page<Notification> notificationPage = notificationMapper.selectPage(pageParam, wrapper);

        // ⭐️ 补全当前页发送者的头像和昵称
        for (Notification n : notificationPage.getRecords()) {
            if (n.getSenderId() != null && n.getSenderId() != 0) {
                com.example.test1.entity.User sender = userMapper.selectById(n.getSenderId());
                if (sender != null) {
                    n.setSenderNickname(sender.getNickname());
                    n.setSenderAvatar(sender.getAvatar());
                }
            } else {
                n.setSenderNickname("系统管理员");
                n.setSenderAvatar("https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png");
            }
        }

        // 组装返回给前端的数据结构
        Map<String, Object> pageData = new HashMap<>();
        pageData.put("total", notificationPage.getTotal());
        pageData.put("list", notificationPage.getRecords());

        result.put("code", 200);
        result.put("data", pageData);
        return result;
    }

    // 3. 将所有消息标记为已读
    @PostMapping("/readAll")
    public Map<String, Object> markAllAsRead() {
        Map<String, Object> result = new HashMap<>();
        Integer userId = UserContext.getUserId();

        UpdateWrapper<Notification> wrapper = new UpdateWrapper<>();
        wrapper.eq("receiver_id", userId).eq("is_read", 0).set("is_read", 1);
        notificationMapper.update(null, wrapper);

        result.put("code", 200);
        result.put("msg", "全部已读成功");
        return result;
    }
}