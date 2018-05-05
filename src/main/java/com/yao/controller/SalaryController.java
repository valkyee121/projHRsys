package com.yao.controller;

import com.yao.biz.BonusService;
import com.yao.biz.SalaryService;
import com.yao.model.Bonus;
import com.yao.model.Employee;
import com.yao.model.Salary;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Controller
public class SalaryController {
    @Resource
    private SalaryService salaryService;
    @Resource
    private BonusService bonusService;

    @RequestMapping("/saveSalary")
    public void saveSalary(HttpSession session, HttpServletRequest request, Salary salary, Bonus bonus) throws Exception{
        Employee employee = (Employee) session.getAttribute("myEmpInfo");
        //查询节点为上月
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.MONTH,-1);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
        String checkMon = sdf.format(cal.getTime());
        Date check = sdf.parse(checkMon);
        bonus.setBmEmpID(employee.getEmpID());
        bonus.setBmDate(check);
        List<Bonus> bonuses = bonusService.listBonusMon(bonus);
        System.out.println(bonuses);
        double punishTemp = 0;
        double overTemp = 0;
        for (Bonus b:bonuses){
            if (b.getBmStatus()==0 || b.getBmStatus()==1){      //迟到早退旷工 punishment
                punishTemp += b.getBmMoney();
            }else if (b.getBmStatus()==2){                  //加班工资
                overTemp += b.getBmMoney();
            }else {                                         //绩效

            }
        }
        salary.setSalEmpID(employee.getEmpID());
        salary.setSalBasis(employee.getEmpSal());
        salary.setSalBonus(0);
        salary.setSalOT(overTemp);
        salary.setSalPunish(punishTemp);
        salary.setSalSocial(-employee.getEmpSal()*0.105);
        salary.setSalDate(check);
        salary.setSalStatus(0);
        salary.setSalTotal(employee.getEmpSal()+salary.getSalBonus()+overTemp+punishTemp+salary.getSalSocial());
        //计算上月加班
        salaryService.saveSalary(salary);
        System.out.println(salary);
        return;
    }
}
