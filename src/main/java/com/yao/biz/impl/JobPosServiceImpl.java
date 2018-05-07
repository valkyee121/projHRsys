package com.yao.biz.impl;

import com.yao.biz.JobPosService;
import com.yao.dao.JobPosMapper;
import com.yao.model.JobPosition;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
public class JobPosServiceImpl implements JobPosService {
    @Resource
    private JobPosMapper jobPosMapper;
    @Override
    public boolean saveJobPos(Map map) {
        return jobPosMapper.saveJobPos(map);
    }

    @Override
    public boolean updateJobPos(JobPosition jp) {
        return jobPosMapper.updateJobPos(jp);
    }

    @Override
    public boolean deleteJobPos(JobPosition jp) {
        return jobPosMapper.deleteJobPos(jp);
    }

    @Override
    public JobPosition findJobPos(JobPosition jp) {
        return jobPosMapper.findJobPos(jp);
    }

    @Override
    public List<JobPosition> listAll() {
        return jobPosMapper.listAll();
    }
}
