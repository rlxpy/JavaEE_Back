package com.example.test1.entity;

import java.util.Date;

public class Student {
    // 新增主键id，对应数据库的id字段
    private Long id;
    private String name;
    private int age;
    // 新增时间字段（可选）
    private Date createTime;
    private Date updateTime;

    // 保留原有构造方法，新增无参构造（MyBatis反射需要）
    public Student() {}

    public Student(String name, int age) {
        this.name = name;
        this.age = age;
    }

    // 补充id、createTime、updateTime的get/set方法
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }

    public Date getUpdateTime() { return updateTime; }
    public void setUpdateTime(Date updateTime) { this.updateTime = updateTime; }

    // 原有name/age的get/set方法
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public int getAge() { return age; }
    public void setAge(int age) { this.age = age; }
}