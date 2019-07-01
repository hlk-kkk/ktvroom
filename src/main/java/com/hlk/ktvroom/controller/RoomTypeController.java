package com.hlk.ktvroom.controller;

import com.hlk.ktvroom.entity.Roomtype;
import com.hlk.ktvroom.service.RoomTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/roomtype")
public class RoomTypeController {
    @Autowired
    private RoomTypeService roomtypeService;
    @Autowired
    private HttpServletRequest httpServletRequest;

    //展示所有
    @RequestMapping("/showAll")
    public List<Roomtype> showAll(Roomtype roomtype) {
        List<Roomtype> roomtypes = roomtypeService.selectAll(roomtype);
        return roomtypes;
    }

    //后台添加房间类型
    @RequestMapping("/insert")
    public Map<Object, Object> add(Roomtype roomtype) {
        Map<Object, Object> map = new HashMap<>();
        roomtypeService.add(roomtype);
        map.put("msg", "添加成功");
        return map;
    }

    //批量删除
    @RequestMapping("/removes")
    public Map<Object, Object> removes(String... ids) {

        Map<Object, Object> map = new HashMap<>();
        roomtypeService.removes(ids);
        map.put("msg", "删除成功");
        return map;
    }

    //根据id查询
    @RequestMapping("/selectById")
    public Roomtype selectById(Roomtype roomtype) {
        Roomtype roomtype1 = roomtypeService.selectById(roomtype);
        return roomtype1;

    }

    //修改
    @RequestMapping("/update")
    public Map<Object, Object> update(Roomtype roomtype) {
        Map<Object, Object> map = new HashMap<>();
        roomtypeService.update(roomtype);
        map.put("msg", "修改成功");
        return map;
    }

}
