package com.hlk.ktvroom.controller;

import com.hlk.ktvroom.entity.Goods;
import com.hlk.ktvroom.entity.Goodsstock;
import com.hlk.ktvroom.service.GoodsService;
import com.hlk.ktvroom.service.GoodsstockService;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Api(value = "goodsstock controller", tags = "用户接口文档")
@RestController
@RequestMapping("/goodsstock")
public class GoodsstockController {
    @Autowired
    private GoodsstockService goodsstockService;
    @Autowired
    private GoodsService goodsService;
    @Autowired
    private HttpServletRequest httpServletRequest;

    //展示所有
    @RequestMapping("/showAll")
    public List<Goodsstock> showAll(Goodsstock goodsstock) {
        List<Goodsstock> goodsstocks = goodsstockService.selectAll(goodsstock);
        return goodsstocks;
    }

    //后台添加商品
    @RequestMapping("/insert")
    public void add(Goodsstock goodsstock) {
        Goods goods = goodsstock.getGoods();
        goods.setGoodsprice(goodsstock.getGoodsinprice());
        goods.setDelfag(1);
        goodsService.add(goods);
        goodsstock.setGoods(goods);
        goodsstockService.add(goodsstock);
    }

    //批量删除
    @RequestMapping("/removes")
    public Map<Object, Object> removes(String[] ids) {
        Map<Object, Object> map = new HashMap<>();
        goodsstockService.removes(ids);
        map.put("msg", "删除成功");
        return map;
    }

    //修改查询
    @RequestMapping("/selectById")
    public Goodsstock selectById(Goodsstock goodsstock) {
        Goodsstock goodsstock1 = goodsstockService.selectById(goodsstock);
        return goodsstock1;
    }

    //修改
    @RequestMapping("/update")
    public Map<Object, Object> update(Goodsstock goodsstock) {
        Map<Object, Object> map = new HashMap<>();
        goodsService.update(goodsstock.getGoods());
        goodsstockService.update(goodsstock);
        map.put("msg", "修改成功");
        return map;
    }
}
