package com.yao.model;

import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

public class Salary implements Serializable {
    private int salID;
    private int salEmpID;
    private double salBasis;
    private double salBonus;
    private double salOT;
    private double salPunish;
    private double salSocial;
    private double salRecon;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date salDate;
    private int salStatus;
    private double salTotal;

    public int getSalID() {
        return salID;
    }

    public void setSalID(int salID) {
        this.salID = salID;
    }

    public int getSalEmpID() {
        return salEmpID;
    }

    public void setSalEmpID(int salEmpID) {
        this.salEmpID = salEmpID;
    }

    public double getSalBasis() {
        return salBasis;
    }

    public void setSalBasis(double salBasis) {
        this.salBasis = salBasis;
    }

    public double getSalBonus() {
        return salBonus;
    }

    public void setSalBonus(double salBonus) {
        this.salBonus = salBonus;
    }

    public double getSalOT() {
        return salOT;
    }

    public void setSalOT(double salOT) {
        this.salOT = salOT;
    }

    public double getSalPunish() {
        return salPunish;
    }

    public void setSalPunish(double salPunish) {
        this.salPunish = salPunish;
    }

    public double getSalSocial() {
        return salSocial;
    }

    public void setSalSocial(double salSocial) {
        this.salSocial = salSocial;
    }

    public double getSalRecon() {
        return salRecon;
    }

    public void setSalRecon(double salRecon) {
        this.salRecon = salRecon;
    }

    public Date getSalDate() {
        return salDate;
    }

    public void setSalDate(Date salDate) {
        this.salDate = salDate;
    }

    public int getSalStatus() {
        return salStatus;
    }

    public void setSalStatus(int salStatus) {
        this.salStatus = salStatus;
    }

    public double getSalTotal() {
        return salTotal;
    }

    public void setSalTotal(double salTotal) {
        this.salTotal = salTotal;
    }

    @Override
    public String toString() {
        return "Salary{" +
                "salID=" + salID +
                ", salEmpID=" + salEmpID +
                ", salBasis=" + salBasis +
                ", salBonus=" + salBonus +
                ", salOT=" + salOT +
                ", salPunish=" + salPunish +
                ", salSocial=" + salSocial +
                ", salRecon=" + salRecon +
                ", salDate=" + salDate +
                ", salStatus=" + salStatus +
                ", salTotal=" + salTotal +
                '}';
    }
}
