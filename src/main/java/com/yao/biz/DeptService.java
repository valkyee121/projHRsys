package com.yao.biz;

import com.yao.dao.DeptMapper;
import com.yao.model.Department;

import java.util.List;
import java.util.Map;

public interface DeptService {
    boolean saveDept (Map map);
    boolean updateDept (Department department);
    boolean deleteDept (Department department);
    Department findDept (Department department);
    List<DeptMapper> listAll (Map map);
    List<DeptMapper> listWithJob ();
}
