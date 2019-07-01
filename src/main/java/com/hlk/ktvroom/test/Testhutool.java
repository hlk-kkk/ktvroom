package com.hlk.ktvroom.test;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.date.DateTime;
import cn.hutool.core.date.DateUtil;
import cn.hutool.log.Log;
import cn.hutool.log.LogFactory;
import cn.hutool.log.level.Level;
import cn.hutool.poi.excel.ExcelUtil;
import cn.hutool.poi.excel.ExcelWriter;
import cn.hutool.poi.excel.cell.CellUtil;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Sheet;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.*;

@RunWith(SpringRunner.class)

public class Testhutool {
    @Test
    public void test1() {
        Map<String, Object> row1 = new LinkedHashMap<>();
        row1.put("姓名", "张三");
        row1.put("年龄", 23);
        row1.put("成绩", 88.32);
        row1.put("是否合格", true);
        row1.put("考试日期", DateUtil.date());
        Map<String, Object> row2 = new LinkedHashMap<>();
        row2.put("姓名", "李四");
        row2.put("年龄", 33);
        row2.put("成绩", 59.50);
        row2.put("是否合格", false);
        row2.put("考试日期", DateUtil.date());
        Map<String, Object> row3 = new LinkedHashMap<>();
        row2.put("姓名", "李四");
        row2.put("年龄", 33);
        row2.put("成绩", 59.50);
        row2.put("是否合格", false);
        row2.put("考试日期", DateUtil.date());
        Map<String, Object> row4 = new LinkedHashMap<>();
        row2.put("姓名", "李四");
        row2.put("年龄", 33);
        row2.put("成绩", 59.50);
        row2.put("是否合格", false);
        row2.put("考试日期", DateUtil.date());
        Map<String, Object> row5 = new LinkedHashMap<>();
        row2.put("姓名", "李四");
        row2.put("年龄", 33);
        row2.put("成绩", 59.50);
        row2.put("是否合格", false);
        row2.put("考试日期", DateUtil.date());
        ArrayList<Map<String, Object>> rows = CollUtil.newArrayList(row1, row2, row3, row4, row5);
        // 通过工具类创建writer
        ExcelWriter writer = ExcelUtil.getWriter("d:/writeMapTest6.xlsx");
//   Map<Integer,List<String>> map=new HashMap();
//       List<String> row3 = CollUtil.newArrayList("aa", "bb", "cc", "dd");
//   map.put(1,row3);
//   writer.writeRow(map,false);
        writer.renameSheet("月信息表");
        Sheet sheet = writer.getSheet();
        CellStyle cellStyle = writer.getCellStyle();
        CellUtil.mergingCells(sheet, 2, 3, 1, 2, cellStyle);
//// 合并单元格后的标题行，使用默认标题样式
        writer.merge(row1.size() - 1, "一班成绩单");
//// 一次性写出内容，使用默认样式，强制输出标题
        writer.write(rows, true);
//// 关闭writer，释放内存
        writer.close();
    }

    @Test
    public void test2() {
        Log log = LogFactory.get();
        try {
            log.info("This is {} log", Level.INFO);
        } catch (Exception e) {
            log.info("This is {} 22log", Level.INFO);
            e.printStackTrace();
        }
    }

    @Test
    public void test3() {
        String i = "  ";
        i.trim();
        if (i != null && i.length() > 0) {
            System.out.println("不为空");
        } else {
            System.out.println("i为空");
        }
    }

    @Test
    public void test4() {
        List<String> row1 = CollUtil.newArrayList("aa", "bb", "cc", "dd");
        List<String> row2 = CollUtil.newArrayList("aa1", "bb1", "cc1", "dd1");
        List<String> row3 = CollUtil.newArrayList("aa2", "bb2", "cc2", "dd2");
        List<String> row4 = CollUtil.newArrayList("aa3", "bb3", "cc3", "dd3");
        List<String> row5 = CollUtil.newArrayList("aa4", "bb4", "cc4", "dd4");
        List<List<String>> rows = CollUtil.newArrayList(row1, row2, row3, row4, row5);

        //通过工具类创建writer
        ExcelWriter writer = ExcelUtil.getWriter("d:/writeTest.xlsx");
//通过构造方法创建writer
//ExcelWriter writer = new ExcelWriter("d:/writeTest.xls");

//跳过当前行，既第一行，非必须，在此演示用
        writer.passCurrentRow();

//合并单元格后的标题行，使用默认标题样式
        writer.merge(rows.size() - 1, "测试标题");
//一次性写出内容，强制输出标题
        writer.write(rows, true);
//关闭writer，释放内存
        writer.close();
    }

    @Test
    public void test5() {
        Date date = DateUtil.date();
        System.out.println(DateUtil.now());
        DateTime dateTime = DateUtil.offsetHour(date, 55);
        System.out.println(dateTime);
        UUID uuid = UUID.randomUUID();
        System.out.println(uuid.toString());
        System.out.println(uuid.toString() + 1);
        String i = "2321321";
        int t = 1;
        System.out.println(t + i);

    }
}

