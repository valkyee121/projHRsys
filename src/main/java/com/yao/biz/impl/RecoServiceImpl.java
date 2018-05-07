package com.yao.biz.impl;

import com.yao.biz.RecoService;
import com.yao.dao.RecoMapper;
import com.yao.model.Reconsider;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
@Service
public class RecoServiceImpl implements RecoService {
    @Resource
    private RecoMapper recoMapper;
    @Override
    public boolean saveReco(Reconsider reconsider) {
        return recoMapper.saveReco(reconsider);
    }

    @Override
    public boolean updateReco(Reconsider reconsider) {
        return recoMapper.updateReco(reconsider);
    }

    @Override
    public boolean deleteReco(Reconsider reconsider) {
        return recoMapper.deleteReco(reconsider);
    }

    @Override
    public Reconsider findByID(Reconsider reconsider) {
        return recoMapper.findByID(reconsider);
    }

    @Override
    public List<Reconsider> listByEmp(int empID) {
        return recoMapper.listByEmp(empID);
    }
}
