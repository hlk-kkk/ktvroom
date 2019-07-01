package com.hlk.ktvroom.service.Impl;

import com.hlk.ktvroom.dao.OrderMapper;
import com.hlk.ktvroom.entity.Order;
import com.hlk.ktvroom.entity.Room;
import com.hlk.ktvroom.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional
@Service
public class OrderServiceImpl implements OrderService {
    @Autowired
    private OrderMapper RoomMapper;

    @Override
    public List<Order> selectAll(Order Order) {
        List<Order> Rooms = RoomMapper.selectAll(Order);
        return Rooms;
    }

    @Override
    public void add(Order Order) {
        RoomMapper.insert(Order);
    }

    @Override
    public Order selectById(Order Order) {
        Order Room1 = RoomMapper.selectByPrimaryKey(Order.getOrderid());
        return Room1;
    }

    @Override
    public void update(Order Order) {
        int i = RoomMapper.updateByPrimaryKeySelective(Order);
    }

    @Override
    public void removes(String[] ids) {
        // TODO Auto-generated method stub
        RoomMapper.removes(ids);
    }

    @Override
    public void modify(Order Order) {
        RoomMapper.modify(Order);
    }

    @Override
    public Integer selectsqu() {
        Integer selectsqu = RoomMapper.selectsqu();
        return selectsqu;
    }

    @Override
    public Integer selectorder(Room room) {
        return RoomMapper.selectorder(room);
    }


}
