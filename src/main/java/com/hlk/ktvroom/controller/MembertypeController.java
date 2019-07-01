package com.hlk.ktvroom.controller;

import com.hlk.ktvroom.entity.Membertype;
import com.hlk.ktvroom.service.MembertypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/membertype")
public class MembertypeController {
    @Autowired
    private MembertypeService membertypeService;
    @Autowired
    private HttpServletRequest httpServletRequest;

    //展示所有
    @RequestMapping("/showAll")
    public List<Membertype> showAll(Membertype membertype) {
        List<Membertype> membertypes = membertypeService.selectAll(membertype);
        return membertypes;
    }

    //后台添加会员
    @RequestMapping("/insert")
    public Map<Object, Object> add(Membertype membertype) {
        Integer integer = membertypeService.selectCount();
        membertype.setMembertypeid(integer + 1);
        Map<Object, Object> map = new HashMap<>();
        int i = membertypeService.insert(membertype);
        if (i == 1) {
            map.put("msg", "添加成功");
        } else {
            map.put("msg", "添加失败");
        }
        return map;
    }

    //批量删除
    @RequestMapping("/removes")
    public Map<Object, Object> removes(String... ids) {

        Map<Object, Object> map = new HashMap<>();
        membertypeService.removes(ids);
        map.put("msg", "删除成功");
        return map;
    }

    //根据id查询
    @RequestMapping("/selectById")
    public Membertype selectById(Membertype membertype) {
        Membertype membertype1 = membertypeService.selectById(membertype);
        return membertype1;

    }

    //修改
    @RequestMapping("/update")
    public Map<Object, Object> update(Membertype membertype) {
        Map<Object, Object> map = new HashMap<>();
        int i = membertypeService.updateByPrimaryKeySelective(membertype);
        if (i == 1) {
            map.put("msg", "修改成功");
        } else {
            map.put("msg", "修改失败");
        }
        return map;
    }

}
