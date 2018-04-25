package com.yao.biz;

import com.yao.model.JobPosition;

import java.util.List;

public interface JobPosService{
    boolean saveJobPos (JobPosition jp);
    boolean updateJobPos (JobPosition jp);
    boolean deleteJobPos (JobPosition jp);
    JobPosition findJobPos (JobPosition jp);
    List<JobPosition> listAll ();
}
