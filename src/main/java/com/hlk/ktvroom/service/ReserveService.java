package com.hlk.ktvroom.service;


import com.hlk.ktvroom.entity.Reserve;

import java.util.List;

public interface ReserveService {
    //展示所有
    List<Reserve> selectAll(Reserve Reserve);

    //添加
    void add(Reserve Reserve);

    //查找
    Reserve selectById(Reserve Reserve);

    //修改
    void update(Reserve Reserve);

    //根据id删除
    void removes(String[] ids);

    //根据id修改状态
    void modify(Reserve Reserve);
}