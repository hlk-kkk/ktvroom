package com.hlk.ktvroom.service;


import com.hlk.ktvroom.entity.Room;

import java.util.List;

public interface RoomService {
    //展示所有
    List<Room> selectAll(Room Room);

    //展示所有
    List<Room> selectAllByStatic(Room Room);

    //添加
    void add(Room Room);

    //查找
    Room selectById(Room Room);

    //修改
    void update(Room Room);

    //根据id删除
    void removes(String[] ids);

    //根据id修改状态
    void modify(Room Room);
}