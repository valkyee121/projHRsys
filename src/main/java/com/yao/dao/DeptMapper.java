package com.yao.dao;

import com.yao.model.Department;

import java.util.List;
import java.util.Map;

public interface DeptMapper {
    boolean saveDept (Department department);
    boolean updateDept (Department department);
    boolean deleteDept (Department department);
    Department findDept (Department department);
    List<DeptMapper> listAll (Map map);
}
