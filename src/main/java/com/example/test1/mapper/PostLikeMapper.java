package com.example.test1.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.test1.entity.Post;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

// PostLikeMapper.java
@Mapper
public interface PostLikeMapper extends BaseMapper<Post> {}
