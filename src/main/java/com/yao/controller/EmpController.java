package com.yao.controller;

import com.yao.biz.EmpService;
import com.yao.biz.InterViewService;
import com.yao.biz.UserService;
import com.yao.model.*;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EmpController {
    @Resource
    private EmpService empService;
    @Resource
    private InterViewService interViewService;
    @Resource
    private UserService userService;
    @RequestMapping("/empInfoPage")
    public String empInfoPage() throws Exception{
        return "empInfoMana";
    }

    /**
     *
     * @param user
     * @param interView
     * @param employee
     * @param department
     * @param jobPosition
     * @throws Exception
     */
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

    /**
     *
     * @param employee
     * @param department
     * @param response
     * @param request
     * @throws Exception
     */
    @RequestMapping("/ajaxListEmpByDept")
    public void ajaxListEmpByDept(Employee employee, Department department, HttpServletResponse response, HttpServletRequest request) throws Exception{
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        employee.setEmpDept(department);
        System.out.println(employee);
        List<Employee> employees = empService.listAllEmp(employee);
        Map<String,Object> jsonObj = new HashMap<String, Object>();
        jsonObj.put("result",employees);
        JSONObject json = new JSONObject(jsonObj);
        response.getWriter().print(json);
        System.out.println(employees);
    }

    @RequestMapping("/empDetails")
    public String empDetails(Employee employee, Model model) throws Exception{
        Employee employee1 = empService.findEmp(employee);
        model.addAttribute("empInfo",employee1);
        return "checkEmpInfo";
    }

    @RequestMapping("/updateDeptByMana")
    public void updateDeptByMana(Employee employee,Department department,JobPosition jobPosition) throws Exception{
        System.out.println(department);
        System.out.println(jobPosition);
        if (department!=null && jobPosition!=null){
            employee.setEmpDept(department);
            employee.setEmpJob(jobPosition);
            empService.updateEmp(employee);
            System.out.println(employee);
        }

    }

}
