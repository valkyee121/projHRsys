package com.yao.controller;

import com.yao.biz.AtteService;
import com.yao.biz.BonusService;
import com.yao.biz.EmpService;
import com.yao.model.Attend;
import com.yao.model.Bonus;
import com.yao.model.Employee;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.crypto.Data;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class AtteController {
    @Resource
    private AtteService atteService;
    @Resource
    private BonusService bonusService;
    @Resource
    private EmpService empService;
    @RequestMapping("/empAttend")
    public String empAttend() throws Exception{
        return "empAttendPage";
    }
    @RequestMapping("/hisAttePage")
    public String hisAttePage() throws Exception{
        return "HistoryAttePage";
    }

    /**
     *
     * @param session
     * @param attend
     * @return
     * @throws Exception
     */
    @RequestMapping("/saveAtteToday")
    public String saveAtteToday(HttpSession session, Attend attend) throws Exception{
        Employee employee = (Employee) session.getAttribute("myEmpInfo");
        System.out.println(employee);
        attend.setAtteEmpID(employee.getEmpID());
        Date now = new Date();
        attend.setAtteBegin(now);
        System.out.println(attend);
        atteService.saveAtte(attend);
        return "redirect:/empAttend";
    }

    @RequestMapping("/updateAtteToday")
    public String updateAtteToday(HttpSession session,Attend attend) throws Exception{
        Employee employee = (Employee) session.getAttribute("myEmpInfo");
        System.out.println(employee);
        attend.setAtteEmpID(employee.getEmpID());
        Date now = new Date();
        attend.setAtteEnd(now);
        atteService.updateAtte(attend);
        return "redirect:/todayHour";
    }

    @RequestMapping("/ajaxActAtte")
    public void ajaxActAtte(HttpSession session, HttpServletResponse response, Attend attend) throws Exception{
        Employee employee = (Employee) session.getAttribute("myEmpInfo");
        attend.setAtteEmpID(employee.getEmpID());
        List<Attend> attends = atteService.listThisMon(attend);
        Map<String,Object> jsonObj = new HashMap<String, Object>();
        jsonObj.put("result",attends);
        JSONObject json = new JSONObject(jsonObj);
        response.getWriter().print(json);
    }

    /**
     *
     * @param session
     * @param attend
     * @param bonus
     * @throws Exception
     */
    @RequestMapping("/todayHour")
    public void todayHour(HttpSession session, Attend attend, Bonus bonus) throws Exception{
        Employee employee = (Employee) session.getAttribute("myEmpInfo");
        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");

        attend.setAtteEmpID(employee.getEmpID());                   //当月第一条打卡记录，清除上月考勤天数
        List<Attend> attends = atteService.listThisMon(attend);
        if (attends.size()<=1){
            employee.setEmpAttend(0);
        }

        Attend attend1 = atteService.findThisAtte(attend);
        String beginTime = sdf.format(attend1.getAtteBegin());         //实际考勤时间
        String endTime = sdf.format(attend1.getAtteEnd());
        Date begin = sdf.parse(beginTime);
        Date end = sdf.parse(endTime);

        Date ordBegin = sdf.parse("9:00:00");                   //考勤时间规则
        Date ordEnd = sdf.parse("18:00:00");
        System.out.println(begin+"//"+end);
        System.out.println(ordBegin+"///"+ordEnd);

        int compBegin = begin.compareTo(ordBegin);  //判断实际考勤与规定时间之差
        int comEnd = end.compareTo(ordEnd);
        int overtime = 0;
        Date beginTemp = new Date();                //考勤时间临时变量
        Date endTemp = new Date();
        System.out.println(compBegin+"////"+comEnd);

        if (compBegin<=0){                          //上班打卡早于9点，记为9点
            beginTemp = ordBegin;
        }else {                                     //上班打卡迟于9点，记为实际打卡时间
            beginTemp = begin;
        }
        if (comEnd>=0){                             //下班打卡晚于18点，记为18点，额外时间保存为加班时间
            endTemp = ordEnd;
            overtime = (int) ((end.getTime()-ordEnd.getTime())/(1000*60*60));
        }else {                                     //下班打卡早于18点，记为实际实际
            endTemp = end;
        }
        /*当日工时*/
        int hours = (int) ((endTemp.getTime()-beginTemp.getTime())/(1000*60*60));
        if (hours<9 && hours>=6){
            bonus.setBmEmpID(employee.getEmpID());
            bonus.setBmMoney(-(employee.getEmpSal()/22)*0.2);
            bonus.setBmDetail("迟到或早退");
            bonus.setBmDate(new Date());
            bonus.setBmStatus(0);
            employee.setEmpAttend(employee.getEmpAttend()+1);
            empService.updateEmp(employee);
            bonusService.saveBonus(bonus);
            System.out.println(bonus);
        }else if (hours<6){
            bonus.setBmEmpID(employee.getEmpID());
            System.out.println(employee.getEmpSal());
            bonus.setBmMoney(-(employee.getEmpSal()/22));
            bonus.setBmDetail("旷工");
            bonus.setBmDate(new Date());
            bonus.setBmStatus(1);
            bonusService.saveBonus(bonus);
            System.out.println(bonus);
        }else {
            employee.setEmpAttend(employee.getEmpAttend()+1);
            empService.updateEmp(employee);
        }
        System.out.println(overtime);
        if (overtime>0){
            bonus.setBmEmpID(employee.getEmpID());
            bonus.setBmMoney(((employee.getEmpSal()/22)/9)*2*overtime);
            bonus.setBmDetail("加班");
            bonus.setBmDate(new Date());
            bonus.setBmStatus(2);
            bonusService.saveBonus(bonus);
        }
        System.out.println(hours);
        return;
    }

    @RequestMapping("/historyAtte")
    public void historyAtte(HttpSession session, Attend attend, HttpServletRequest request, HttpServletResponse response) throws Exception{
        Employee employee = (Employee) session.getAttribute("myEmpInfo");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
        attend.setAtteEmpID(employee.getEmpID());
        String checkMon = request.getParameter("checkMon");
        Date check = sdf.parse(checkMon);
        attend.setAtteBegin(check);
        List<Attend> attends = atteService.listByMon(attend);
        Map<String,Object> jsonObj = new HashMap<String, Object>();
        jsonObj.put("result",attends);
        JSONObject json = new JSONObject(jsonObj);
        response.getWriter().print(json);
        System.out.println(json);
    }
}
