package com.hlk.ktvroom.service;


import com.hlk.ktvroom.entity.Goodsstock;

import java.util.List;

public interface GoodsstockService {
    //展示所有
    List<Goodsstock> selectAll(Goodsstock Goodsstock);

    //添加
    void add(Goodsstock Goodsstock);

    //查找
    Goodsstock selectById(Goodsstock Goodsstock);

    //根据商品id查询库存id
    Goodsstock selectById1(Goodsstock Goodsstock);

    //修改
    void update(Goodsstock Goodsstock);

    //根据id删除
    void removes(String[] ids);
}