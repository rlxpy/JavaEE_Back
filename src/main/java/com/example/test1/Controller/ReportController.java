package com.example.test1.Controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.example.test1.entity.Report;
import com.example.test1.Service.ReportService;
import com.example.test1.utils.UserContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/report")
@CrossOrigin // 别忘了允许跨域
public class ReportController {

    @Autowired
    private ReportService reportService;

    // 🚩 玩家端：提交举报
    @PostMapping("/submit")
    public Map<String, Object> submitReport(@RequestBody Report report) {
        Map<String, Object> result = new HashMap<>();

        // 🛡️ 核心防线：从拦截器的 ThreadLocal 中获取真正的用户 ID
        Integer currentUserId = UserContext.getUserId();

        if (currentUserId == null) {
            result.put("code", 401);
            result.put("msg", "请先登录后再进行举报哦");
            return result;
        }

        try {
            // 强制覆盖举报人 ID，防止越权伪造
            report.setReporterId(currentUserId);

            // 呼叫 Service 干活
            reportService.submitReport(report);

            result.put("code", 200);
            result.put("msg", "举报提交成功，小管家将尽快核实！");
        } catch (Exception e) {
            result.put("code", 500);
            result.put("msg", "服务器异常，提交失败");
        }
        return result;
    }
    // 👑 管理员：分页查询全站举报列表
    @GetMapping("/admin/list")
    public Map<String, Object> getAdminReportList(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) Integer status) {

        Map<String, Object> result = new HashMap<>();
        // 这里可以加一行管理员越权校验逻辑（如判断 currentUser.getRole() == 'admin'）

        IPage<Report> pageInfo = reportService.getAdminReportList(page, size, status);

        // 包装成前端认识的分页格式
        Map<String, Object> pageData = new HashMap<>();
        pageData.put("total", pageInfo.getTotal());
        pageData.put("list", pageInfo.getRecords());

        result.put("code", 200);
        result.put("data", pageData);
        return result;
    }

    // 👑 管理员：处理举报 (action: 1=确认违规并清理, 2=驳回)
    @PostMapping("/admin/process")
    public Map<String, Object> processReport(
            @RequestParam Integer reportId,
            @RequestParam Integer action,
            @RequestParam(required = false) String customMessage) { // ⭐️ 加上这个非必传参数
        Map<String, Object> result = new HashMap<>();
        try {
            reportService.processReport(reportId, action, customMessage);
            result.put("code", 200);
            result.put("msg", action == 1 ? "制裁成功，已清理内容并发送系统警告信！" : "已驳回该举报！");
        } catch (Exception e) {
            result.put("code", 500);
            result.put("msg", "处理失败：" + e.getMessage());
        }
        return result;
    }
}