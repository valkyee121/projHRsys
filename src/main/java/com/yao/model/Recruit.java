package com.yao.model;

import java.io.Serializable;

public class Recruit implements Serializable {
    private int riid;
    private String riName;
    private String riCompany;
    private String riSalary;
    private String riDuty;
    private String riDesired;
    private String riAddtion;
    private String riLocation;
    private int riStatus;

    public int getRiid() {
        return riid;
    }

    public void setRiid(int riid) {
        this.riid = riid;
    }

    public String getRiName() {
        return riName;
    }

    public void setRiName(String riName) {
        this.riName = riName;
    }

    public String getRiCompany() {
        return riCompany;
    }

    public void setRiCompany(String riCompany) {
        this.riCompany = riCompany;
    }

    public String getRiSalary() {
        return riSalary;
    }

    public void setRiSalary(String riSalary) {
        this.riSalary = riSalary;
    }

    public String getRiDuty() {
        return riDuty;
    }

    public void setRiDuty(String riDuty) {
        this.riDuty = riDuty;
    }

    public String getRiDesired() {
        return riDesired;
    }

    public void setRiDesired(String riDesired) {
        this.riDesired = riDesired;
    }

    public String getRiAddtion() {
        return riAddtion;
    }

    public void setRiAddtion(String riAddtion) {
        this.riAddtion = riAddtion;
    }

    public String getRiLocation() {
        return riLocation;
    }

    public void setRiLocation(String riLocation) {
        this.riLocation = riLocation;
    }

    public int getRiStatus() {
        return riStatus;
    }

    public void setRiStatus(int riStatus) {
        this.riStatus = riStatus;
    }

    @Override
    public String toString() {
        return "Recruit{" +
                "riid=" + riid +
                ", riName='" + riName + '\'' +
                ", riCompany='" + riCompany + '\'' +
                ", riSalary='" + riSalary + '\'' +
                ", riDuty='" + riDuty + '\'' +
                ", riDesired='" + riDesired + '\'' +
                ", riAddtion='" + riAddtion + '\'' +
                ", riLocation='" + riLocation + '\'' +
                ", riStatus=" + riStatus +
                '}';
    }
}