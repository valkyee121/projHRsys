package com.yao.model;

import java.io.Serializable;
import java.util.Date;

public class Reconsider implements Serializable {
    private int recoID;
    private String recoContent;
    private double recoMoney;
    private Salary salary;
    private Employee employee;
    private Date recoDate;

    public int getRecoID() {
        return recoID;
    }

    public void setRecoID(int recoID) {
        this.recoID = recoID;
    }

    public String getRecoContent() {
        return recoContent;
    }

    public void setRecoContent(String recoContent) {
        this.recoContent = recoContent;
    }

    public double getRecoMoney() {
        return recoMoney;
    }

    public void setRecoMoney(double recoMoney) {
        this.recoMoney = recoMoney;
    }

    public Salary getSalary() {
        return salary;
    }

    public void setSalary(Salary salary) {
        this.salary = salary;
    }

    public Employee getEmployee() {
        return employee;
    }

    public void setEmployee(Employee employee) {
        this.employee = employee;
    }

    public Date getRecoDate() {
        return recoDate;
    }

    public void setRecoDate(Date recoDate) {
        this.recoDate = recoDate;
    }

    @Override
    public String toString() {
        return "Reconsider{" +
                "recoID=" + recoID +
                ", recoContent='" + recoContent + '\'' +
                ", recoMoney=" + recoMoney +
                ", salary=" + salary +
                ", employee=" + employee +
                ", recoDate=" + recoDate +
                '}';
    }
}
