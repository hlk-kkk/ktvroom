package com.hlk.ktvroom;

import io.goeasy.GoEasy;
import org.junit.Test;

public class TestGoEasy {
    @Test
    public void Test1() {
        //创建goEasy对象
        GoEasy goEasy = new GoEasy("http://rest-hangzhou.goeasy.io", "BC-f4ff56b0748546268594dd8d6f91e416");
        //发送参数
        goEasy.publish("demo_channel1", "Hello world!");
    }
}
