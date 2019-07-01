package com.hlk.ktvroom.service.Impl;

import com.hlk.ktvroom.dao.GoodsorderMapper;
import com.hlk.ktvroom.entity.Goodsorder;
import com.hlk.ktvroom.service.GoodsorderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional
@Service
public class GoodsorderServiceImpl implements GoodsorderService {
    @Autowired
    private GoodsorderMapper GoodsstockMapper;

    @Override
    public List<Goodsorder> selectAll(Goodsorder Goodsorder) {
        List<Goodsorder> Goodsstocks = GoodsstockMapper.selectAll(Goodsorder);
        return Goodsstocks;
    }

    @Override
    public void add(Goodsorder Goodsorder) {
        GoodsstockMapper.insert(Goodsorder);
    }

    @Override
    public Goodsorder selectById(Goodsorder Goodsorder) {
        Goodsorder Goodsstock1 = GoodsstockMapper.selectByPrimaryKey(Goodsorder.getGoodsorderid());
        return Goodsstock1;
    }

    @Override
    public void update(Goodsorder Goodsorder) {
        int i = GoodsstockMapper.updateByPrimaryKeySelective(Goodsorder);
    }

    @Override
    public void removes(String[] ids) {
        // TODO Auto-generated method stub
        GoodsstockMapper.removes(ids);
    }
}
