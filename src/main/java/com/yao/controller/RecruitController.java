package com.yao.controller;

import com.yao.biz.RecruitService;
import org.springframework.stereotype.Controller;

import javax.annotation.Resource;

@Controller
public class RecruitController {
    @Resource
    private RecruitService recruitService;
}
