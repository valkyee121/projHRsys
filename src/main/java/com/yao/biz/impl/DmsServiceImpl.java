package com.yao.biz.impl;

import com.yao.biz.DmsService;
import com.yao.dao.DmsMapper;
import com.yao.model.Dimission;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class DmsServiceImpl implements DmsService {
    @Resource
    private DmsMapper dmsMapper;
    @Override
    public boolean saveDms(Dimission dimission) {
        return dmsMapper.saveDms(dimission);
    }

    @Override
    public boolean updateDms(Dimission dimission) {
        return dmsMapper.updateDms(dimission);
    }

    @Override
    public boolean deleteDms(Dimission dimission) {
        return dmsMapper.deleteDms(dimission);
    }

    @Override
    public Dimission findByEmp(int empId, int status) {
        return dmsMapper.findByEmp(empId, status);
    }

    @Override
    public List<Dimission> listAllByStatus(Dimission dimission) {
        return dmsMapper.listAllByStatus(dimission);
    }
}
