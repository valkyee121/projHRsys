package com.yao.biz.impl;

import com.yao.biz.TrainnService;
import com.yao.dao.TrainnMapper;
import com.yao.model.Trainn;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class TrainnServiceImpl implements TrainnService {
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
    public List<Trainn> listAll() {
        return trainnMapper.listAll();
    }
}
