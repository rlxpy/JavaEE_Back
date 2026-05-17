package com.example.test1.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import java.util.List;
import java.util.Map;

@Mapper
public interface StatMapper {
    // 统计总数
    @Select("SELECT COUNT(*) FROM user")
    int countTotalUsers();

    @Select("SELECT COUNT(*) FROM games")
    int countTotalGames();

    @Select("SELECT COUNT(*) FROM post")
    int countTotalPosts();

    // 统计用户角色分布 (返回 List<Map> 供饼图使用)
    @Select("SELECT role, COUNT(*) as count FROM user GROUP BY role")
    List<Map<String, Object>> countUsersByRole();

    // 统计游戏状态分布 (供柱状图使用)
    @Select("SELECT status, COUNT(*) as count FROM games GROUP BY status")
    List<Map<String, Object>> countGamesByStatus();
}