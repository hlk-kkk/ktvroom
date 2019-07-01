package com.hlk.ktvroom.service.Impl;

import com.hlk.ktvroom.dao.GoodstypeMapper;
import com.hlk.ktvroom.entity.Goodstype;
import com.hlk.ktvroom.service.GoodstypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional
@Service
public class GoodstypeServiceImpl implements GoodstypeService {
    @Autowired
    private GoodstypeMapper GoodstypeMapper;

    @Override
    public List<Goodstype> selectAll(Goodstype Goodstype) {
        List<Goodstype> Goodstypes = GoodstypeMapper.selectAll(Goodstype);
        return Goodstypes;
    }

    @Override
    public void add(Goodstype Goodstype) {
        GoodstypeMapper.insert(Goodstype);
    }

    @Override
    public Goodstype selectById(Goodstype Goodstype) {
        Goodstype Goodstype1 = GoodstypeMapper.selectByPrimaryKey(Goodstype.getGoodstypeid());
        return Goodstype1;
    }

    @Override
    public void update(Goodstype Goodstype) {
        int i = GoodstypeMapper.updateByPrimaryKeySelective(Goodstype);
    }

    @Override
    public void removes(String[] ids) {
        // TODO Auto-generated method stub
        GoodstypeMapper.removes(ids);
    }
}
