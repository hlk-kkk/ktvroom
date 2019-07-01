package com.hlk.ktvroom.service;

import com.hlk.ktvroom.entity.Membertype;

import java.util.List;

public interface MembertypeService {
    int deleteByPrimaryKey(Integer membertypeid);

    int insert(Membertype record);

    int insertSelective(Membertype record);

    Membertype selectByPrimaryKey(Integer membertypeid);

    int updateByPrimaryKeySelective(Membertype record);

    int updateByPrimaryKey(Membertype record);

    //展示所有
    List<Membertype> selectAll(Membertype membertype);

    //根据id删除
    void removes(String[] ids);

    //查找
    Membertype selectById(Membertype membertype);

    //查询会员类别的数量
    Integer selectCount();
}
