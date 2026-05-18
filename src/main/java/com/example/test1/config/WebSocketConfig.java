package com.example.test1.config;

import com.example.test1.utils.JwtUtils;
import com.example.test1.ws.WebSocketServer;
import io.jsonwebtoken.Claims;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.server.HandshakeInterceptor;

import java.util.Map;

@Configuration
@EnableWebSocket // ⭐️ 开启 WebSocket 魔法
public class WebSocketConfig implements WebSocketConfigurer {

    @Autowired
    private WebSocketServer webSocketServer;

    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
        registry.addHandler(webSocketServer, "/ws") // 客户端连接地址：ws://localhost:8080/ws
                .setAllowedOrigins("*") // 允许 Vue 前端跨域连接
                .addInterceptors(new HandshakeInterceptor() {

                    // ⭐️ 握手前的安检程序
                    @Override
                    public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler, Map<String, Object> attributes) {
                        if (request instanceof ServletServerHttpRequest) {
                            ServletServerHttpRequest servletRequest = (ServletServerHttpRequest) request;
                            // 1. 从 URL 参数中提取 token (例如 /ws?token=xxxx)
                            String token = servletRequest.getServletRequest().getParameter("token");
                            if (token != null) {
                                try {
                                    // 2. 调用你之前写好的 JwtUtils 验明正身
                                    Claims claims = JwtUtils.parseToken(token);
                                    Integer userId = claims.get("userId", Integer.class);

                                    // 3. 把 userId 盖章存入 attributes，供 WebSocketServer 使用
                                    attributes.put("userId", userId);
                                    return true; // 身份合法，放行开门！
                                } catch (Exception e) {
                                    System.out.println("⚠️ [WebSocket] 发现黑客伪造 Token，直接踢飞！");
                                    return false; // Token 过期或伪造，拒绝连接
                                }
                            }
                        }
                        return false; // 没带 Token，直接拒绝
                    }

                    @Override
                    public void afterHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler, Exception exception) {}
                });
    }
}