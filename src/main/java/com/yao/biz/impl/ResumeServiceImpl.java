package com.yao.biz.impl;

import com.yao.biz.ResumeService;
import com.yao.dao.ResumeMapper;
import com.yao.model.Resume;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ResumeServiceImpl implements ResumeService {
    @Resource
    private ResumeMapper resumeMapper;
    @Override
    public boolean saveResume(Resume resume) {
        return resumeMapper.saveResume(resume);
    }

    @Override
    public boolean updateResume(Resume resume) {
        return resumeMapper.updateResume(resume);
    }

    @Override
    public boolean deleteResume(Resume resume) {
        return resumeMapper.deleteResume(resume);
    }

    @Override
    public Resume findThisResume(Resume resume) {
        return resumeMapper.findThisResume(resume);
    }

    @Override
    public List<Resume> listMyResume(Resume resume) {
        return resumeMapper.listMyResume(resume);
    }
}
