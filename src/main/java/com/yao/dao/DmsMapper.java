package com.yao.dao;

import com.yao.model.Dimission;

import java.util.List;

public interface DmsMapper {
    boolean saveDms (Dimission dimission);
    boolean updateDms (Dimission dimission);
    boolean deleteDms (Dimission dimission);
    Dimission findByEmp (int empId, int status);
    List<Dimission> listAllByStatus (Dimission dimission);
}
