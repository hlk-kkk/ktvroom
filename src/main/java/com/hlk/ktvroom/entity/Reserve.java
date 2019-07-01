package com.hlk.ktvroom.entity;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Reserve implements Serializable {
    private Integer resid;

    private String resname;

    private String resphone;

    private Integer delflag;

    private Roomtype roomtype;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:MM:SS")
    @JSONField(format = "yyyy-MM-dd HH:MM:SS")
    private Date resarrtime;


}