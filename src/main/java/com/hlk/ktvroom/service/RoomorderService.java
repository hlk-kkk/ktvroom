package com.hlk.ktvroom.service;


import com.hlk.ktvroom.entity.Roomorder;

import java.util.List;

public interface RoomorderService {
    //展示所有
    List<Roomorder> selectAll(Roomorder Roomorder);

    //添加
    void add(Roomorder Roomorder);

    //查找
    Roomorder selectById(Roomorder Roomorder);

    //修改
    void update(Roomorder Roomorder);

    //根据id删除
    void removes(String[] ids);

    //根据id修改状态
    void modify(Roomorder Roomorder);

    //根据orderid查询
    void selectByOrderId();
}