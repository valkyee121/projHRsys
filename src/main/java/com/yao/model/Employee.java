package com.yao.model;

import java.io.Serializable;
import java.util.Date;

public class Employee implements Serializable {
    private int empID;
    private String empName;
    private int empSex;
    private Date empBirth;
    private String empCity;
    private String empEmail;
    private Department empDept;
    private JobPosition empJob;
    private int empAttend;
    private int empStatus;
    private Date empHireDate;

    public int getEmpID() {
        return empID;
    }

    public void setEmpID(int empID) {
        this.empID = empID;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName;
    }

    public int getEmpSex() {
        return empSex;
    }

    public void setEmpSex(int empSex) {
        this.empSex = empSex;
    }

    public Date getEmpBirth() {
        return empBirth;
    }

    public void setEmpBirth(Date empBirth) {
        this.empBirth = empBirth;
    }

    public String getEmpCity() {
        return empCity;
    }

    public void setEmpCity(String empCity) {
        this.empCity = empCity;
    }

    public String getEmpEmail() {
        return empEmail;
    }

    public void setEmpEmail(String empEmail) {
        this.empEmail = empEmail;
    }

    public Department getEmpDept() {
        return empDept;
    }

    public void setEmpDept(Department empDept) {
        this.empDept = empDept;
    }

    public JobPosition getEmpJob() {
        return empJob;
    }

    public void setEmpJob(JobPosition empJob) {
        this.empJob = empJob;
    }

    public int getEmpAttend() {
        return empAttend;
    }

    public void setEmpAttend(int empAttend) {
        this.empAttend = empAttend;
    }

    public int getEmpStatus() {
        return empStatus;
    }

    public void setEmpStatus(int empStatus) {
        this.empStatus = empStatus;
    }

    public Date getEmpHireDate() {
        return empHireDate;
    }

    public void setEmpHireDate(Date empHireDate) {
        this.empHireDate = empHireDate;
    }

    @Override
    public String toString() {
        return "Employee{" +
                "empID=" + empID +
                ", empName='" + empName + '\'' +
                ", empSex=" + empSex +
                ", empBirth=" + empBirth +
                ", empCity='" + empCity + '\'' +
                ", empEmail='" + empEmail + '\'' +
                ", empDept=" + empDept +
                ", empJob=" + empJob +
                ", empAttend=" + empAttend +
                ", empStatus=" + empStatus +
                ", empHireDate=" + empHireDate +
                '}';
    }
}
