package com.yao.model;

import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

public class Dimission implements Serializable{
    private int dmID;
    private Employee employee;
    private String dmContent;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date dmDate;
    private int dmStatus;

    public int getDmID() {
        return dmID;
    }

    public void setDmID(int dmID) {
        this.dmID = dmID;
    }

    public Employee getEmployee() {
        return employee;
    }

    public void setEmployee(Employee employee) {
        this.employee = employee;
    }

    public String getDmContent() {
        return dmContent;
    }

    public void setDmContent(String dmContent) {
        this.dmContent = dmContent;
    }

    public Date getDmDate() {
        return dmDate;
    }

    public void setDmDate(Date dmDate) {
        this.dmDate = dmDate;
    }

    public int getDmStatus() {
        return dmStatus;
    }

    public void setDmStatus(int dmStatus) {
        this.dmStatus = dmStatus;
    }

    @Override
    public String toString() {
        return "Dimission{" +
                "dmID=" + dmID +
                ", employee=" + employee +
                ", dmContent='" + dmContent + '\'' +
                ", dmDate=" + dmDate +
                ", dmStatus=" + dmStatus +
                '}';
    }
}
