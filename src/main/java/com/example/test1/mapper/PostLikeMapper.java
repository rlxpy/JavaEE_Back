package com.example.test1.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

// PostLikeMapper.java
@Mapper
public interface PostLikeMapper {
    Integer checkLike(@Param("userId") Integer userId, @Param("postId") Integer postId);
    void addLike(@Param("userId") Integer userId, @Param("postId") Integer postId);
    void removeLike(@Param("userId") Integer userId, @Param("postId") Integer postId);
}
