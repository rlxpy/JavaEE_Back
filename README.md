# 🎮 GASP (Game And Sharing Platform) - 游戏交流与分享平台

![Vue3](https://img.shields.io/badge/Vue.js-3.0-brightgreen)
![Spring Boot](https://img.shields.io/badge/SpringBoot-2.x-blue)
![MyBatis-Plus](https://img.shields.io/badge/MyBatis--Plus-Latest-red)
![License](https://img.shields.io/badge/License-MIT-green)

## 📖 项目简介
**GASP (Game And Sharing Platform)** 是一个专为游戏玩家与独立开发者打造的现代化交流枢纽。
在这里，玩家（冒险者）可以发现好玩的游戏、交流心得；开发者（造物主）可以发布自己的作品并获取真实反馈。项目采用前后端分离架构，拥有极致的现代化 SaaS 级 UI 交互与严密的账号安全体系。

## ✨ 核心特性
- 🛡️ **大厂级账号安全体系**：
  - 基于 `jBCrypt` 的密码加盐强加密。
  - 基于 `Redis` + `Spring Mail` 的邮件验证码双轨验证（防连点、防恶意刷接口）。
  - 支持忘记密码的邮件安全重置与强制下线机制。
- 🎨 **现代化无边界 UI**：
  - 采用 Vue 3 + Element Plus，深度定制毛玻璃（玻璃拟态）、悬浮卡片与流光按钮特效。
  - 支持复杂的 3D 翻转卡片登录注册无缝切换。
- 👥 **精细化权限流转 (RBAC)**：
  - 区分普通玩家（0）、开发者（1）与超级管理员（2），不同角色动态渲染专属后台控制面板。
- 🚀 **高性能数据交互**：
  - MyBatis-Plus 深度整合分页插件，实现多条件复杂查询与极速响应。

## 🛠️ 技术栈
### 💻 前端 (Frontend)
- **核心框架**: Vue 3 (Composition API)
- **UI 组件库**: Element Plus
- **路由控制**: Vue Router 4
- **网络请求**: Axios (深度封装拦截器与 Token 无感放行)
- **图标库**: @element-plus/icons-vue

### ⚙️ 后端 (Backend)
- **核心框架**: Spring Boot (JavaEE)
- **持久层**: MyBatis-Plus + MySQL 8.x
- **缓存与防刷**: Redis + StringRedisTemplate
- **安全认证**: JWT (JSON Web Token) 自定义拦截器
- **异步处理**: `@Async` 多线程邮件发送优化

## 🚀 快速启动 (Local Deployment)

### 1. 环境准备
请确保您的电脑上已安装以下环境：
- JDK 1.8 或 17+
- Node.js 16+
- MySQL 8.0+
- Redis (默认 6379 端口运行)

### 2. 数据库初始化
1. 在 MySQL 中新建数据库 `gasp_db` (字符集 `utf8mb4`)。
2. 找到后端项目 `sql/` 目录下的 `javaee.sql` 文件。
3. 将其导入到您的数据库中。

### 3. 后端启动
1. 使用 IDEA 打开 `JavaEE_Back` 项目。
2. 找到 `src/main/resources/application-example.properties` 文件，复制一份并重命名为 `application.properties`。
3. 在 `application.properties` 中填入您本人的 MySQL 密码与 QQ邮箱授权码。
4. 运行 `Test1Application.java` 启动后端服务（默认运行在 `8080` 端口）。

### 4. 前端启动
1. 打开终端，进入 `JavaEE_Front` 目录。
2. 安装依赖：
   ```bash
   npm install
3. 启动开发服务器：
   ```bash
   npm run dev
浏览器访问终端输出的本地地址（如 http://localhost:5173）即可体验！

🤝 贡献与参与
本项目为课堂演练与开源交流项目。欢迎提交 Pull Request 或 Issue 探讨优化方案！

📄 开源协议
本项目基于 MIT License 协议开源。
