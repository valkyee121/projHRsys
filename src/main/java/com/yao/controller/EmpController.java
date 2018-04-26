package com.yao.controller;

import com.yao.biz.EmpService;
import com.yao.biz.InterViewService;
import com.yao.biz.UserService;
import com.yao.model.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;

@Controller
public class EmpController {
    @Resource
    private EmpService empService;
    @Resource
    private InterViewService interViewService;
    @Resource
    private UserService userService;
    @RequestMapping("/saveNewEmp")
    public void saveNewEmp(User user,InterView interView, Employee employee, Department department, JobPosition jobPosition) throws Exception{
        employee.setEmpJob(jobPosition);
        employee.setEmpDept(department);
        user.setuEmail(employee.getEmpEmail());
        System.out.println(department);
        System.out.println(jobPosition);
        System.out.println(employee);
        if (empService.saveEmp(employee)){
            user.setuType(2);
            interView.setJivStatus(5);
            userService.updateUser(user);
            interViewService.updateInterView(interView);
        }
    }
}
