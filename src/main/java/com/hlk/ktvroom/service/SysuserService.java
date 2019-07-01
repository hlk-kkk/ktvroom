package com.hlk.ktvroom.service;


import com.hlk.ktvroom.entity.Sysuser;

import java.util.List;

public interface SysuserService {
    //登录
    boolean login(Sysuser sysuser);

    //注册
    void register(Sysuser sysuser);

    //展示所有
    List<Sysuser> selectAll(Sysuser sysuser);

    //添加
    void add(Sysuser sysuser);

    //查找
    Sysuser selectById(Sysuser sysuser);

    //修改
    void update(Sysuser sysuser);

    //根据id删除
    public void removes(String[] ids);

    //根据id修改状态
    void modify(Sysuser sysuser);
}