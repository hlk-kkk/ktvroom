package com.hlk.ktvroom.service.Impl;

import com.hlk.ktvroom.dao.ReserveMapper;
import com.hlk.ktvroom.entity.Reserve;
import com.hlk.ktvroom.service.ReserveService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional
@Service
public class ReserveServiceImpl implements ReserveService {
    @Autowired
    private ReserveMapper reserveMapper;

    @Override
    public List<Reserve> selectAll(Reserve Reserve) {
        List<Reserve> reserves = reserveMapper.selectAll(Reserve);
        return reserves;
    }

    @Override
    public void add(Reserve Reserve) {
        reserveMapper.insert(Reserve);
    }

    @Override
    public Reserve selectById(Reserve Reserve) {
        Reserve reserve1 = reserveMapper.selectByPrimaryKey(Reserve.getResid());
        return reserve1;
    }

    @Override
    public void update(Reserve Reserve) {
        int i = reserveMapper.updateByPrimaryKeySelective(Reserve);
    }

    @Override
    public void removes(String[] ids) {
        // TODO Auto-generated method stub
        reserveMapper.removes(ids);
    }

    @Override
    public void modify(Reserve Reserve) {
        reserveMapper.modify(Reserve);
    }

}
