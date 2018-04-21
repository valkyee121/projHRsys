package com.yao.biz;

import com.yao.model.Recruit;

import java.util.List;

public interface RecruitService {
    boolean saveRecruit (Recruit recruit);
    boolean updateRecruit (Recruit recruit);
    boolean deleteRecruit (Recruit recruit);
    Recruit findRecruit (Recruit recruit);
    List<Recruit> listAll (Recruit recruit);
}
