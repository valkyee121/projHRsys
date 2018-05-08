package com.yao.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class JobPosition implements Serializable {
    private Integer jobID;
    private String jobName;
    private double jobSalary;
    private int jobStatus;
    private Department department;

    public Integer getJobID() {
        return jobID;
    }

    public void setJobID(Integer jobID) {
        this.jobID = jobID;
    }

    public String getJobName() {
        return jobName;
    }

    public void setJobName(String jobName) {
        this.jobName = jobName;
    }

    public double getJobSalary() {
        return jobSalary;
    }

    public void setJobSalary(double jobSalary) {
        this.jobSalary = jobSalary;
    }

    public int getJobStatus() {
        return jobStatus;
    }

    public void setJobStatus(int jobStatus) {
        this.jobStatus = jobStatus;
    }

    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }

    @Override
    public String toString() {
        return "JobPosition{" +
                "jobID=" + jobID +
                ", jobName='" + jobName + '\'' +
                ", jobSalary=" + jobSalary +
                ", jobStatus=" + jobStatus +
                ", department=" + department +
                '}';
    }
}
