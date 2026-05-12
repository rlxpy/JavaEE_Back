package com.example.test1.utils;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;

import java.security.Key;
import java.util.Date;

public class JwtUtils {
    // 1. 签名密钥：这是服务器的“公章”，绝对不能泄漏！(要求必须大于 32 个字符)
    // 实际企业开发中，这个值会写在 application.properties 里，这里为了方便学习直接写死
    private static final String SECRET_KEY = "GameExchangePlatformSecretKeyVerySecure123";
    // 2. 将字符串密钥转换成 JWT 认可的加密 Key 对象
    private static final Key KEY = Keys.hmacShaKeyFor(SECRET_KEY.getBytes());
    // 3. 护照有效期：设置为 7 天 (单位是毫秒)
    private static final long EXPIRE_TIME = 60 * 60 * 1000 * 24 * 7;

    /**
     * 颁发护照：用户登录成功后，调用此方法生成 Token
     *
     * @param userId 用户的数据库主键 ID
     * @param role   用户角色 (0-普通, 1-管理员)
     * @return 经过加密的 Token 字符串
     */
    public static String generateToken(Integer userId,Integer role) {
        return Jwts.builder()
        // 1. 设置载荷 (Payload)：你要把什么信息存进 Token 里？
        // 注意：千万不要把密码存进去！Token 是可以被 Base64 解码看到的，只是不能被篡改。
                .claim("userId",userId)
                .claim("role",role)
        // 2. 签发时间：现在
                .setIssuedAt(new Date())
        // 3. 过期时间：现在 + 7天
                .setExpiration(new Date(System.currentTimeMillis() + EXPIRE_TIME))
        // 4. 盖章签名：使用 HS256 算法和我们的私钥盖章，防止别人伪造！
                .signWith(KEY, SignatureAlgorithm.HS256)
        // 5. 拼装生成最终的字符串
                .compact();
    }
    /**
     * 🔵 验证护照：当用户带 Token 访问接口时，解析 Token 拿出里面的信息
     *
     * @param token 前端传来的 Token 字符串
     * @return Claims (载荷)，里面包含了刚才存的 userId 和 role
     */
    public static Claims parseToken(String token) {
        // 如果 Token 过期、被篡改、格式不对，这里会自动抛出异常！
        return Jwts.parserBuilder()
                .setSigningKey(KEY)// 拿出我们的私钥去验证这个 Token 是不是我们发的
                .build()
                .parseClaimsJws(token)// 尝试解析
                .getBody();// 拿到里面的数据 (Claims)
    }
}
