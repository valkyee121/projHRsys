package com.yao.controller;

import com.yao.biz.EmpService;
import com.yao.biz.InterViewService;
import com.yao.biz.UserService;
import com.yao.model.*;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.beans.PropertyEditorSupport;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
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

    /*@InitBinder
    public void InitBinder(WebDataBinder dataBinder)
    {
        dataBinder.registerCustomEditor(Date.class, new PropertyEditorSupport() {
            public void setAsText(String value) {
                try {
                    setValue(new SimpleDateFormat("yyyy-MM-dd").parse(value));
                } catch(ParseException e) {
                    setValue(null);
                }
            }
            public String getAsText() {
                return new SimpleDateFormat("yyyy-MM-dd").format((Date) getValue());
            }
        });
    }*/
    @RequestMapping("/empInfoPage")
    public String empInfoPage() throws Exception{
        return "empInfoMana";
    }
    @RequestMapping("/trainnPage")
    public String trainnPage() throws Exception{
        return "myTrainnPage";
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
    public void saveNewEmp(User user,InterView interView, Employee employee, Department department, JobPosition jobPosition, HttpServletResponse response) throws Exception{
        employee.setEmpJob(jobPosition);
        employee.setEmpDept(department);
        employee.setEmpSal(jobPosition.getJobSalary());
        user.setuEmail(employee.getEmpEmail());
        Map<String,Object> jsonObj = new HashMap<String, Object>();
        if (empService.saveEmp(employee)){
            user.setuType(2);
            interView.setJivStatus(5);
            System.out.println(user);
            userService.updateUser(user);
            interViewService.updateInterView(interView);
            jsonObj.put("code","1");
        }else {
            jsonObj.put("code","2");
        }
        JSONObject json = new JSONObject(jsonObj);
        response.getWriter().print(json);
        return;
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

    @RequestMapping("/empMyDetails")
    public String empMyDetails(HttpSession session, Model model, Employee employee) throws Exception{
        employee = (Employee) session.getAttribute("myEmpInfo");
        Employee employee1 = empService.findEmp(employee);
        model.addAttribute("empInfo",employee1);
        return "myEmpInfo";
    }

    @RequestMapping("/updateDeptByMana")
    public String updateDeptByMana(Employee employee,Department department,JobPosition jobPosition, Model model, HttpServletResponse response ) throws Exception{
        System.out.println(department);
        System.out.println(jobPosition);
        PrintWriter out = response.getWriter();
        if (department!=null && jobPosition!=null){
            employee.setEmpDept(department);
            employee.setEmpJob(jobPosition);
            empService.updateEmp(employee);
            System.out.println(employee);
            model.addAttribute("msg","更新成功");
        }
        return "redirect:/empInfoPage";
    }

    @RequestMapping("/updateBasisInfo")
    public void updateBasisInfo(Employee employee) throws Exception{
        System.out.println(employee);
        if (employee!=null){
            empService.updateBasis(employee);
        }
    }

    /**
     *
     * @param session
     * @param response
     * @throws Exception
     */
    @RequestMapping("/ajaxMyTrainn")
    public void ajaxMyTrainn(HttpSession session,HttpServletResponse response) throws Exception{
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        Employee employee = (Employee) session.getAttribute("myEmpInfo");
        Employee employee1 = empService.findWithTr(employee.getEmpID());
        Map<String,Object> jsonObj = new HashMap<String, Object>();
        jsonObj.put("result",employee1);
        JSONObject json = new JSONObject(jsonObj);
        response.getWriter().print(json);
        System.out.println(employee1);
    }

    @RequestMapping("/ajaxFindEmpSal")
    public void ajaxFindEmpSal(Employee employee, Salary salary,HttpServletResponse response) throws Exception{
        Employee employee1 = empService.findWithSal(employee.getEmpID(),salary.getSalStatus());
        System.out.println(employee1);
        Map<String,Object> jsonObj = new HashMap<String, Object>();
        jsonObj.put("result",employee1);
        JSONObject json = new JSONObject(jsonObj);
        response.getWriter().print(json);
    }
}
