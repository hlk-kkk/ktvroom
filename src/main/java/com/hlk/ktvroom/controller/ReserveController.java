package com.hlk.ktvroom.controller;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.hlk.ktvroom.entity.Query;
import com.hlk.ktvroom.entity.Reserve;
import com.hlk.ktvroom.entity.Roomtype;
import com.hlk.ktvroom.service.OrderService;
import com.hlk.ktvroom.service.ReserveService;
import com.hlk.ktvroom.service.RoomorderService;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Api(value = "Reserve controller", tags = "用户接口文档")
@Controller
@RequestMapping("/reserve")
public class ReserveController {
    @Autowired
    private ReserveService ReserveService;
    @Autowired
    private OrderService orderService;
    @Autowired
    private RoomorderService roomorderService;
    @Autowired
    private HttpServletRequest httpServletRequest;

    //展示所有
    @RequestMapping("/showAll")
    public String showAll(ModelMap map, Reserve reserve, Query query) {
        Page<Object> page = PageHelper.startPage(query.getPageSum(), query.getPageSize());
        List<Reserve> Reserves = ReserveService.selectAll(reserve);
        Integer count = (int) (page.getTotal() % query.getPageSize() == 0 ? (page.getTotal() / query.getPageSize()) : (page.getTotal() / query.getPageSize() + 1));
        query.setCount(count);
        map.put("reserves", Reserves);
        return "forward:/frontPage/manager/reserve/reserve.jsp";
    }

    //后台添加预定人员
    @RequestMapping("/insert")
    @ResponseBody
    public Map<Object, Object> add(@RequestBody Reserve reserve) {
        Map<Object, Object> map = new HashMap<>();
        Integer delflag = reserve.getDelflag();
        Roomtype roomtype = new Roomtype();
        roomtype.setRoomtypeid(delflag);
        reserve.setRoomtype(roomtype);
        reserve.setDelflag(0);
        ReserveService.add(reserve);
        map.put("msg", "预定成功");
        return map;
    }

    //批量删除
    @RequestMapping("/removes")
    public Map<Object, Object> removes(String[] ids) {
        Map<Object, Object> map = new HashMap<>();
        ReserveService.removes(ids);
        map.put("msg", "删除成功");
        return map;
    }

    //修改查询
    @RequestMapping("selectById")
    public Reserve selectById(Reserve Reserve) {
        Reserve Reserve1 = ReserveService.selectById(Reserve);
        return Reserve1;
    }

    //修改
    @RequestMapping("/update")
    public void update(Reserve Reserve) {
        ReserveService.update(Reserve);
    }

    @RequestMapping("/modify")
    public Map<String, String> modify(Reserve Reserve) {
        Map<String, String> map = new HashMap<>();
        ReserveService.modify(Reserve);
        map.put("msg", "修改成功");
        return map;
    }
}
