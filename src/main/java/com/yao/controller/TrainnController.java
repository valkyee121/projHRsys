package com.yao.controller;

import com.yao.biz.TrainnService;
import com.yao.model.Trainn;
import org.json.JSONObject;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Controller
public class TrainnController {
    @Resource
    private TrainnService trainnService;

   /* @InitBinder
    protected void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }*/
    @RequestMapping("/trainnManaPage")
    public String trainnManaPage() throws Exception{
        return "trainnManaPage";
    }

    @RequestMapping("/ajaxListTrainn")
    public void ajaxListTrainn(int trStatus, HttpServletResponse response) throws Exception{
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        Map<String,Object> param = new HashMap<String, Object>();
        List<Trainn> trainns = new ArrayList<Trainn>();
        if (trStatus==0){
            trainns = trainnService.listCurr();
            /*trainns = (List<Trainn>) param.get("result");*/
        }
        if (trStatus==1){
            trainnService.listPast(param);
            trainns = (List<Trainn>) param.get("result");
        }
        System.out.println(trainns);
        Map<String,Object> jsonObj = new HashMap<String, Object>();
        jsonObj.put("result",trainns);
        JSONObject json = new JSONObject(jsonObj);
        response.getWriter().print(json);
    }

    @RequestMapping("/findTrainn")
    public String findTrainn(Trainn trainn, Model model, HttpServletResponse response) throws Exception{
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        if (trainn!=null && !"".equals(trainn)){
            Trainn trainn1 = trainnService.findTrain(trainn);

            System.out.println(trainn1);
            model.addAttribute("trainn",trainn1);
        }else {
            System.out.println("null");
        }
        return "trainnMod";
    }

    @RequestMapping("/updateTrainn")
    public void updateTrainn(Trainn trainn) throws Exception{
        if (trainn!=null && !"".equals(trainn)){
            System.out.println(trainn);
            trainnService.updateTrainn(trainn);
        }
    }

    /**
     * 该培训参与人员
     * @param trainn
     * @throws Exception
     */
    @RequestMapping("/ajaxTrList")
    public void ajaxTrList(Trainn trainn, HttpServletResponse response) throws Exception{
        System.out.println(trainn);
        List<Trainn> trainns = trainnService.findWithEmp(trainn);
        System.out.println(trainns);
        Map<String,Object> jsonObj = new HashMap<String, Object>();
        jsonObj.put("result",trainns);
        System.out.println(trainns);
        JSONObject json = new JSONObject(jsonObj);
        response.getWriter().print(json);
    }

    @RequestMapping("/saveTrEmp")
    public void saveTrEmp(HttpServletRequest request) throws Exception{
        String empID = request.getParameter("empID");
        int trID = Integer.parseInt(request.getParameter("trIDm"));
        List<String> a=new ArrayList<String>();
        List<Object> b=new ArrayList<Object>();
        String[]s1 = empID.split("&");
        for (String temp:s1){
            String[]s2 = temp.split("=");
            a.add(s2[0]);
            b.add(s2[1]);
        }
        System.out.println(a);
        System.out.println(b);
        System.out.println(trID);
        trainnService.saveTrEmp(b,trID);

    }
    /**
     *
     * @param trainn
     * @throws Exception
     */
    @RequestMapping("/newTrainSave")
    public void newTrainSave(Trainn trainn) throws Exception{
      /*  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH24:mm:ss");
        trainn.setTrBegin();
        trainn.setTrEnd(sdf.format(trainn.getTrEnd()));*/
        System.out.println(trainn);
        trainn.setTrStatus(0);
/*        trainn.setEmployees(null);*/
        if (trainn!=null && !"".equals(trainn)){
            System.out.println(trainn);
            trainnService.saveTrainn(trainn);
        }
    }
}
