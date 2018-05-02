package com.yao.biz.impl;

import com.yao.biz.SalaryService;
import com.yao.dao.SalaryMapper;
import com.yao.model.Salary;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
@Service
public class SalaryServiceImpl implements SalaryService {
    @Resource
    private SalaryMapper salaryMapper;
    @Override
    public boolean saveSalary(Salary salary) {
        return salaryMapper.saveSalary(salary);
    }

    @Override
    public boolean updateSalary(Salary salary) {
        return salaryMapper.updateSalary(salary);
    }

    @Override
    public boolean deleteSalary(Salary salary) {
        return salaryMapper.deleteSalary(salary);
    }

    @Override
    public Salary findThis(Salary salary) {
        return salaryMapper.findThis(salary);
    }

    @Override
    public List<Salary> listByMon(Salary salary) {
        return salaryMapper.listByMon(salary);
    }
}
