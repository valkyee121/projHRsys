package com.yao.biz.impl;

import com.yao.biz.InterViewService;
import com.yao.dao.InterViewMapper;
import com.yao.model.InterView;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;
@Service
public class InterViewServiceImpl implements InterViewService {
    @Resource
    private InterViewMapper interViewMapper;
    @Override
    public boolean saveInterView(InterView interView) {
        return interViewMapper.saveInterView(interView);
    }

    @Override
    public boolean updateInterView(InterView interView) {
        return interViewMapper.updateInterView(interView);
    }

    @Override
    public boolean deleteInterView(InterView interView) {
        return interViewMapper.deleteInterView(interView);
    }

    @Override
    public InterView findThisIV(int resuID, int reID) {
        return interViewMapper.findThisIV(resuID,reID);
    }

    @Override
    public InterView finfIvById(InterView interView) {
        return interViewMapper.finfIvById(interView);
    }

    @Override
    public List<InterView> listAll(int resuID) {
        return interViewMapper.listAll(resuID);
    }

    @Override
    public List<InterView> listByStatus(int status) {
        return interViewMapper.listByStatus(status);
    }
}
