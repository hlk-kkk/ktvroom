package com.hlk.ktvroom.dao;

import com.hlk.ktvroom.entity.Sysuser;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SysuserMapper {
    int deleteByPrimaryKey(Integer sysid);

    int insert(Sysuser record);

    int insertSelective(Sysuser record);

    Sysuser selectByPrimaryKey(String sysword);

    int updateByPrimaryKeySelective(Sysuser record);

    int updateByPrimaryKey(Sysuser record);

    List<Sysuser> selectAll(Sysuser user);

    Sysuser selectBySysuser(Sysuser user);

    void removes(@Param("ids") String[] ids);

    void modify(Sysuser user);
}