package com.hlk.ktvroom;

import org.springframework.util.StopWatch;

public class TestStopWatch {
    public static void main(String[] args) throws InterruptedException {
        StopWatch stopWatch = new StopWatch();
        //任务一
        stopWatch.start("任务一");
        Thread.sleep(10000);
        stopWatch.stop();
        //任务二
        stopWatch.start("任务二");
        Thread.sleep(30000);
        stopWatch.stop();
        String result = stopWatch.prettyPrint();
        System.out.println(result);
    }
}
