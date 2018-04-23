package com.yao.dao;

import com.yao.model.Resume;

import java.util.List;

public interface ResumeMapper {
    boolean saveResume (Resume resume);
    boolean updateResume (Resume resume);
    boolean deleteResume (Resume resume);
    Resume findThisResume (Resume resume);
    List<Resume> listMyResume (Resume resume);
}
