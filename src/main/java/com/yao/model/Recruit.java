package com.yao.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Recruit implements Serializable {
    private int riid;
    private String riName;
    private String riCompany;
    private double riSalary;
    private String riDuty;
    private String riDesired;
    private String riAddtion;
    private String riLocation;
    private int riStatus;
    private JobPosition riJob;
    private Department riDept;
    private List<Resume> resumes = new ArrayList<Resume>();
    private List<InterView> interViews = new ArrayList<InterView>();

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

    public double getRiSalary() {
        return riSalary;
    }

    public void setRiSalary(double riSalary) {
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

    public JobPosition getRiJob() {
        return riJob;
    }

    public void setRiJob(JobPosition riJob) {
        this.riJob = riJob;
    }

    public Department getRiDept() {
        return riDept;
    }

    public void setRiDept(Department riDept) {
        this.riDept = riDept;
    }

    public List<Resume> getResumes() {
        return resumes;
    }

    public void setResumes(List<Resume> resumes) {
        this.resumes = resumes;
    }

    public List<InterView> getInterViews() {
        return interViews;
    }

    public void setInterViews(List<InterView> interViews) {
        this.interViews = interViews;
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
                ", riJob=" + riJob +
                ", riDept=" + riDept +
                '}';
    }
}
