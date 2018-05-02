package com.yao.controller;

import com.yao.biz.SalaryService;
import org.springframework.stereotype.Controller;

import javax.annotation.Resource;

@Controller
public class SalaryController {
    @Resource
    private SalaryService salaryService;
}
