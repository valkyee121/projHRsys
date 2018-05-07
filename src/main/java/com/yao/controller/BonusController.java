package com.yao.controller;

import com.yao.biz.BonusService;
import com.yao.model.Bonus;
import com.yao.model.Employee;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
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
public class BonusController {
    @Resource
    private BonusService bonusService;

    @RequestMapping("/myBonus")
    public String myBonus() throws Exception{
        return "histBonusPage";
    }

    @RequestMapping("/ajaxMyBonus")
    public void ajaxMyBonus(HttpSession session, Employee employee, Bonus bonus, HttpServletRequest request, HttpServletResponse response) throws Exception{
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        employee = (Employee) session.getAttribute("myEmpInfo");
        bonus.setBmEmpID(employee.getEmpID());
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
        String checkMon = request.getParameter("checkMon");
        Date check = sdf.parse(checkMon);
        bonus.setBmDate(check);
        List<Bonus> bonuses = bonusService.listBonusMon(bonus);
        Map<String,Object> jsonObj = new HashMap<String, Object>();
        jsonObj.put("result",bonuses);
        JSONObject json = new JSONObject(jsonObj);
        response.getWriter().print(json);
        System.out.println(json);
        return;
    }
}
