package com.yao.biz.impl;

import com.yao.biz.EmpService;
import com.yao.dao.EmpMapper;
import com.yao.model.Employee;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
@Service
public class EmpServiceImpl implements EmpService {
    @Resource
    private EmpMapper empMapper;
    @Override
    public boolean saveEmp(Employee employee) {
        return empMapper.saveEmp(employee);
    }

    @Override
    public boolean updateEmp(Employee employee) {
        return empMapper.updateEmp(employee);
    }

    @Override
    public boolean updateBasis(Employee employee) {
        return empMapper.updateBasis(employee);
    }

    @Override
    public boolean deleteEmp(Employee employee) {
        return empMapper.deleteEmp(employee);
    }

    @Override
    public Employee findEmp(Employee employee) {
        return empMapper.findEmp(employee);
    }

    @Override
    public Employee findWithTr(int empID) {
        return empMapper.findWithTr(empID);
    }

    @Override
    public List<Employee> listAllEmp(Employee employee) {
        return empMapper.listAllEmp(employee);
    }
}
