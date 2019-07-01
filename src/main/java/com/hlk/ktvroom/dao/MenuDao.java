package com.hlk.ktvroom.dao;

import com.hlk.ktvroom.entity.Menu;

import java.util.List;

public interface MenuDao {
    /**
     * 获得Menu数据的总行数
     *
     * @return
     */
    long getMenuRowCount();

    /**
     * 获得Menu数据集合
     *
     * @return
     */
    List<Menu> selectMenu(Menu menu);

    /**
     * 获得一个Menu对象,以参数Menu对象中不为空的属性作为条件进行查询
     *
     * @param obj
     * @return
     */
    Menu selectMenuByObj(Menu obj);

    /**
     * 通过Menu的id获得Menu对象
     *
     * @param id
     * @return
     */
    Menu selectMenuById(Integer id);

    /**
     * 插入Menu到数据库,包括null值
     *
     * @param value
     * @return
     */
    int insertMenu(Menu value);

    /**
     * 插入Menu中属性值不为null的数据到数据库
     *
     * @param value
     * @return
     */
    int insertNonEmptyMenu(Menu value);

    /**
     * 通过Menu的id删除Menu
     *
     * @param id
     * @return
     */
    int deleteMenuById(Integer id);

    /**
     * 通过Menu的id更新Menu中的数据,包括null值
     *
     * @param enti
     * @return
     */
    int updateMenuById(Menu enti);

    /**
     * 通过Menu的id更新Menu中属性不为null的数据
     *
     * @param enti
     * @return
     */
    int updateNonEmptyMenuById(Menu enti);
}