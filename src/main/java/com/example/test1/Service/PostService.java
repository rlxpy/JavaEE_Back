package com.example.test1.Service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.example.test1.entity.Post;
import java.util.List;

public interface PostService {
    List<Post> getAllPosts(String keyword);
    void addPost(Post post);
    Post getPostById(int id);
    IPage<Post> getPostsByUserId(int page, int size,Integer userId, String keyword);
    void deletePost(int id, int userId);
    void deletePostByAdmin(int id);

}