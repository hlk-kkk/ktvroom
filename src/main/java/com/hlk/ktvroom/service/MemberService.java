package com.hlk.ktvroom.service;


import com.hlk.ktvroom.entity.Member;

import java.util.List;

public interface MemberService {

    //展示所有
    List<Member> selectAll(Member member);

    //添加
    Integer add(Member member);

    //查找
    Member selectById(Member member);

    //修改
    void update(Member member);

    //根据id删除
    void removes(String[] ids);

    //根据id修改状态
    void modify(Member member);
}