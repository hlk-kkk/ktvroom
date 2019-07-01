package com.hlk.ktvroom.service;


import com.hlk.ktvroom.entity.Goodsorder;

import java.util.List;

public interface GoodsorderService {
    //展示所有
    List<Goodsorder> selectAll(Goodsorder Goodsorder);

    //添加
    void add(Goodsorder Goodsorder);

    //查找
    Goodsorder selectById(Goodsorder Goodsorder);

    //修改
    void update(Goodsorder Goodsorder);

    //根据id删除
    void removes(String[] ids);
}