package com.hlk.ktvroom.test;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.date.DateUtil;
import cn.hutool.poi.excel.ExcelUtil;
import cn.hutool.poi.excel.ExcelWriter;
import cn.hutool.poi.excel.cell.CellUtil;
import com.hlk.ktvroom.entity.Goodsorder;
import com.hlk.ktvroom.entity.Roomorder;
import com.hlk.ktvroom.service.GoodsorderService;
import com.hlk.ktvroom.service.RoomorderService;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Sheet;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.*;

@RunWith(SpringRunner.class)
public class Testexport {
    @Autowired
    private RoomorderService roomorderService;
    @Autowired
    private GoodsorderService goodsorderService;

    @Test
    public void test1() {
        Map<Integer, List<Object>> map = new HashMap<>();
        List<Roomorder> roomorders = roomorderService.selectAll(new Roomorder());
        List<Goodsorder> goodsorders = goodsorderService.selectAll(new Goodsorder());
        for (Roomorder roomorder : roomorders) {
            Integer orderid = roomorder.getOrder().getOrderid();
            List<Object> objects = new ArrayList<>();
            objects.add(roomorder);
            map.put(orderid, objects);
            for (Goodsorder goodsorder : goodsorders) {
                if (goodsorder.getOrder().getOrderid() == orderid) {
                    objects.add(goodsorder);
                }
            }
            map.put(orderid, objects);
        }
        // 通过工具类创建writer
        ExcelWriter writer = ExcelUtil.getWriter("d:/writeMapTest40.xlsx");
        writer.merge(0, "KTV销售统计报表");
        writer.renameSheet("月信息表");
        Sheet sheet = writer.getSheet();
        CellStyle cellStyle = writer.getCellStyle();
        for (Map.Entry<Integer, List<Object>> map1 : map.entrySet()) {
            Integer key = map1.getKey();
            List<Object> value = map1.getValue();
            ArrayList<Object> rows1 = CollUtil.newArrayList("订单id", "房间号码", "房间类型", "开始时间", "结束时间", "订单金额");
            writer.writeRow(rows1);
            int i = 0;
            int currentRow1 = 0;
            int currentRow = 0;
            Map<Integer, Goodsorder> map2 = new HashMap<>();
            for (Object o : value) {
//            writer.merge(0, "月订单信息");
                if (o instanceof Roomorder) {
                    Roomorder roomorder = (Roomorder) o;
                    Date begintime = roomorder.getOrder().getBegintime();
                    Date endtime = roomorder.getOrder().getEndtime();
                    String format = DateUtil.format(begintime, "yyyy/MM/dd HH:mm");
                    String format1 = DateUtil.format(endtime, "yyyy/MM/dd HH:mm");
                    ArrayList<Object> rows2 = CollUtil.newArrayList(roomorder.getOrder().getOrderid(), roomorder.getRoom().getRoomname(), roomorder.getRoom().getRoomtype().getRoomtype(), format, format1, roomorder.getOrder().getOrdermoney());
                    writer.writeRow(rows2);
                    currentRow = writer.getCurrentRow();
                }
                if (o instanceof Goodsorder) {
                    if (i == 0) {
                        ArrayList<Object> rows3 = CollUtil.newArrayList("订单id", "商品名称", "商品数量");
                        writer.writeRow(rows3);
                        i++;
                    }
                    Goodsorder goodsorder = (Goodsorder) o;
                    if (map2.containsKey(goodsorder.getGoods().getGoodsid())) {
                        Integer goodsnum = map2.get(goodsorder.getGoods().getGoodsid()).getGoodsnum();
                        Integer goodsnum1 = goodsorder.getGoodsnum();
                        goodsorder.setGoodsnum(goodsnum + goodsnum1);
                        map2.put(goodsorder.getGoods().getGoodsid(), goodsorder);
                    } else {
                        map2.put(goodsorder.getGoods().getGoodsid(), goodsorder);
                    }
                }

            }
            for (Map.Entry<Integer, Goodsorder> map3 : map2.entrySet()) {
                ArrayList<Object> rows2 = CollUtil.newArrayList(map3.getKey(), map3.getValue().getGoods().getGoodsname(), map3.getValue().getGoodsnum());
                writer.writeRow(rows2);
            }
            currentRow1 = writer.getCurrentRow();
            System.out.println(currentRow + "!!!" + currentRow1);
            if (currentRow != currentRow1)
                CellUtil.mergingCells(sheet, currentRow - 1, currentRow1 - 1, 0, 0, cellStyle);
        }
        ArrayList<Object> rows2 = CollUtil.newArrayList("总订单数量", "", "总销售额", "");
        writer.writeRow(rows2);

        writer.autoSizeColumn(3);
        writer.autoSizeColumn(4);

        writer.close();
    }

}
