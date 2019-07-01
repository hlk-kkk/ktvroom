package com.hlk.ktvroom.service;


import com.hlk.ktvroom.entity.Goodstype;

import java.util.List;

public interface GoodstypeService {
    //展示所有
    List<Goodstype> selectAll(Goodstype Goodstype);

    //添加
    void add(Goodstype Goodstype);

    //查找
    Goodstype selectById(Goodstype Goodstype);

    //修改
    void update(Goodstype Goodstype);

    //根据id删除
    void removes(String[] ids);
}