package com.yao.biz;

import com.yao.model.Employee;

import java.util.List;

public interface EmpService {
    boolean saveEmp (Employee employee);
    boolean updateEmp (Employee employee);
    boolean updateBasis (Employee employee);
    boolean deleteEmp (Employee employee);
    Employee findEmp (Employee employee);
    Employee findWithTr (int empID);
    Employee findWithBM (int empID);
    Employee findWithSal (int empID, int salStatus);
    Employee findWithDms (int empID);
    List<Employee> listAllEmp (Employee employee);
    List<Employee> listAllByDms (int dmStatus);
}
