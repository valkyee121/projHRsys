package com.yao.biz.impl;

import com.yao.biz.BonusService;
import com.yao.dao.BonusMapper;
import com.yao.model.Bonus;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
@Service
public class BonusServiceImpl implements BonusService {
    @Resource
    private BonusMapper bonusMapper;
    @Override
    public boolean saveBonus(Bonus bonus) {
        return bonusMapper.saveBonus(bonus);
    }

    @Override
    public boolean updateBonus(Bonus bonus) {
        return bonusMapper.updateBonus(bonus);
    }

    @Override
    public boolean deleteBonus(Bonus bonus) {
        return bonusMapper.deleteBonus(bonus);
    }

    @Override
    public Bonus findThis(Bonus bonus) {
        return bonusMapper.findThis(bonus);
    }

    @Override
    public List<Bonus> listBonusMon(Bonus bonus) {
        return bonusMapper.listBonusMon(bonus);
    }
}
