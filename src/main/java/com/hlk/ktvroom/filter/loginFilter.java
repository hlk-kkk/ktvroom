package com.hlk.ktvroom.filter;

import com.hlk.ktvroom.entity.Sysuser;
import com.hlk.ktvroom.entity.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(urlPatterns = {"/backPage/*", "/frontPage/*"}, filterName = "logFilter2")
public class loginFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        //每一个项目对于登陆的实现逻辑都有所区别，我这里使用最简单的Session提取User来验证登陆。
        HttpServletRequest httpServletRequest = (HttpServletRequest) servletRequest;
        HttpServletResponse httpServletResponse = (HttpServletResponse) servletResponse;
        HttpSession session = httpServletRequest.getSession();
        //这里的User是登陆时放入session的
        User user = (User) session.getAttribute("user");
        Sysuser sysuser = (Sysuser) session.getAttribute("sysuser");
        //如果session中没有user，表示没登陆
        if (user == null && sysuser == null) {
            //这个方法返回false表示忽略当前请求，如果一个用户调用了需要登陆才能使用的接口，如果他没有登陆这里会直接忽略掉
            //当然你可以利用response给用户返回一些提示信息，告诉他没登陆
            httpServletResponse.sendRedirect(httpServletRequest.getContextPath() + "/main/login.jsp");
        } else {
            filterChain.doFilter(servletRequest, servletResponse);
            //如果session里有user，表示该用户已经登陆，放行，用户即可继续调用自己需要的接口
        }
    }

    @Override
    public void destroy() {
    }
}
