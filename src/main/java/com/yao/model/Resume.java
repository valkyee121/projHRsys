package com.yao.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Resume implements Serializable{
    private int resuID;
    private String resuName;
    private int resuSex;
    private Date resuBirth;
    private String resuCity;
    private int resuCell;
    private String resuInfo;
    private int resuStatus;
    private String resuEmail;
    private int uid;
    private InternalPost internalPost;
    private List<Recruit> recruits = new ArrayList<Recruit>();
    private List<InterView> interViews = new ArrayList<InterView>();

    public int getResuID() {
        return resuID;
    }

    public void setResuID(int resuID) {
        this.resuID = resuID;
    }

    public String getResuName() {
        return resuName;
    }

    public void setResuName(String resuName) {
        this.resuName = resuName;
    }

    public int getResuSex() {
        return resuSex;
    }

    public void setResuSex(int resuSex) {
        this.resuSex = resuSex;
    }

    public Date getResuBirth() {
        return resuBirth;
    }

    public void setResuBirth(Date resuBirth) {
        this.resuBirth = resuBirth;
    }

    public String getResuCity() {
        return resuCity;
    }

    public void setResuCity(String resuCity) {
        this.resuCity = resuCity;
    }

    public int getResuCell() {
        return resuCell;
    }

    public void setResuCell(int resuCell) {
        this.resuCell = resuCell;
    }

    public String getResuInfo() {
        return resuInfo;
    }

    public void setResuInfo(String resuInfo) {
        this.resuInfo = resuInfo;
    }

    public int getResuStatus() {
        return resuStatus;
    }

    public void setResuStatus(int resuStatus) {
        this.resuStatus = resuStatus;
    }

    public String getResuEmail() {
        return resuEmail;
    }

    public void setResuEmail(String resuEmail) {
        this.resuEmail = resuEmail;
    }

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

    public List<Recruit> getRecruits() {
        return recruits;
    }

    public void setRecruits(List<Recruit> recruits) {
        this.recruits = recruits;
    }

    public InternalPost getInternalPost() {
        return internalPost;
    }

    public void setInternalPost(InternalPost internalPost) {
        this.internalPost = internalPost;
    }

    public List<InterView> getInterViews() {
        return interViews;
    }

    public void setInterViews(List<InterView> interViews) {
        this.interViews = interViews;
    }

    @Override
    public String toString() {
        return "Resume{" +
                "resuID=" + resuID +
                ", resuName='" + resuName + '\'' +
                ", resuSex=" + resuSex +
                ", resuBirth=" + resuBirth +
                ", resuCity='" + resuCity + '\'' +
                ", resuCell=" + resuCell +
                ", resuInfo='" + resuInfo + '\'' +
                ", resuStatus=" + resuStatus +
                ", resuEmail='" + resuEmail + '\'' +
                ", uid=" + uid +
                ", internalPost=" + internalPost +
                ", recruits=" + recruits +
                '}';
    }
}
