package com.example.test1.Controller;

import com.example.test1.entity.GameCategory;
import com.example.test1.mapper.GameCategoryMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/gameCategory")
@CrossOrigin
public class GameCategoryController {

    @Autowired
    private GameCategoryMapper gameCategoryMapper;

    @GetMapping("/list")
    public Map<String, Object> getAllCategories() {
        Map<String, Object> result = new HashMap<>();
        List<GameCategory> list = gameCategoryMapper.selectList(null);
        result.put("code", 200);
        result.put("data", list);
        return result;
    }
}