package com.example.test1.Controller;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/file")
@CrossOrigin
public class FileController {

    @PostMapping("/upload")
    public Map<String, Object> upload(@RequestParam("file") MultipartFile file) {
        Map<String, Object> result = new HashMap<>();

        if (file.isEmpty()) {
            result.put("code", 400);
            result.put("msg", "上传失败，文件为空");
            return result;
        }

        try {
            // 1. 获取原文件名，并提取后缀名 (比如 .jpg, .png)
            String originalFilename = file.getOriginalFilename();
            String extension = originalFilename.substring(originalFilename.lastIndexOf("."));

            // 2. 为了防止文件名重复覆盖，使用 UUID 生成唯一的随机文件名
            String newFileName = UUID.randomUUID().toString() + extension;

            // 3. 确定保存路径
            String path = System.getProperty("user.dir") + "/uploads/";
            File dest = new File(path + newFileName);

            // 4. 将前端传来的文件保存到目标硬盘路径
            file.transferTo(dest);

            // 5. 拼接出这个文件的网络访问 URL (注意这里的端口要和你的项目端口一致)
            String fileUrl = "http://localhost:8080/uploads/" + newFileName;

            result.put("code", 200);
            result.put("msg", "上传成功");
            result.put("data", fileUrl); // 把 URL 返回给前端

        } catch (IOException e) {
            result.put("code", 500);
            result.put("msg", "文件上传失败：" + e.getMessage());
        }

        return result;
    }
}