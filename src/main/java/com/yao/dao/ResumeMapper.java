package com.yao.dao;

import com.yao.model.Recruit;
import com.yao.model.Resume;

import java.util.List;
import java.util.Map;

public interface ResumeMapper {
    boolean saveResume (Resume resume);
    boolean updateResume (Resume resume);
    boolean deleteResume (Resume resume);
    Resume findThisResume (Resume resume);
    List<Resume> listMyPost (Resume resume);
    boolean postResume (int ruseid, int riid);
}
