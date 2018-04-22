package com.yao.biz;

import com.yao.model.Recruit;

import java.util.List;
import java.util.Map;

public interface RecruitService {
    boolean saveRecruit (Recruit recruit);
    boolean updateRecruit (Recruit recruit);
    boolean deleteRecruit (Recruit recruit);
    Recruit findRecruit (Recruit recruit);
    List<Recruit> listAll (Map map);
}
