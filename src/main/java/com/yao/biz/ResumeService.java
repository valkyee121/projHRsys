package com.yao.biz;

import com.yao.model.Recruit;
import com.yao.model.Resume;

import java.util.List;
import java.util.Map;

public interface ResumeService {
    boolean saveResume (Resume resume);
    boolean updateResume (Resume resume);
    boolean deleteResume (Resume resume);
    Resume findThisResume (int resuid, int riid);
    List<Resume> listMyPost (int resuid, int poStat);
    List<Resume> listAllPost (int poStat);
    boolean savePostResume (int riid,int ruseid, int poStat);
    boolean updatePostResume (int riid,int ruseid, int poStat);
}
