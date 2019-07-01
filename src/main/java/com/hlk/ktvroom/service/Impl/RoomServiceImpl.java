package com.hlk.ktvroom.service.Impl;

import com.hlk.ktvroom.dao.RoomMapper;
import com.hlk.ktvroom.entity.Room;
import com.hlk.ktvroom.service.RoomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional
@Service
public class RoomServiceImpl implements RoomService {
    @Autowired
    private RoomMapper RoomMapper;

    @Override
    public List<Room> selectAll(Room Room) {
        List<Room> Rooms = RoomMapper.selectAll(Room);
        return Rooms;
    }

    @Override
    public List<Room> selectAllByStatic(Room Room) {
        List<Room> Rooms = RoomMapper.selectAllByStatic(Room);
        return Rooms;
    }

    @Override
    public void add(Room Room) {
        RoomMapper.insert(Room);
    }

    @Override
    public Room selectById(Room Room) {
        Room Room1 = RoomMapper.selectByPrimaryKey(Room.getRoomid());
        return Room1;
    }

    @Override
    public void update(Room Room) {
        int i = RoomMapper.updateByPrimaryKeySelective(Room);
    }

    @Override
    public void removes(String[] ids) {
        // TODO Auto-generated method stub
        RoomMapper.removes(ids);
    }

    @Override
    public void modify(Room Room) {
        RoomMapper.modify(Room);
    }

}
