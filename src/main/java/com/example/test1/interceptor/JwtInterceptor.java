package com.example.test1.interceptor;

import com.example.test1.entity.User;
import com.example.test1.mapper.UserMapper;
import com.example.test1.utils.JwtUtils;
import com.example.test1.utils.UserContext;
import io.jsonwebtoken.Claims;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class JwtInterceptor implements HandlerInterceptor {

    @Autowired
    private UserMapper userMapper; // ⭐️ 注入 Mapper 用于实时查询状态

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        if("OPTIONS".equalsIgnoreCase(request.getMethod())){
            return true;
        }

        String token = request.getHeader("token");
        String requestURI = request.getRequestURI();
        boolean isHybridApi = requestURI.contains("/post/page") || requestURI.contains("/game/page"); // 放行公共分页接口

        if(token == null || token.isEmpty()){
            if (isHybridApi) return true;
            response.setStatus(401);
            response.setContentType("application/json;charset=utf-8");
            response.getWriter().write("{\"code\":401, \"msg\":\"请先登录！\"}");
            return false;
        }

        try{
            Claims claims = JwtUtils.parseToken(token);
            Integer userId = claims.get("userId", Integer.class);

            // ⭐️ 第二道防线：实时拦截器封杀在线违规者
            User user = userMapper.selectById(userId);
            if (user != null && user.getStatus() != null && user.getStatus() == 1) {
                response.setStatus(401); // 返回 401，前端会直接跳回登录页
                response.setContentType("application/json;charset=utf-8");
                response.getWriter().write("{\"code\":401, \"msg\":\"您的账号已被永久封停，强制下线！\"}");
                return false;
            }

            UserContext.setUserId(userId);
            return true;
        }catch (Exception e){
            if (isHybridApi) return true;
            response.setStatus(401);
            response.setContentType("application/json;charset=utf-8");
            response.getWriter().write("{\"code\":401, \"msg\":\"Token已过期或无效，请重新登录！\"}");
            return false;
        }
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        UserContext.remove();
    }
}