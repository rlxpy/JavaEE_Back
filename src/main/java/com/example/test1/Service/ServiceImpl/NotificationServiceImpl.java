package com.example.test1.Service.ServiceImpl;

import com.example.test1.entity.Notification;
import com.example.test1.mapper.NotificationMapper;
import com.example.test1.Service.NotificationService;
import com.example.test1.ws.WebSocketServer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class NotificationServiceImpl implements NotificationService {

    @Autowired
    private NotificationMapper notificationMapper;


    @Override
    @Transactional(rollbackFor = Exception.class)
    public void sendNotification(Notification notification) {
        // 如果是自己给自己点赞/评论，就不发通知了
        if (notification.getSenderId().equals(notification.getReceiverId())) {
            return;
        }

        // 1. 永不丢失：将消息持久化保存到 MySQL 数据库
        notificationMapper.insert(notification);

        // 2. 毫秒级触达：通知 WebSocket 服务器向该目标用户发起弹窗攻击（如果他在线的话）
        // 这里为了极致轻量化，我们只给前端推送一个 "NEW_MSG" 的信号，让前端知道右上角该亮红点了！
        WebSocketServer.sendToUser(notification.getReceiverId(), "NEW_MSG");
    }
}