package com.example.test1.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.test1.entity.GameCategory;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface GameCategoryMapper extends BaseMapper<GameCategory> {
}