package com.yao.model;

import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

public class Attend implements Serializable {
    private int atteID;
    private int atteEmpID;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date atteBegin;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date atteEnd;

    public int getAtteID() {
        return atteID;
    }

    public void setAtteID(int atteID) {
        this.atteID = atteID;
    }

    public int getAtteEmpID() {
        return atteEmpID;
    }

    public void setAtteEmpID(int atteEmpID) {
        this.atteEmpID = atteEmpID;
    }

    public Date getAtteBegin() {
        return atteBegin;
    }

    public void setAtteBegin(Date atteBegin) {
        this.atteBegin = atteBegin;
    }

    public Date getAtteEnd() {
        return atteEnd;
    }

    public void setAtteEnd(Date atteEnd) {
        this.atteEnd = atteEnd;
    }

    @Override
    public String toString() {
        return "Attend{" +
                "atteID=" + atteID +
                ", atteEmpID=" + atteEmpID +
                ", atteBegin=" + atteBegin +
                ", atteEnd=" + atteEnd +
                '}';
    }
}
