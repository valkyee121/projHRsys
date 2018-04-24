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
    public InterView findThisIV(InterView interView) {
        return interViewMapper.findThisIV(interView);
    }

    @Override
    public List<InterView> listAll(Map map) {
        return interViewMapper.listAll(map);
    }
}
