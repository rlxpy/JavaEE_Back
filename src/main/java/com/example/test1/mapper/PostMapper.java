package com.example.test1.mapper;

import com.example.test1.entity.Post;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface PostMapper {
    // 获取所有帖子（配合 PageHelper 使用）
    List<Post> getAllPosts(@Param("keyword") String keyword);

    // 发布新帖子
    int insertPost(Post post);

    Post getPostById(int id);

    void incrementViewCount(int id);

    void incrementLikeCount(int id);

    void decrementLikeCount(int id);

    List<Post> getPostsByUserId(@Param("userId") Integer userId, @Param("keyword") String keyword);

    void deletePost(int id, int userId);

    void deletePostByAdmin(int id);

}