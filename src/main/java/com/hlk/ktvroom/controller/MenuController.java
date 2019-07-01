package com.hlk.ktvroom.controller;

import com.hlk.ktvroom.entity.Menu;
import com.hlk.ktvroom.entity.Sysuser;
import com.hlk.ktvroom.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/menu")
public class MenuController {
    @Autowired
    private MenuService menuservice;
    @Autowired
    private HttpServletRequest httpServletRequest;

    @RequestMapping("/showAll")
    public List<Menu> showAll() {
        HttpSession session = httpServletRequest.getSession();
        Sysuser sysuser = (Sysuser) session.getAttribute("sysuser");
        List<Menu> list = new ArrayList<>();
        Menu menu = new Menu();
        if (sysuser.getSysname().equals("test")) {
            menu.setId(3);
        }
        list = menuservice.selectMenu(menu);
        return list;
    }
}
