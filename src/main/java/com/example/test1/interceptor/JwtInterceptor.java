package com.example.test1.interceptor;

import com.example.test1.utils.JwtUtils;
import com.example.test1.utils.UserContext;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

/**
 * ⭐️ 全局 JWT 拦截器 (海关安检门)
 */
@Component
public class JwtInterceptor implements HandlerInterceptor {
    /**
     * 1. 在请求到达 Controller 之前执行
     * 返回 true 表示放行，返回 false 表示拦截（打回前端）
     */
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // ⭐️ 解决跨域坑：浏览器发起 POST/DELETE 前，会先发一个 OPTIONS 预检请求。直接放行它！
        if("OPTIONS".equalsIgnoreCase(request.getMethod())){
            return true;
        }

        // 1. 从 HTTP 头部拿出 Token (前端通常放在名为 Authorization 或 token 的请求头里)
        String token = request.getHeader("token");
        String requestURI = request.getRequestURI();

        boolean isHybridApi = requestURI.contains("/post/page");

        // 2. 如果没带 Token，直接拦截！
        if(token == null || token.isEmpty()){
            if (isHybridApi) {
                return true;
            }
            response.setStatus(401);
            response.setContentType("application/json;charset=utf-8");
            response.getWriter().write("{\"code\":401, \"msg\":\"请先登录！\"}");
            return false;
        }
        try{
            // 3. 验证护照 (解析 Token)
            Claims claims = JwtUtils.parseToken(token);
            // 4. 解析成功！提取出存进去的 userId
            Integer userId = claims.get("userId", Integer.class);
            // 5. 将 userId 放入当前线程的私有储物柜！
            UserContext.setUserId(userId);
            //6. 安检通过，放行去 Controller！
            return true;
        }catch (Exception e){
            // 解析失败（比如 Token 过期了，或者被篡改了）
            if (isHybridApi) {
                return true;
            }
            response.setStatus(401);
            response.setContentType("application/json;charset=utf-8");
            response.getWriter().write("{\"code\":401, \"msg\":\"Token已过期或无效，请重新登录！\"}");
            return false;
        }
    }
    /**
     * 2. 在请求结束，返回给前端之后执行
     */
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        UserContext.remove();
    }
}
