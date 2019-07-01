package com.hlk.ktvroom.controller;

import com.hlk.ktvroom.entity.Room;
import com.hlk.ktvroom.service.RoomService;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Api(value = "room controller", tags = "用户接口文档")
@Controller
@RequestMapping("/room")
public class RoomController {
    @Autowired
    private RoomService roomService;
    @Autowired
    private HttpServletRequest httpServletRequest;

    //展示所有
    @RequestMapping("/showAll")
    @ResponseBody
    public List<Room> showAll(Room room) {
        List<Room> rooms = roomService.selectAll(room);
        return rooms;
    }

    //前台展示所有
    @RequestMapping("/showAll1")
    public String showAll1(Room room) {
        List<Room> rooms = roomService.selectAll(room);
        httpServletRequest.setAttribute("rooms", rooms);
        return "forward:/frontPage/manager/room/RoomList.jsp";
    }

    //后台添加房间
    @RequestMapping("/insert")
    public void add(Room room) {
        room.setRoomcondition("1");
        roomService.add(room);
    }

    //批量删除
    @RequestMapping("/removes")
    @ResponseBody
    public Map<Object, Object> removes(String[] ids) {
        Map<Object, Object> map = new HashMap<>();
        roomService.removes(ids);
        map.put("msg", "删除成功");
        return map;
    }

    //修改查询
    @RequestMapping("selectById")
    @ResponseBody
    public Room selectById(Room room) {
        Room room1 = roomService.selectById(room);
        return room1;
    }

    //修改
    @RequestMapping("/update")
    public void update(Room room) {
        roomService.update(room);
    }

    @RequestMapping("/modify")
    @ResponseBody
    public Map<String, String> modify(Room room) {
        Map<String, String> map = new HashMap<>();
        roomService.modify(room);
        map.put("msg", "修改成功");
        return map;
    }

    //展示未使用房
    @RequestMapping("/showAllByStatic")
    @ResponseBody
    public List<Room> showAllByStatic(Room room) {
        List<Room> rooms = roomService.selectAllByStatic(room);
        return rooms;
    }
}
