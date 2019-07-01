package com.hlk.ktvroom.service.Impl;

import com.hlk.ktvroom.dao.UserMapper;
import com.hlk.ktvroom.entity.User;
import com.hlk.ktvroom.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional
@Service
public class userServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;

    @Override
    public boolean login(User user) {
        User sysuser1 = userMapper.selectByUser(user);
        if (sysuser1 == null) {
            return false;
        } else {
            if (sysuser1.getUserpwd().equals(user.getUserpwd())) {
                return true;
            }
            return false;
        }
    }

    @Override
    public void register(User user) {
        userMapper.insert(user);
    }

    @Override
    public List<User> selectAll(User user) {
        List<User> users = userMapper.selectAll(user);
        return users;
    }

    @Override
    public void add(User user) {
        userMapper.insert(user);
    }

    @Override
    public User selectById(User user) {
        User user1 = userMapper.selectByPrimaryKey(user.getUserid());
        return user1;
    }

    @Override
    public void update(User user) {
        int i = userMapper.updateByPrimaryKeySelective(user);
    }

    @Override
    public void removes(String[] ids) {
        // TODO Auto-generated method stub
        userMapper.removes(ids);
    }

    @Override
    public void modify(User user) {
        userMapper.modify(user);
    }

}
