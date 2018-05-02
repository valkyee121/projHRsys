package com.yao.controller;

import com.yao.biz.BonusService;
import org.springframework.stereotype.Controller;

import javax.annotation.Resource;

@Controller
public class BonusController {
    @Resource
    private BonusService bonusService;


}
