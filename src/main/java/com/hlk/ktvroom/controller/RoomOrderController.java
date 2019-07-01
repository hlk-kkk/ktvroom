package com.hlk.ktvroom.controller;

import cn.hutool.core.date.DateTime;
import cn.hutool.core.date.DateUtil;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.hlk.ktvroom.entity.*;
import com.hlk.ktvroom.service.*;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Api(value = "room controller", tags = "用户接口文档")
@Controller
@RequestMapping("/roomorder")
public class RoomOrderController {
    @Autowired
    private RoomorderService roomorderService;
    @Autowired
    private RoomService roomService;
    @Autowired
    private MembertypeService membertypeService;
    @Autowired
    private OrderService orderService;
    @Autowired
    private ReserveService reserveService;
    @Autowired
    private GoodsstockService goodsstockService;
    @Autowired
    private GoodsorderService goodsorderService;
    @Autowired
    private HttpServletRequest httpServletRequest;

    @RequestMapping("/showAll")
    @ResponseBody
    public List<Roomorder> showAll(Roomorder room) {
        List<Roomorder> rooms = roomorderService.selectAll(room);
        return rooms;
    }

    //前台房间订单展示
    @RequestMapping("/showAll1")
    public String showAll1(Roomorder room) {
        List<Roomorder> rooms = roomorderService.selectAll(room);
        httpServletRequest.setAttribute("rooms", rooms);
        return "forward:/frontPage/manager/room/RoomList.jsp";
    }

    //前台开房
    @RequestMapping("/insert")
    public String add(Roomorder roomorder, Integer discount, Integer roomdate, Integer roomid) {
        Order order = new Order();
        Date date = new Date();
        DateTime newDate3 = DateUtil.offsetHour(date, discount);
        order.setBegintime(date);
        order.setEndtime(newDate3);
        order.setDelflag(0);
        Room room1 = new Room();
        room1.setRoomid(roomid);
        Room room2 = roomService.selectById(room1);
        Roomtype roomtype = room2.getRoomtype();
        String roommoney = roomtype.getRoommoney();
        if (discount == 0) {
            discount = 10;
            order.setDiscount(Integer.toString(discount));
        } else {
            Membertype membertype = new Membertype();
            membertype.setMembertypeid(discount);
            Membertype membertype1 = membertypeService.selectById(membertype);
            order.setDiscount(membertype1.getMemberdiscount().toString());
        }
        order.setOrdermoney(Integer.parseInt(roommoney) * roomdate);
        orderService.add(order);
        Integer selectsqu = orderService.selectsqu();
        order.setOrderid(selectsqu);
        roomorder.setOrder(order);
        roomorder.setRoom(room1);
        roomorderService.add(roomorder);
        room2.setRoomcondition("3");
        roomService.modify(room2);
        return "redirect:/room/showAll1";
    }

    //前台预定开房
    /*
     * #param roomorder 房间订单对象
     * discount 会员类型id
     * roomdate 开房时间
     * */
    @RequestMapping("/insert1")
    public String add1(Roomorder roomorder, Integer discount, Integer roomdate, Integer roomid, Integer resid) {
        Order order = new Order();
        Date date = new Date();
        DateTime newDate3 = DateUtil.offsetHour(date, discount);
        order.setBegintime(date);
        order.setEndtime(newDate3);
        order.setDelflag(0);
        Room room1 = new Room();
        room1.setRoomid(roomid);
        Room room2 = roomService.selectById(room1);
        Roomtype roomtype = room2.getRoomtype();
        String roommoney = roomtype.getRoommoney();
        if (discount == 0) {
            discount = 10;
            order.setDiscount(Integer.toString(discount));
        } else {
            Membertype membertype = new Membertype();
            membertype.setMembertypeid(discount);
            Membertype membertype1 = membertypeService.selectById(membertype);
            order.setDiscount(membertype1.getMemberdiscount().toString());
        }
        order.setOrdermoney(Integer.parseInt(roommoney) * roomdate);
        orderService.add(order);
        Integer selectsqu = orderService.selectsqu();
        order.setOrderid(selectsqu);
        roomorder.setOrder(order);
        roomorder.setRoom(room1);
        roomorderService.add(roomorder);
        room2.setRoomcondition("3");
        roomService.modify(room2);
        Reserve reserve = new Reserve();
        reserve.setResid(resid);
        reserve.setDelflag(1);
        reserveService.update(reserve);
        return "redirect:/reserve/showAll";
    }

    //前台退房
    @RequestMapping("/removes")
    @ResponseBody
    public Map<Object, Object> removes(String[] ids) {
        Map<Object, Object> map = new HashMap<>();
        roomorderService.removes(ids);
        map.put("msg", "删除成功");
        return map;
    }

    //订单
    @RequestMapping("/showAll2")
    public String showAll2(Roomorder roomorder, Query query) {
        Page<Object> page = PageHelper.startPage(query.getPageSum(), query.getPageSize());
        List<Roomorder> rooms = roomorderService.selectAll(roomorder);
        Integer count = (int) (page.getTotal() % query.getPageSize() == 0 ? (page.getTotal() / query.getPageSize()) : (page.getTotal() / query.getPageSize() + 1));
        query.setCount(count);
        httpServletRequest.setAttribute("rooms", rooms);
        return "forward:/frontPage/manager/settle/settle.jsp";
    }

    //前台购买酒水
    @RequestMapping("/shopgoods")
    @ResponseBody
    public Map<Object, Object> shopgoods(Integer roomids, Integer goodsnum, Integer goodsid) {
        Map<Object, Object> map = new HashMap<>();
        //根据商品id查询是否由库存
        Goodsstock goodsstock = new Goodsstock();
        Goods goods = new Goods();
        goods.setGoodsid(goodsid);
        goodsstock.setGoods(goods);
        Goodsstock goodsstock1 = goodsstockService.selectById1(goodsstock);
        Integer goodsnum1 = goodsstock1.getGoodsnum();
        if (goodsnum1 >= goodsnum) {
            //将库存减少
            goodsstock1.setGoodsnum(goodsnum1 - goodsnum);
            goodsstockService.update(goodsstock1);
            //根据房间id和房间支付状态查出当前订单id
            Room room = new Room();
            room.setRoomid(roomids);
            Integer selectorderid = orderService.selectorder(room);
            //创建商品订单对象
            Goodsorder goodsorder = new Goodsorder();
            goodsorder.setGoodsnum(goodsnum);
            Order order = new Order();
            order.setOrderid(selectorderid);
            goodsorder.setOrder(order);
            goodsorder.setDelflag(0);
            Goods goods1 = new Goods();
            goods1.setGoodsid(goodsid);
            goodsorder.setGoods(goods1);
            //更新订单表价钱
            BigDecimal goodsoutprice = goodsstock1.getGoodsoutprice();
            int i = goodsoutprice.intValue();
            Integer count = i * goodsnum;
            Order order1 = orderService.selectById(order);
            order.setOrdermoney(order1.getOrdermoney() + count);
            orderService.update(order);
            goodsorderService.add(goodsorder);
            map.put("msg", "购买成功");
        } else {
            map.put("msg", "购买失败，库存不足");
        }
        return map;
    }

    //查询订单详情
    @RequestMapping("selectOrder")
    @ResponseBody
    public Map<String, List> selectOrder(Roomorder roomorder, Goodsorder goodsorder, Integer orderid) {
        Map<String, List> map = new HashMap<>();
        Order order = new Order();
        order.setOrderid(orderid);
        roomorder.setOrder(order);
        goodsorder.setOrder(order);
        List<Roomorder> rooms = roomorderService.selectAll(roomorder);
        List<Goodsorder> goods = goodsorderService.selectAll(goodsorder);
        map.put("rooms", rooms);
        map.put("goods", goods);
        return map;
    }

    //修改查询
    @RequestMapping("selectById")
    @ResponseBody
    public Roomorder selectById(Roomorder room) {
        Roomorder room1 = roomorderService.selectById(room);
        return room1;
    }

    //修改
    @RequestMapping("/update")
    public void update(Roomorder room) {
        roomorderService.update(room);
    }

    @RequestMapping("/modify")
    @ResponseBody
    public Map<String, String> modify(Roomorder room) {
        Map<String, String> map = new HashMap<>();
        map.put("msg", "修改成功");
        return map;
    }

    //支付中
    @RequestMapping("/ordering")
    public void ordering(Integer orderid) {
        HttpSession session = httpServletRequest.getSession();
        session.setAttribute("orderid", orderid);
    }

    //支付完成
    @RequestMapping("/orderok")
    public String orderok() {
        HttpSession session = httpServletRequest.getSession();
        Integer orderid = (Integer) session.getAttribute("orderid");
        Order order = new Order();
        order.setOrderid(orderid);
        order.setDelflag(1);
        orderService.update(order);
        Roomorder roomorder = new Roomorder();
        roomorder.setOrder(order);
        List<Roomorder> roomorders = roomorderService.selectAll(roomorder);
        Roomorder roomorder1 = roomorders.get(0);
        Room room = roomorder1.getRoom();
        room.setRoomcondition("3");
        roomService.update(room);
        return "redirect:/frontPage/index_iframe.jsp";
    }

}
