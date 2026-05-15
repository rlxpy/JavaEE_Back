package com.example.test1.Service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.example.test1.entity.Post;
import java.util.List;

public interface PostService {
    // ⭐️ 增加 sortBy 参数
    IPage<Post> getPostsByPage(int page, int size, String keyword, Integer categoryId, Integer gameId, Boolean isFollowFeed, String sortBy);
    List<Post> getAllPosts(String keyword);
    void addPost(Post post);
    Post getPostById(Integer id);
    List<Post> getPostsByUserId(Integer userId, String keyword);
    void deletePost(Integer id, Integer userId);
    void deletePostByAdmin(Integer id);
    void incrementViewCount(Integer id);
    void incrementLikeCount(Integer id);
    void decrementLikeCount(Integer id);
}