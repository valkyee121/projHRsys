package com.yao.model;

import java.io.Serializable;
import java.util.Date;

public class InterView implements Serializable{
    private int jivID;
    private Resume resume;          //简历一对多 （一）
    private Recruit recruit;        //招聘信息一对多   （一）
    private Date jivDate;
    private String jivLocal;
    private int jivStatus;

    public int getJivID() {
        return jivID;
    }

    public void setJivID(int jivID) {
        this.jivID = jivID;
    }

    public Resume getResume() {
        return resume;
    }

    public void setResume(Resume resume) {
        this.resume = resume;
    }

    public Recruit getRecruit() {
        return recruit;
    }

    public void setRecruit(Recruit recruit) {
        this.recruit = recruit;
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

    public int getJivStatus() {
        return jivStatus;
    }

    public void setJivStatus(int jinStatus) {
        this.jivStatus = jinStatus;
    }

    @Override
    public String toString() {
        return "InterView{" +
                "jivID=" + jivID +
                ", resume=" + resume +
                ", recruit=" + recruit +
                ", jivDate=" + jivDate +
                ", jivLocal='" + jivLocal + '\'' +
                ", jivStatus=" + jivStatus +
                '}';
    }
}
