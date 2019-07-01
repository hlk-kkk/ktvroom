package com.hlk.ktvroom.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.math.BigDecimal;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Goodsstock implements Serializable {
    private Integer goodsstockid;

    private Goods goods;

    private Integer goodsnum;

    private BigDecimal goodsinprice;

    private BigDecimal goodsoutprice;


}