package com.hlk.ktvroom.entity;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Member implements Serializable {
    private Integer memberid;

    private Membertype membertype;

    private String membername;

    private Integer sex;

    private String memberphone;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JSONField(format = "yyyy-MM-dd")
    private Date entryDate;

    private String membernum;

    private Integer memberintegral;

    private Integer delfag;
    private String auditingmsg;
    private static final long serialVersionUID = 1L;


}