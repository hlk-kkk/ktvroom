package com.hlk.ktvroom.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Query {
    //分页
    private Integer count;
    private Integer pageSize = 6;
    private Integer pageSum = 1;
    private Integer start;
    private Integer end;
    private String resname;
    private Integer delflag;
    private Order order;
}
