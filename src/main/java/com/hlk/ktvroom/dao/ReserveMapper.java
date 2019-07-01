package com.hlk.ktvroom.dao;

import com.hlk.ktvroom.entity.Reserve;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ReserveMapper {
    int deleteByPrimaryKey(Integer resid);

    int insert(Reserve record);

    int insertSelective(Reserve record);

    Reserve selectByPrimaryKey(Integer resid);

    int updateByPrimaryKeySelective(Reserve record);

    int updateByPrimaryKey(Reserve record);

    List<Reserve> selectAll(Reserve record);

    void removes(@Param("ids") String[] ids);

    void modify(Reserve record);
}