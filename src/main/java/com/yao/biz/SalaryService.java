package com.yao.biz;

import com.yao.model.Salary;

import java.util.List;

public interface SalaryService {
    boolean saveSalary (Salary salary);
    boolean updateSalary (Salary salary);
    boolean deleteSalary (Salary salary);
    Salary findThis (Salary salary);
    List<Salary> listByMon (Salary salary);
}
