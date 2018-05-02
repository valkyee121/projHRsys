package com.yao.biz.impl;

import com.yao.biz.TrainnService;
import com.yao.dao.TrainnMapper;
import com.yao.model.Trainn;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
public class TrainnServiceImpl implements TrainnService {
    @Resource
    private TrainnMapper trainnMapper;
    @Override
    public boolean saveTrainn(Trainn trainn) {
        return trainnMapper.saveTrainn(trainn);
    }

    @Override
    public boolean updateTrainn(Trainn trainn) {
        return trainnMapper.updateTrainn(trainn);
    }

    @Override
    public boolean deleteTrainn(Trainn trainn) {
        return trainnMapper.deleteTrainn(trainn);
    }

    @Override
    public Trainn findTrain(Trainn trainn) {
        return trainnMapper.findTrain(trainn);
    }

    @Override
    public List<Trainn> findWithEmp(Trainn trainn) {
        return trainnMapper.findWithEmp(trainn);
    }


    @Override
    public List<Trainn> listPast(Map map) {
        return trainnMapper.listPast(map);
    }

    @Override
    public List<Trainn> listCurr() {
        return trainnMapper.listCurr();
    }

    @Override
    public boolean saveTrEmp(List<Object> empList,int trId) {
        return trainnMapper.saveTrEmp(empList,trId);
    }

}
