/*
Navicat MySQL Data Transfer

Source Server         : 1
Source Server Version : 80028
Source Host           : localhost:3306
Source Database       : javaee

Target Server Type    : MYSQL
Target Server Version : 80028
File Encoding         : 65001

Date: 2026-05-18 11:28:24
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `categories`
-- ----------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '分类主键ID',
  `name` varchar(50) NOT NULL COMMENT '分类名称，如：动作、RPG、射击',
  `description` varchar(255) DEFAULT NULL COMMENT '分类描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='游戏分类表';

-- ----------------------------
-- Records of categories
-- ----------------------------
INSERT INTO `categories` VALUES ('1', '攻略心得', '通关秘籍、职业加点、隐藏成就全在这里');
INSERT INTO `categories` VALUES ('2', '吐槽闲聊', '游戏内外的八卦、开箱日常、吐槽吹水');
INSERT INTO `categories` VALUES ('3', '求助问答', '卡关了？报错了？买哪个好？大佬来帮你解答');
INSERT INTO `categories` VALUES ('4', '寻求组队', '找CP、找代练、找公会开荒，绝不孤单');
INSERT INTO `categories` VALUES ('5', '官方资讯', '游戏更新公告、版本前瞻、赛事报道');

-- ----------------------------
-- Table structure for `comment`
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '评论主键ID',
  `user_id` int NOT NULL COMMENT '评论人ID，关联users表',
  `game_id` int DEFAULT NULL COMMENT '评论的游戏ID（在游戏页面评论则有值）',
  `post_id` int DEFAULT NULL COMMENT '评论的帖子ID（在帖子里回复则有值）',
  `parent_id` int DEFAULT NULL COMMENT '父级评论ID（标明这条评论是回复谁的。如果不为空，说明它是一个楼中楼的子回复）',
  `reply_to_nickname` varchar(50) DEFAULT NULL COMMENT '被回复人的昵称（冗余字段，比如：回复 @张三，这里存的就是张三，方便前端直接展示）',
  `content` text NOT NULL COMMENT '评论正文内容',
  `image_urls` varchar(2000) DEFAULT NULL COMMENT '评论配图，最多9张，用逗号分隔',
  `like_count` int DEFAULT '0' COMMENT '点赞数',
  `rating` tinyint DEFAULT NULL COMMENT '⭐新增：打分(1-5分，仅当评论游戏时有值)',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '评论时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='评论与打分表';

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES ('1', '1', '1', null, null, null, '这个游戏太震撼了，画质无敌，强推！', null, '0', '5', '2026-05-02 12:26:14');
INSERT INTO `comment` VALUES ('2', '3', '1', null, null, null, '一般般吧兄弟', null, '0', '1', '2026-05-02 12:47:25');
INSERT INTO `comment` VALUES ('3', '1', '1', null, null, null, '差评', null, '0', '1', '2026-05-02 12:50:42');
INSERT INTO `comment` VALUES ('4', '3', '1', null, null, null, '好玩啊', null, '0', '5', '2026-05-02 12:54:21');
INSERT INTO `comment` VALUES ('5', '3', '1', null, null, null, '好玩', null, '0', '5', '2026-05-02 13:00:21');
INSERT INTO `comment` VALUES ('6', '3', '1', null, null, null, '好玩！！！', null, '0', '5', '2026-05-02 18:10:00');
INSERT INTO `comment` VALUES ('7', '3', '1', null, null, null, '确实不错', null, '0', '5', '2026-05-02 18:14:03');
INSERT INTO `comment` VALUES ('9', '5', '4', null, null, null, '我觉得还可以吧', null, '0', '5', '2026-05-03 09:45:46');
INSERT INTO `comment` VALUES ('10', '5', null, '3', null, null, 'nb\n', null, '0', '0', '2026-05-03 11:31:12');
INSERT INTO `comment` VALUES ('11', '5', null, '3', null, null, '去11', null, '0', '0', '2026-05-03 11:31:44');
INSERT INTO `comment` VALUES ('12', '1', '1', null, null, null, '111', null, '0', '1', '2026-05-15 09:59:54');
INSERT INTO `comment` VALUES ('13', '213', null, '57', null, null, 'nb\n', null, '2', '0', '2026-05-15 10:08:04');
INSERT INTO `comment` VALUES ('14', '213', null, '57', null, null, '那我来测试一下', 'http://localhost:8080/uploads/6708d8b7-2e02-40d1-ac31-fcf29b2d3fb3.png,http://localhost:8080/uploads/9cb9adc8-c5d2-420c-88c5-afd54410ce44.png,http://localhost:8080/uploads/d6b8e679-ffe6-4e7c-87d5-7137a0de4d4c.png,http://localhost:8080/uploads/87a19d9b-5a6b-4f33-b392-8cf3905aed83.png,http://localhost:8080/uploads/0437b1ad-6bc5-44b1-9e83-09374fb6654c.png,http://localhost:8080/uploads/957c1626-2d72-4471-a386-97914e40ad78.png,http://localhost:8080/uploads/dc903ea5-eb82-4b2f-9d36-4a4aded960a1.png,http://localhost:8080/uploads/fc8b653c-1a10-4371-b7fe-6e581ce2d678.png,http://localhost:8080/uploads/90080992-649e-4383-af0e-192957186745.png', '2', '0', '2026-05-15 10:14:50');
INSERT INTO `comment` VALUES ('15', '213', null, '57', '14', 'SuperAdmin', '有点牛啊\n', '', '0', '0', '2026-05-15 10:24:03');
INSERT INTO `comment` VALUES ('16', '214', null, '57', '14', 'SuperAdmin', '这么强？\n', '', '0', '0', '2026-05-15 10:25:40');
INSERT INTO `comment` VALUES ('17', '214', null, '57', '14', '测试者999', '确实很强', '', '0', '0', '2026-05-15 10:25:52');
INSERT INTO `comment` VALUES ('18', '213', null, '57', '14', '测试者999', '谢谢\n', '', '0', '0', '2026-05-15 11:14:56');
INSERT INTO `comment` VALUES ('19', '214', null, '57', null, null, '你好老师', '', '2', '0', '2026-05-15 11:19:53');
INSERT INTO `comment` VALUES ('20', '214', null, '57', null, null, '你好', '', '1', '0', '2026-05-15 11:20:13');
INSERT INTO `comment` VALUES ('21', '213', null, '57', '19', '测试者999', '嗯嗯，你好', '', '0', '0', '2026-05-15 11:21:04');
INSERT INTO `comment` VALUES ('22', '214', null, '57', '19', 'SuperAdmin', '哇，被回复了！', '', '0', '0', '2026-05-15 11:21:49');
INSERT INTO `comment` VALUES ('25', '216', '107', null, '23', 'SuperAdmin', '你好你好\n', null, '0', '0', '2026-05-15 12:03:56');
INSERT INTO `comment` VALUES ('26', '216', '107', null, '23', 'test11', '111', null, '0', '0', '2026-05-15 12:04:04');
INSERT INTO `comment` VALUES ('29', '216', '107', null, '28', 'test11', '111', null, '1', '0', '2026-05-15 12:11:54');
INSERT INTO `comment` VALUES ('30', '213', '107', null, null, null, '? 该评论已被作者删除', null, '2', '5', '2026-05-15 12:12:28');
INSERT INTO `comment` VALUES ('32', '213', null, '8', null, null, '111', '', '1', '0', '2026-05-17 10:18:03');
INSERT INTO `comment` VALUES ('33', '213', null, '10', null, null, '111\n', '', '1', '0', '2026-05-17 10:22:04');
INSERT INTO `comment` VALUES ('34', '213', null, '10', null, null, '111', '', '1', '0', '2026-05-17 10:30:08');
INSERT INTO `comment` VALUES ('35', '213', '107', null, '28', 'test11', '11', null, '0', '0', '2026-05-17 10:44:42');
INSERT INTO `comment` VALUES ('37', '216', '107', null, '30', 'SuperAdmin', 'nb\n', null, '1', '0', '2026-05-17 10:58:32');
INSERT INTO `comment` VALUES ('38', '213', '107', null, '30', 'test11', 'hh\n', null, '1', '0', '2026-05-17 11:05:41');
INSERT INTO `comment` VALUES ('39', '213', '107', null, '30', 'SuperAdmin', '1', null, '0', '0', '2026-05-17 11:11:08');
INSERT INTO `comment` VALUES ('40', '213', '107', null, '30', 'SuperAdmin', '1', null, '0', '0', '2026-05-17 11:11:20');
INSERT INTO `comment` VALUES ('41', '213', '107', null, '30', 'SuperAdmin', '1', null, '0', '0', '2026-05-17 11:11:24');
INSERT INTO `comment` VALUES ('42', '213', '107', null, '30', 'SuperAdmin', '1', null, '0', '0', '2026-05-17 11:11:28');
INSERT INTO `comment` VALUES ('43', '213', '107', null, '30', 'SuperAdmin', '1', null, '0', '0', '2026-05-17 11:11:33');
INSERT INTO `comment` VALUES ('44', '213', '107', null, '30', 'SuperAdmin', '1', null, '0', '0', '2026-05-17 11:11:38');
INSERT INTO `comment` VALUES ('45', '213', '107', null, '30', 'SuperAdmin', '666', null, '0', '0', '2026-05-17 11:14:27');
INSERT INTO `comment` VALUES ('46', '213', '107', null, '30', 'SuperAdmin', '我也要', null, '0', '0', '2026-05-17 11:14:45');

-- ----------------------------
-- Table structure for `comment_like`
-- ----------------------------
DROP TABLE IF EXISTS `comment_like`;
CREATE TABLE `comment_like` (
  `id` int NOT NULL AUTO_INCREMENT,
  `comment_id` int NOT NULL COMMENT '被点赞的评论ID',
  `user_id` int NOT NULL COMMENT '点赞人的ID',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '点赞时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_comment_user` (`comment_id`,`user_id`) COMMENT '防止同一个人对同一条评论重复点赞'
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of comment_like
-- ----------------------------
INSERT INTO `comment_like` VALUES ('1', '13', '213', '2026-05-15 10:08:30');
INSERT INTO `comment_like` VALUES ('2', '14', '213', '2026-05-15 10:15:00');
INSERT INTO `comment_like` VALUES ('3', '13', '214', '2026-05-15 10:27:00');
INSERT INTO `comment_like` VALUES ('4', '14', '214', '2026-05-15 10:27:00');
INSERT INTO `comment_like` VALUES ('5', '19', '214', '2026-05-15 11:20:00');
INSERT INTO `comment_like` VALUES ('6', '19', '213', '2026-05-15 11:21:00');
INSERT INTO `comment_like` VALUES ('7', '20', '213', '2026-05-15 11:21:00');
INSERT INTO `comment_like` VALUES ('8', '28', '213', '2026-05-17 10:15:30');
INSERT INTO `comment_like` VALUES ('9', '29', '213', '2026-05-17 10:16:00');
INSERT INTO `comment_like` VALUES ('10', '32', '213', '2026-05-17 10:18:30');
INSERT INTO `comment_like` VALUES ('11', '33', '213', '2026-05-17 10:22:30');
INSERT INTO `comment_like` VALUES ('12', '34', '213', '2026-05-17 10:30:30');
INSERT INTO `comment_like` VALUES ('13', '30', '216', '2026-05-17 10:58:30');
INSERT INTO `comment_like` VALUES ('14', '30', '213', '2026-05-17 10:59:30');
INSERT INTO `comment_like` VALUES ('15', '37', '213', '2026-05-17 11:06:00');
INSERT INTO `comment_like` VALUES ('16', '38', '213', '2026-05-17 11:06:00');

-- ----------------------------
-- Table structure for `favorites`
-- ----------------------------
DROP TABLE IF EXISTS `favorites`;
CREATE TABLE `favorites` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '收藏主键ID',
  `user_id` int NOT NULL COMMENT '收藏人ID，关联users表',
  `game_id` int NOT NULL COMMENT '收藏的游戏ID，关联games表',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '收藏时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='游戏收藏表';

-- ----------------------------
-- Records of favorites
-- ----------------------------
INSERT INTO `favorites` VALUES ('7', '5', '4', '2026-05-03 11:31:37');
INSERT INTO `favorites` VALUES ('8', '6', '4', '2026-05-06 10:06:30');
INSERT INTO `favorites` VALUES ('9', '207', '106', '2026-05-12 18:15:29');
INSERT INTO `favorites` VALUES ('10', '213', '106', '2026-05-14 19:43:11');
INSERT INTO `favorites` VALUES ('11', '216', '107', '2026-05-15 19:33:40');
INSERT INTO `favorites` VALUES ('12', '213', '107', '2026-05-15 19:35:19');

-- ----------------------------
-- Table structure for `games`
-- ----------------------------
DROP TABLE IF EXISTS `games`;
CREATE TABLE `games` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '游戏主键ID',
  `developer_id` int NOT NULL COMMENT '开发者ID，关联users表',
  `category_id` int DEFAULT NULL COMMENT '⭐新增：分类ID，关联categories表',
  `game_name` varchar(100) NOT NULL COMMENT '游戏名称',
  `description` text COMMENT '游戏简介',
  `cover_image` varchar(255) DEFAULT NULL COMMENT '封面图URL',
  `download_link` varchar(255) DEFAULT NULL COMMENT '下载链接',
  `average_rating` decimal(3,2) DEFAULT '0.00' COMMENT '⭐新增：游戏平均评分(如 4.50)',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '发布时间',
  `status` int DEFAULT '0' COMMENT '0-待审核 1-已上架 2-被驳回',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='游戏信息表';

-- ----------------------------
-- Records of games
-- ----------------------------
INSERT INTO `games` VALUES ('1', '1', '1', '黑神话：悟空', '一款以中国神话为背景的动作角色扮演游戏，重塑中国古典名著。', 'https://media.st.dl.bscdn.net/steam/apps/2415600/header.jpg', 'https://store.steampowered.com/', '3.50', '2026-05-02 11:58:24', '1');
INSERT INTO `games` VALUES ('2', '1', '2', '星露谷物语', '继承爷爷的农场，学会在这片土地上生活，把这些杂草丛生的田地变成繁荣的家园。', 'https://media.st.dl.bscdn.net/steam/apps/413150/header.jpg', 'https://store.steampowered.com/', '4.80', '2026-05-02 11:58:24', '1');
INSERT INTO `games` VALUES ('3', '2', '1', '双人成行', '踏上生命中最疯狂的旅程，一款别开生面的平台冒险游戏，完全为合作模式而生。', 'https://media.st.dl.bscdn.net/steam/apps/1426210/header.jpg', 'https://store.steampowered.com/', '4.90', '2026-05-02 11:58:24', '1');
INSERT INTO `games` VALUES ('4', '6', '1', '测试游戏1', '测试测试', 'http://localhost:8080/uploads/c5aaf1d7-65e1-4eca-8046-4d294cca6c1b.png', 'https://pan.baidu.com/s/1Uyib1tFZLoA9wTGz5KV02Q?pwd=rlx1 提取码: rlx1', '5.00', '2026-05-02 19:37:38', '1');
INSERT INTO `games` VALUES ('6', '7', null, '代号：史诗大作 V1', '这是一跨耗时多年研发的现象级游戏系列第 1 部，画质精美，玩法丰富，不容错过！', null, null, '4.47', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('7', '8', null, '代号：史诗大作 V2', '这是一跨耗时多年研发的现象级游戏系列第 2 部，画质精美，玩法丰富，不容错过！', null, null, '3.40', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('8', '9', null, '代号：史诗大作 V3', '这是一跨耗时多年研发的现象级游戏系列第 3 部，画质精美，玩法丰富，不容错过！', null, null, '4.58', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('9', '10', null, '代号：史诗大作 V4', '这是一跨耗时多年研发的现象级游戏系列第 4 部，画质精美，玩法丰富，不容错过！', null, null, '3.70', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('10', '11', null, '代号：史诗大作 V5', '这是一跨耗时多年研发的现象级游戏系列第 5 部，画质精美，玩法丰富，不容错过！', null, null, '3.76', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('11', '12', null, '代号：史诗大作 V6', '这是一跨耗时多年研发的现象级游戏系列第 6 部，画质精美，玩法丰富，不容错过！', null, null, '4.71', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('12', '13', null, '代号：史诗大作 V7', '这是一跨耗时多年研发的现象级游戏系列第 7 部，画质精美，玩法丰富，不容错过！', null, null, '3.24', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('13', '14', null, '代号：史诗大作 V8', '这是一跨耗时多年研发的现象级游戏系列第 8 部，画质精美，玩法丰富，不容错过！', null, null, '3.11', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('14', '15', null, '代号：史诗大作 V9', '这是一跨耗时多年研发的现象级游戏系列第 9 部，画质精美，玩法丰富，不容错过！', null, null, '4.80', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('18', '19', null, '代号：史诗大作 V13', '这是一跨耗时多年研发的现象级游戏系列第 13 部，画质精美，玩法丰富，不容错过！', null, null, '3.41', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('19', '20', null, '代号：史诗大作 V14', '这是一跨耗时多年研发的现象级游戏系列第 14 部，画质精美，玩法丰富，不容错过！', null, null, '4.13', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('20', '21', null, '代号：史诗大作 V15', '这是一跨耗时多年研发的现象级游戏系列第 15 部，画质精美，玩法丰富，不容错过！', null, null, '3.44', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('21', '22', null, '代号：史诗大作 V16', '这是一跨耗时多年研发的现象级游戏系列第 16 部，画质精美，玩法丰富，不容错过！', null, null, '3.79', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('22', '23', null, '代号：史诗大作 V17', '这是一跨耗时多年研发的现象级游戏系列第 17 部，画质精美，玩法丰富，不容错过！', null, null, '3.65', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('23', '24', null, '代号：史诗大作 V18', '这是一跨耗时多年研发的现象级游戏系列第 18 部，画质精美，玩法丰富，不容错过！', null, null, '3.87', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('24', '25', null, '代号：史诗大作 V19', '这是一跨耗时多年研发的现象级游戏系列第 19 部，画质精美，玩法丰富，不容错过！', null, null, '3.39', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('25', '26', null, '代号：史诗大作 V20', '这是一跨耗时多年研发的现象级游戏系列第 20 部，画质精美，玩法丰富，不容错过！', null, null, '4.37', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('26', '27', null, '代号：史诗大作 V21', '这是一跨耗时多年研发的现象级游戏系列第 21 部，画质精美，玩法丰富，不容错过！', null, null, '4.64', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('27', '28', null, '代号：史诗大作 V22', '这是一跨耗时多年研发的现象级游戏系列第 22 部，画质精美，玩法丰富，不容错过！', null, null, '3.12', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('28', '29', null, '代号：史诗大作 V23', '这是一跨耗时多年研发的现象级游戏系列第 23 部，画质精美，玩法丰富，不容错过！', null, null, '4.68', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('29', '30', null, '代号：史诗大作 V24', '这是一跨耗时多年研发的现象级游戏系列第 24 部，画质精美，玩法丰富，不容错过！', null, null, '3.02', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('30', '31', null, '代号：史诗大作 V25', '这是一跨耗时多年研发的现象级游戏系列第 25 部，画质精美，玩法丰富，不容错过！', null, null, '4.09', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('31', '32', null, '代号：史诗大作 V26', '这是一跨耗时多年研发的现象级游戏系列第 26 部，画质精美，玩法丰富，不容错过！', null, null, '4.37', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('32', '33', null, '代号：史诗大作 V27', '这是一跨耗时多年研发的现象级游戏系列第 27 部，画质精美，玩法丰富，不容错过！', null, null, '4.59', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('33', '34', null, '代号：史诗大作 V28', '这是一跨耗时多年研发的现象级游戏系列第 28 部，画质精美，玩法丰富，不容错过！', null, null, '4.83', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('34', '35', null, '代号：史诗大作 V29', '这是一跨耗时多年研发的现象级游戏系列第 29 部，画质精美，玩法丰富，不容错过！', null, null, '3.36', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('35', '36', null, '代号：史诗大作 V30', '这是一跨耗时多年研发的现象级游戏系列第 30 部，画质精美，玩法丰富，不容错过！', null, null, '3.34', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('36', '37', null, '代号：史诗大作 V31', '这是一跨耗时多年研发的现象级游戏系列第 31 部，画质精美，玩法丰富，不容错过！', null, null, '3.60', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('37', '38', null, '代号：史诗大作 V32', '这是一跨耗时多年研发的现象级游戏系列第 32 部，画质精美，玩法丰富，不容错过！', null, null, '4.99', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('38', '39', null, '代号：史诗大作 V33', '这是一跨耗时多年研发的现象级游戏系列第 33 部，画质精美，玩法丰富，不容错过！', null, null, '3.17', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('39', '40', null, '代号：史诗大作 V34', '这是一跨耗时多年研发的现象级游戏系列第 34 部，画质精美，玩法丰富，不容错过！', null, null, '3.86', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('40', '41', null, '代号：史诗大作 V35', '这是一跨耗时多年研发的现象级游戏系列第 35 部，画质精美，玩法丰富，不容错过！', null, null, '4.79', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('41', '42', null, '代号：史诗大作 V36', '这是一跨耗时多年研发的现象级游戏系列第 36 部，画质精美，玩法丰富，不容错过！', null, null, '3.37', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('42', '43', null, '代号：史诗大作 V37', '这是一跨耗时多年研发的现象级游戏系列第 37 部，画质精美，玩法丰富，不容错过！', null, null, '3.50', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('43', '44', null, '代号：史诗大作 V38', '这是一跨耗时多年研发的现象级游戏系列第 38 部，画质精美，玩法丰富，不容错过！', null, null, '4.37', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('44', '45', null, '代号：史诗大作 V39', '这是一跨耗时多年研发的现象级游戏系列第 39 部，画质精美，玩法丰富，不容错过！', null, null, '4.38', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('45', '46', null, '代号：史诗大作 V40', '这是一跨耗时多年研发的现象级游戏系列第 40 部，画质精美，玩法丰富，不容错过！', null, null, '3.76', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('46', '47', null, '代号：史诗大作 V41', '这是一跨耗时多年研发的现象级游戏系列第 41 部，画质精美，玩法丰富，不容错过！', null, null, '4.66', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('47', '48', null, '代号：史诗大作 V42', '这是一跨耗时多年研发的现象级游戏系列第 42 部，画质精美，玩法丰富，不容错过！', null, null, '3.01', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('48', '49', null, '代号：史诗大作 V43', '这是一跨耗时多年研发的现象级游戏系列第 43 部，画质精美，玩法丰富，不容错过！', null, null, '4.08', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('49', '50', null, '代号：史诗大作 V44', '这是一跨耗时多年研发的现象级游戏系列第 44 部，画质精美，玩法丰富，不容错过！', null, null, '4.39', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('50', '51', null, '代号：史诗大作 V45', '这是一跨耗时多年研发的现象级游戏系列第 45 部，画质精美，玩法丰富，不容错过！', null, null, '4.69', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('51', '52', null, '代号：史诗大作 V46', '这是一跨耗时多年研发的现象级游戏系列第 46 部，画质精美，玩法丰富，不容错过！', null, null, '3.28', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('52', '53', null, '代号：史诗大作 V47', '这是一跨耗时多年研发的现象级游戏系列第 47 部，画质精美，玩法丰富，不容错过！', null, null, '3.34', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('53', '54', null, '代号：史诗大作 V48', '这是一跨耗时多年研发的现象级游戏系列第 48 部，画质精美，玩法丰富，不容错过！', null, null, '3.85', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('54', '55', null, '代号：史诗大作 V49', '这是一跨耗时多年研发的现象级游戏系列第 49 部，画质精美，玩法丰富，不容错过！', null, null, '4.25', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('55', '56', null, '代号：史诗大作 V50', '这是一跨耗时多年研发的现象级游戏系列第 50 部，画质精美，玩法丰富，不容错过！', null, null, '4.68', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('56', '57', null, '代号：史诗大作 V51', '这是一跨耗时多年研发的现象级游戏系列第 51 部，画质精美，玩法丰富，不容错过！', null, null, '3.66', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('57', '58', null, '代号：史诗大作 V52', '这是一跨耗时多年研发的现象级游戏系列第 52 部，画质精美，玩法丰富，不容错过！', null, null, '3.25', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('58', '59', null, '代号：史诗大作 V53', '这是一跨耗时多年研发的现象级游戏系列第 53 部，画质精美，玩法丰富，不容错过！', null, null, '4.25', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('59', '60', null, '代号：史诗大作 V54', '这是一跨耗时多年研发的现象级游戏系列第 54 部，画质精美，玩法丰富，不容错过！', null, null, '4.54', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('60', '61', null, '代号：史诗大作 V55', '这是一跨耗时多年研发的现象级游戏系列第 55 部，画质精美，玩法丰富，不容错过！', null, null, '4.91', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('61', '62', null, '代号：史诗大作 V56', '这是一跨耗时多年研发的现象级游戏系列第 56 部，画质精美，玩法丰富，不容错过！', null, null, '3.96', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('62', '63', null, '代号：史诗大作 V57', '这是一跨耗时多年研发的现象级游戏系列第 57 部，画质精美，玩法丰富，不容错过！', null, null, '4.07', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('63', '64', null, '代号：史诗大作 V58', '这是一跨耗时多年研发的现象级游戏系列第 58 部，画质精美，玩法丰富，不容错过！', null, null, '3.46', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('64', '65', null, '代号：史诗大作 V59', '这是一跨耗时多年研发的现象级游戏系列第 59 部，画质精美，玩法丰富，不容错过！', null, null, '4.11', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('65', '66', null, '代号：史诗大作 V60', '这是一跨耗时多年研发的现象级游戏系列第 60 部，画质精美，玩法丰富，不容错过！', null, null, '3.17', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('66', '67', null, '代号：史诗大作 V61', '这是一跨耗时多年研发的现象级游戏系列第 61 部，画质精美，玩法丰富，不容错过！', null, null, '4.53', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('67', '68', null, '代号：史诗大作 V62', '这是一跨耗时多年研发的现象级游戏系列第 62 部，画质精美，玩法丰富，不容错过！', null, null, '4.11', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('68', '69', null, '代号：史诗大作 V63', '这是一跨耗时多年研发的现象级游戏系列第 63 部，画质精美，玩法丰富，不容错过！', null, null, '3.95', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('69', '70', null, '代号：史诗大作 V64', '这是一跨耗时多年研发的现象级游戏系列第 64 部，画质精美，玩法丰富，不容错过！', null, null, '4.45', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('70', '71', null, '代号：史诗大作 V65', '这是一跨耗时多年研发的现象级游戏系列第 65 部，画质精美，玩法丰富，不容错过！', null, null, '3.41', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('71', '72', null, '代号：史诗大作 V66', '这是一跨耗时多年研发的现象级游戏系列第 66 部，画质精美，玩法丰富，不容错过！', null, null, '4.67', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('72', '73', null, '代号：史诗大作 V67', '这是一跨耗时多年研发的现象级游戏系列第 67 部，画质精美，玩法丰富，不容错过！', null, null, '4.14', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('73', '74', null, '代号：史诗大作 V68', '这是一跨耗时多年研发的现象级游戏系列第 68 部，画质精美，玩法丰富，不容错过！', null, null, '3.67', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('74', '75', null, '代号：史诗大作 V69', '这是一跨耗时多年研发的现象级游戏系列第 69 部，画质精美，玩法丰富，不容错过！', null, null, '4.92', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('75', '76', null, '代号：史诗大作 V70', '这是一跨耗时多年研发的现象级游戏系列第 70 部，画质精美，玩法丰富，不容错过！', null, null, '4.60', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('76', '77', null, '代号：史诗大作 V71', '这是一跨耗时多年研发的现象级游戏系列第 71 部，画质精美，玩法丰富，不容错过！', null, null, '3.22', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('77', '78', null, '代号：史诗大作 V72', '这是一跨耗时多年研发的现象级游戏系列第 72 部，画质精美，玩法丰富，不容错过！', null, null, '3.33', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('78', '79', null, '代号：史诗大作 V73', '这是一跨耗时多年研发的现象级游戏系列第 73 部，画质精美，玩法丰富，不容错过！', null, null, '3.99', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('79', '80', null, '代号：史诗大作 V74', '这是一跨耗时多年研发的现象级游戏系列第 74 部，画质精美，玩法丰富，不容错过！', null, null, '4.95', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('80', '81', null, '代号：史诗大作 V75', '这是一跨耗时多年研发的现象级游戏系列第 75 部，画质精美，玩法丰富，不容错过！', null, null, '3.78', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('81', '82', null, '代号：史诗大作 V76', '这是一跨耗时多年研发的现象级游戏系列第 76 部，画质精美，玩法丰富，不容错过！', null, null, '3.07', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('82', '83', null, '代号：史诗大作 V77', '这是一跨耗时多年研发的现象级游戏系列第 77 部，画质精美，玩法丰富，不容错过！', null, null, '3.01', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('83', '84', null, '代号：史诗大作 V78', '这是一跨耗时多年研发的现象级游戏系列第 78 部，画质精美，玩法丰富，不容错过！', null, null, '4.81', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('84', '85', null, '代号：史诗大作 V79', '这是一跨耗时多年研发的现象级游戏系列第 79 部，画质精美，玩法丰富，不容错过！', null, null, '4.04', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('85', '86', null, '代号：史诗大作 V80', '这是一跨耗时多年研发的现象级游戏系列第 80 部，画质精美，玩法丰富，不容错过！', null, null, '4.75', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('86', '87', null, '代号：史诗大作 V81', '这是一跨耗时多年研发的现象级游戏系列第 81 部，画质精美，玩法丰富，不容错过！', null, null, '4.65', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('87', '88', null, '代号：史诗大作 V82', '这是一跨耗时多年研发的现象级游戏系列第 82 部，画质精美，玩法丰富，不容错过！', null, null, '4.02', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('88', '89', null, '代号：史诗大作 V83', '这是一跨耗时多年研发的现象级游戏系列第 83 部，画质精美，玩法丰富，不容错过！', null, null, '3.11', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('89', '90', null, '代号：史诗大作 V84', '这是一跨耗时多年研发的现象级游戏系列第 84 部，画质精美，玩法丰富，不容错过！', null, null, '4.51', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('90', '91', null, '代号：史诗大作 V85', '这是一跨耗时多年研发的现象级游戏系列第 85 部，画质精美，玩法丰富，不容错过！', null, null, '4.22', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('91', '92', null, '代号：史诗大作 V86', '这是一跨耗时多年研发的现象级游戏系列第 86 部，画质精美，玩法丰富，不容错过！', null, null, '4.56', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('92', '93', null, '代号：史诗大作 V87', '这是一跨耗时多年研发的现象级游戏系列第 87 部，画质精美，玩法丰富，不容错过！', null, null, '3.14', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('93', '94', null, '代号：史诗大作 V88', '这是一跨耗时多年研发的现象级游戏系列第 88 部，画质精美，玩法丰富，不容错过！', null, null, '3.01', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('94', '95', null, '代号：史诗大作 V89', '这是一跨耗时多年研发的现象级游戏系列第 89 部，画质精美，玩法丰富，不容错过！', null, null, '4.66', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('95', '96', null, '代号：史诗大作 V90', '这是一跨耗时多年研发的现象级游戏系列第 90 部，画质精美，玩法丰富，不容错过！', null, null, '3.24', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('96', '97', null, '代号：史诗大作 V91', '这是一跨耗时多年研发的现象级游戏系列第 91 部，画质精美，玩法丰富，不容错过！', null, null, '3.22', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('97', '98', null, '代号：史诗大作 V92', '这是一跨耗时多年研发的现象级游戏系列第 92 部，画质精美，玩法丰富，不容错过！', null, null, '3.37', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('98', '99', null, '代号：史诗大作 V93', '这是一跨耗时多年研发的现象级游戏系列第 93 部，画质精美，玩法丰富，不容错过！', null, null, '4.21', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('99', '100', null, '代号：史诗大作 V94', '这是一跨耗时多年研发的现象级游戏系列第 94 部，画质精美，玩法丰富，不容错过！', null, null, '3.93', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('100', '101', null, '代号：史诗大作 V95', '这是一跨耗时多年研发的现象级游戏系列第 95 部，画质精美，玩法丰富，不容错过！', null, null, '4.04', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('101', '102', null, '代号：史诗大作 V96', '这是一跨耗时多年研发的现象级游戏系列第 96 部，画质精美，玩法丰富，不容错过！', null, null, '3.41', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('102', '103', null, '代号：史诗大作 V97', '这是一跨耗时多年研发的现象级游戏系列第 97 部，画质精美，玩法丰富，不容错过！', null, null, '3.92', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('103', '104', null, '代号：史诗大作 V98', '这是一跨耗时多年研发的现象级游戏系列第 98 部，画质精美，玩法丰富，不容错过！', null, null, '4.36', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('104', '105', null, '代号：史诗大作 V99', '这是一跨耗时多年研发的现象级游戏系列第 99 部，画质精美，玩法丰富，不容错过！', null, null, '3.03', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('105', '106', null, '代号：史诗大作 V100', '这是一跨耗时多年研发的现象级游戏系列第 100 部，画质精美，玩法丰富，不容错过！', null, null, '3.10', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('106', '6', '1', '测试', '测试', 'http://localhost:8080/uploads/60a3fd32-0b27-4705-a6c1-c5693e6b865b.png', '111', '0.00', '2026-05-06 10:06:12', '1');
INSERT INTO `games` VALUES ('107', '216', '1', '消息测试', '消息测试', 'http://localhost:8080/uploads/7c006e0d-19a4-4ed7-924f-93ec15573ad1.png', '111', '5.00', '2026-05-15 11:36:41', '1');

-- ----------------------------
-- Table structure for `game_category`
-- ----------------------------
DROP TABLE IF EXISTS `game_category`;
CREATE TABLE `game_category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL COMMENT '分类名称',
  `description` varchar(255) DEFAULT NULL COMMENT '分类描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='游戏专属分类表';

-- ----------------------------
-- Records of game_category
-- ----------------------------
INSERT INTO `game_category` VALUES ('1', '角色扮演 (RPG)', '体验别样人生的剧情向游戏');
INSERT INTO `game_category` VALUES ('2', '动作射击 (ACT/FPS)', '考验操作与反应的硬核游戏');
INSERT INTO `game_category` VALUES ('3', '休闲模拟 (SIM)', '种田、建造、放松身心的游戏');
INSERT INTO `game_category` VALUES ('4', '策略战棋 (SLG)', '烧脑、排兵布阵的战术游戏');

-- ----------------------------
-- Table structure for `notification`
-- ----------------------------
DROP TABLE IF EXISTS `notification`;
CREATE TABLE `notification` (
  `id` int NOT NULL AUTO_INCREMENT,
  `receiver_id` int NOT NULL COMMENT '接收者ID (谁该亮红点)',
  `sender_id` int NOT NULL COMMENT '发送者ID (0代表系统管理员)',
  `type` int NOT NULL COMMENT '1:点赞 2:收藏 3:评论/回复 4:系统通知',
  `reference_type` varchar(50) DEFAULT NULL COMMENT '关联业务模块: post, comment, game',
  `reference_id` int DEFAULT NULL COMMENT '关联业务的具体ID (用于前端点击跳转)',
  `content` varchar(1000) DEFAULT NULL COMMENT '消息文本内容或评论摘要',
  `is_read` tinyint(1) DEFAULT '0' COMMENT '0:未读 1:已读',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '触发时间',
  PRIMARY KEY (`id`),
  KEY `idx_receiver` (`receiver_id`,`is_read`) COMMENT '提升查询未读消息的性能'
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of notification
-- ----------------------------
INSERT INTO `notification` VALUES ('1', '213', '214', '3', 'post', '57', '你好老师', '1', '2026-05-15 11:19:53');
INSERT INTO `notification` VALUES ('2', '213', '214', '3', 'post', '57', '你好', '1', '2026-05-15 11:20:13');
INSERT INTO `notification` VALUES ('3', '214', '213', '3', 'post', '57', '嗯嗯，你好', '1', '2026-05-15 11:21:04');
INSERT INTO `notification` VALUES ('4', '213', '216', '3', 'game', '107', '你好你好\n', '1', '2026-05-15 12:03:56');
INSERT INTO `notification` VALUES ('5', '213', '216', '3', 'game', '107', '111', '1', '2026-05-15 12:04:04');
INSERT INTO `notification` VALUES ('6', '216', '213', '3', 'game', '107', '好玩', '1', '2026-05-15 12:12:28');
INSERT INTO `notification` VALUES ('7', '213', '216', '1', 'post', '57', '赞了你的帖子', '1', '2026-05-15 19:27:29');
INSERT INTO `notification` VALUES ('8', '213', '216', '2', 'post', '57', '收藏了你的帖子: 图片上传测试', '1', '2026-05-15 19:33:28');
INSERT INTO `notification` VALUES ('9', '216', '213', '2', 'game', '107', '收藏了你的游戏: 消息测试', '1', '2026-05-15 19:35:19');
INSERT INTO `notification` VALUES ('10', '216', '214', '2', 'game', '107', '收藏了你的游戏: 消息测试', '1', '2026-05-15 19:35:41');
INSERT INTO `notification` VALUES ('11', '213', '217', '1', 'post', '57', '赞了你的帖子', '1', '2026-05-15 19:43:14');
INSERT INTO `notification` VALUES ('12', '213', '217', '1', 'post', '57', '赞了你的帖子', '1', '2026-05-15 19:43:16');
INSERT INTO `notification` VALUES ('13', '17', '217', '2', 'game', '16', '收藏了你的游戏: 代号：史诗大作 V11', '0', '2026-05-15 19:43:41');
INSERT INTO `notification` VALUES ('14', '213', '217', '1', 'post', '57', '赞了你的帖子', '1', '2026-05-15 19:44:58');
INSERT INTO `notification` VALUES ('15', '213', '217', '2', 'post', '57', '收藏了你的帖子: 图片上传测试', '1', '2026-05-15 19:45:01');
INSERT INTO `notification` VALUES ('16', '216', '213', '1', 'post', null, '赞了你的评论: 111', '1', '2026-05-17 10:12:40');
INSERT INTO `notification` VALUES ('17', '216', '213', '1', 'post', null, '赞了你的评论: 111', '1', '2026-05-17 10:12:43');
INSERT INTO `notification` VALUES ('18', '216', '213', '1', 'post', null, '赞了你的评论: 111', '1', '2026-05-17 10:12:49');
INSERT INTO `notification` VALUES ('19', '216', '213', '1', 'post', null, '赞了你的评论: 111', '1', '2026-05-17 10:15:24');
INSERT INTO `notification` VALUES ('20', '216', '213', '3', 'game', '107', '1', '1', '2026-05-17 10:15:34');
INSERT INTO `notification` VALUES ('21', '216', '213', '1', 'post', null, '赞了你的评论: 111', '1', '2026-05-17 10:15:40');
INSERT INTO `notification` VALUES ('22', '216', '213', '1', 'post', null, '赞了你的评论: 111', '1', '2026-05-17 10:15:49');
INSERT INTO `notification` VALUES ('23', '216', '213', '1', 'post', null, '赞了你的评论: 111', '1', '2026-05-17 10:16:42');
INSERT INTO `notification` VALUES ('24', '112', '213', '1', 'post', '8', '赞了你的帖子', '0', '2026-05-17 10:17:58');
INSERT INTO `notification` VALUES ('25', '112', '213', '3', 'post', '8', '111', '0', '2026-05-17 10:18:03');
INSERT INTO `notification` VALUES ('26', '114', '213', '3', 'post', '10', '111\n', '0', '2026-05-17 10:22:04');
INSERT INTO `notification` VALUES ('27', '114', '213', '3', 'post', '10', '111', '0', '2026-05-17 10:30:08');
INSERT INTO `notification` VALUES ('28', '114', '213', '1', 'post', '10', '赞了你的帖子', '0', '2026-05-17 10:30:15');
INSERT INTO `notification` VALUES ('29', '216', '213', '3', 'game', '107', '11', '1', '2026-05-17 10:44:42');
INSERT INTO `notification` VALUES ('30', '216', '213', '3', 'game', '107', '1', '1', '2026-05-17 10:57:34');
INSERT INTO `notification` VALUES ('31', '213', '216', '1', 'post', null, '赞了你的评论: 好玩', '1', '2026-05-17 10:58:28');
INSERT INTO `notification` VALUES ('32', '213', '216', '3', 'game', '107', 'nb\n', '1', '2026-05-17 10:58:32');
INSERT INTO `notification` VALUES ('33', '213', '216', '1', 'post', null, '赞了你的评论: 好玩', '1', '2026-05-17 10:58:37');
INSERT INTO `notification` VALUES ('34', '216', '213', '1', 'post', null, '赞了你的评论: nb\n', '0', '2026-05-17 11:05:34');
INSERT INTO `notification` VALUES ('35', '216', '213', '3', 'game', '107', '这游戏傻逼吧', '0', '2026-05-17 14:27:54');
INSERT INTO `notification` VALUES ('36', '213', '1', '4', null, null, '系统警告：您的评论因严重违规已被管理员强制清除。请遵守社区规范，共同维护良好环境！', '1', '2026-05-17 14:49:01');
INSERT INTO `notification` VALUES ('37', '17', '0', '4', null, null, '【系统违规处理通知】\n您发布的游戏因涉嫌“抄袭侵权、盗版游戏”，已被社区管家强制清除。\n请严格遵守平台规范，共同维护良好的交流环境！', '0', '2026-05-17 15:01:04');
INSERT INTO `notification` VALUES ('38', '18', '0', '4', null, null, '【系统违规处理通知】\n您发布的游戏因涉嫌“抄袭侵权、盗版游戏”，已被社区管家强制清除。\n请严格遵守平台规范，共同维护良好的交流环境！', '0', '2026-05-17 15:01:50');

-- ----------------------------
-- Table structure for `post`
-- ----------------------------
DROP TABLE IF EXISTS `post`;
CREATE TABLE `post` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL COMMENT '帖子标题',
  `user_id` int NOT NULL COMMENT '作者ID',
  `game_id` int DEFAULT NULL COMMENT '鍏宠仈鐨勬父鎴廔D',
  `category_id` int DEFAULT NULL COMMENT '板块ID',
  `view_count` int DEFAULT '0',
  `like_count` int DEFAULT '0',
  `comment_count` int DEFAULT '0',
  `collect_count` int DEFAULT '0',
  `hot_score` double DEFAULT '0' COMMENT '热度分',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_game_id` (`game_id`),
  KEY `idx_hot_score` (`hot_score`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of post
-- ----------------------------
INSERT INTO `post` VALUES ('1', '测试1', '6', null, null, '1', '0', '0', '0', '0', '2026-05-03 10:05:24', '2026-05-14 13:45:16', '0');
INSERT INTO `post` VALUES ('2', '测试2', '6', '4', null, '3', '0', '0', '0', '0', '2026-05-03 10:23:51', '2026-05-14 13:45:16', '0');
INSERT INTO `post` VALUES ('3', '贴子测试', '5', '1', null, '40', '1', '0', '0', '1', '2026-05-03 10:29:44', '2026-05-14 20:11:20', '0');
INSERT INTO `post` VALUES ('4', '关于《代号：史诗大作 V2》的深度评测与隐藏攻略', '108', '7', null, '988', '417', '0', '0', '0', '2026-05-03 19:40:32', '2026-05-14 21:01:57', '0');
INSERT INTO `post` VALUES ('5', '关于《代号：史诗大作 V3》的深度评测与隐藏攻略', '109', '8', null, '2944', '1', '0', '0', '1', '2026-05-03 19:40:32', '2026-05-14 21:01:44', '0');
INSERT INTO `post` VALUES ('6', '关于《代号：史诗大作 V4》的深度评测与隐藏攻略', '110', '9', null, '2027', '360', '0', '0', '0', '2026-05-03 19:40:32', '2026-05-14 21:06:52', '0');
INSERT INTO `post` VALUES ('7', '关于《代号：史诗大作 V5》的深度评测与隐藏攻略', '111', '10', null, '1964', '398', '0', '0', '0', '2026-05-03 19:40:32', '2026-05-14 21:05:54', '0');
INSERT INTO `post` VALUES ('8', '关于《代号：史诗大作 V6》的深度评测与隐藏攻略', '112', '11', null, '4019', '1', '1', '0', '1', '2026-05-03 19:40:32', '2026-05-17 10:21:47', '0');
INSERT INTO `post` VALUES ('9', '关于《代号：史诗大作 V7》的深度评测与隐藏攻略', '113', '12', null, '3575', '1', '0', '0', '1', '2026-05-03 19:40:32', '2026-05-14 20:02:27', '0');
INSERT INTO `post` VALUES ('10', '关于《代号：史诗大作 V8》的深度评测与隐藏攻略', '114', '13', null, '1782', '1', '2', '0', '1', '2026-05-03 19:40:32', '2026-05-17 10:30:30', '0');
INSERT INTO `post` VALUES ('11', '关于《代号：史诗大作 V9》的深度评测与隐藏攻略', '115', '14', null, '1421', '1', '0', '0', '1', '2026-05-03 19:40:32', '2026-05-15 08:56:52', '0');
INSERT INTO `post` VALUES ('12', '关于《代号：史诗大作 V10》的深度评测与隐藏攻略', '116', '15', null, '864', '326', '0', '0', '0', '2026-05-03 19:40:32', '2026-05-14 20:25:24', '0');
INSERT INTO `post` VALUES ('13', '关于《代号：史诗大作 V11》的深度评测与隐藏攻略', '117', '16', null, '3736', '387', '0', '0', '0', '2026-05-03 19:40:32', '2026-05-14 21:02:07', '0');
INSERT INTO `post` VALUES ('14', '关于《代号：史诗大作 V12》的深度评测与隐藏攻略', '118', '17', null, '3181', '427', '0', '0', '0', '2026-05-03 19:40:32', '2026-05-14 13:45:16', '0');
INSERT INTO `post` VALUES ('15', '关于《代号：史诗大作 V13》的深度评测与隐藏攻略', '119', '18', null, '1832', '133', '0', '0', '0', '2026-05-03 19:40:32', '2026-05-14 13:45:16', '0');
INSERT INTO `post` VALUES ('16', '关于《代号：史诗大作 V14》的深度评测与隐藏攻略', '120', '19', null, '1179', '189', '0', '0', '0', '2026-05-03 19:40:32', '2026-05-14 13:45:16', '0');
INSERT INTO `post` VALUES ('17', '关于《代号：史诗大作 V15》的深度评测与隐藏攻略', '121', '20', null, '927', '395', '0', '0', '0', '2026-05-03 19:40:32', '2026-05-14 13:45:16', '0');
INSERT INTO `post` VALUES ('18', '关于《代号：史诗大作 V16》的深度评测与隐藏攻略', '122', '21', null, '2006', '315', '0', '0', '0', '2026-05-03 19:40:32', '2026-05-14 13:45:16', '0');
INSERT INTO `post` VALUES ('19', '关于《代号：史诗大作 V17》的深度评测与隐藏攻略', '123', '22', null, '4768', '437', '0', '0', '0', '2026-05-03 19:40:32', '2026-05-14 13:45:16', '0');
INSERT INTO `post` VALUES ('20', '关于《代号：史诗大作 V18》的深度评测与隐藏攻略', '124', '23', null, '2553', '465', '0', '0', '0', '2026-05-03 19:40:32', '2026-05-14 13:45:16', '0');
INSERT INTO `post` VALUES ('21', '关于《代号：史诗大作 V19》的深度评测与隐藏攻略', '125', '24', null, '601', '404', '0', '0', '0', '2026-05-03 19:40:32', '2026-05-14 13:45:16', '0');
INSERT INTO `post` VALUES ('22', '关于《代号：史诗大作 V20》的深度评测与隐藏攻略', '126', '25', null, '3438', '4', '0', '0', '0', '2026-05-03 19:40:32', '2026-05-14 13:45:16', '0');
INSERT INTO `post` VALUES ('23', '关于《代号：史诗大作 V21》的深度评测与隐藏攻略', '127', '26', null, '4923', '447', '0', '0', '0', '2026-05-03 19:40:32', '2026-05-14 13:45:16', '0');
INSERT INTO `post` VALUES ('24', '关于《代号：史诗大作 V22》的深度评测与隐藏攻略', '128', '27', null, '2605', '460', '0', '0', '0', '2026-05-03 19:40:32', '2026-05-14 13:45:16', '0');
INSERT INTO `post` VALUES ('25', '关于《代号：史诗大作 V23》的深度评测与隐藏攻略', '129', '28', null, '190', '214', '0', '0', '0', '2026-05-03 19:40:32', '2026-05-14 13:45:16', '0');
INSERT INTO `post` VALUES ('26', '关于《代号：史诗大作 V24》的深度评测与隐藏攻略', '130', '29', null, '167', '439', '0', '0', '0', '2026-05-03 19:40:32', '2026-05-14 13:45:16', '0');
INSERT INTO `post` VALUES ('27', '关于《代号：史诗大作 V25》的深度评测与隐藏攻略', '131', '30', null, '1462', '413', '0', '0', '0', '2026-05-03 19:40:32', '2026-05-14 13:45:16', '0');
INSERT INTO `post` VALUES ('28', '关于《代号：史诗大作 V26》的深度评测与隐藏攻略', '132', '31', null, '1287', '403', '0', '0', '0', '2026-05-03 19:40:32', '2026-05-14 13:45:16', '0');
INSERT INTO `post` VALUES ('29', '关于《代号：史诗大作 V27》的深度评测与隐藏攻略', '133', '32', null, '1297', '1', '0', '0', '1', '2026-05-03 19:40:32', '2026-05-14 20:06:22', '0');
INSERT INTO `post` VALUES ('30', '关于《代号：史诗大作 V28》的深度评测与隐藏攻略', '134', '33', null, '3018', '194', '0', '0', '0', '2026-05-03 19:40:32', '2026-05-14 20:02:31', '0');
INSERT INTO `post` VALUES ('31', '关于《代号：史诗大作 V29》的深度评测与隐藏攻略', '135', '34', null, '673', '253', '0', '0', '0', '2026-05-03 19:40:32', '2026-05-14 13:45:16', '0');
INSERT INTO `post` VALUES ('32', '关于《代号：史诗大作 V30》的深度评测与隐藏攻略', '136', '35', null, '641', '61', '0', '0', '0', '2026-05-03 19:40:32', '2026-05-14 13:45:16', '0');
INSERT INTO `post` VALUES ('33', '关于《代号：史诗大作 V31》的深度评测与隐藏攻略', '137', '36', null, '1131', '382', '0', '0', '0', '2026-05-03 19:40:32', '2026-05-14 13:45:16', '0');
INSERT INTO `post` VALUES ('34', '关于《代号：史诗大作 V32》的深度评测与隐藏攻略', '138', '37', null, '714', '210', '0', '0', '0', '2026-05-03 19:40:32', '2026-05-14 13:45:16', '0');
INSERT INTO `post` VALUES ('35', '关于《代号：史诗大作 V33》的深度评测与隐藏攻略', '139', '38', null, '3392', '63', '0', '0', '0', '2026-05-03 19:40:32', '2026-05-14 13:45:16', '0');
INSERT INTO `post` VALUES ('36', '关于《代号：史诗大作 V34》的深度评测与隐藏攻略', '140', '39', null, '3022', '319', '0', '0', '0', '2026-05-03 19:40:32', '2026-05-14 13:45:16', '0');
INSERT INTO `post` VALUES ('37', '关于《代号：史诗大作 V35》的深度评测与隐藏攻略', '141', '40', null, '1896', '490', '0', '0', '0', '2026-05-03 19:40:32', '2026-05-14 13:45:16', '0');
INSERT INTO `post` VALUES ('38', '关于《代号：史诗大作 V36》的深度评测与隐藏攻略', '142', '41', null, '3833', '445', '0', '0', '0', '2026-05-03 19:40:32', '2026-05-14 13:45:16', '0');
INSERT INTO `post` VALUES ('39', '关于《代号：史诗大作 V37》的深度评测与隐藏攻略', '143', '42', null, '762', '45', '0', '0', '0', '2026-05-03 19:40:32', '2026-05-14 13:45:16', '0');
INSERT INTO `post` VALUES ('40', '关于《代号：史诗大作 V38》的深度评测与隐藏攻略', '144', '43', null, '4984', '356', '0', '0', '0', '2026-05-03 19:40:32', '2026-05-14 13:45:16', '0');
INSERT INTO `post` VALUES ('41', '关于《代号：史诗大作 V39》的深度评测与隐藏攻略', '145', '44', null, '2853', '358', '0', '0', '0', '2026-05-03 19:40:32', '2026-05-14 13:45:16', '0');
INSERT INTO `post` VALUES ('42', '关于《代号：史诗大作 V40》的深度评测与隐藏攻略', '146', '45', null, '4359', '104', '0', '0', '0', '2026-05-03 19:40:32', '2026-05-14 13:45:16', '0');
INSERT INTO `post` VALUES ('43', '关于《代号：史诗大作 V41》的深度评测与隐藏攻略', '147', '46', null, '2144', '258', '0', '0', '0', '2026-05-03 19:40:32', '2026-05-14 13:45:16', '0');
INSERT INTO `post` VALUES ('44', '关于《代号：史诗大作 V42》的深度评测与隐藏攻略', '148', '47', null, '1512', '479', '0', '0', '0', '2026-05-03 19:40:32', '2026-05-14 13:45:16', '0');
INSERT INTO `post` VALUES ('45', '关于《代号：史诗大作 V43》的深度评测与隐藏攻略', '149', '48', null, '4435', '279', '0', '0', '0', '2026-05-03 19:40:32', '2026-05-14 13:45:16', '0');
INSERT INTO `post` VALUES ('46', '关于《代号：史诗大作 V44》的深度评测与隐藏攻略', '150', '49', null, '669', '495', '0', '0', '0', '2026-05-03 19:40:32', '2026-05-14 13:45:16', '0');
INSERT INTO `post` VALUES ('47', '关于《代号：史诗大作 V45》的深度评测与隐藏攻略', '151', '50', null, '2791', '407', '0', '0', '0', '2026-05-03 19:40:32', '2026-05-14 13:45:16', '0');
INSERT INTO `post` VALUES ('48', '关于《代号：史诗大作 V46》的深度评测与隐藏攻略', '152', '51', null, '2011', '282', '0', '0', '0', '2026-05-03 19:40:32', '2026-05-14 13:45:16', '0');
INSERT INTO `post` VALUES ('49', '关于《代号：史诗大作 V47》的深度评测与隐藏攻略', '153', '52', null, '3098', '201', '0', '0', '0', '2026-05-03 19:40:32', '2026-05-14 13:45:16', '0');
INSERT INTO `post` VALUES ('50', '关于《代号：史诗大作 V48》的深度评测与隐藏攻略', '154', '53', null, '773', '282', '0', '0', '0', '2026-05-03 19:40:32', '2026-05-14 13:45:16', '0');
INSERT INTO `post` VALUES ('51', '关于《代号：史诗大作 V49》的深度评测与隐藏攻略', '155', '54', null, '1803', '54', '0', '0', '0', '2026-05-03 19:40:32', '2026-05-14 13:45:16', '0');
INSERT INTO `post` VALUES ('52', '关于《代号：史诗大作 V50》的深度评测与隐藏攻略', '156', '55', null, '2261', '470', '0', '0', '0', '2026-05-03 19:40:32', '2026-05-14 13:45:16', '0');
INSERT INTO `post` VALUES ('53', '关于《代号：史诗大作 V51》的深度评测与隐藏攻略', '157', '56', null, '1751', '463', '0', '0', '0', '2026-05-03 19:40:32', '2026-05-14 13:45:16', '0');
INSERT INTO `post` VALUES ('54', '111', '207', null, null, '14', '0', '0', '0', '0', '2026-05-12 18:19:03', '2026-05-14 21:06:46', '0');
INSERT INTO `post` VALUES ('55', '2026.5.14Post开发', '213', null, null, '19', '1', '0', '0', '1', '2026-05-14 14:30:23', '2026-05-17 20:04:12', '0');
INSERT INTO `post` VALUES ('56', '不会写了', '213', '106', '3', '20', '1', '0', '0', '1', '2026-05-14 20:25:50', '2026-05-17 20:04:01', '0');
INSERT INTO `post` VALUES ('57', '图片上传测试', '213', '106', '5', '54', '4', '11', '0', '4', '2026-05-15 09:42:30', '2026-05-17 19:55:25', '0');

-- ----------------------------
-- Table structure for `posts`
-- ----------------------------
DROP TABLE IF EXISTS `posts`;
CREATE TABLE `posts` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '帖子主键ID',
  `user_id` int NOT NULL COMMENT '发帖人ID，关联users表',
  `game_id` int DEFAULT NULL COMMENT '关联的游戏ID（如果是综合讨论则为空）',
  `title` varchar(100) NOT NULL COMMENT '帖子标题',
  `content` text NOT NULL COMMENT '帖子正文内容',
  `view_count` int DEFAULT '0' COMMENT '浏览量',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '发帖时间',
  `like_count` int DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='交流帖子表';

-- ----------------------------
-- Records of posts
-- ----------------------------
INSERT INTO `posts` VALUES ('1', '6', null, '测试1', 'test111', '1', '2026-05-03 10:05:24', '0');
INSERT INTO `posts` VALUES ('2', '6', '4', '测试2', '测试关联游戏功能', '3', '2026-05-03 10:23:51', '0');
INSERT INTO `posts` VALUES ('3', '5', '1', '贴子测试', '可以输入关联游戏了', '23', '2026-05-03 10:29:44', '1');
INSERT INTO `posts` VALUES ('4', '108', '7', '关于《代号：史诗大作 V2》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 1 关的那个隐藏 Boss...', '985', '2026-05-03 19:40:32', '417');
INSERT INTO `posts` VALUES ('5', '109', '8', '关于《代号：史诗大作 V3》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 2 关的那个隐藏 Boss...', '2941', '2026-05-03 19:40:32', '216');
INSERT INTO `posts` VALUES ('6', '110', '9', '关于《代号：史诗大作 V4》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 3 关的那个隐藏 Boss...', '2023', '2026-05-03 19:40:32', '360');
INSERT INTO `posts` VALUES ('7', '111', '10', '关于《代号：史诗大作 V5》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 4 关的那个隐藏 Boss...', '1962', '2026-05-03 19:40:32', '398');
INSERT INTO `posts` VALUES ('8', '112', '11', '关于《代号：史诗大作 V6》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 5 关的那个隐藏 Boss...', '4011', '2026-05-03 19:40:32', '312');
INSERT INTO `posts` VALUES ('9', '113', '12', '关于《代号：史诗大作 V7》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 6 关的那个隐藏 Boss...', '3571', '2026-05-03 19:40:32', '349');
INSERT INTO `posts` VALUES ('10', '114', '13', '关于《代号：史诗大作 V8》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 7 关的那个隐藏 Boss...', '1765', '2026-05-03 19:40:32', '334');
INSERT INTO `posts` VALUES ('11', '115', '14', '关于《代号：史诗大作 V9》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 8 关的那个隐藏 Boss...', '1408', '2026-05-03 19:40:32', '201');
INSERT INTO `posts` VALUES ('12', '116', '15', '关于《代号：史诗大作 V10》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 9 关的那个隐藏 Boss...', '863', '2026-05-03 19:40:32', '326');
INSERT INTO `posts` VALUES ('13', '117', '16', '关于《代号：史诗大作 V11》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 10 关的那个隐藏 Boss...', '3734', '2026-05-03 19:40:32', '387');
INSERT INTO `posts` VALUES ('14', '118', '17', '关于《代号：史诗大作 V12》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 11 关的那个隐藏 Boss...', '3181', '2026-05-03 19:40:32', '427');
INSERT INTO `posts` VALUES ('15', '119', '18', '关于《代号：史诗大作 V13》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 12 关的那个隐藏 Boss...', '1832', '2026-05-03 19:40:32', '133');
INSERT INTO `posts` VALUES ('16', '120', '19', '关于《代号：史诗大作 V14》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 13 关的那个隐藏 Boss...', '1179', '2026-05-03 19:40:32', '189');
INSERT INTO `posts` VALUES ('17', '121', '20', '关于《代号：史诗大作 V15》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 14 关的那个隐藏 Boss...', '927', '2026-05-03 19:40:32', '395');
INSERT INTO `posts` VALUES ('18', '122', '21', '关于《代号：史诗大作 V16》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 15 关的那个隐藏 Boss...', '2006', '2026-05-03 19:40:32', '315');
INSERT INTO `posts` VALUES ('19', '123', '22', '关于《代号：史诗大作 V17》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 16 关的那个隐藏 Boss...', '4768', '2026-05-03 19:40:32', '437');
INSERT INTO `posts` VALUES ('20', '124', '23', '关于《代号：史诗大作 V18》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 17 关的那个隐藏 Boss...', '2553', '2026-05-03 19:40:32', '465');
INSERT INTO `posts` VALUES ('21', '125', '24', '关于《代号：史诗大作 V19》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 18 关的那个隐藏 Boss...', '601', '2026-05-03 19:40:32', '404');
INSERT INTO `posts` VALUES ('22', '126', '25', '关于《代号：史诗大作 V20》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 19 关的那个隐藏 Boss...', '3438', '2026-05-03 19:40:32', '4');
INSERT INTO `posts` VALUES ('23', '127', '26', '关于《代号：史诗大作 V21》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 20 关的那个隐藏 Boss...', '4923', '2026-05-03 19:40:32', '447');
INSERT INTO `posts` VALUES ('24', '128', '27', '关于《代号：史诗大作 V22》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 21 关的那个隐藏 Boss...', '2605', '2026-05-03 19:40:32', '460');
INSERT INTO `posts` VALUES ('25', '129', '28', '关于《代号：史诗大作 V23》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 22 关的那个隐藏 Boss...', '190', '2026-05-03 19:40:32', '214');
INSERT INTO `posts` VALUES ('26', '130', '29', '关于《代号：史诗大作 V24》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 23 关的那个隐藏 Boss...', '167', '2026-05-03 19:40:32', '439');
INSERT INTO `posts` VALUES ('27', '131', '30', '关于《代号：史诗大作 V25》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 24 关的那个隐藏 Boss...', '1462', '2026-05-03 19:40:32', '413');
INSERT INTO `posts` VALUES ('28', '132', '31', '关于《代号：史诗大作 V26》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 25 关的那个隐藏 Boss...', '1287', '2026-05-03 19:40:32', '403');
INSERT INTO `posts` VALUES ('29', '133', '32', '关于《代号：史诗大作 V27》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 26 关的那个隐藏 Boss...', '1294', '2026-05-03 19:40:32', '438');
INSERT INTO `posts` VALUES ('30', '134', '33', '关于《代号：史诗大作 V28》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 27 关的那个隐藏 Boss...', '3017', '2026-05-03 19:40:32', '194');
INSERT INTO `posts` VALUES ('31', '135', '34', '关于《代号：史诗大作 V29》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 28 关的那个隐藏 Boss...', '673', '2026-05-03 19:40:32', '253');
INSERT INTO `posts` VALUES ('32', '136', '35', '关于《代号：史诗大作 V30》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 29 关的那个隐藏 Boss...', '641', '2026-05-03 19:40:32', '61');
INSERT INTO `posts` VALUES ('33', '137', '36', '关于《代号：史诗大作 V31》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 30 关的那个隐藏 Boss...', '1131', '2026-05-03 19:40:32', '382');
INSERT INTO `posts` VALUES ('34', '138', '37', '关于《代号：史诗大作 V32》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 31 关的那个隐藏 Boss...', '714', '2026-05-03 19:40:32', '210');
INSERT INTO `posts` VALUES ('35', '139', '38', '关于《代号：史诗大作 V33》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 32 关的那个隐藏 Boss...', '3392', '2026-05-03 19:40:32', '63');
INSERT INTO `posts` VALUES ('36', '140', '39', '关于《代号：史诗大作 V34》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 33 关的那个隐藏 Boss...', '3022', '2026-05-03 19:40:32', '319');
INSERT INTO `posts` VALUES ('37', '141', '40', '关于《代号：史诗大作 V35》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 34 关的那个隐藏 Boss...', '1896', '2026-05-03 19:40:32', '490');
INSERT INTO `posts` VALUES ('38', '142', '41', '关于《代号：史诗大作 V36》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 35 关的那个隐藏 Boss...', '3833', '2026-05-03 19:40:32', '445');
INSERT INTO `posts` VALUES ('39', '143', '42', '关于《代号：史诗大作 V37》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 36 关的那个隐藏 Boss...', '762', '2026-05-03 19:40:32', '45');
INSERT INTO `posts` VALUES ('40', '144', '43', '关于《代号：史诗大作 V38》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 37 关的那个隐藏 Boss...', '4984', '2026-05-03 19:40:32', '356');
INSERT INTO `posts` VALUES ('41', '145', '44', '关于《代号：史诗大作 V39》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 38 关的那个隐藏 Boss...', '2853', '2026-05-03 19:40:32', '358');
INSERT INTO `posts` VALUES ('42', '146', '45', '关于《代号：史诗大作 V40》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 39 关的那个隐藏 Boss...', '4359', '2026-05-03 19:40:32', '104');
INSERT INTO `posts` VALUES ('43', '147', '46', '关于《代号：史诗大作 V41》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 40 关的那个隐藏 Boss...', '2144', '2026-05-03 19:40:32', '258');
INSERT INTO `posts` VALUES ('44', '148', '47', '关于《代号：史诗大作 V42》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 41 关的那个隐藏 Boss...', '1512', '2026-05-03 19:40:32', '479');
INSERT INTO `posts` VALUES ('45', '149', '48', '关于《代号：史诗大作 V43》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 42 关的那个隐藏 Boss...', '4435', '2026-05-03 19:40:32', '279');
INSERT INTO `posts` VALUES ('46', '150', '49', '关于《代号：史诗大作 V44》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 43 关的那个隐藏 Boss...', '669', '2026-05-03 19:40:32', '495');
INSERT INTO `posts` VALUES ('47', '151', '50', '关于《代号：史诗大作 V45》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 44 关的那个隐藏 Boss...', '2791', '2026-05-03 19:40:32', '407');
INSERT INTO `posts` VALUES ('48', '152', '51', '关于《代号：史诗大作 V46》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 45 关的那个隐藏 Boss...', '2011', '2026-05-03 19:40:32', '282');
INSERT INTO `posts` VALUES ('49', '153', '52', '关于《代号：史诗大作 V47》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 46 关的那个隐藏 Boss...', '3098', '2026-05-03 19:40:32', '201');
INSERT INTO `posts` VALUES ('50', '154', '53', '关于《代号：史诗大作 V48》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 47 关的那个隐藏 Boss...', '773', '2026-05-03 19:40:32', '282');
INSERT INTO `posts` VALUES ('51', '155', '54', '关于《代号：史诗大作 V49》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 48 关的那个隐藏 Boss...', '1803', '2026-05-03 19:40:32', '54');
INSERT INTO `posts` VALUES ('52', '156', '55', '关于《代号：史诗大作 V50》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 49 关的那个隐藏 Boss...', '2261', '2026-05-03 19:40:32', '470');
INSERT INTO `posts` VALUES ('53', '157', '56', '关于《代号：史诗大作 V51》的深度评测与隐藏攻略', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 50 关的那个隐藏 Boss...', '1751', '2026-05-03 19:40:32', '463');
INSERT INTO `posts` VALUES ('54', '207', null, '111', '111', '0', '2026-05-12 18:19:03', '0');

-- ----------------------------
-- Table structure for `post_content`
-- ----------------------------
DROP TABLE IF EXISTS `post_content`;
CREATE TABLE `post_content` (
  `post_id` int NOT NULL COMMENT '对应post表的主键',
  `content` longtext COMMENT '几千字的游戏攻略、HTML内容全在这',
  PRIMARY KEY (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of post_content
-- ----------------------------
INSERT INTO `post_content` VALUES ('1', 'test111');
INSERT INTO `post_content` VALUES ('2', '测试关联游戏功能');
INSERT INTO `post_content` VALUES ('3', '可以输入关联游戏了');
INSERT INTO `post_content` VALUES ('4', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 1 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('5', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 2 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('6', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 3 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('7', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 4 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('8', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 5 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('9', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 6 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('10', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 7 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('11', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 8 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('12', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 9 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('13', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 10 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('14', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 11 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('15', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 12 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('16', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 13 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('17', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 14 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('18', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 15 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('19', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 16 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('20', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 17 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('21', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 18 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('22', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 19 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('23', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 20 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('24', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 21 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('25', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 22 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('26', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 23 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('27', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 24 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('28', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 25 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('29', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 26 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('30', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 27 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('31', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 28 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('32', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 29 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('33', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 30 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('34', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 31 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('35', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 32 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('36', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 33 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('37', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 34 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('38', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 35 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('39', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 36 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('40', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 37 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('41', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 38 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('42', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 39 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('43', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 40 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('44', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 41 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('45', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 42 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('46', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 43 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('47', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 44 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('48', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 45 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('49', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 46 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('50', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 47 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('51', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 48 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('52', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 49 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('53', '游戏体验非常棒！在这个游戏里我发现了几个隐藏彩蛋，大家前期不要急着推主线，多探索支线任务，特别是第 50 关的那个隐藏 Boss...');
INSERT INTO `post_content` VALUES ('54', '111');
INSERT INTO `post_content` VALUES ('55', 'post+redis测试');
INSERT INTO `post_content` VALUES ('56', '救命');
INSERT INTO `post_content` VALUES ('57', '<h1>标题</h1><h2>一.二级标题</h2><p>正文</p><p><img src=\"http://localhost:8080/uploads/d5206c97-4521-4d9b-900b-382940a0bf2d.png\" alt=\"\" data-href=\"\" style=\"width: 360.00px;height: 360.00px;\"/></p><p>正文</p><p>测试完毕</p>');

-- ----------------------------
-- Table structure for `post_favorite`
-- ----------------------------
DROP TABLE IF EXISTS `post_favorite`;
CREATE TABLE `post_favorite` (
  `id` int NOT NULL AUTO_INCREMENT,
  `post_id` int NOT NULL,
  `user_id` int NOT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_post_user_fav` (`post_id`,`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of post_favorite
-- ----------------------------
INSERT INTO `post_favorite` VALUES ('2', '11', '213', '2026-05-14 19:45:52');
INSERT INTO `post_favorite` VALUES ('4', '55', '213', '2026-05-14 19:53:13');
INSERT INTO `post_favorite` VALUES ('5', '3', '213', '2026-05-14 20:01:00');
INSERT INTO `post_favorite` VALUES ('6', '9', '213', '2026-05-14 20:01:06');
INSERT INTO `post_favorite` VALUES ('7', '29', '213', '2026-05-14 20:05:34');
INSERT INTO `post_favorite` VALUES ('8', '56', '213', '2026-05-14 20:26:04');
INSERT INTO `post_favorite` VALUES ('10', '57', '214', '2026-05-15 10:29:19');
INSERT INTO `post_favorite` VALUES ('12', '57', '216', '2026-05-15 19:33:28');
INSERT INTO `post_favorite` VALUES ('13', '57', '217', '2026-05-15 19:45:01');
INSERT INTO `post_favorite` VALUES ('14', '57', '213', '2026-05-17 19:55:44');

-- ----------------------------
-- Table structure for `post_like`
-- ----------------------------
DROP TABLE IF EXISTS `post_like`;
CREATE TABLE `post_like` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '独立物理主键',
  `post_id` int NOT NULL COMMENT '帖子ID',
  `user_id` int NOT NULL COMMENT '用户ID',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '点赞时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_post_user` (`post_id`,`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of post_like
-- ----------------------------
INSERT INTO `post_like` VALUES ('62', '213', '213', '2026-05-14 15:05:30');
INSERT INTO `post_like` VALUES ('64', '55', '213', '2026-05-14 17:17:00');
INSERT INTO `post_like` VALUES ('65', '11', '213', '2026-05-14 19:46:00');
INSERT INTO `post_like` VALUES ('66', '3', '213', '2026-05-14 19:46:30');
INSERT INTO `post_like` VALUES ('67', '5', '213', '2026-05-14 19:53:30');
INSERT INTO `post_like` VALUES ('68', '9', '213', '2026-05-14 20:01:30');
INSERT INTO `post_like` VALUES ('69', '29', '213', '2026-05-14 20:06:00');
INSERT INTO `post_like` VALUES ('70', '56', '213', '2026-05-14 20:26:30');
INSERT INTO `post_like` VALUES ('71', '57', '213', '2026-05-15 09:43:00');
INSERT INTO `post_like` VALUES ('72', '57', '214', '2026-05-15 10:25:30');
INSERT INTO `post_like` VALUES ('73', '57', '216', '2026-05-15 19:27:30');
INSERT INTO `post_like` VALUES ('74', '57', '217', '2026-05-15 19:43:30');
INSERT INTO `post_like` VALUES ('75', '8', '213', '2026-05-17 10:18:00');
INSERT INTO `post_like` VALUES ('76', '10', '213', '2026-05-17 10:30:30');

-- ----------------------------
-- Table structure for `report`
-- ----------------------------
DROP TABLE IF EXISTS `report`;
CREATE TABLE `report` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '举报记录ID',
  `reporter_id` int NOT NULL COMMENT '举报人ID (发起举报的用户)',
  `target_type` varchar(20) NOT NULL COMMENT '举报目标类型: game(游戏), post(帖子), comment(评论)',
  `target_id` int NOT NULL COMMENT '被举报目标的具体ID',
  `reason` varchar(255) NOT NULL COMMENT '举报原因 (如: 色情低俗, 广告引流等)',
  `status` int DEFAULT '0' COMMENT '处理状态: 0=待处理, 1=已处理并警告, 2=已驳回',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '举报提交时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='全站统一举报表';

-- ----------------------------
-- Records of report
-- ----------------------------
INSERT INTO `report` VALUES ('1', '213', 'comment', '47', '【恶意辱骂、人身攻击】 乱说脏话', '1', '2026-05-17 14:31:15');
INSERT INTO `report` VALUES ('2', '213', 'game', '107', '【其他违规内容】 不好玩', '2', '2026-05-17 14:31:47');
INSERT INTO `report` VALUES ('3', '213', 'game', '16', '【抄袭侵权、盗版游戏】', '1', '2026-05-17 15:00:32');
INSERT INTO `report` VALUES ('4', '213', 'game', '17', '【抄袭侵权、盗版游戏】 抄袭', '1', '2026-05-17 15:01:43');

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '瀵嗙爜',
  `nickname` varchar(50) NOT NULL COMMENT '昵称',
  `avatar` varchar(255) DEFAULT '' COMMENT '头像URL',
  `role` tinyint NOT NULL DEFAULT '0' COMMENT '角色：0-普通用户, 1-游戏作者, 2-超级管理员',
  `status` int DEFAULT '0' COMMENT '0:正常, 1:封禁',
  `email` varchar(100) DEFAULT NULL COMMENT '绑定邮箱',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=220 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户表';

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'zhangsan', '111111', '张三', 'https://example.com/avatar.png', '1', '0', null);
INSERT INTO `user` VALUES ('2', '李四', '111111', 'ls', null, '0', '0', null);
INSERT INTO `user` VALUES ('3', 'player1', '123', '一号玩家pro', null, '0', '0', null);
INSERT INTO `user` VALUES ('4', '2220617749', '123456', 'Rlx', '', '2', '0', null);
INSERT INTO `user` VALUES ('5', '222', '123456', 'ww', null, '0', '1', null);
INSERT INTO `user` VALUES ('6', 'kfz', '123456', '开发者', null, '1', '0', null);
INSERT INTO `user` VALUES ('7', 'dev_mock_1', '123456', '独立工作室_1', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('8', 'dev_mock_2', '123456', '独立工作室_2', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('9', 'dev_mock_3', '123456', '独立工作室_3', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('10', 'dev_mock_4', '123456', '独立工作室_4', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('11', 'dev_mock_5', '123456', '独立工作室_5', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('12', 'dev_mock_6', '123456', '独立工作室_6', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('13', 'dev_mock_7', '123456', '独立工作室_7', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('14', 'dev_mock_8', '123456', '独立工作室_8', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('15', 'dev_mock_9', '123456', '独立工作室_9', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('16', 'dev_mock_10', '123456', '独立工作室_10', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('17', 'dev_mock_11', '123456', '独立工作室_11', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('18', 'dev_mock_12', '123456', '独立工作室_12', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('19', 'dev_mock_13', '123456', '独立工作室_13', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('20', 'dev_mock_14', '123456', '独立工作室_14', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('21', 'dev_mock_15', '123456', '独立工作室_15', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('22', 'dev_mock_16', '123456', '独立工作室_16', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('23', 'dev_mock_17', '123456', '独立工作室_17', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('24', 'dev_mock_18', '123456', '独立工作室_18', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('25', 'dev_mock_19', '123456', '独立工作室_19', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('26', 'dev_mock_20', '123456', '独立工作室_20', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('27', 'dev_mock_21', '123456', '独立工作室_21', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('28', 'dev_mock_22', '123456', '独立工作室_22', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('29', 'dev_mock_23', '123456', '独立工作室_23', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('30', 'dev_mock_24', '123456', '独立工作室_24', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('31', 'dev_mock_25', '123456', '独立工作室_25', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('32', 'dev_mock_26', '123456', '独立工作室_26', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('33', 'dev_mock_27', '123456', '独立工作室_27', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('34', 'dev_mock_28', '123456', '独立工作室_28', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('35', 'dev_mock_29', '123456', '独立工作室_29', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('36', 'dev_mock_30', '123456', '独立工作室_30', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('37', 'dev_mock_31', '123456', '独立工作室_31', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('38', 'dev_mock_32', '123456', '独立工作室_32', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('39', 'dev_mock_33', '123456', '独立工作室_33', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('40', 'dev_mock_34', '123456', '独立工作室_34', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('41', 'dev_mock_35', '123456', '独立工作室_35', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('42', 'dev_mock_36', '123456', '独立工作室_36', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('43', 'dev_mock_37', '123456', '独立工作室_37', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('44', 'dev_mock_38', '123456', '独立工作室_38', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('45', 'dev_mock_39', '123456', '独立工作室_39', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('46', 'dev_mock_40', '123456', '独立工作室_40', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('47', 'dev_mock_41', '123456', '独立工作室_41', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('48', 'dev_mock_42', '123456', '独立工作室_42', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('49', 'dev_mock_43', '123456', '独立工作室_43', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('50', 'dev_mock_44', '123456', '独立工作室_44', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('51', 'dev_mock_45', '123456', '独立工作室_45', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('52', 'dev_mock_46', '123456', '独立工作室_46', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('53', 'dev_mock_47', '123456', '独立工作室_47', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('54', 'dev_mock_48', '123456', '独立工作室_48', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('55', 'dev_mock_49', '123456', '独立工作室_49', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('56', 'dev_mock_50', '123456', '独立工作室_50', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('57', 'dev_mock_51', '123456', '独立工作室_51', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('58', 'dev_mock_52', '123456', '独立工作室_52', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('59', 'dev_mock_53', '123456', '独立工作室_53', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('60', 'dev_mock_54', '123456', '独立工作室_54', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('61', 'dev_mock_55', '123456', '独立工作室_55', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('62', 'dev_mock_56', '123456', '独立工作室_56', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('63', 'dev_mock_57', '123456', '独立工作室_57', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('64', 'dev_mock_58', '123456', '独立工作室_58', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('65', 'dev_mock_59', '123456', '独立工作室_59', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('66', 'dev_mock_60', '123456', '独立工作室_60', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('67', 'dev_mock_61', '123456', '独立工作室_61', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('68', 'dev_mock_62', '123456', '独立工作室_62', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('69', 'dev_mock_63', '123456', '独立工作室_63', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('70', 'dev_mock_64', '123456', '独立工作室_64', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('71', 'dev_mock_65', '123456', '独立工作室_65', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('72', 'dev_mock_66', '123456', '独立工作室_66', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('73', 'dev_mock_67', '123456', '独立工作室_67', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('74', 'dev_mock_68', '123456', '独立工作室_68', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('75', 'dev_mock_69', '123456', '独立工作室_69', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('76', 'dev_mock_70', '123456', '独立工作室_70', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('77', 'dev_mock_71', '123456', '独立工作室_71', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('78', 'dev_mock_72', '123456', '独立工作室_72', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('79', 'dev_mock_73', '123456', '独立工作室_73', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('80', 'dev_mock_74', '123456', '独立工作室_74', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('81', 'dev_mock_75', '123456', '独立工作室_75', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('82', 'dev_mock_76', '123456', '独立工作室_76', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('83', 'dev_mock_77', '123456', '独立工作室_77', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('84', 'dev_mock_78', '123456', '独立工作室_78', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('85', 'dev_mock_79', '123456', '独立工作室_79', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('86', 'dev_mock_80', '123456', '独立工作室_80', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('87', 'dev_mock_81', '123456', '独立工作室_81', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('88', 'dev_mock_82', '123456', '独立工作室_82', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('89', 'dev_mock_83', '123456', '独立工作室_83', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('90', 'dev_mock_84', '123456', '独立工作室_84', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('91', 'dev_mock_85', '123456', '独立工作室_85', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('92', 'dev_mock_86', '123456', '独立工作室_86', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('93', 'dev_mock_87', '123456', '独立工作室_87', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('94', 'dev_mock_88', '123456', '独立工作室_88', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('95', 'dev_mock_89', '123456', '独立工作室_89', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('96', 'dev_mock_90', '123456', '独立工作室_90', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('97', 'dev_mock_91', '123456', '独立工作室_91', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('98', 'dev_mock_92', '123456', '独立工作室_92', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('99', 'dev_mock_93', '123456', '独立工作室_93', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('100', 'dev_mock_94', '123456', '独立工作室_94', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('101', 'dev_mock_95', '123456', '独立工作室_95', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('102', 'dev_mock_96', '123456', '独立工作室_96', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('103', 'dev_mock_97', '123456', '独立工作室_97', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('104', 'dev_mock_98', '123456', '独立工作室_98', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('105', 'dev_mock_99', '123456', '独立工作室_99', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('106', 'dev_mock_100', '123456', '独立工作室_100', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1', '0', null);
INSERT INTO `user` VALUES ('107', 'player_mock_1', '123456', '热心玩家_1', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('108', 'player_mock_2', '123456', '热心玩家_2', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('109', 'player_mock_3', '123456', '热心玩家_3', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('110', 'player_mock_4', '123456', '热心玩家_4', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('111', 'player_mock_5', '123456', '热心玩家_5', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('112', 'player_mock_6', '123456', '热心玩家_6', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('113', 'player_mock_7', '123456', '热心玩家_7', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('114', 'player_mock_8', '123456', '热心玩家_8', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('115', 'player_mock_9', '123456', '热心玩家_9', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('116', 'player_mock_10', '123456', '热心玩家_10', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('117', 'player_mock_11', '123456', '热心玩家_11', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('118', 'player_mock_12', '123456', '热心玩家_12', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('119', 'player_mock_13', '123456', '热心玩家_13', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('120', 'player_mock_14', '123456', '热心玩家_14', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('121', 'player_mock_15', '123456', '热心玩家_15', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('122', 'player_mock_16', '123456', '热心玩家_16', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('123', 'player_mock_17', '123456', '热心玩家_17', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('124', 'player_mock_18', '123456', '热心玩家_18', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('125', 'player_mock_19', '123456', '热心玩家_19', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('126', 'player_mock_20', '123456', '热心玩家_20', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('127', 'player_mock_21', '123456', '热心玩家_21', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('128', 'player_mock_22', '123456', '热心玩家_22', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('129', 'player_mock_23', '123456', '热心玩家_23', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('130', 'player_mock_24', '123456', '热心玩家_24', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('131', 'player_mock_25', '123456', '热心玩家_25', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('132', 'player_mock_26', '123456', '热心玩家_26', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('133', 'player_mock_27', '123456', '热心玩家_27', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('134', 'player_mock_28', '123456', '热心玩家_28', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('135', 'player_mock_29', '123456', '热心玩家_29', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('136', 'player_mock_30', '123456', '热心玩家_30', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('137', 'player_mock_31', '123456', '热心玩家_31', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('138', 'player_mock_32', '123456', '热心玩家_32', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('139', 'player_mock_33', '123456', '热心玩家_33', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('140', 'player_mock_34', '123456', '热心玩家_34', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('141', 'player_mock_35', '123456', '热心玩家_35', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('142', 'player_mock_36', '123456', '热心玩家_36', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('143', 'player_mock_37', '123456', '热心玩家_37', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('144', 'player_mock_38', '123456', '热心玩家_38', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('145', 'player_mock_39', '123456', '热心玩家_39', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('146', 'player_mock_40', '123456', '热心玩家_40', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('147', 'player_mock_41', '123456', '热心玩家_41', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('148', 'player_mock_42', '123456', '热心玩家_42', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('149', 'player_mock_43', '123456', '热心玩家_43', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('150', 'player_mock_44', '123456', '热心玩家_44', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('151', 'player_mock_45', '123456', '热心玩家_45', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('152', 'player_mock_46', '123456', '热心玩家_46', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('153', 'player_mock_47', '123456', '热心玩家_47', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('154', 'player_mock_48', '123456', '热心玩家_48', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('155', 'player_mock_49', '123456', '热心玩家_49', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('156', 'player_mock_50', '123456', '热心玩家_50', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('157', 'player_mock_51', '123456', '热心玩家_51', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('158', 'player_mock_52', '123456', '热心玩家_52', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('159', 'player_mock_53', '123456', '热心玩家_53', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('160', 'player_mock_54', '123456', '热心玩家_54', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('161', 'player_mock_55', '123456', '热心玩家_55', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('162', 'player_mock_56', '123456', '热心玩家_56', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('163', 'player_mock_57', '123456', '热心玩家_57', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('164', 'player_mock_58', '123456', '热心玩家_58', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('165', 'player_mock_59', '123456', '热心玩家_59', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('166', 'player_mock_60', '123456', '热心玩家_60', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('167', 'player_mock_61', '123456', '热心玩家_61', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('168', 'player_mock_62', '123456', '热心玩家_62', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('169', 'player_mock_63', '123456', '热心玩家_63', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('170', 'player_mock_64', '123456', '热心玩家_64', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('171', 'player_mock_65', '123456', '热心玩家_65', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('172', 'player_mock_66', '123456', '热心玩家_66', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('173', 'player_mock_67', '123456', '热心玩家_67', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('174', 'player_mock_68', '123456', '热心玩家_68', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('175', 'player_mock_69', '123456', '热心玩家_69', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('176', 'player_mock_70', '123456', '热心玩家_70', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('177', 'player_mock_71', '123456', '热心玩家_71', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('178', 'player_mock_72', '123456', '热心玩家_72', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('179', 'player_mock_73', '123456', '热心玩家_73', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('180', 'player_mock_74', '123456', '热心玩家_74', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('181', 'player_mock_75', '123456', '热心玩家_75', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('182', 'player_mock_76', '123456', '热心玩家_76', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('183', 'player_mock_77', '123456', '热心玩家_77', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('184', 'player_mock_78', '123456', '热心玩家_78', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('185', 'player_mock_79', '123456', '热心玩家_79', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('186', 'player_mock_80', '123456', '热心玩家_80', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('187', 'player_mock_81', '123456', '热心玩家_81', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('188', 'player_mock_82', '123456', '热心玩家_82', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('189', 'player_mock_83', '123456', '热心玩家_83', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('190', 'player_mock_84', '123456', '热心玩家_84', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('191', 'player_mock_85', '123456', '热心玩家_85', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('192', 'player_mock_86', '123456', '热心玩家_86', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('193', 'player_mock_87', '123456', '热心玩家_87', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('194', 'player_mock_88', '123456', '热心玩家_88', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('195', 'player_mock_89', '123456', '热心玩家_89', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('196', 'player_mock_90', '123456', '热心玩家_90', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('197', 'player_mock_91', '123456', '热心玩家_91', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('198', 'player_mock_92', '123456', '热心玩家_92', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('199', 'player_mock_93', '123456', '热心玩家_93', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('200', 'player_mock_94', '123456', '热心玩家_94', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('201', 'player_mock_95', '123456', '热心玩家_95', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('202', 'player_mock_96', '123456', '热心玩家_96', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('203', 'player_mock_97', '123456', '热心玩家_97', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('204', 'player_mock_98', '123456', '热心玩家_98', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('205', 'player_mock_99', '123456', '热心玩家_99', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('206', 'player_mock_100', '123456', '热心玩家_100', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0', '0', null);
INSERT INTO `user` VALUES ('207', 'Rlx', '$2a$10$2aCUghsKpJAQsTa9Ln0GHO1RfFC8YSsso0IgHToboxV.MTWLVAsZC', 'rl', null, '2', '0', null);
INSERT INTO `user` VALUES ('208', 'test4', '$2a$10$J9mz4RtaBWG/iRFUpakNFeuuqLlnGZ3OhwqbnpEeylJsoch/A3EA2', '444', '', '0', '0', null);
INSERT INTO `user` VALUES ('209', 'test5', '$2a$10$rA54/ffBjxdwpLQVg4X/aO3iscx2MSyPgBNCrFhUWhAGX4ZD5.ula', '555', '', '0', '0', null);
INSERT INTO `user` VALUES ('210', 'test6', '$2a$10$zY9iMEZ3U5QVWLR0lZsJDenu7uDTLysLMNURNNtU/LTpOo0vNZu9.', '666', '', '0', '0', null);
INSERT INTO `user` VALUES ('211', 'text777', '$2a$10$3dFG35TZGwQ5llifojq9t.X5lgy9OqjtmO4jgtQWHDsPLUILbdDxa', '777', '', '0', '0', null);
INSERT INTO `user` VALUES ('212', '123456', '$2a$10$gX3072gFisNVNAUfsPApsOKWgbhk0nBe1u/M.qfeAXwAf31rWScla', '1', '', '0', '0', null);
INSERT INTO `user` VALUES ('213', 'r2220617749', '$2a$10$Xzrx0WG23XXQ4qt4yxDV.urbaktrZjREwVGCREO8ihuMcJEsSj4qO', 'SuperAdmin', '', '2', '0', null);
INSERT INTO `user` VALUES ('214', 'test999', '$2a$10$sHjQY6yPuQ985gNd0Gnpo.wwmHVTuY4F33iJSacLq8fijzINxHFMW', '测试者999', '', '0', '0', null);
INSERT INTO `user` VALUES ('215', 'test10', '$2a$10$IpWJrUq9iMsgEtsKRyLA/elYLsBRja2U8W2R45lL9nhn4yptRJV4u', 'test10', '', '0', '0', null);
INSERT INTO `user` VALUES ('216', '111111', '$2a$10$XDYkhTcckpmXH/ZZkRlIBuaSBAN7yHgBGGArMB1WoK5CXJ1oOHpdC', 'test11', '', '1', '0', null);
INSERT INTO `user` VALUES ('217', '888888', '$2a$10$bRh8q/yOyy3P36/uHI1ZNejyIhAES7db1d5NRms8Hm5mdQDQ3eDoO', 'wkk', '', '2', '0', null);
INSERT INTO `user` VALUES ('218', 'yxkfz', '$2a$10$iijJrQrah3nhhG1Hbzaj6uh8IESSggCwSGd03lCu.iBkdQwz4sJYK', 'yxkfz', '', '1', '0', null);
INSERT INTO `user` VALUES ('219', '163yx', '$2a$10$wiW.HPHpKVXBvfgZdyTMFOhKEzsw1UVrKlHz.uxRqZW5fsPuPIXz2', '邮箱测试', '', '0', '0', 'R2220617749@163.com');

-- ----------------------------
-- Table structure for `user_subscribed_game`
-- ----------------------------
DROP TABLE IF EXISTS `user_subscribed_game`;
CREATE TABLE `user_subscribed_game` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT '用户ID',
  `game_id` int NOT NULL COMMENT '关注的游戏ID',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '关注时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_game` (`user_id`,`game_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of user_subscribed_game
-- ----------------------------
INSERT INTO `user_subscribed_game` VALUES ('3', '213', '1', '2026-05-14 17:30:46');
INSERT INTO `user_subscribed_game` VALUES ('5', '213', '14', '2026-05-14 19:11:03');
INSERT INTO `user_subscribed_game` VALUES ('6', '213', '106', '2026-05-14 20:26:20');
INSERT INTO `user_subscribed_game` VALUES ('7', '217', '106', '2026-05-15 19:44:02');
