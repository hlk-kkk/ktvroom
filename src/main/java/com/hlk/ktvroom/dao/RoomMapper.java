package com.hlk.ktvroom.dao;

import com.hlk.ktvroom.entity.Room;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface RoomMapper {
    int deleteByPrimaryKey(Integer roomid);

    int insert(Room record);

    int insertSelective(Room record);

    Room selectByPrimaryKey(Integer roomid);

    int updateByPrimaryKeySelective(Room record);

    int updateByPrimaryKey(Room record);

    List<Room> selectAll(Room record);

    Room selectByRoom(Room record);

    void removes(@Param("ids") String[] ids);

    void modify(Room record);

    List<Room> selectAllByStatic(Room record);
}