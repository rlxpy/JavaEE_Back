package com.example.test1.Controller;

import com.example.test1.entity.Category;
import com.example.test1.mapper.CategoryMapper; // 记得新建一个空的 CategoryMapper 接口继承 BaseMapper
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/category")
@CrossOrigin
public class CategoryController {

    @Autowired
    private CategoryMapper categoryMapper;

    // 获取所有分区列表 (前端拿去渲染上方的 Tab 栏)
    @GetMapping("/list")
    public Map<String, Object> getCategoryList() {
        Map<String, Object> result = new HashMap<>();
        result.put("code", 200);
        result.put("data", categoryMapper.selectList(null));
        return result;
    }
}