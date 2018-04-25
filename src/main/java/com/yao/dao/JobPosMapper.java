package com.yao.dao;

import com.yao.model.JobPosition;

import java.util.List;

public interface JobPosMapper {
    boolean saveJobPos (JobPosition jp);
    boolean updateJobPos (JobPosition jp);
    boolean deleteJobPos (JobPosition jp);
    JobPosition findJobPos (JobPosition jp);
    List<JobPosition> listAll ();
}
