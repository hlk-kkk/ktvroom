package com.hlk.ktvroom.service.Impl;

import com.hlk.ktvroom.dao.MenuDao;
import com.hlk.ktvroom.entity.Menu;
import com.hlk.ktvroom.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional
@Service
public class MenuServiceImpl implements MenuService {
    @Autowired
    private MenuDao menuDao;

    @Override
    public long getMenuRowCount() {
        return menuDao.getMenuRowCount();
    }

    @Override
    public List<Menu> selectMenu(Menu menu) {
        return menuDao.selectMenu(menu);
    }

    @Override
    public Menu selectMenuByObj(Menu obj) {
        return menuDao.selectMenuByObj(obj);
    }

    @Override
    public Menu selectMenuById(Integer id) {
        return menuDao.selectMenuById(id);
    }

    @Override
    public int insertMenu(Menu value) {
        return menuDao.insertMenu(value);
    }

    @Override
    public int insertNonEmptyMenu(Menu value) {
        return menuDao.insertNonEmptyMenu(value);
    }

    @Override
    public int deleteMenuById(Integer id) {
        return menuDao.deleteMenuById(id);
    }

    @Override
    public int updateMenuById(Menu enti) {
        return menuDao.updateMenuById(enti);
    }

    @Override
    public int updateNonEmptyMenuById(Menu enti) {
        return menuDao.updateNonEmptyMenuById(enti);
    }

    public MenuDao getMenuDao() {
        return this.menuDao;
    }

    public void setMenuDao(MenuDao menuDao) {
        this.menuDao = menuDao;
    }

}