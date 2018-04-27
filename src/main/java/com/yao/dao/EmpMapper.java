package com.yao.dao;

import com.yao.model.Employee;

import java.util.List;

public interface EmpMapper {
    boolean saveEmp (Employee employee);
    boolean updateEmp (Employee employee);
    boolean deleteEmp (Employee employee);
    Employee findEmp (Employee employee);
    List<Employee> listAllEmp (Employee employee);
}
