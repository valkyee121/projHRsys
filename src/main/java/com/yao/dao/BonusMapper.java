package com.yao.dao;

import com.yao.model.Bonus;

import java.util.List;

public interface BonusMapper {
    boolean saveBonus (Bonus bonus);
    boolean updateBonus (Bonus bonus);
    boolean deleteBonus (Bonus bonus);
    Bonus findThis (Bonus bonus);
    List<Bonus> listBonusMon (Bonus bonus);
}
