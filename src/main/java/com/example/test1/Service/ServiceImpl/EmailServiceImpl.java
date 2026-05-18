package com.example.test1.Service.ServiceImpl;

import com.example.test1.Service.EmailService;
import jakarta.mail.internet.MimeMessage; // 注意：如果你用的是 Spring Boot 2.x，这里应该是 javax.mail.internet.MimeMessage
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

@Service
public class EmailServiceImpl implements EmailService {

    @Autowired
    private JavaMailSender mailSender;

    @Value("${spring.mail.username}")
    private String from;

    @Async
    @Override
    public void sendAuthCodeEmail(String email, String code) {
        try {
            // ⭐️ 升级：使用 MimeMessage 支持复杂的 HTML 富文本
            MimeMessage mimeMessage = mailSender.createMimeMessage();
            // true 表示需要创建一个 multipart message（支持 HTML）
            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");

            helper.setFrom(from + "(GASP 官方团队)"); // 设置发件人高逼格昵称
            helper.setTo(email);
            helper.setSubject("[GASP] 账号安全验证指令");

            // 🎨 纯手工打造的大厂级 HTML 邮件模板
            String htmlContent =
                    "<div style=\"background-color: #f4f6fc; padding: 40px 20px; font-family: 'PingFang SC', 'Microsoft YaHei', sans-serif;\">" +
                            "<div style=\"max-width: 600px; margin: 0 auto; background-color: #ffffff; border-radius: 16px; padding: 40px; box-shadow: 0 4px 20px rgba(0,0,0,0.05);\">" +
                            "<h2 style=\"color: #3f51b5; margin-top: 0; letter-spacing: 1px;\">[ GASP ] 账号安全指令</h2>" +
                            "<p style=\"color: #5c6b77; font-size: 16px; line-height: 1.6;\">尊敬的旅行者：</p>" +
                            "<p style=\"color: #5c6b77; font-size: 16px; line-height: 1.6;\">您正在执行安全级别较高的操作。您的动态安全验证码为：</p>" +

                            // 验证码高光展示区
                            "<div style=\"background-color: #f0fdf4; border: 1px solid #bbf7d0; border-radius: 12px; padding: 20px; text-align: center; margin: 30px 0;\">" +
                            "<span style=\"font-size: 38px; font-weight: 900; color: #166534; letter-spacing: 12px;\">" + code + "</span>" +
                            "</div>" +

                            "<p style=\"color: #8a9bb1; font-size: 14px;\">此验证码将在 <strong>5 分钟</strong> 后失效。请回到网页中填入此码完成验证。</p>" +
                            "<hr style=\"border: none; border-top: 1px dashed #eef2f6; margin: 30px 0;\">" +

                            // 安全警告区
                            "<p style=\"color: #f56c6c; font-size: 13px; margin: 0; line-height: 1.6;\">" +
                            "⚠️ <strong>安全警告：</strong>验证码代表您的身份凭证。GASP 官方团队永远不会向您索要此验证码。如果这不是您本人的操作，说明您的邮箱存在泄露风险，请立刻忽略并删除此邮件！" +
                            "</p>" +

                            // 底部落款
                            "<p style=\"color: #a0aec0; font-size: 12px; margin-top: 25px; text-align: center;\">" +
                            "GASP (Game And Sharing Platform) 自动化系统发信，请勿直接回复。" +
                            "</p>" +
                            "</div>" +
                            "</div>";

            // true 代表这段文本是 HTML 格式
            helper.setText(htmlContent, true);

            // 发送邮件
            mailSender.send(mimeMessage);
            System.out.println("✅ [GASP] HTML 邮件已极速后台发送至: " + email);

        } catch (Exception e) {
            System.err.println("❌ 邮件后台发送失败: " + e.getMessage());
        }
    }
}