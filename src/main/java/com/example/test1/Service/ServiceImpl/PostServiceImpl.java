package com.example.test1.Service.ServiceImpl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.test1.Service.PostService;
import com.example.test1.entity.*;
import com.example.test1.mapper.*;
import com.example.test1.utils.UserContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

@Service
public class PostServiceImpl implements PostService {

    @Autowired
    private PostMapper postMapper;

    @Autowired
    private PostContentMapper postContentMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @Autowired
    private UserSubscribedGameMapper userSubscribedGameMapper;

    @Autowired
    private PostLikeMapper postLikeMapper; // ⭐️ 新增注入：为了在缓存丢失时去查真实点赞名单

    @Autowired
    private GameMapper gameMapper;

    // ==========================================
    // ⭐️ 核心工具方法 1：给帖子补全发帖人的头像和昵称
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
    // 🧠 核心工具方法 2：实时缓存懒加载引擎 (Cache-Aside)
    // ==========================================
    private void fillRealTimeStats(Post post) {
        if (post == null) return;

        Integer postId = post.getId();
        String loadedFlagKey = "post:cache_loaded:" + postId;
        String likeSetKey = "post:like:" + postId;
        String trendingZSetKey = "post:trending:";

        // 1. 如果缓存是热乎的（标记键存在），直接从 Redis 秒读，覆盖 MySQL 的旧数据
        if (Boolean.TRUE.equals(stringRedisTemplate.hasKey(loadedFlagKey))) {
            Double hotScore = stringRedisTemplate.opsForZSet().score(trendingZSetKey, postId.toString());
            Long likeCount = stringRedisTemplate.opsForSet().size(likeSetKey);
            if (hotScore != null) post.setHotScore(hotScore);
            if (likeCount != null) post.setLikeCount(likeCount.intValue());
            return; // 搞定，直接返回
        }

        // 2. ⚠️ 缓存未命中（过期或被清空了）！执行降级策略：去 MySQL 捞数据并重建缓存！
        System.out.println("⚠️ 列表/详情查询时缓存未命中，正在从 MySQL 预热帖子 " + postId + " 的数据到 Redis...");

        Double dbHotScore = post.getHotScore() != null ? post.getHotScore() : 0.0;
        stringRedisTemplate.opsForZSet().add(trendingZSetKey, postId.toString(), dbHotScore);

        LambdaQueryWrapper<PostLike> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(PostLike::getPostId, postId);
        List<PostLike> likes = postLikeMapper.selectList(wrapper);

        if (!likes.isEmpty()) {
            String[] userIds = likes.stream()
                    .map(like -> like.getUserId().toString())
                    .toArray(String[]::new);
            stringRedisTemplate.opsForSet().add(likeSetKey, userIds);
            post.setLikeCount(likes.size()); // 以真实查出来的点赞数为准
        } else {
            post.setLikeCount(0);
        }

        // 重建完毕，赋予 2 小时生命周期
        stringRedisTemplate.opsForValue().set(loadedFlagKey, "1", 2, TimeUnit.HOURS);
        stringRedisTemplate.expire(likeSetKey, 2, TimeUnit.HOURS);
    }

    // ==========================================
    // 接口实现
    // ==========================================

    @Override
    public IPage<Post> getPostsByPage(int page, int size, String keyword, Integer categoryId, Integer gameId, Boolean isFollowFeed, String sortBy) {
        Page<Post> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<Post> wrapper = new LambdaQueryWrapper<>();

        if (keyword != null && !keyword.isEmpty()) {
            wrapper.and(w -> w
                    .like(Post::getTitle, keyword)
                    .or().inSql(Post::getId, "SELECT post_id FROM post_content WHERE content LIKE '%" + keyword + "%'")
            );
        }

        if (categoryId != null) wrapper.eq(Post::getCategoryId, categoryId);
        if (gameId != null) wrapper.eq(Post::getGameId, gameId);

        if (isFollowFeed != null && isFollowFeed) {
            Integer userId = UserContext.getUserId();
            if (userId != null) {
                LambdaQueryWrapper<UserSubscribedGame> subWrapper = new LambdaQueryWrapper<>();
                subWrapper.eq(UserSubscribedGame::getUserId, userId);
                List<UserSubscribedGame> subGames = userSubscribedGameMapper.selectList(subWrapper);

                if (subGames != null && !subGames.isEmpty()) {
                    List<Integer> subscribedGameIds = subGames.stream()
                            .map(UserSubscribedGame::getGameId)
                            .collect(Collectors.toList());
                    wrapper.in(Post::getGameId, subscribedGameIds);
                } else {
                    wrapper.eq(Post::getId, -1);
                }
            }
        }

        // 5. ⭐️ 核心魔法：动态排序引擎
        if ("hot".equals(sortBy)) {
            // 如果前端要求看热门，就按热度分降序！
            wrapper.orderByDesc(Post::getHotScore);
        } else {
            // 否则默认按最新时间降序
            wrapper.orderByDesc(Post::getCreateTime);
        }

        IPage<Post> postPage = postMapper.selectPage(pageParam, wrapper);

        // ⭐️ 分页查出后，给每一篇帖子补全头像，并【注入实时热度和点赞】
        if (postPage.getRecords() != null) {
            for (Post post : postPage.getRecords()) {
                fillUserInfo(post);
                fillRealTimeStats(post); // 🚀 列表页现在也绝对实时了！
            }
        }

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

        if (posts != null) {
            for (Post post : posts) {
                fillUserInfo(post);
                fillRealTimeStats(post); // 🚀
            }
        }
        return posts;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void addPost(Post post) {
        post.setViewCount(0);
        post.setLikeCount(0);
        post.setCommentCount(0);
        post.setCollectCount(0);
        post.setHotScore(0.0);

        postMapper.insert(post);

        if(post.getContent()!=null && !post.getContent().isEmpty()){
            PostContent postContent = new PostContent(post.getId(), post.getContent());
            postContentMapper.insert(postContent);
        }
    }

    @Override
    public Post getPostById(Integer id) {
        incrementViewCount(id);

        Post post = postMapper.selectById(id);
        if(post == null) return null;

        // ⭐️ 核心逻辑：如果帖子关联了游戏，把游戏名字查出来
        if (post.getGameId() != null) {
            Game game = gameMapper.selectById(post.getGameId());
            if (game != null) {
                post.setGameName(game.getGameName());
            }
        }

        PostContent postContent = postContentMapper.selectById(id);
        if(postContent != null) post.setContent(postContent.getContent());

        fillUserInfo(post);
        fillRealTimeStats(post);
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

        if (posts != null) {
            for (Post post : posts) {
                fillUserInfo(post);
                fillRealTimeStats(post); // 🚀 我的发帖列表也绝对实时了！
            }
        }
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