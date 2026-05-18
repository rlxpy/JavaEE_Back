# 🎮 游戏交流与开发平台 - 启动指南

## 第一步：准备数据库
1. 在你本地的 MySQL 中新建一个数据库（注意字符集选 utf8mb4）。
2. 把后端项目根目录下的 `javaee.sql` 拖进 Navicat 里运行，导入表结构和基础数据。
3. ⚠️ **最重要的一步**：打开后端 `src/main/resources/application.properties` 文件，把 `spring.datasource.password` 改成你本机的 MySQL 密码！

## 第二步：启动后端 (Spring Boot)
1. 用 IDEA 打开后端文件夹。
2. 等待 Maven 自动下载依赖（如果没有自动下载，点一下右侧的刷新按钮）。
3. 找到带 `main` 方法的启动类，点击绿色三角启动（默认运行在 8080 端口）。

## 第三步：启动前端 (Vue 3 + Vite)
1. 用 WebStorm 或 VS Code 打开前端文件夹。
2. 打开终端，运行 `npm install` 下载所有前端依赖（之前装过的 ECharts, Element Plus 都在这里面了）。
3. 运行 `npm run dev` 启动前端。
4. 在浏览器访问 `http://localhost:5173`。