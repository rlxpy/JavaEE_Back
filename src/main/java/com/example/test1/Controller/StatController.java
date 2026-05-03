package com.example.test1.Controller;

import com.example.test1.mapper.StatMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/stat")
@CrossOrigin
public class StatController {

    @Autowired
    private StatMapper statMapper;

    // 👑 管理员获取大屏统计数据
    @GetMapping("/dashboard")
    public Map<String, Object> getDashboardStats() {
        Map<String, Object> result = new HashMap<>();
        try {
            // 组装所有统计数据
            Map<String, Object> data = new HashMap<>();
            data.put("totalUsers", statMapper.countTotalUsers());
            data.put("totalGames", statMapper.countTotalGames());
            data.put("totalPosts", statMapper.countTotalPosts());
            data.put("roleDist", statMapper.countUsersByRole());
            data.put("gameStatusDist", statMapper.countGamesByStatus());

            result.put("code", 200);
            result.put("data", data);
        } catch (Exception e) {
            result.put("code", 500);
            result.put("msg", "获取统计数据失败");
        }
        return result;
    }
}