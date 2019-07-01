package com.hlk.ktvroom.dao;

import com.hlk.ktvroom.entity.Goodsorder;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface GoodsorderMapper {
    int deleteByPrimaryKey(Integer goodsorderid);

    int insert(Goodsorder record);

    int insertSelective(Goodsorder record);

    Goodsorder selectByPrimaryKey(Integer goodsorderid);

    int updateByPrimaryKeySelective(Goodsorder record);

    int updateByPrimaryKey(Goodsorder record);

    List<Goodsorder> selectAll(Goodsorder record);

    void removes(@Param("ids") String[] ids);
}