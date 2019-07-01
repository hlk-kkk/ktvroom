package com.hlk.ktvroom.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Goodsorder implements Serializable {
    private Integer goodsorderid;

    private Goods goods;

    private Order order;

    private Integer delflag;

    private Integer goodsnum;


}