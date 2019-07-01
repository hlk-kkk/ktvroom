package com.hlk.ktvroom.service.Impl;

import com.hlk.ktvroom.dao.MembertypeMapper;
import com.hlk.ktvroom.entity.Membertype;
import com.hlk.ktvroom.service.MembertypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MembertypeServiceImpl implements MembertypeService {
    @Autowired
    private MembertypeMapper membertypeMapper;

    @Override
    public int deleteByPrimaryKey(Integer membertypeid) {
        int i = membertypeMapper.deleteByPrimaryKey(membertypeid);
        return i;
    }

    @Override
    public int insert(Membertype record) {
        int insert = membertypeMapper.insert(record);
        return insert;
    }

    @Override
    public int insertSelective(Membertype record) {
        int i = membertypeMapper.insertSelective(record);
        return i;
    }

    @Override
    public Membertype selectByPrimaryKey(Integer membertypeid) {
        Membertype membertype = membertypeMapper.selectByPrimaryKey(membertypeid);
        return membertype;
    }

    @Override
    public int updateByPrimaryKeySelective(Membertype record) {
        int i = membertypeMapper.updateByPrimaryKeySelective(record);
        return i;
    }

    @Override
    public int updateByPrimaryKey(Membertype record) {
        int i = membertypeMapper.updateByPrimaryKey(record);
        return i;
    }

    @Override
    public void removes(String[] ids) {
        // TODO Auto-generated method stub
        membertypeMapper.removes(ids);
    }

    @Override
    public List<Membertype> selectAll(Membertype membertype) {
        List<Membertype> membertypes = membertypeMapper.selectAll(membertype);
        return membertypes;
    }

    @Override
    public Membertype selectById(Membertype membertype) {
        Membertype member1 = membertypeMapper.selectByPrimaryKey(membertype.getMembertypeid());
        return member1;
    }

    @Override
    public Integer selectCount() {
        Integer integer = membertypeMapper.selectCount();
        return integer;
    }
}
