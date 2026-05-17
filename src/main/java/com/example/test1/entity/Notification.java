package com.example.test1.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import java.util.Date;

@Data
@TableName("notification")
public class Notification {
    @TableId(type = IdType.AUTO)
    private Integer id;

    private Integer receiverId;
    private Integer senderId;

    private Integer type; // 1:点赞 2:收藏 3:评论/回复 4:系统通知
    private String referenceType; // post, comment, game
    private Integer referenceId;
    private String content;

    private Integer isRead; // 0 未读, 1 已读
    private Date createTime;

    // ⭐️ 非数据库字段：前端展示需要知道是谁发的消息
    @TableField(exist = false)
    private String senderNickname;

    @TableField(exist = false)
    private String senderAvatar;
}