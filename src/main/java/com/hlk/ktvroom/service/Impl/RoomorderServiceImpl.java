package com.hlk.ktvroom.service.Impl;

import com.hlk.ktvroom.dao.RoomorderMapper;
import com.hlk.ktvroom.entity.Roomorder;
import com.hlk.ktvroom.service.RoomorderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional
@Service
public class RoomorderServiceImpl implements RoomorderService {
    @Autowired
    private RoomorderMapper roomorderMapper;

    @Override
    public List<Roomorder> selectAll(Roomorder Roomorder) {
        List<Roomorder> Rooms = roomorderMapper.selectAll(Roomorder);
        return Rooms;
    }

    @Override
    public void add(Roomorder Roomorder) {
        roomorderMapper.insert(Roomorder);
    }

    @Override
    public Roomorder selectById(Roomorder Roomorder) {
        Roomorder Room1 = roomorderMapper.selectByPrimaryKey(Roomorder.getRoomorderid());
        return Room1;
    }

    @Override
    public void update(Roomorder Roomorder) {
        int i = roomorderMapper.updateByPrimaryKeySelective(Roomorder);
    }

    @Override
    public void removes(String[] ids) {
        // TODO Auto-generated method stub
        roomorderMapper.removes(ids);
    }

    @Override
    public void modify(Roomorder Roomorder) {
        roomorderMapper.modify(Roomorder);
    }

    @Override
    public void selectByOrderId() {
        roomorderMapper.selectByOrderId();

    }

}
