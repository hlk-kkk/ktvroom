package com.hlk.ktvroom.service;


import com.hlk.ktvroom.entity.Order;
import com.hlk.ktvroom.entity.Room;

import java.util.List;

public interface OrderService {
    //展示所有
    List<Order> selectAll(Order Order);

    //添加
    void add(Order Order);

    //查找
    Order selectById(Order Order);

    //修改
    void update(Order Order);

    //根据id删除
    void removes(String[] ids);

    //根据id修改状态
    void modify(Order Order);

    Integer selectsqu();

    Integer selectorder(Room rooms);
}