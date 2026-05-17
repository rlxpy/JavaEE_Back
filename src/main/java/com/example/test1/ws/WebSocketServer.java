package com.example.test1.ws;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.io.IOException;
import java.util.concurrent.ConcurrentHashMap;

@Component
public class WebSocketServer extends TextWebSocketHandler {

    // ⭐️ 核心魔法：存储所有在线用户的连接管道 (ConcurrentHashMap 保证线程安全)
    // Key 是 userId，Value 是他的专属连接 Session
    private static final ConcurrentHashMap<Integer, WebSocketSession> ONLINE_USERS = new ConcurrentHashMap<>();

    // 用户连接成功时触发
    @Override
    public void afterConnectionEstablished(WebSocketSession session) {
        // 这里的 userId 是从下面的拦截器里传过来的
        Integer userId = (Integer) session.getAttributes().get("userId");
        if (userId != null) {
            ONLINE_USERS.put(userId, session);
            System.out.println("🔗 [WebSocket] 用户 " + userId + " 已上线！当前全站在线人数：" + ONLINE_USERS.size());
        }
    }

    // 用户断开连接时触发
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) {
        Integer userId = (Integer) session.getAttributes().get("userId");
        if (userId != null) {
            ONLINE_USERS.remove(userId);
            System.out.println("❌ [WebSocket] 用户 " + userId + " 已离线！");
        }
    }

    // ⭐️ 极其重要的公共接口：供我们业务层调用，给指定玩家推送消息！
    public static void sendToUser(Integer userId, String message) {
        WebSocketSession session = ONLINE_USERS.get(userId);
        // 判断目标玩家是否在线
        if (session != null && session.isOpen()) {
            try {
                // 如果在线，瞬间顺着网线推过去！
                session.sendMessage(new TextMessage(message));
            } catch (IOException e) {
                System.err.println("推送消息给用户 " + userId + " 失败：" + e.getMessage());
            }
        }
        // 如果玩家不在线（session == null），就什么都不做，反正数据库里存了未读消息，他下次登录能看到。
    }
}