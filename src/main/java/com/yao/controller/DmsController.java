package com.yao.controller;

import com.yao.biz.DmsService;
import com.yao.biz.EmpService;
import com.yao.biz.UserService;
import com.yao.model.Dimission;
import com.yao.model.Employee;
import com.yao.model.User;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class DmsController {
    @Resource
    private DmsService dmsService;
    @Resource
    private EmpService empService;
    @Resource
    private UserService userService;
    @RequestMapping("/empDmsPage")
    public String empDmsPage() throws Exception{
        return "empDmsMana";
    }

    @RequestMapping("/myDmsApply")
    public String myDmsApply(HttpServletResponse response, HttpSession session, Employee employee, Model model) throws Exception{
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        employee = (Employee) session.getAttribute("myEmpInfo");
        System.out.println(employee);
        Employee employee1 = empService.findWithDms(employee.getEmpID());
        model.addAttribute("myDms",employee1);
        return "myDimissPage";
    }

    @RequestMapping("/saveDmsApply")
    public void saveDmsApply(Dimission dimission,Employee employee) throws Exception{
        dimission.setDmStatus(1);
        dimission.setEmployee(employee);
        Dimission dimission1 = dmsService.findByEmp(employee.getEmpID(),dimission.getDmStatus());
        if (null!=dimission1 && !"".equals(dimission1)){
            dmsService.updateDms(dimission);
        }else {
            dmsService.saveDms(dimission);
        }
        System.out.println(dimission);
        return;
    }

    @RequestMapping("/ajaxListDms")
    public void ajaxListDms(Dimission dimission, HttpServletResponse response) throws Exception{
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        List<Employee> employees = empService.listAllByDms(dimission.getDmStatus());
        Map<String,Object> jsonObj = new HashMap<String, Object>();
        jsonObj.put("result",employees);
        JSONObject json = new JSONObject(jsonObj);
        response.getWriter().print(json);
        return;
    }

    @RequestMapping("/acceptDms")
    public void acceptDms(Employee employee, Dimission dimission, User user) throws Exception{
        Employee employee1 = empService.findWithDms(employee.getEmpID());
        employee.setEmpStatus(2);
        dimission.setDmStatus(2);
        dimission.setDmID(employee1.getDimission().getDmID());
        employee.setDimission(dimission);
        user.setuEmail(employee1.getEmpEmail());
        user.setuType(1);
        if (empService.updateEmp(employee)){
            dmsService.updateDms(dimission);
            userService.updateUser(user);
        }
    }
}
