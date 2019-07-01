package com.hlk.ktvroom.dao;

import com.hlk.ktvroom.entity.Order;
import com.hlk.ktvroom.entity.Room;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface OrderMapper {
    int deleteByPrimaryKey(Integer orderid);

    int insert(Order record);

    int insertSelective(Order record);

    Order selectByPrimaryKey(Integer orderid);

    int updateByPrimaryKeySelective(Order record);

    int updateByPrimaryKey(Order record);

    List<Order> selectAll(Order record);

    Order selectByRoom(Order record);

    void removes(@Param("ids") String[] ids);

    void modify(Order record);

    Integer selectsqu();

    Integer selectorder(Room room);
}