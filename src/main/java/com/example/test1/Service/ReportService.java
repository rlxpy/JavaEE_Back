package com.example.test1.Service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.example.test1.entity.Report;

public interface ReportService {
    // 原有的玩家提交举报接口
    void submitReport(Report report);

    // 👑 1. 管理员：获取全站举报列表 (带分页、状态筛选、内容预览)
    IPage<Report> getAdminReportList(int page, int size, Integer status);

    // 👑 2. 管理员：执行终极审判 (action: 1=违规删除并警告, 2=驳回举报)
    void processReport(Integer reportId, Integer action, String customMessage);
}