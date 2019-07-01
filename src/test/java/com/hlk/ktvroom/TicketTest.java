package com.hlk.ktvroom;

import cn.hutool.http.HttpUtil;
import org.junit.Test;

import java.util.HashMap;

public class TicketTest {
    @Test
    public void test1() {
        String url = "https://buy.damai.cn/multi/trans/adjustConfirmOrder?feature=%7B%22serviceVersion%22:%221.8.5%22%7D";
        HashMap<String, Object> paramMap = new HashMap<>();
        paramMap.put("city", "北京");
        String result1 = HttpUtil.post(url, paramMap);
        System.out.println(result1);
    }

    @Test
    public void test2() {
        String str = "d#s#fds##";
        String[] split = str.split("#");
        for (String s : split) {
            System.out.println("str=" + s);
        }

    }

}
