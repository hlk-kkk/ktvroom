package com.hlk.ktvroom.controller;

import com.hlk.ktvroom.entity.Sysuser;
import com.hlk.ktvroom.entity.User;
import com.hlk.ktvroom.service.SysuserService;
import com.hlk.ktvroom.service.UserService;
import com.hlk.ktvroom.util.ValidateImageCodeUtils;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import net.sourceforge.pinyin4j.PinyinHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.*;

@Api(value = "user controller", tags = "用户接口文档")
@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;
    @Autowired
    private SysuserService sysuserService;
    @Autowired
    private HttpServletRequest httpServletRequest;

    //前台登录
    @ApiOperation(value = "根据用户名与密码查询数据库", notes = "登录功能")
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String Login(String username, String password, Integer status) throws InterruptedException {
        HttpSession session = httpServletRequest.getSession();
        User user = new User();
        Sysuser sysuser = new Sysuser();
        boolean b = false;
        if (status == 1) {
            user.setUsername(username);
            user.setUserpwd(password);
            List<User> users = userService.selectAll(user);
            b = userService.login(user);
            if (b) {
                session.setAttribute("user", users.get(0));
                Thread.sleep(500);
                return "redirect:/frontPage/index_iframe.jsp";
            }
        } else {
            sysuser.setSysname(username);
            sysuser.setSyspwd(password);
            List<Sysuser> sysusers = sysuserService.selectAll(sysuser);
            b = sysuserService.login(sysuser);
            if (b) {
                session.setAttribute("sysuser", sysusers.get(0));
                Thread.sleep(500);
                return "redirect:/backPage/menu.jsp";
            }
        }
        if (!b) {
            httpServletRequest.setAttribute("msg", "用户名或者密码错误");
            Thread.sleep(500);
            return "forward:/main/login.jsp";
        }
        return "";
    }

    @RequestMapping("/register")
    public String Register(Sysuser sysuser, String code, HttpSession session) {
        String realcode = (String) session.getAttribute("code");
        if (realcode.equals(code)) {
            Sysuser sysuser1 = sysuserService.selectById(sysuser);
            if (sysuser1 == null) {
                httpServletRequest.setAttribute("msg", "注册失败邀请码错误");
                return "forward:/main/register.jsp";
            } else {
                String uuid = UUID.randomUUID().toString().replace("-", "").substring(21);
                sysuser.setSysword(uuid);
                session.setAttribute("sysword", "你的邀请码为" + uuid + "请牢记！！！！！！");
                sysuserService.register(sysuser);
                return "forward:/main/login.jsp";
            }
        } else {
            httpServletRequest.setAttribute("msg", "注册失败验证码错误");
            return "forward:/main/register.jsp";
        }
    }

    //展示所有
    @RequestMapping("/showAll")
    @ResponseBody
    public List<User> showAll(User user) {
        System.out.println(user);
        List<User> users = userService.selectAll(user);
        return users;
    }

    //后台添加用户
    @RequestMapping("/insert")
    public void add(User user) {
        String realname = user.getRealname();
        String convert = "";
        for (int j = 0; j < realname.length(); j++) {
            char word = realname.charAt(j);
            String[] pinyinArray = PinyinHelper.toHanyuPinyinStringArray(word);
            if (pinyinArray != null) {
                convert += pinyinArray[0].charAt(0);
            } else {
                convert += word;
            }
        }
        user.setUsername(convert);
        user.setUserpwd("123456");
        user.setEntryData(new Date());
        user.setStatus(1);
        userService.add(user);
    }

    //批量删除
    @RequestMapping("/removes")
    @ResponseBody
    public Map<Object, Object> removes(String[] ids) {
        Map<Object, Object> map = new HashMap<>();
        userService.removes(ids);
        map.put("msg", "删除成功");
        return map;
    }

    //修改查询
    @RequestMapping("selectById")
    @ResponseBody
    public User selectById(User user) {
        User user1 = userService.selectById(user);
        return user1;
    }

    //修改
    @RequestMapping("/update")
    @ResponseBody
    public Map<Object, Object> update(User user) {
        Map<Object, Object> map = new HashMap<>();
        userService.update(user);
        map.put("msg", "修改成功");
        return map;
    }

    @RequestMapping("/modify")
    @ResponseBody
    public Map<String, String> modify(User user) {
        Map<String, String> map = new HashMap<>();
        userService.modify(user);
        map.put("msg", "修改成功");
        return map;
    }

    //验证码
    @RequestMapping("/getCode")
    public void getCode(HttpServletResponse response, HttpSession session) {
        String code = ValidateImageCodeUtils.getSecurityCode();
        session.setAttribute("code", code);
        BufferedImage image = ValidateImageCodeUtils.createImage(code);
        ServletOutputStream out = null;
        try {
            out = response.getOutputStream();
        } catch (IOException e1) {
            // TODO Auto-generated catch block
            e1.printStackTrace();
        }
        try {
            ImageIO.write(image, "png", out);
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } finally {
            try {
                out.close();
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
    }

    @RequestMapping("/code1")
    @ResponseBody
    public Map<String, String> Code(String code2, HttpSession session) {
        Map<String, String> map = new HashMap<String, String>();
        String realcode = (String) session.getAttribute("code");
        System.out.println(realcode);
        System.out.println(code2);
        if (realcode.equals(code2)) {
            map.put("msg", "验证码正确");
        } else {
            map.put("msg", "验证码错误");
        }
        return map;
    }

}
