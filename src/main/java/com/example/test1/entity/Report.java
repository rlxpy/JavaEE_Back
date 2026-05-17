package com.example.test1.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@TableName("report")
public class Report {

    @TableId(type = IdType.AUTO)
    private Integer id;

    // 发起举报的用户 ID
    private Integer reporterId;

    // 举报类型：'game', 'post', 'comment'
    private String targetType;

    // 被举报内容的 ID
    private Integer targetId;

    // 举报原因
    private String reason;

    // 处理状态：0=待处理, 1=已处理, 2=已驳回
    private Integer status;

    // 举报时间
    private Date createTime;

    // ==========================================
    // ⭐️ 下面这些是给后台管理员看数据时预留的连表字段 (数据库里没有这些列)
    // ==========================================

    @TableField(exist = false)
    private String reporterNickname; // 举报人的昵称

    @TableField(exist = false)
    private String targetPreview; // 被举报内容的预览（比如帖子的标题、评论的内容）
}