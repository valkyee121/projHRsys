package com.yao.biz.impl;

import com.yao.biz.DeptService;
import com.yao.dao.DeptMapper;
import com.yao.model.Department;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
public class DeptServieImpl implements DeptService {
    @Resource
    private DeptMapper deptMapper;
    @Override
    public boolean saveDept(Map map) {
        return deptMapper.saveDept(map);
    }

    @Override
    public boolean updateDept(Department department) {
        return deptMapper.updateDept(department);
    }

    @Override
    public boolean deleteDept(Department department) {
        return deptMapper.deleteDept(department);
    }

    @Override
    public Department findDept(Department department) {
        return deptMapper.findDept(department);
    }

    @Override
    public List<DeptMapper> listAll(Map map) {
        return deptMapper.listAll(map);
    }
}
