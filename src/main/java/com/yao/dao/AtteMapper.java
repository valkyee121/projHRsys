package com.yao.dao;

import com.yao.model.Attend;

import java.util.List;

public interface AtteMapper {
    boolean saveAtte (Attend attend);
    boolean updateAtte (Attend attend);
    boolean deleteAtte (Attend attend);
    Attend findThisAtte (Attend attend);
    List<Attend> listThisMon (Attend attend);
    List<Attend> listByMon (Attend attend);
}
