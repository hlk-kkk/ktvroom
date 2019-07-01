package com.hlk.ktvroom.service.Impl;

import com.hlk.ktvroom.dao.SysuserMapper;
import com.hlk.ktvroom.entity.Sysuser;
import com.hlk.ktvroom.service.SysuserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional
@Service
public class SysuserServiceImpl implements SysuserService {
    @Autowired
    private SysuserMapper sysuserMapper;

    @Override
    public boolean login(Sysuser sysuser) {
        Sysuser sysuser1 = sysuserMapper.selectBySysuser(sysuser);
        if (sysuser1 == null) {
            return false;
        } else {
            if (sysuser1.getSyspwd().equals(sysuser.getSyspwd())) {
                return true;
            }
            return false;
        }
    }

    @Override
    public void register(Sysuser sysuser) {
        sysuserMapper.insert(sysuser);
    }

    @Override
    public List<Sysuser> selectAll(Sysuser sysuser) {
        List<Sysuser> sysusers = sysuserMapper.selectAll(sysuser);
        return sysusers;
    }

    @Override
    public void add(Sysuser sysuser) {
        sysuserMapper.insert(sysuser);
    }

    @Override
    public Sysuser selectById(Sysuser sysuser) {
        Sysuser sysuser1 = sysuserMapper.selectByPrimaryKey(sysuser.getSysword());
        return sysuser1;
    }

    @Override
    public void update(Sysuser sysuser) {
        int i = sysuserMapper.updateByPrimaryKeySelective(sysuser);
    }

    @Override
    public void removes(String[] ids) {
        // TODO Auto-generated method stub
        sysuserMapper.removes(ids);
    }

    @Override
    public void modify(Sysuser sysuser) {
        sysuserMapper.modify(sysuser);
    }

}
