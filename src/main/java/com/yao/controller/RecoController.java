package com.yao.controller;

import com.yao.biz.BonusService;
import com.yao.biz.RecoService;
import com.yao.biz.SalaryService;
import com.yao.model.Bonus;
import com.yao.model.Employee;
import com.yao.model.Reconsider;
import com.yao.model.Salary;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class RecoController {
    @Resource
    private RecoService recoService;
    @Resource
    private SalaryService salaryService;
    @Resource
    private BonusService bonusService;
    /*@RequestMapping("/empReco")
    public String empReco() throws Exception{
        return "empRecoPage";
    }*/
    @RequestMapping("/saveNewReco")
    public void saveNewReco(Reconsider reco, HttpSession session, Employee employee, Salary salary) throws Exception{
        employee = (Employee) session.getAttribute("myEmpInfo");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
        String mon = sdf.format(new Date());
        Date now = sdf.parse(mon);
        salary.setSalEmpID(employee.getEmpID());
        Salary salary1 = salaryService.findThis(salary);
        reco.setEmployee(employee);
        reco.setSalary(salary1);
        reco.setRecoDate(now);
        recoService.saveReco(reco);
        System.out.println(reco);
        return;
    }
    @RequestMapping("/listMyReco")
    public String listMyReco(HttpSession session, Model model) throws Exception{
        Employee employee = (Employee) session.getAttribute("myEmpInfo");
        System.out.println(employee.getEmpID());
        List<Reconsider> reconsiders = recoService.listByEmp(employee.getEmpID());
        model.addAttribute("reco",reconsiders);
        return "empRecoPage";
    }
    @RequestMapping("/ajaxFindReco")
    public void ajaxFindReco(Reconsider reconsider,Employee employee, HttpServletResponse response) throws Exception{
        System.out.println(employee);
        reconsider.setEmployee(employee);
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        if (null!=reconsider){
            List<Reconsider> reconsiders = recoService.listByEmp(reconsider.getEmployee().getEmpID());
            Map<String,Object> jsonObj = new HashMap<String, Object>();
            jsonObj.put("result",reconsiders);
            JSONObject json = new JSONObject(jsonObj);
            response.getWriter().print(json);
        }
        return;
    }

    @RequestMapping("/updateReco")
    public void updateReco(Reconsider reconsider) throws Exception{
        if (null!=reconsider){
            recoService.updateReco(reconsider);
        }
        return;
    }

    @RequestMapping("/deleteReco")
    public void deleteReco(Reconsider reconsider) throws Exception{
        if (null!=reconsider){
            recoService.deleteReco(reconsider);
        }
        return;
    }

    @RequestMapping("/acceptReco")
    public void acceptReco(Reconsider reconsider, Bonus bonus, HttpServletRequest request) throws Exception{
        Reconsider reconsider1 = recoService.findByID(reconsider);
        System.out.println(reconsider1);
        bonus.setBmEmpID(reconsider1.getEmployee().getEmpID());
        bonus.setBmDetail("上月复议");
        bonus.setBmMoney(reconsider1.getRecoMoney());
        bonus.setBmDate(reconsider1.getRecoDate());
        bonus.setBmStatus(3);
        if (null!=reconsider1 && !"".equals(reconsider1)){
            if (bonusService.saveBonus(bonus)){
                recoService.deleteReco(reconsider1);
            }
        }
        return;
    }
}
