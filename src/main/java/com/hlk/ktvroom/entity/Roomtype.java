package com.hlk.ktvroom.entity;

import java.io.Serializable;

public class Roomtype implements Serializable {
    private Integer roomtypeid;

    private String roomtype;

    private String roommoney;

    private String roomremark;

    private String roomminmoney;

    private static final long serialVersionUID = 1L;

    public Integer getRoomtypeid() {
        return roomtypeid;
    }

    public void setRoomtypeid(Integer roomtypeid) {
        this.roomtypeid = roomtypeid;
    }

    public String getRoomtype() {
        return roomtype;
    }

    public void setRoomtype(String roomtype) {
        this.roomtype = roomtype == null ? null : roomtype.trim();
    }

    public String getRoommoney() {
        return roommoney;
    }

    public void setRoommoney(String roommoney) {
        this.roommoney = roommoney == null ? null : roommoney.trim();
    }

    public String getRoomremark() {
        return roomremark;
    }

    public void setRoomremark(String roomremark) {
        this.roomremark = roomremark == null ? null : roomremark.trim();
    }

    public String getRoomminmoney() {
        return roomminmoney;
    }

    public void setRoomminmoney(String roomminmoney) {
        this.roomminmoney = roomminmoney == null ? null : roomminmoney.trim();
    }

    @Override
    public boolean equals(Object that) {
        if (this == that) {
            return true;
        }
        if (that == null) {
            return false;
        }
        if (getClass() != that.getClass()) {
            return false;
        }
        Roomtype other = (Roomtype) that;
        return (this.getRoomtypeid() == null ? other.getRoomtypeid() == null : this.getRoomtypeid().equals(other.getRoomtypeid()))
                && (this.getRoomtype() == null ? other.getRoomtype() == null : this.getRoomtype().equals(other.getRoomtype()))
                && (this.getRoommoney() == null ? other.getRoommoney() == null : this.getRoommoney().equals(other.getRoommoney()))
                && (this.getRoomremark() == null ? other.getRoomremark() == null : this.getRoomremark().equals(other.getRoomremark()))
                && (this.getRoomminmoney() == null ? other.getRoomminmoney() == null : this.getRoomminmoney().equals(other.getRoomminmoney()));
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((getRoomtypeid() == null) ? 0 : getRoomtypeid().hashCode());
        result = prime * result + ((getRoomtype() == null) ? 0 : getRoomtype().hashCode());
        result = prime * result + ((getRoommoney() == null) ? 0 : getRoommoney().hashCode());
        result = prime * result + ((getRoomremark() == null) ? 0 : getRoomremark().hashCode());
        result = prime * result + ((getRoomminmoney() == null) ? 0 : getRoomminmoney().hashCode());
        return result;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", roomtypeid=").append(roomtypeid);
        sb.append(", roomtype=").append(roomtype);
        sb.append(", roommoney=").append(roommoney);
        sb.append(", roomremark=").append(roomremark);
        sb.append(", roomminmoney=").append(roomminmoney);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}