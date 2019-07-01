package com.hlk.ktvroom.dao;

import com.hlk.ktvroom.entity.Membertype;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MembertypeMapper {
    int deleteByPrimaryKey(Integer membertypeid);

    int insert(Membertype record);

    int insertSelective(Membertype record);

    Membertype selectByPrimaryKey(Integer membertypeid);

    int updateByPrimaryKeySelective(Membertype record);

    int updateByPrimaryKey(Membertype record);

    void removes(@Param("ids") String[] ids);

    List<Membertype> selectAll(Membertype membertype);

    //查询会员类别的数量
    Integer selectCount();
}