package com.hlk.ktvroom.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.math.BigDecimal;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Goods implements Serializable {
    private Integer goodsid;

    private String goodsname;

    private Goodstype goodstype;

    private Integer delfag;

    private BigDecimal goodsprice;

    private static final long serialVersionUID = 1L;
}