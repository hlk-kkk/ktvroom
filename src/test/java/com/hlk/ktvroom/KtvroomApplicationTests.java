package com.hlk.ktvroom;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@SpringBootTest
public class KtvroomApplicationTests {

    @Test
    public void contextLoads() {
        Runnable r = () -> System.out.println("hehe");
        r.run();
    }
}
