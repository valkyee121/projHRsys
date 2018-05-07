package com.yao.dao;

import com.yao.model.JobPosition;

import java.util.List;
import java.util.Map;

public interface JobPosMapper {
    boolean saveJobPos (Map map);
    boolean updateJobPos (JobPosition jp);
    boolean deleteJobPos (JobPosition jp);
    JobPosition findJobPos (JobPosition jp);
    List<JobPosition> listAll ();
}
