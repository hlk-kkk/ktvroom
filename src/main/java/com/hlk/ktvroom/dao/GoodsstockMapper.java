package com.hlk.ktvroom.dao;

import com.hlk.ktvroom.entity.Goodsstock;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface GoodsstockMapper {
    int deleteByPrimaryKey(Integer goodsstockid);

    int insert(Goodsstock record);

    int insertSelective(Goodsstock record);

    Goodsstock selectByPrimaryKey(Integer goodsstockid);

    Goodsstock selectByPrimaryKey1(Integer goodsid);

    int updateByPrimaryKeySelective(Goodsstock record);

    int updateByPrimaryKey(Goodsstock record);

    List<Goodsstock> selectAll(Goodsstock record);

    void removes(@Param("ids") String[] ids);
}