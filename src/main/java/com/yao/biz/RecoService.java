package com.yao.biz;

import com.yao.model.Reconsider;

import java.util.List;

public interface RecoService {
    boolean saveReco (Reconsider reconsider);
    boolean updateReco (Reconsider reconsider);
    boolean deleteReco (Reconsider reconsider);
    Reconsider findByID (Reconsider reconsider);
    List<Reconsider> listByEmp (int empID);
}
