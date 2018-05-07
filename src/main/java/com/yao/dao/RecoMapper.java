package com.yao.dao;

import com.yao.model.Reconsider;

import java.util.List;

public interface RecoMapper {
    boolean saveReco (Reconsider reconsider);
    boolean updateReco (Reconsider reconsider);
    boolean deleteReco (Reconsider reconsider);
    Reconsider findByID (Reconsider reconsider);
    List<Reconsider> listByEmp (int empID);
}
