package com.hlk.ktvroom.service.Impl;

import com.hlk.ktvroom.dao.MemberMapper;
import com.hlk.ktvroom.entity.Member;
import com.hlk.ktvroom.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional
@Service
public class MemberServiceImpl implements MemberService {
    @Autowired
    private MemberMapper memberMapper;


    @Override
    public List<Member> selectAll(Member member) {
        List<Member> members = memberMapper.selectAll(member);
        return members;
    }

    @Override
    public Integer add(Member member) {
        int insert = memberMapper.insert(member);
        return insert;
    }

    @Override
    public Member selectById(Member member) {
        Member member1 = memberMapper.selectByPrimaryKey(member.getMemberid());
        return member1;
    }

    @Override
    public void update(Member member) {
        int i = memberMapper.updateByPrimaryKeySelective(member);
    }

    @Override
    public void removes(String[] ids) {
        // TODO Auto-generated method stub
        memberMapper.removes(ids);
    }

    @Override
    public void modify(Member member) {
        memberMapper.modify(member);
    }

}
