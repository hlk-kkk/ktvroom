package com.hlk.ktvroom.dao;

import com.hlk.ktvroom.entity.Member;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MemberMapper {
    int deleteByPrimaryKey(Integer memberid);

    int insert(Member member);

    int insertSelective(Member member);

    Member selectByPrimaryKey(Integer memberid);

    int updateByPrimaryKeySelective(Member member);

    int updateByPrimaryKey(Member member);

    List<Member> selectAll(Member member);

    Member selectByMember(Member member);

    void removes(@Param("ids") String[] ids);

    void modify(Member member);
}