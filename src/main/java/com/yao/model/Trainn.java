package com.yao.model;

import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Trainn implements Serializable {
    private int trID;
    private String trTitle;
    private String trContent;
    /*@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")*/
    private Date trBegin;
    /*@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")*/
    private Date trEnd;
    private String trLocal;
    private int trStatus;
    private List<Employee> employees = new ArrayList<Employee>();


    public int getTrID() {
        return trID;
    }

    public void setTrID(int trID) {
        this.trID = trID;
    }

    public String getTrTitle() {
        return trTitle;
    }

    public void setTrTitle(String trTitle) {
        this.trTitle = trTitle;
    }

    public String getTrContent() {
        return trContent;
    }

    public void setTrContent(String trContent) {
        this.trContent = trContent;
    }

    public Date getTrBegin() {
        return trBegin;
    }

    public void setTrBegin(Date trBegin) {
        this.trBegin = trBegin;
    }

    public Date getTrEnd() {
        return trEnd;
    }

    public void setTrEnd(Date trEnd) {
        this.trEnd = trEnd;
    }

    public String getTrLocal() {
        return trLocal;
    }

    public void setTrLocal(String trLocal) {
        this.trLocal = trLocal;
    }

    public int getTrStatus() {
        return trStatus;
    }

    public void setTrStatus(int trStatus) {
        this.trStatus = trStatus;
    }

    public List<Employee> getEmployees() {
        return employees;
    }

    public void setEmployees(List<Employee> employees) {
        this.employees = employees;
    }

    @Override
    public String toString() {
        return "Trainn{" +
                "trID=" + trID +
                ", trTitle='" + trTitle + '\'' +
                ", trContent='" + trContent + '\'' +
                ", trBegin=" + trBegin +
                ", trEnd=" + trEnd +
                ", trLocal='" + trLocal + '\'' +
                ", trStatus=" + trStatus +
                ", employees=" + employees +
                '}';
    }
}
