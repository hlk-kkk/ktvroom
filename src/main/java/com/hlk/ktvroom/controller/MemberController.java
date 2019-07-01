package com.hlk.ktvroom.controller;

import com.hlk.ktvroom.entity.Member;
import com.hlk.ktvroom.entity.Membertype;
import com.hlk.ktvroom.service.MemberService;
import com.hlk.ktvroom.service.MembertypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Controller
@RequestMapping("/member")
public class MemberController {
    @Autowired
    private MemberService memberService;
    @Autowired
    private MembertypeService membertypeService;
    @Autowired
    private HttpServletRequest httpServletRequest;

    //提升会员
    @RequestMapping("/improve")
    @ResponseBody
    public Map improve(Member member) {
        Map<String, String> map = new HashMap<>();
        Member member1 = memberService.selectById(member);
        Membertype membertype = member1.getMembertype();
        Integer membertypeid = membertype.getMembertypeid();
        Membertype membertype1 = membertypeService.selectByPrimaryKey(membertypeid + 1);
        if (membertype1 == null) {
            map.put("msg", "该用户以达到最高等级");
        } else {
            if (member1.getMemberintegral() >= membertype1.getMemberintegral()) {
                member1.setMembertype(membertype1);
                memberService.update(member1);
                map.put("msg", "提升会员等级成功");
            } else {
                map.put("msg", "当前积分达不到提升标准");
            }
        }
        return map;
    }

    //展示所有
    @RequestMapping("/showAll")
    @ResponseBody
    public List<Member> showAll(Member member) {
        List<Member> users = memberService.selectAll(member);
        return users;
    }

    //展示所有
    @RequestMapping("/showAll1")
    public String showAll1(Member member) {
        List<Member> users = memberService.selectAll(member);
        httpServletRequest.setAttribute("members", users);
        return "forward:/frontPage/manager/member/member.jsp";
    }

    //后台添加会员
    @RequestMapping("/insert")
    @ResponseBody
    public Map<Object, Object> add(Member member) {
        Map<Object, Object> map = new HashMap<>();
        Membertype membertype = new Membertype();
        membertype.setMembertypeid(1);
        member.setMembertype(membertype);
        member.setEntryDate(new Date());
        String uuid = UUID.randomUUID().toString().replace("-", "").substring(21);
        member.setMembernum(uuid);
        member.setMemberintegral(0);
        member.setDelfag(2);
        Integer add = memberService.add(member);
        if (add == 1) {
            map.put("msg", "添加成功");
        } else {
            map.put("msg", "添加失败");
        }
        return map;
    }

    //批量删除
    @RequestMapping("/removes")
    @ResponseBody
    public Map<Object, Object> removes(String... ids) {
        Map<Object, Object> map = new HashMap<>();
        memberService.removes(ids);
        map.put("msg", "删除成功");
        return map;
    }

    //根据id查询
    @RequestMapping("/selectById")
    @ResponseBody
    public Member selectById(Member member) {
        Member member1 = memberService.selectById(member);
        String auditingmsg = member1.getAuditingmsg();
        String auditingmsg1 = "前台用户申请冻结该用户,原因:" + auditingmsg;
        member1.setAuditingmsg(auditingmsg1);
        return member1;

    }

    //修改
    @RequestMapping("/update")
    public void update(Member member) {
        Map<String, String> map = new HashMap<>();
        memberService.update(member);
        map.put("msg", "修改成功");
    }

    //修改状态
    @RequestMapping("/modify")
    @ResponseBody
    public Map<String, String> modify1(Member member) {
        member.setDelfag(0);
        Map<String, String> map = new HashMap<>();
        memberService.modify(member);
        map.put("msg", "修改成功");
        return map;
    }

    //前台添加会员
    @RequestMapping("/insert1")
    public String add1(Member member) {
        Map<Object, Object> map = new HashMap<>();
        Membertype membertype = new Membertype();
        membertype.setMembertypeid(1);
        member.setMembertype(membertype);
        member.setEntryDate(new Date());
        String uuid = UUID.randomUUID().toString().replace("-", "").substring(21);
        member.setMembernum(uuid);
        member.setMemberintegral(0);
        member.setDelfag(2);
        Integer add = memberService.add(member);
        if (add == 1) {
            map.put("msg", "添加成功");
        } else {
            map.put("msg", "添加失败");
        }
        return "redirect:/member/showAll1";
    }
}
