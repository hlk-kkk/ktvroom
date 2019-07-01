package com.hlk.ktvroom.service;


import com.hlk.ktvroom.entity.Roomtype;

import java.util.List;

public interface RoomTypeService {
    //展示所有
    List<Roomtype> selectAll(Roomtype Room);

    //添加
    void add(Roomtype Room);

    //查找
    Roomtype selectById(Roomtype Room);

    //修改
    void update(Roomtype Room);

    //根据id删除
    void removes(String[] ids);

    //根据id修改状态
    void modify(Roomtype Room);
}