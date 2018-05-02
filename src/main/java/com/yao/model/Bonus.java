package com.yao.model;

import java.io.Serializable;
import java.util.Date;

public class Bonus implements Serializable {
    private int bmID;
    private int bmEmpID;
    private double bmMoney;
    private Date bmDate;
    private String bmDetail;
    private int bmStatus;

    public int getBmID() {
        return bmID;
    }

    public void setBmID(int bmID) {
        this.bmID = bmID;
    }

    public int getBmEmpID() {
        return bmEmpID;
    }

    public void setBmEmpID(int bmEmpID) {
        this.bmEmpID = bmEmpID;
    }

    public double getBmMoney() {
        return bmMoney;
    }

    public void setBmMoney(double bmMoney) {
        this.bmMoney = bmMoney;
    }

    public Date getBmDate() {
        return bmDate;
    }

    public void setBmDate(Date bmDate) {
        this.bmDate = bmDate;
    }

    public String getBmDetail() {
        return bmDetail;
    }

    public void setBmDetail(String bmDetail) {
        this.bmDetail = bmDetail;
    }

    public int getBmStatus() {
        return bmStatus;
    }

    public void setBmStatus(int bmStatus) {
        this.bmStatus = bmStatus;
    }

    @Override
    public String toString() {
        return "Bonus{" +
                "bmID=" + bmID +
                ", bmEmpID=" + bmEmpID +
                ", bmMoney=" + bmMoney +
                ", bmDate=" + bmDate +
                ", bmDetail='" + bmDetail + '\'' +
                ", bmStatus=" + bmStatus +
                '}';
    }
}
