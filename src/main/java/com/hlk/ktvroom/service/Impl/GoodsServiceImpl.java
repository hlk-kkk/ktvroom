package com.hlk.ktvroom.service.Impl;

import com.hlk.ktvroom.dao.GoodsMapper;
import com.hlk.ktvroom.entity.Goods;
import com.hlk.ktvroom.service.GoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional
@Service
public class GoodsServiceImpl implements GoodsService {
    @Autowired
    private GoodsMapper GoodsMapper;

    @Override
    public List<Goods> selectAll(Goods Goods) {
        List<Goods> Goodss = GoodsMapper.selectAll(Goods);
        return Goodss;
    }

    @Override
    public int add(Goods Goods) {
        return GoodsMapper.insert(Goods);
    }

    @Override
    public Goods selectById(Goods Goods) {
        Goods Goods1 = GoodsMapper.selectByPrimaryKey(Goods.getGoodsid());
        return Goods1;
    }

    @Override
    public void update(Goods Goods) {
        int i = GoodsMapper.updateByPrimaryKeySelective(Goods);
    }

    @Override
    public void removes(String[] ids) {
        // TODO Auto-generated method stub
        GoodsMapper.removes(ids);
    }
}
