package com.yao.dao;

import com.yao.model.Recruit;
import com.yao.model.Resume;

import java.util.List;
import java.util.Map;

public interface ResumeMapper {
    boolean saveResume (Resume resume);
    boolean updateResume (Resume resume);
    boolean deleteResume (Resume resume);
    Resume findThisResume (int resuid, int riid);
    List<Resume> listMyPost (int resuid, int poStat);
    List<Resume> listAllPost (int poStat);
    boolean postResume (int riid,int ruseid, int poStat);
}
