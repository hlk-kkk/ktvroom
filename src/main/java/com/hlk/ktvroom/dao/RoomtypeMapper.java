package com.hlk.ktvroom.dao;

import com.hlk.ktvroom.entity.Roomtype;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface RoomtypeMapper {
    int deleteByPrimaryKey(Integer roomtypeid);

    int insert(Roomtype record);

    int insertSelective(Roomtype record);

    Roomtype selectByPrimaryKey(Integer roomtypeid);

    int updateByPrimaryKeySelective(Roomtype record);

    int updateByPrimaryKey(Roomtype record);

    List<Roomtype> selectAll(Roomtype record);

    void removes(@Param("ids") String[] ids);

    void modify(Roomtype record);
}