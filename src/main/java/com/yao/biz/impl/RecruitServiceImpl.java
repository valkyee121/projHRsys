package com.yao.biz.impl;

import com.yao.biz.RecruitService;
import com.yao.dao.RecruitMapper;
import com.yao.model.Recruit;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
@Service
public class RecruitServiceImpl implements RecruitService {
    @Resource
    private RecruitMapper recruitMapper;
    @Override
    public boolean saveRecruit(Recruit recruit) {
        return recruitMapper.saveRecruit(recruit);
    }

    @Override
    public boolean updateRecruit(Recruit recruit) {
        return recruitMapper.updateRecruit(recruit);
    }

    @Override
    public boolean deleteRecruit(Recruit recruit) {
        return recruitMapper.deleteRecruit(recruit);
    }

    @Override
    public Recruit findRecruit(Recruit recruit) {
        return recruitMapper.findRecruit(recruit);
    }

    @Override
    public List<Recruit> listAll(Recruit recruit) {
        return recruitMapper.listAll(recruit);
    }
}
