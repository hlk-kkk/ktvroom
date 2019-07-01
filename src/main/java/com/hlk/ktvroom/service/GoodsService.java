package com.hlk.ktvroom.service;


import com.hlk.ktvroom.entity.Goods;

import java.util.List;

public interface GoodsService {
    //展示所有
    List<Goods> selectAll(Goods Goods);

    //添加
    int add(Goods Goods);

    //查找
    Goods selectById(Goods Goods);

    //修改
    void update(Goods Goods);

    //根据id删除
    void removes(String[] ids);
}