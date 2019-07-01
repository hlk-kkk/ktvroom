package com.hlk.ktvroom.controller;

import com.hlk.ktvroom.entity.Goods;
import com.hlk.ktvroom.service.GoodsService;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Api(value = "goods controller", tags = "用户接口文档")
@Controller
@RequestMapping("/goods")
public class GoodsController {
    @Autowired
    private GoodsService goodsService;
    @Autowired
    private HttpServletRequest httpServletRequest;

    //展示所有
    @RequestMapping("/showAll")
    @ResponseBody
    public List<Goods> showAll(Goods goods) {
        List<Goods> goodss = goodsService.selectAll(goods);
        return goodss;
    }

    //前台展示所有
    @RequestMapping("/showAll1")
    @ResponseBody
    public List<Goods> showAll1(Goods goods) {
        List<Goods> goodss = goodsService.selectAll(goods);
        return goodss;
    }

    //后台添加商品
    @RequestMapping("/insert")
    @ResponseBody
    public void add(Goods goods) {
        System.out.println(goods);
        goodsService.add(goods);
    }

    //批量删除
    @RequestMapping("/removes")
    @ResponseBody
    public Map<Object, Object> removes(String[] ids) {
        Map<Object, Object> map = new HashMap<>();
        goodsService.removes(ids);
        map.put("msg", "删除成功");
        return map;
    }

    //修改查询
    @RequestMapping("selectById")
    @ResponseBody
    public Goods selectById(Goods goods) {
        Goods goods1 = goodsService.selectById(goods);
        return goods1;
    }

    //修改
    @RequestMapping("/update")
    public void update(Goods goods) {
        goodsService.update(goods);
    }

    //前台消费商品
    @RequestMapping("/consume")
    public void consume() {


    }
}
