package com.hlk.ktvroom.service.Impl;

import com.hlk.ktvroom.dao.GoodsstockMapper;
import com.hlk.ktvroom.entity.Goodsstock;
import com.hlk.ktvroom.service.GoodsstockService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional
@Service
public class GoodsstockServiceImpl implements GoodsstockService {
    @Autowired
    private GoodsstockMapper GoodsstockMapper;

    @Override
    public List<Goodsstock> selectAll(Goodsstock Goodsstock) {
        List<Goodsstock> Goodsstocks = GoodsstockMapper.selectAll(Goodsstock);
        return Goodsstocks;
    }

    @Override
    public void add(Goodsstock Goodsstock) {
        GoodsstockMapper.insert(Goodsstock);
    }

    @Override
    public Goodsstock selectById(Goodsstock Goodsstock) {
        Goodsstock Goodsstock1 = GoodsstockMapper.selectByPrimaryKey(Goodsstock.getGoodsstockid());
        return Goodsstock1;
    }

    @Override
    public void update(Goodsstock Goodsstock) {
        int i = GoodsstockMapper.updateByPrimaryKeySelective(Goodsstock);
    }

    @Override
    public void removes(String[] ids) {
        // TODO Auto-generated method stub
        GoodsstockMapper.removes(ids);
    }

    @Override
    public Goodsstock selectById1(Goodsstock Goodsstock) {
        System.out.println(Goodsstock);
        Integer goodsid = Goodsstock.getGoods().getGoodsid();
        Goodsstock Goodsstock1 = GoodsstockMapper.selectByPrimaryKey1(goodsid);
        return Goodsstock1;
    }

}
