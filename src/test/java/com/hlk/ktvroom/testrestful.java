package com.hlk.ktvroom;

import cn.hutool.http.HttpRequest;
import org.junit.Test;

public class testrestful {
    @Test
    public void test1() {
        HttpRequest httpRequest = HttpRequest.get("www.baidu.com?id=root");
        System.out.println(httpRequest);
    }
}
