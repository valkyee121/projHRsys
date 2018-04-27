package com.yao.biz;

import com.yao.model.Employee;

import java.util.List;

public interface EmpService {
    boolean saveEmp (Employee employee);
    boolean updateEmp (Employee employee);
    boolean deleteEmp (Employee employee);
    Employee findEmp (Employee employee);
    List<Employee> listAllEmp (Employee employee);
}
