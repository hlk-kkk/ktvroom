package com.hlk.ktvroom.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Roomorder implements Serializable {
    private Integer roomorderid;

    private Room room;

    private Order order;


}