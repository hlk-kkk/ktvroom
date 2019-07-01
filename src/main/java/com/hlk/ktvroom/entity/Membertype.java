package com.hlk.ktvroom.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.math.BigDecimal;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Membertype implements Serializable {
    private Integer membertypeid;

    private String memberlevel;

    private BigDecimal memberdiscount;

    private Integer memberintegral;

}