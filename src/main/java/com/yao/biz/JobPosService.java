package com.yao.biz;

import com.yao.model.JobPosition;

import java.util.List;
import java.util.Map;

public interface JobPosService{
    boolean saveJobPos (Map map);
    boolean updateJobPos (JobPosition jp);
    boolean deleteJobPos (JobPosition jp);
    JobPosition findJobPos (JobPosition jp);
    List<JobPosition> listAll ();
}
