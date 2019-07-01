package com.hlk.ktvroom.service.Impl;

import com.hlk.ktvroom.dao.RoomtypeMapper;
import com.hlk.ktvroom.entity.Roomtype;
import com.hlk.ktvroom.service.RoomTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional
@Service
public class RoomTypeServiceImpl implements RoomTypeService {
    @Autowired
    private RoomtypeMapper RoomMapper;

    @Override
    public List<Roomtype> selectAll(Roomtype Room) {
        List<Roomtype> Rooms = RoomMapper.selectAll(Room);
        return Rooms;
    }

    @Override
    public void add(Roomtype Room) {
        RoomMapper.insert(Room);
    }

    @Override
    public Roomtype selectById(Roomtype Room) {
        Roomtype Room1 = RoomMapper.selectByPrimaryKey(Room.getRoomtypeid());
        return Room1;
    }

    @Override
    public void update(Roomtype Room) {
        int i = RoomMapper.updateByPrimaryKeySelective(Room);
    }

    @Override
    public void removes(String[] ids) {
        // TODO Auto-generated method stub
        RoomMapper.removes(ids);
    }

    @Override
    public void modify(Roomtype Room) {
        RoomMapper.modify(Room);
    }

}
