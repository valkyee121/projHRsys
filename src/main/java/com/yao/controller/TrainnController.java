package com.yao.controller;

import com.yao.biz.TrainnService;
import com.yao.model.Trainn;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;

@Controller
public class TrainnController {
    @Resource
    private TrainnService trainnService;

    @RequestMapping("/trainnManaPage")
    public String trainnManaPage() throws Exception{
        return "trainnManaPage";
    }

    @RequestMapping("/newTrainSave")
    public void newTrainSave(Trainn trainn) throws Exception{
        System.out.println(trainn);
    }
}
