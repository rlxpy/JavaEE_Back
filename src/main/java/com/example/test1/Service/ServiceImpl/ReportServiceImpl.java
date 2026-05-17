package com.example.test1.Service.ServiceImpl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.test1.entity.*;
import com.example.test1.mapper.*;
import com.example.test1.Service.ReportService;
import com.example.test1.Service.NotificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
public class ReportServiceImpl implements ReportService {

    @Autowired
    private ReportMapper reportMapper;
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private PostMapper postMapper;
    @Autowired
    private CommentMapper commentMapper;
    @Autowired
    private GameMapper gameMapper;
    @Autowired
    private NotificationService notificationService; // ⭐️ 复用我们的消息神器！

    @Override
    public void submitReport(Report report) {
        if (report.getStatus() == null) report.setStatus(0);
        report.setCreateTime(new Date());
        reportMapper.insert(report);
    }

    // 👑 1. 获取带有“上帝视角预览”的举报列表
    @Override
    public IPage<Report> getAdminReportList(int page, int size, Integer status) {
        Page<Report> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<Report> wrapper = new LambdaQueryWrapper<>();

        // 如果传了状态(0,1,2)，就按状态查，否则查全部
        if (status != null) {
            wrapper.eq(Report::getStatus, status);
        }
        wrapper.orderByDesc(Report::getCreateTime);

        IPage<Report> reportPage = reportMapper.selectPage(pageParam, wrapper);
        List<Report> records = reportPage.getRecords();

        // ⭐️ 核心魔法：拼装举报人的昵称和被举报的原文预览！
        for (Report r : records) {
            // 1. 查举报人昵称
            User reporter = userMapper.selectById(r.getReporterId());
            if (reporter != null) r.setReporterNickname(reporter.getNickname());

            // 2. 查案发现场（多态查询）
            if ("comment".equals(r.getTargetType())) {
                Comment c = commentMapper.selectById(r.getTargetId());
                r.setTargetPreview(c != null ? c.getContent() : "【🚫原评论已消失】");
            } else if ("post".equals(r.getTargetType())) {
                Post p = postMapper.selectById(r.getTargetId());
                r.setTargetPreview(p != null ? "《" + p.getTitle() + "》" : "【🚫原帖子已消失】");
            } else if ("game".equals(r.getTargetType())) {
                Game g = gameMapper.selectById(r.getTargetId());
                r.setTargetPreview(g != null ? "游戏：" + g.getGameName() : "【🚫游戏已下架】");
            }
        }
        return reportPage;
    }

    // 👑 2. 终极审判（带事务，确保删内容和发警告同时成功）
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void processReport(Integer reportId, Integer action, String customMessage) {
        Report report = reportMapper.selectById(reportId);
        if (report == null) throw new RuntimeException("举报记录不存在");

        // 1. 更新案卷状态
        report.setStatus(action);
        reportMapper.updateById(report);

        // 2. 如果是驳回，直接结束
        if (action == 2) return;

        // 3. 封杀逻辑...
        if (action == 1) {
            Integer targetOwnerId = null;
            String targetTypeName = "";

            if ("comment".equals(report.getTargetType())) {
                Comment c = commentMapper.selectById(report.getTargetId());
                if (c != null) {
                    targetOwnerId = c.getUserId();
                    targetTypeName = "评论";
                    Comment tombstone = new Comment();
                    tombstone.setId(c.getId());
                    tombstone.setContent("🚫 该评论因违规已被管理员彻底清除");
                    commentMapper.updateById(tombstone);
                }
            } else if ("post".equals(report.getTargetType())) {
                Post p = postMapper.selectById(report.getTargetId());
                if (p != null) {
                    targetOwnerId = p.getUserId();
                    targetTypeName = "帖子";
                    postMapper.deleteById(p.getId());
                }
            } else if ("game".equals(report.getTargetType())) {
                Game g = gameMapper.selectById(report.getTargetId());
                if (g != null) {
                    targetOwnerId = g.getDeveloperId();
                    targetTypeName = "游戏";
                    gameMapper.deleteById(g.getId());
                }
            }

            // ⭐️ 核心闭环：使用前端传来的自定义警告语！
            if (targetOwnerId != null) {
                Notification notif = new Notification();
                notif.setSenderId(0); // 0 代表系统管家
                notif.setReceiverId(targetOwnerId);
                notif.setType(4);

                // 如果前端传了自定义话术就用前端的，没传就用兜底的
                if (customMessage != null && !customMessage.trim().isEmpty()) {
                    notif.setContent(customMessage);
                } else {
                    notif.setContent("【系统通知】您的" + targetTypeName + "因严重违规已被彻底清除。请严格遵守社区规范！");
                }

                notificationService.sendNotification(notif);
            }
        }
    }
}