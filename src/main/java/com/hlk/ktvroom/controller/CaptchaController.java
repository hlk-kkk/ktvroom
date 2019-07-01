package com.hlk.ktvroom.controller;

import com.hlk.ktvroom.util.ValidateImageCodeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.IOException;

@Controller
@RequestMapping("/util")
public class CaptchaController {
    @Autowired
    private HttpSession session;

    @SuppressWarnings("AlibabaLowerCamelCaseVariableNaming")
    @RequestMapping("/captcha")
    public void Captcha(HttpServletResponse response) {
        String code = ValidateImageCodeUtils.getSecurityCode();
        System.out.println(code);
        BufferedImage image = ValidateImageCodeUtils.createImage(code);
        session.setAttribute("code", code);
        ServletOutputStream out = null;
        try {
            out = response.getOutputStream();
        } catch (IOException e) {
            e.printStackTrace();
        }
        try {
            ImageIO.write(image, "png", out);
        } catch (IOException e) {
            e.printStackTrace();
        }
//        //获得验证码对象[验证码图片，验证码码值]
//        LineCaptcha cap = CaptchaUtil.createLineCaptcha(200,40);
//        //1. 将验证码图片写出到输出流
//        ServletOutputStream outputStream = rep.getOutputStream();
//        cap.write(outputStream);
//        //2. 获得真正的验证码的值
//        String code1 = cap.getCode();
//        session.setAttribute("code", code);
    }
}
