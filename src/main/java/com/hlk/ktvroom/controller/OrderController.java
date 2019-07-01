package com.hlk.ktvroom.controller;

import com.hlk.ktvroom.entity.Order;
import com.hlk.ktvroom.service.OrderService;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Api(value = "order controller", tags = "用户接口文档")
@Controller
@RequestMapping("/order")
public class OrderController {
    @Autowired
    private OrderService orderService;
    @Autowired
    private HttpServletRequest httpServletRequest;

    //展示所有
    @RequestMapping("/showAll")
    @ResponseBody
    public List<Order> showAll(Order order) {
        List<Order> orders = orderService.selectAll(order);
        return orders;
    }

    //前台展示所有
    @RequestMapping("/showAll1")
    public String showAll1(Order order) {
        List<Order> orders = orderService.selectAll(order);
        httpServletRequest.setAttribute("orders", orders);
        return "forward:/frontPage/manager/order/RoomList.jsp";
    }

    //批量删除
    @RequestMapping("/removes")
    @ResponseBody
    public Map<Object, Object> removes(String[] ids) {
        Map<Object, Object> map = new HashMap<>();
        orderService.removes(ids);
        map.put("msg", "删除成功");
        return map;
    }

    //修改查询
    @RequestMapping("selectById")
    @ResponseBody
    public Order selectById(Order order) {
        Order room1 = orderService.selectById(order);
        return room1;
    }

    //修改
    @RequestMapping("/update")
    public void update(Order order) {
        orderService.update(order);
    }

    @RequestMapping("/modify")
    @ResponseBody
    public Map<String, String> modify(Order order) {
        Map<String, String> map = new HashMap<>();
        orderService.modify(order);
        map.put("msg", "修改成功");
        return map;
    }
}
