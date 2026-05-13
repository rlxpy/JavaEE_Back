/*
Navicat MySQL Data Transfer

Source Server         : 1
Source Server Version : 80028
Source Host           : localhost:3306
Source Database       : javaee

Target Server Type    : MYSQL
Target Server Version : 80028
File Encoding         : 65001

Date: 2026-05-13 16:51:58
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='游戏分类表';

-- ----------------------------
-- Records of categories
-- ----------------------------

-- ----------------------------
-- Table structure for `comments`
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '评论主键ID',
  `user_id` int NOT NULL COMMENT '评论人ID，关联users表',
  `game_id` int DEFAULT NULL COMMENT '评论的游戏ID（在游戏页面评论则有值）',
  `post_id` int DEFAULT NULL COMMENT '评论的帖子ID（在帖子里回复则有值）',
  `content` text NOT NULL COMMENT '评论正文内容',
  `rating` tinyint DEFAULT NULL COMMENT '⭐新增：打分(1-5分，仅当评论游戏时有值)',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '评论时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1855041539 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='评论与打分表';

-- ----------------------------
-- Records of comments
-- ----------------------------
INSERT INTO `comments` VALUES ('1', '1', '1', null, '这个游戏太震撼了，画质无敌，强推！', '5', '2026-05-02 12:26:14');
INSERT INTO `comments` VALUES ('2', '3', '1', null, '一般般吧兄弟', '1', '2026-05-02 12:47:25');
INSERT INTO `comments` VALUES ('3', '1', '1', null, '差评', '1', '2026-05-02 12:50:42');
INSERT INTO `comments` VALUES ('4', '3', '1', null, '好玩啊', '5', '2026-05-02 12:54:21');
INSERT INTO `comments` VALUES ('5', '3', '1', null, '好玩', '5', '2026-05-02 13:00:21');
INSERT INTO `comments` VALUES ('6', '3', '1', null, '好玩！！！', '5', '2026-05-02 18:10:00');
INSERT INTO `comments` VALUES ('7', '3', '1', null, '确实不错', '5', '2026-05-02 18:14:03');
INSERT INTO `comments` VALUES ('9', '5', '4', null, '我觉得还可以吧', '5', '2026-05-03 09:45:46');
INSERT INTO `comments` VALUES ('10', '5', null, '3', 'nb\n', '0', '2026-05-03 11:31:12');
INSERT INTO `comments` VALUES ('11', '5', null, '3', '去11', '0', '2026-05-03 11:31:44');

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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='游戏收藏表';

-- ----------------------------
-- Records of favorites
-- ----------------------------
INSERT INTO `favorites` VALUES ('7', '5', '4', '2026-05-03 11:31:37');
INSERT INTO `favorites` VALUES ('8', '6', '4', '2026-05-06 10:06:30');
INSERT INTO `favorites` VALUES ('9', '207', '106', '2026-05-12 18:15:29');

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
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='游戏信息表';

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
INSERT INTO `games` VALUES ('16', '17', null, '代号：史诗大作 V11', '这是一跨耗时多年研发的现象级游戏系列第 11 部，画质精美，玩法丰富，不容错过！', null, null, '4.92', '2026-05-03 19:40:32', '1');
INSERT INTO `games` VALUES ('17', '18', null, '代号：史诗大作 V12', '这是一跨耗时多年研发的现象级游戏系列第 12 部，画质精美，玩法丰富，不容错过！', null, null, '4.64', '2026-05-03 19:40:32', '1');
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
-- Table structure for `post_likes`
-- ----------------------------
DROP TABLE IF EXISTS `post_likes`;
CREATE TABLE `post_likes` (
  `user_id` int NOT NULL,
  `post_id` int NOT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`,`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of post_likes
-- ----------------------------
INSERT INTO `post_likes` VALUES ('5', '3', '2026-05-03 11:31:54');
INSERT INTO `post_likes` VALUES ('207', '7', '2026-05-12 18:18:20');
INSERT INTO `post_likes` VALUES ('207', '51', '2026-05-12 18:18:48');

-- ----------------------------
-- Table structure for `users`
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '瀵嗙爜',
  `nickname` varchar(50) NOT NULL COMMENT '昵称',
  `avatar` varchar(255) DEFAULT '' COMMENT '头像URL',
  `role` tinyint NOT NULL DEFAULT '0' COMMENT '角色：0-普通用户, 1-游戏作者, 2-超级管理员',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=214 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户表';

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('1', 'zhangsan', '111111', '张三', 'https://example.com/avatar.png', '1');
INSERT INTO `users` VALUES ('2', '李四', '111111', 'ls', null, '0');
INSERT INTO `users` VALUES ('3', 'player1', '123', '一号玩家pro', null, '0');
INSERT INTO `users` VALUES ('4', '2220617749', '123456', 'Rlx', '', '2');
INSERT INTO `users` VALUES ('5', '222', '123456', 'ww', null, '0');
INSERT INTO `users` VALUES ('6', 'kfz', '123456', '开发者', null, '1');
INSERT INTO `users` VALUES ('7', 'dev_mock_1', '123456', '独立工作室_1', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('8', 'dev_mock_2', '123456', '独立工作室_2', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('9', 'dev_mock_3', '123456', '独立工作室_3', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('10', 'dev_mock_4', '123456', '独立工作室_4', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('11', 'dev_mock_5', '123456', '独立工作室_5', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('12', 'dev_mock_6', '123456', '独立工作室_6', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('13', 'dev_mock_7', '123456', '独立工作室_7', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('14', 'dev_mock_8', '123456', '独立工作室_8', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('15', 'dev_mock_9', '123456', '独立工作室_9', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('16', 'dev_mock_10', '123456', '独立工作室_10', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('17', 'dev_mock_11', '123456', '独立工作室_11', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('18', 'dev_mock_12', '123456', '独立工作室_12', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('19', 'dev_mock_13', '123456', '独立工作室_13', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('20', 'dev_mock_14', '123456', '独立工作室_14', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('21', 'dev_mock_15', '123456', '独立工作室_15', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('22', 'dev_mock_16', '123456', '独立工作室_16', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('23', 'dev_mock_17', '123456', '独立工作室_17', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('24', 'dev_mock_18', '123456', '独立工作室_18', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('25', 'dev_mock_19', '123456', '独立工作室_19', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('26', 'dev_mock_20', '123456', '独立工作室_20', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('27', 'dev_mock_21', '123456', '独立工作室_21', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('28', 'dev_mock_22', '123456', '独立工作室_22', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('29', 'dev_mock_23', '123456', '独立工作室_23', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('30', 'dev_mock_24', '123456', '独立工作室_24', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('31', 'dev_mock_25', '123456', '独立工作室_25', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('32', 'dev_mock_26', '123456', '独立工作室_26', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('33', 'dev_mock_27', '123456', '独立工作室_27', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('34', 'dev_mock_28', '123456', '独立工作室_28', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('35', 'dev_mock_29', '123456', '独立工作室_29', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('36', 'dev_mock_30', '123456', '独立工作室_30', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('37', 'dev_mock_31', '123456', '独立工作室_31', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('38', 'dev_mock_32', '123456', '独立工作室_32', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('39', 'dev_mock_33', '123456', '独立工作室_33', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('40', 'dev_mock_34', '123456', '独立工作室_34', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('41', 'dev_mock_35', '123456', '独立工作室_35', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('42', 'dev_mock_36', '123456', '独立工作室_36', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('43', 'dev_mock_37', '123456', '独立工作室_37', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('44', 'dev_mock_38', '123456', '独立工作室_38', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('45', 'dev_mock_39', '123456', '独立工作室_39', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('46', 'dev_mock_40', '123456', '独立工作室_40', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('47', 'dev_mock_41', '123456', '独立工作室_41', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('48', 'dev_mock_42', '123456', '独立工作室_42', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('49', 'dev_mock_43', '123456', '独立工作室_43', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('50', 'dev_mock_44', '123456', '独立工作室_44', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('51', 'dev_mock_45', '123456', '独立工作室_45', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('52', 'dev_mock_46', '123456', '独立工作室_46', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('53', 'dev_mock_47', '123456', '独立工作室_47', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('54', 'dev_mock_48', '123456', '独立工作室_48', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('55', 'dev_mock_49', '123456', '独立工作室_49', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('56', 'dev_mock_50', '123456', '独立工作室_50', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('57', 'dev_mock_51', '123456', '独立工作室_51', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('58', 'dev_mock_52', '123456', '独立工作室_52', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('59', 'dev_mock_53', '123456', '独立工作室_53', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('60', 'dev_mock_54', '123456', '独立工作室_54', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('61', 'dev_mock_55', '123456', '独立工作室_55', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('62', 'dev_mock_56', '123456', '独立工作室_56', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('63', 'dev_mock_57', '123456', '独立工作室_57', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('64', 'dev_mock_58', '123456', '独立工作室_58', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('65', 'dev_mock_59', '123456', '独立工作室_59', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('66', 'dev_mock_60', '123456', '独立工作室_60', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('67', 'dev_mock_61', '123456', '独立工作室_61', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('68', 'dev_mock_62', '123456', '独立工作室_62', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('69', 'dev_mock_63', '123456', '独立工作室_63', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('70', 'dev_mock_64', '123456', '独立工作室_64', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('71', 'dev_mock_65', '123456', '独立工作室_65', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('72', 'dev_mock_66', '123456', '独立工作室_66', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('73', 'dev_mock_67', '123456', '独立工作室_67', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('74', 'dev_mock_68', '123456', '独立工作室_68', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('75', 'dev_mock_69', '123456', '独立工作室_69', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('76', 'dev_mock_70', '123456', '独立工作室_70', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('77', 'dev_mock_71', '123456', '独立工作室_71', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('78', 'dev_mock_72', '123456', '独立工作室_72', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('79', 'dev_mock_73', '123456', '独立工作室_73', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('80', 'dev_mock_74', '123456', '独立工作室_74', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('81', 'dev_mock_75', '123456', '独立工作室_75', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('82', 'dev_mock_76', '123456', '独立工作室_76', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('83', 'dev_mock_77', '123456', '独立工作室_77', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('84', 'dev_mock_78', '123456', '独立工作室_78', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('85', 'dev_mock_79', '123456', '独立工作室_79', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('86', 'dev_mock_80', '123456', '独立工作室_80', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('87', 'dev_mock_81', '123456', '独立工作室_81', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('88', 'dev_mock_82', '123456', '独立工作室_82', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('89', 'dev_mock_83', '123456', '独立工作室_83', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('90', 'dev_mock_84', '123456', '独立工作室_84', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('91', 'dev_mock_85', '123456', '独立工作室_85', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('92', 'dev_mock_86', '123456', '独立工作室_86', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('93', 'dev_mock_87', '123456', '独立工作室_87', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('94', 'dev_mock_88', '123456', '独立工作室_88', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('95', 'dev_mock_89', '123456', '独立工作室_89', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('96', 'dev_mock_90', '123456', '独立工作室_90', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('97', 'dev_mock_91', '123456', '独立工作室_91', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('98', 'dev_mock_92', '123456', '独立工作室_92', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('99', 'dev_mock_93', '123456', '独立工作室_93', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('100', 'dev_mock_94', '123456', '独立工作室_94', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('101', 'dev_mock_95', '123456', '独立工作室_95', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('102', 'dev_mock_96', '123456', '独立工作室_96', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('103', 'dev_mock_97', '123456', '独立工作室_97', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('104', 'dev_mock_98', '123456', '独立工作室_98', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('105', 'dev_mock_99', '123456', '独立工作室_99', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('106', 'dev_mock_100', '123456', '独立工作室_100', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', '1');
INSERT INTO `users` VALUES ('107', 'player_mock_1', '123456', '热心玩家_1', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('108', 'player_mock_2', '123456', '热心玩家_2', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('109', 'player_mock_3', '123456', '热心玩家_3', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('110', 'player_mock_4', '123456', '热心玩家_4', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('111', 'player_mock_5', '123456', '热心玩家_5', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('112', 'player_mock_6', '123456', '热心玩家_6', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('113', 'player_mock_7', '123456', '热心玩家_7', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('114', 'player_mock_8', '123456', '热心玩家_8', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('115', 'player_mock_9', '123456', '热心玩家_9', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('116', 'player_mock_10', '123456', '热心玩家_10', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('117', 'player_mock_11', '123456', '热心玩家_11', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('118', 'player_mock_12', '123456', '热心玩家_12', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('119', 'player_mock_13', '123456', '热心玩家_13', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('120', 'player_mock_14', '123456', '热心玩家_14', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('121', 'player_mock_15', '123456', '热心玩家_15', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('122', 'player_mock_16', '123456', '热心玩家_16', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('123', 'player_mock_17', '123456', '热心玩家_17', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('124', 'player_mock_18', '123456', '热心玩家_18', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('125', 'player_mock_19', '123456', '热心玩家_19', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('126', 'player_mock_20', '123456', '热心玩家_20', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('127', 'player_mock_21', '123456', '热心玩家_21', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('128', 'player_mock_22', '123456', '热心玩家_22', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('129', 'player_mock_23', '123456', '热心玩家_23', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('130', 'player_mock_24', '123456', '热心玩家_24', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('131', 'player_mock_25', '123456', '热心玩家_25', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('132', 'player_mock_26', '123456', '热心玩家_26', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('133', 'player_mock_27', '123456', '热心玩家_27', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('134', 'player_mock_28', '123456', '热心玩家_28', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('135', 'player_mock_29', '123456', '热心玩家_29', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('136', 'player_mock_30', '123456', '热心玩家_30', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('137', 'player_mock_31', '123456', '热心玩家_31', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('138', 'player_mock_32', '123456', '热心玩家_32', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('139', 'player_mock_33', '123456', '热心玩家_33', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('140', 'player_mock_34', '123456', '热心玩家_34', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('141', 'player_mock_35', '123456', '热心玩家_35', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('142', 'player_mock_36', '123456', '热心玩家_36', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('143', 'player_mock_37', '123456', '热心玩家_37', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('144', 'player_mock_38', '123456', '热心玩家_38', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('145', 'player_mock_39', '123456', '热心玩家_39', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('146', 'player_mock_40', '123456', '热心玩家_40', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('147', 'player_mock_41', '123456', '热心玩家_41', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('148', 'player_mock_42', '123456', '热心玩家_42', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('149', 'player_mock_43', '123456', '热心玩家_43', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('150', 'player_mock_44', '123456', '热心玩家_44', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('151', 'player_mock_45', '123456', '热心玩家_45', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('152', 'player_mock_46', '123456', '热心玩家_46', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('153', 'player_mock_47', '123456', '热心玩家_47', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('154', 'player_mock_48', '123456', '热心玩家_48', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('155', 'player_mock_49', '123456', '热心玩家_49', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('156', 'player_mock_50', '123456', '热心玩家_50', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('157', 'player_mock_51', '123456', '热心玩家_51', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('158', 'player_mock_52', '123456', '热心玩家_52', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('159', 'player_mock_53', '123456', '热心玩家_53', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('160', 'player_mock_54', '123456', '热心玩家_54', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('161', 'player_mock_55', '123456', '热心玩家_55', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('162', 'player_mock_56', '123456', '热心玩家_56', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('163', 'player_mock_57', '123456', '热心玩家_57', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('164', 'player_mock_58', '123456', '热心玩家_58', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('165', 'player_mock_59', '123456', '热心玩家_59', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('166', 'player_mock_60', '123456', '热心玩家_60', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('167', 'player_mock_61', '123456', '热心玩家_61', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('168', 'player_mock_62', '123456', '热心玩家_62', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('169', 'player_mock_63', '123456', '热心玩家_63', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('170', 'player_mock_64', '123456', '热心玩家_64', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('171', 'player_mock_65', '123456', '热心玩家_65', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('172', 'player_mock_66', '123456', '热心玩家_66', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('173', 'player_mock_67', '123456', '热心玩家_67', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('174', 'player_mock_68', '123456', '热心玩家_68', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('175', 'player_mock_69', '123456', '热心玩家_69', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('176', 'player_mock_70', '123456', '热心玩家_70', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('177', 'player_mock_71', '123456', '热心玩家_71', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('178', 'player_mock_72', '123456', '热心玩家_72', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('179', 'player_mock_73', '123456', '热心玩家_73', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('180', 'player_mock_74', '123456', '热心玩家_74', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('181', 'player_mock_75', '123456', '热心玩家_75', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('182', 'player_mock_76', '123456', '热心玩家_76', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('183', 'player_mock_77', '123456', '热心玩家_77', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('184', 'player_mock_78', '123456', '热心玩家_78', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('185', 'player_mock_79', '123456', '热心玩家_79', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('186', 'player_mock_80', '123456', '热心玩家_80', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('187', 'player_mock_81', '123456', '热心玩家_81', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('188', 'player_mock_82', '123456', '热心玩家_82', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('189', 'player_mock_83', '123456', '热心玩家_83', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('190', 'player_mock_84', '123456', '热心玩家_84', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('191', 'player_mock_85', '123456', '热心玩家_85', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('192', 'player_mock_86', '123456', '热心玩家_86', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('193', 'player_mock_87', '123456', '热心玩家_87', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('194', 'player_mock_88', '123456', '热心玩家_88', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('195', 'player_mock_89', '123456', '热心玩家_89', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('196', 'player_mock_90', '123456', '热心玩家_90', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('197', 'player_mock_91', '123456', '热心玩家_91', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('198', 'player_mock_92', '123456', '热心玩家_92', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('199', 'player_mock_93', '123456', '热心玩家_93', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('200', 'player_mock_94', '123456', '热心玩家_94', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('201', 'player_mock_95', '123456', '热心玩家_95', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('202', 'player_mock_96', '123456', '热心玩家_96', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('203', 'player_mock_97', '123456', '热心玩家_97', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('204', 'player_mock_98', '123456', '热心玩家_98', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('205', 'player_mock_99', '123456', '热心玩家_99', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('206', 'player_mock_100', '123456', '热心玩家_100', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '0');
INSERT INTO `users` VALUES ('207', 'Rlx', '$2a$10$2aCUghsKpJAQsTa9Ln0GHO1RfFC8YSsso0IgHToboxV.MTWLVAsZC', 'rl', null, '2');
INSERT INTO `users` VALUES ('208', 'test4', '$2a$10$J9mz4RtaBWG/iRFUpakNFeuuqLlnGZ3OhwqbnpEeylJsoch/A3EA2', '444', '', '0');
INSERT INTO `users` VALUES ('209', 'test5', '$2a$10$rA54/ffBjxdwpLQVg4X/aO3iscx2MSyPgBNCrFhUWhAGX4ZD5.ula', '555', '', '0');
INSERT INTO `users` VALUES ('210', 'test6', '$2a$10$zY9iMEZ3U5QVWLR0lZsJDenu7uDTLysLMNURNNtU/LTpOo0vNZu9.', '666', '', '0');
INSERT INTO `users` VALUES ('211', 'text777', '$2a$10$3dFG35TZGwQ5llifojq9t.X5lgy9OqjtmO4jgtQWHDsPLUILbdDxa', '777', '', '0');
INSERT INTO `users` VALUES ('212', '123456', '$2a$10$gX3072gFisNVNAUfsPApsOKWgbhk0nBe1u/M.qfeAXwAf31rWScla', '1', '', '0');
INSERT INTO `users` VALUES ('213', 'r2220617749', '$2a$10$Xzrx0WG23XXQ4qt4yxDV.urbaktrZjREwVGCREO8ihuMcJEsSj4qO', 'SuperAdmin', '', '2');
