package com.example.test1.Service.ServiceImpl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.test1.Service.PostService;
import com.example.test1.entity.Post;
import com.example.test1.mapper.PostMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PostServiceImpl implements PostService {

    @Autowired
    private PostMapper postMapper;


    @Override
    public List<Post> getAllPosts(String keyword) {
        return postMapper.getAllPosts(keyword);
    }

    @Override
    public void addPost(Post post) {
        postMapper.insertPost(post);
    }

    @Override
    public Post getPostById(int id) {
        // 每次有人点进帖子详情，浏览量自动 +1
        postMapper.incrementViewCount(id);
        return postMapper.getPostById(id);
    }

    @Override
    public IPage<Post> getPostsByPage(int page, int size, String keyword) {
        Page<Post> pageParam = new Page<>(page, size); // 创建分页对象
        LambdaQueryWrapper<Post> wrapper = new LambdaQueryWrapper<>();

        if (keyword != null && !keyword.isEmpty()) {
            // 比如按标题搜索
            wrapper.like(Post::getTitle, keyword);
        }

        return postMapper.selectPage(pageParam, wrapper); // ⭐️ 原生分页魔法！
    }

    @Override
    public void deletePost(int id, int userId) {}

    @Override
    public void deletePostByAdmin(int id) {
        postMapper.deletePostByAdmin(id);
    }
}