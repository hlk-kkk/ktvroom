package com.hlk.ktvroom.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Room implements Serializable {
    private Integer roomid;

    private String roomname;

    private Roomtype roomtype;

    private String roomcondition;


}