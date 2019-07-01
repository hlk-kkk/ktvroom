package com.hlk.ktvroom.dao;

import com.hlk.ktvroom.entity.Roomorder;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface RoomorderMapper {
    int deleteByPrimaryKey(Integer roomorderid);

    int insert(Roomorder record);

    int insertSelective(Roomorder record);

    Roomorder selectByPrimaryKey(Integer roomorderid);

    int updateByPrimaryKeySelective(Roomorder record);

    int updateByPrimaryKey(Roomorder record);

    List<Roomorder> selectAll(Roomorder record);

    Roomorder selectByRoom(Roomorder record);

    void removes(@Param("ids") String[] ids);

    void modify(Roomorder record);

    void selectByOrderId();
}