package com.yao.dao;

import com.yao.model.Salary;

import java.util.List;

public interface SalaryMapper {
    boolean saveSalary (Salary salary);
    boolean updateSalary (Salary salary);
    boolean deleteSalary (Salary salary);
    Salary findThis (Salary salary);
    List<Salary> listByMon (Salary salary);
}
