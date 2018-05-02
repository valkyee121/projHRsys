package com.yao.biz.impl;

import com.yao.biz.AtteService;
import com.yao.dao.AtteMapper;
import com.yao.model.Attend;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
@Service
public class AtteServiceImpl implements AtteService {
    @Resource
    private AtteMapper atteMapper;
    @Override
    public boolean saveAtte(Attend attend) {
        return atteMapper.saveAtte(attend);
    }

    @Override
    public boolean updateAtte(Attend attend) {
        return atteMapper.updateAtte(attend);
    }

    @Override
    public boolean deleteAtte(Attend attend) {
        return atteMapper.deleteAtte(attend);
    }

    @Override
    public Attend findThisAtte(Attend attend) {
        return atteMapper.findThisAtte(attend);
    }

    @Override
    public List<Attend> listThisMon(Attend attend) {
        return atteMapper.listThisMon(attend);
    }

    @Override
    public List<Attend> listByMon(Attend attend) {
        return atteMapper.listByMon(attend);
    }
}
