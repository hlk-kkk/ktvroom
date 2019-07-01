package com.hlk.ktvroom.dao;

import com.hlk.ktvroom.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserMapper {
    int deleteByPrimaryKey(Integer userid);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Integer userid);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);

    List<User> selectAll(User user);

    User selectByUser(User user);

    void removes(@Param("ids") String[] ids);

    void modify(User user);
}