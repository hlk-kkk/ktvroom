package com.hlk.ktvroom.dao;

import com.hlk.ktvroom.entity.Goodstype;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface GoodstypeMapper {
    int deleteByPrimaryKey(Integer goodstypeid);

    int insert(Goodstype record);

    int insertSelective(Goodstype record);

    Goodstype selectByPrimaryKey(Integer goodstypeid);

    int updateByPrimaryKeySelective(Goodstype record);

    int updateByPrimaryKey(Goodstype record);

    List<Goodstype> selectAll(Goodstype record);

    void removes(@Param("ids") String[] ids);
}