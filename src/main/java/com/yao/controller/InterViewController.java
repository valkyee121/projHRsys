package com.yao.controller;

import com.yao.biz.InterViewService;
import org.springframework.stereotype.Controller;

import javax.annotation.Resource;

@Controller
public class InterViewController {
    @Resource
    private InterViewService interViewService;
}
