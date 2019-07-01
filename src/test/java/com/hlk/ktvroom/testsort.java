package com.hlk.ktvroom;

import org.junit.Test;

import java.util.ArrayList;
import java.util.List;

public class testsort {
    @Test
    public void test1() {
        List<Integer> list = new ArrayList<>();
        list.add(1);
        list.add(12);
        list.add(4);
        list.add(8);
        list.add(3);
        int[] a = {1, 12, 4, 8, 5, 2, 43, 32, 46, 22, 11, 555, 33, 76, 34, 26, 9};
        //冒泡排序，前面一个跟后面一个比较大的放后面
        for (int i = 0; i < a.length - 1; i++) {
            for (int j = 0; j < a.length - 1; j++) {
                if (a[j] > a[j + 1]) {
                    int b = a[j];
                    a[j] = a[j + 1];
                    a[j + 1] = b;
                }
            }
        }
        for (int i : a) {
            System.out.println(i);

        }
        //选择排序，第一个数跟后面所有数比较
        for (int i = 0; i < a.length - 1; i++) {
            for (int j = i; j < a.length - 1; j++) {
                if (a[i] < a[j]) {
                    int b = a[i];
                    a[i] = a[j];
                    a[j] = b;
                }
            }
        }
        for (int i : a) {
            System.out.println(i);
        }
    }
    //饿汉式
//        private static final testsort instance = new testsort();
//        public static testsort newInstance(){
//            return instance;
//        }
//        private testsort(){};

    //    private static final testsort getInstance=new testsort();
//       public static testsort newInstance(){
//           return getInstance;
//       }
//       private tessort(){};
    //懒汉式t
//     private static testsort instance=null;
//    public static synchronized  testsort newInteance(){
//         if(instance == null )
//              instance =new testsort();
//         return instance;
//    }
//    private testsort(){};
    //使用静态代码块方式
    private static class Holder {
        static final testsort instance = new testsort();
    }

    public static testsort newInstance() {
        return Holder.instance;
    }

    private testsort() {
    }
}

