package com.hlk.ktvroom.controller;

import com.hlk.ktvroom.entity.Goodstype;
import com.hlk.ktvroom.service.GoodstypeService;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Api(value = "goodstype controller", tags = "用户接口文档")
@RestController
@RequestMapping("/goodstype")
public class GoodstypeController {
    @Autowired
    private GoodstypeService goodstypeService;
    @Autowired
    private HttpServletRequest httpServletRequest;

    //展示所有
    @RequestMapping("/showAll")
    public List<Goodstype> showAll(Goodstype goodstype) {
        List<Goodstype> goodstypes = goodstypeService.selectAll(goodstype);
        return goodstypes;
    }

    //后台添加商品
    @RequestMapping("/insert")
    public void add(Goodstype goodstype) {
        goodstypeService.add(goodstype);
    }

    //批量删除
    @RequestMapping("/removes")
    public Map<Object, Object> removes(String[] ids) {
        Map<Object, Object> map = new HashMap<>();
        goodstypeService.removes(ids);
        map.put("msg", "删除成功");
        return map;
    }

    //修改查询
    @RequestMapping("selectById")
    public Goodstype selectById(Goodstype goodstype) {
        Goodstype goodstype1 = goodstypeService.selectById(goodstype);
        return goodstype1;
    }

    //修改
    @RequestMapping("/update")
    public void update(Goodstype goodstype) {
        goodstypeService.update(goodstype);
    }
}
