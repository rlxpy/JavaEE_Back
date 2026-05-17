package com.example.test1.task;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.example.test1.entity.Post;
import com.example.test1.entity.PostLike;
import com.example.test1.mapper.PostLikeMapper;
import com.example.test1.mapper.PostMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Component // 交给 Spring 容器管理
public class PostSyncTask {

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @Autowired
    private PostMapper postMapper;

    @Autowired
    private PostLikeMapper postLikeMapper;

    @Autowired
    private com.example.test1.mapper.CommentMapper commentMapper;

    @Autowired
    private com.example.test1.mapper.CommentLikeMapper commentLikeMapper;

    @Scheduled(cron = "0/30 * * * * ?")
    @Transactional(rollbackFor = Exception.class)
    public void syncPostDataToMySQL() {
        List<String> postIdsList = stringRedisTemplate.opsForSet().pop("post:need_sync", 1000);

        if (postIdsList == null || postIdsList.isEmpty()) {
            return;
        }

        System.out.println("\n🚚 [定时任务启动] 正在将 Redis 数据【增量】落盘至 MySQL...");

        String trendingZSetKey = "post:trending:";
        Set<String> postIds = new HashSet<>(postIdsList);

        if (postIds == null || postIds.isEmpty()) return;

        for (String postIdStr : postIds) {
            Integer postId = Integer.parseInt(postIdStr);
            String likeSetKey = "post:like:" + postId;

            // ==========================================
            // 步骤 1：同步【主表】的总数与热度（保持不变）
            // ==========================================
            Double hotScore = stringRedisTemplate.opsForZSet().score(trendingZSetKey, postIdStr);
            Long likeCount = stringRedisTemplate.opsForSet().size(likeSetKey);

            Post updatePost = new Post();
            updatePost.setId(postId);
            if (hotScore != null) updatePost.setHotScore(hotScore);
            if (likeCount != null) updatePost.setLikeCount(likeCount.intValue());
            postMapper.updateById(updatePost);

            // ==========================================
            // 步骤 2：同步【明细表】的具体点赞人（⭐️ 升级为精准增量同步）
            // ==========================================

            // ① 获取 Redis 中的最新点赞集合 (也就是绝对正确的名单)
            Set<String> redisUserIdsStr = stringRedisTemplate.opsForSet().members(likeSetKey);
            Set<Integer> redisUserIds = new HashSet<>();
            if (redisUserIdsStr != null) {
                // 把 String 类型的 ID 统统转成 Integer 存入集合
                for (String s : redisUserIdsStr) redisUserIds.add(Integer.parseInt(s));
            }

            // ② 获取 MySQL 中的旧点赞集合 (上一次同步时的名单)
            LambdaQueryWrapper<PostLike> queryWrapper = new LambdaQueryWrapper<>();
            queryWrapper.eq(PostLike::getPostId, postId);
            List<PostLike> mysqlLikes = postLikeMapper.selectList(queryWrapper);
            Set<Integer> mysqlUserIds = new HashSet<>();
            for (PostLike like : mysqlLikes) {
                mysqlUserIds.add(like.getUserId());
            }

            // ③ ⭐️ 算法核心：计算两个集合的差集 (Diff)
            // Java 集合自带的 removeAll 方法，就是数学里的“减法”

            // 需要新增的人 = Redis 最新名单 减去 MySQL 旧名单
            Set<Integer> toAdd = new HashSet<>(redisUserIds);
            toAdd.removeAll(mysqlUserIds); // 剔除掉 MySQL 里已经存在的人，剩下的就是该新增的！

            // 需要删除的人 = MySQL 旧名单 减去 Redis 最新名单
            Set<Integer> toDelete = new HashSet<>(mysqlUserIds);
            toDelete.removeAll(redisUserIds); // 剔除掉 Redis 里还在的人，剩下的就是偷偷取消点赞的！

            // ④ ⭐️ 精准执行数据库操作！只动该动的数据！

            // 执行新增插入
            for (Integer uid : toAdd) {
                PostLike newLike = new PostLike();
                newLike.setPostId(postId);
                newLike.setUserId(uid);
                postLikeMapper.insert(newLike);
                System.out.println("   [增量同步] 新增点赞记录: 用户 " + uid);
            }

            // 执行删除清理
            for (Integer uid : toDelete) {
                LambdaQueryWrapper<PostLike> delWrapper = new LambdaQueryWrapper<>();
                delWrapper.eq(PostLike::getPostId, postId).eq(PostLike::getUserId, uid);
                postLikeMapper.delete(delWrapper);
                System.out.println("   [增量同步] 清理已取消的点赞: 用户 " + uid);
            }
        }
        System.out.println("✅ [定时任务完成] " + postIds.size() + " 篇帖子的数据已增量同步！\n");
    }

    // 👇 新增：评论点赞的定时同步任务
    @Scheduled(cron = "0/30 * * * * ?")
    @Transactional(rollbackFor = Exception.class)
    public void syncCommentDataToMySQL() {
        List<String> commentIdsList = stringRedisTemplate.opsForSet().pop("comment:need_sync", 1000);
        if (commentIdsList == null || commentIdsList.isEmpty()) return;

        Set<String> commentIds = new HashSet<>(commentIdsList);
        for (String commentIdStr : commentIds) {
            Integer commentId = Integer.parseInt(commentIdStr);
            String likeSetKey = "comment:like:" + commentId;

            // 1. 同步评论的【总点赞数】
            Long likeCount = stringRedisTemplate.opsForSet().size(likeSetKey);
            com.example.test1.entity.Comment updateComment = new com.example.test1.entity.Comment();
            updateComment.setId(commentId);
            if (likeCount != null) updateComment.setLikeCount(likeCount.intValue()); // 注意实体类里叫 like_count 还是 likeCount
            commentMapper.updateById(updateComment);

            // 2. 增量同步【明细表】(差集算法)
            Set<String> redisUserIdsStr = stringRedisTemplate.opsForSet().members(likeSetKey);
            Set<Integer> redisUserIds = new HashSet<>();
            if (redisUserIdsStr != null) {
                for (String s : redisUserIdsStr) redisUserIds.add(Integer.parseInt(s));
            }

            LambdaQueryWrapper<com.example.test1.entity.CommentLike> queryWrapper = new LambdaQueryWrapper<>();
            queryWrapper.eq(com.example.test1.entity.CommentLike::getCommentId, commentId);
            List<com.example.test1.entity.CommentLike> mysqlLikes = commentLikeMapper.selectList(queryWrapper);
            Set<Integer> mysqlUserIds = new HashSet<>();
            for (com.example.test1.entity.CommentLike like : mysqlLikes) {
                mysqlUserIds.add(like.getUserId());
            }

            Set<Integer> toAdd = new HashSet<>(redisUserIds);
            toAdd.removeAll(mysqlUserIds);

            Set<Integer> toDelete = new HashSet<>(mysqlUserIds);
            toDelete.removeAll(redisUserIds);

            for (Integer uid : toAdd) {
                com.example.test1.entity.CommentLike newLike = new com.example.test1.entity.CommentLike();
                newLike.setCommentId(commentId);
                newLike.setUserId(uid);
                commentLikeMapper.insert(newLike);
            }

            for (Integer uid : toDelete) {
                LambdaQueryWrapper<com.example.test1.entity.CommentLike> delWrapper = new LambdaQueryWrapper<>();
                delWrapper.eq(com.example.test1.entity.CommentLike::getCommentId, commentId)
                        .eq(com.example.test1.entity.CommentLike::getUserId, uid);
                commentLikeMapper.delete(delWrapper);
            }
        }
        System.out.println("✅ [定时任务] " + commentIds.size() + " 条评论的点赞已同步！");
    }
}