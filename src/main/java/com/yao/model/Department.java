package com.yao.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Department implements Serializable {
    private int deptID;
    private String deptName;
    private Date deptBuild;
    private int deptStatus;
    private List<JobPosition> jobPositions = new ArrayList<JobPosition>();

    public int getDeptID() {
        return deptID;
    }

    public void setDeptID(int deptID) {
        this.deptID = deptID;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

    public Date getDeptBuild() {
        return deptBuild;
    }

    public void setDeptBuild(Date deptBuild) {
        this.deptBuild = deptBuild;
    }

    public int getDeptStatus() {
        return deptStatus;
    }

    public void setDeptStatus(int deptStatus) {
        this.deptStatus = deptStatus;
    }

    public List<JobPosition> getJobPositions() {
        return jobPositions;
    }

    public void setJobPositions(List<JobPosition> jobPositions) {
        this.jobPositions = jobPositions;
    }

    @Override
    public String toString() {
        return "Department{" +
                "deptID=" + deptID +
                ", deptName='" + deptName + '\'' +
                ", deptBuild=" + deptBuild +
                ", deptStatus=" + deptStatus +
                '}';
    }
}
