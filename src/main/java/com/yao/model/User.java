package com.yao.model;

import java.io.Serializable;

public class User implements Serializable{
    private int uid;
    private String uEmail;
    private String uPass;
    private int uType;

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

    public String getuEmail() {
        return uEmail;
    }

    public void setuEmail(String uEmail) {
        this.uEmail = uEmail;
    }

    public String getuPass() {
        return uPass;
    }

    public void setuPass(String uPass) {
        this.uPass = uPass;
    }

    public int getuType() {
        return uType;
    }

    public void setuType(int uType) {
        this.uType = uType;
    }

    @Override
    public String toString() {
        return "User{" +
                "uid=" + uid +
                ", uEmail='" + uEmail + '\'' +
                ", uPass='" + uPass + '\'' +
                ", uType=" + uType +
                '}';
    }
}
