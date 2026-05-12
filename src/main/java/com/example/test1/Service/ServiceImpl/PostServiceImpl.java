package com.example.test1.Service.ServiceImpl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.test1.Service.PostService;
import com.example.test1.entity.Post;
import com.example.test1.entity.User;
import com.example.test1.mapper.PostMapper;
import com.example.test1.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PostServiceImpl implements PostService {

    @Autowired
    private PostMapper postMapper;

    @Autowired
    private UserMapper userMapper; // ⭐️ 注入 UserMapper，用来查头像和昵称！

    // ==========================================
    // ⭐️ 核心工具方法：给帖子补全发帖人的头像和昵称
    // ==========================================
    private void fillUserInfo(Post post) {
        if (post != null && post.getUserId() != null) {
            User user = userMapper.selectById(post.getUserId());
            if (user != null) {
                post.setNickname(user.getNickname());
                post.setAvatar(user.getAvatar());
            }
        }
    }

    private void fillUserInfo(List<Post> posts) {
        if (posts != null) {
            for (Post post : posts) {
                fillUserInfo(post);
            }
        }
    }

    // ==========================================

    @Override
    public IPage<Post> getPostsByPage(int page, int size, String keyword) {
        Page<Post> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<Post> wrapper = new LambdaQueryWrapper<>();
        if (keyword != null && !keyword.isEmpty()) {
            wrapper.like(Post::getTitle, keyword).or().like(Post::getContent, keyword);
        }
        wrapper.orderByDesc(Post::getCreateTime);

        // 1. 先用 MP 分页查出纯净的帖子列表
        IPage<Post> postPage = postMapper.selectPage(pageParam, wrapper);

        // 2. ⭐️ 遍历当前页的数据，把所有头像和昵称补齐！
        fillUserInfo(postPage.getRecords());
        return postPage;
    }

    @Override
    public List<Post> getAllPosts(String keyword) {
        LambdaQueryWrapper<Post> wrapper = new LambdaQueryWrapper<>();
        if (keyword != null && !keyword.isEmpty()) {
            wrapper.like(Post::getTitle, keyword).or().like(Post::getContent, keyword);
        }
        wrapper.orderByDesc(Post::getCreateTime);
        List<Post> posts = postMapper.selectList(wrapper);
        fillUserInfo(posts); // ⭐️ 补全数据
        return posts;
    }

    @Override
    public void addPost(Post post) {
        if(post.getViewCount() == null) post.setViewCount(0);
        if(post.getLikeCount() == null) post.setLikeCount(0);
        postMapper.insert(post);
    }

    @Override
    public Post getPostById(Integer id) {
        incrementViewCount(id); // 浏览量 +1
        Post post = postMapper.selectById(id);
        fillUserInfo(post); // ⭐️ 补全单条帖子的数据
        return post;
    }

    @Override
    public List<Post> getPostsByUserId(Integer userId, String keyword) {
        LambdaQueryWrapper<Post> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Post::getUserId, userId);
        if (keyword != null && !keyword.isEmpty()) {
            wrapper.and(w -> w.like(Post::getTitle, keyword).or().like(Post::getContent, keyword));
        }
        wrapper.orderByDesc(Post::getCreateTime);
        List<Post> posts = postMapper.selectList(wrapper);
        fillUserInfo(posts); // ⭐️ 补全数据
        return posts;
    }

    @Override
    public void deletePost(Integer id, Integer userId) {
        LambdaQueryWrapper<Post> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Post::getId, id).eq(Post::getUserId, userId);
        postMapper.delete(wrapper);
    }

    @Override
    public void deletePostByAdmin(Integer id) {
        postMapper.deleteById(id);
    }

    // ================= 自增自减方法 =================
    @Override
    public void incrementViewCount(Integer id) {
        UpdateWrapper<Post> wrapper = new UpdateWrapper<>();
        wrapper.eq("id", id).setSql("view_count = view_count + 1");
        postMapper.update(null, wrapper);
    }

    @Override
    public void incrementLikeCount(Integer id) {
        UpdateWrapper<Post> wrapper = new UpdateWrapper<>();
        wrapper.eq("id", id).setSql("like_count = like_count + 1");
        postMapper.update(null, wrapper);
    }

    @Override
    public void decrementLikeCount(Integer id) {
        UpdateWrapper<Post> wrapper = new UpdateWrapper<>();
        wrapper.eq("id", id).setSql("like_count = like_count - 1");
        postMapper.update(null, wrapper);
    }
}