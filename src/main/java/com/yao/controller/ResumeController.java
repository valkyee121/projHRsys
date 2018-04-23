package com.yao.controller;

import com.yao.biz.ResumeService;
import org.springframework.stereotype.Controller;

import javax.annotation.Resource;

@Controller
public class ResumeController {
    @Resource
    private ResumeService resumeService;
}
