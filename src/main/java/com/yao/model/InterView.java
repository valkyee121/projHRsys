package com.yao.model;

import java.io.Serializable;
import java.util.Date;

public class InterView implements Serializable{
    private int jivID;
    private int jivResuID;
    private int jivReID;
    private Date jivDate;
    private String jivLocal;
    private int jinStatus;

    public int getJivID() {
        return jivID;
    }

    public void setJivID(int jivID) {
        this.jivID = jivID;
    }

    public int getJivResuID() {
        return jivResuID;
    }

    public void setJivResuID(int jivResuID) {
        this.jivResuID = jivResuID;
    }

    public int getJivReID() {
        return jivReID;
    }

    public void setJivReID(int jivReID) {
        this.jivReID = jivReID;
    }

    public Date getJivDate() {
        return jivDate;
    }

    public void setJivDate(Date jivDate) {
        this.jivDate = jivDate;
    }

    public String getJivLocal() {
        return jivLocal;
    }

    public void setJivLocal(String jivLocal) {
        this.jivLocal = jivLocal;
    }

    public int getJinStatus() {
        return jinStatus;
    }

    public void setJinStatus(int jinStatus) {
        this.jinStatus = jinStatus;
    }

    @Override
    public String toString() {
        return "InterView{" +
                "jivID=" + jivID +
                ", jivResuID=" + jivResuID +
                ", jivReID=" + jivReID +
                ", jivDate=" + jivDate +
                ", jivLocal='" + jivLocal + '\'' +
                ", jinStatus=" + jinStatus +
                '}';
    }
}
