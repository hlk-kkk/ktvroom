package com.hlk.ktvroom.service;


import com.hlk.ktvroom.entity.User;

import java.util.List;

public interface UserService {
    //登录
    boolean login(User user);

    //注册
    void register(User user);

    //展示所有
    List<User> selectAll(User user);

    //添加
    void add(User user);

    //查找
    User selectById(User user);

    //修改
    void update(User user);

    //根据id删除
    public void removes(String[] ids);

    //根据id修改状态
    void modify(User user);
}