package com.yao.biz;

import com.yao.model.Bonus;

import java.util.List;

public interface BonusService {
    boolean saveBonus (Bonus bonus);
    boolean updateBonus (Bonus bonus);
    boolean deleteBonus (Bonus bonus);
    Bonus findThis (Bonus bonus);
    List<Bonus> listBonusMon (Bonus bonus);
}
