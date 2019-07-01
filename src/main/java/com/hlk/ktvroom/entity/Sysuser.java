package com.hlk.ktvroom.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@AllArgsConstructor
@Data
@NoArgsConstructor
public class Sysuser implements Serializable {
    private Integer sysid;

    private String sysname;

    private String syspwd;

    private String sysword;
}