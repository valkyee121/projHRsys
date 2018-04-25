package com.yao.controller;

import com.yao.biz.JobPosService;
import org.springframework.stereotype.Controller;

import javax.annotation.Resource;

@Controller
public class JobPosController {
    @Resource
    private JobPosService jobPosService;

}
