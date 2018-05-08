package com.yao.controller;

import com.yao.biz.InterViewService;
import com.yao.biz.ResumeService;
import com.yao.model.InterView;
import com.yao.model.Recruit;
import com.yao.model.Resume;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class InterViewController {
    @Resource
    private InterViewService interViewService;
    @Resource
    private ResumeService resumeService;
    @RequestMapping("/interViewPage")
    public String interViewPage() throws Exception{
        return "InterViewPage";
    }

    @RequestMapping("/interViewManag")
    public String interViewManag() throws Exception{
        return "interViewManag";
    }

    @RequestMapping("/newEmployeePage")
    public String newEmployeePage() throws Exception{
        return "newEmpSave";
    }
    /**
     *
     * @param iv
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/interViewSave")
    public void interViewSave(Resume resume, Recruit recruit, InterView iv, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception{
        request.setCharacterEncoding("UTF-8");
        int resuID = Integer.parseInt(request.getParameter("resumeID"));
        int recruID = Integer.parseInt(request.getParameter("recruitID"));
        iv.setJivStatus(0);
        InterView interView = interViewService.findThisIV(resuID,recruID);
        resume.setResuID(resuID);
        recruit.setRiid(recruID);
        iv.setResume(resume);
        iv.setRecruit(recruit);
        Map<String,Object> jsonObj = new HashMap<String, Object>();
        if (null==interView){
            if (interViewService.saveInterView(iv)){
                resumeService.updatePostResume(recruID,resuID,2);
                model.addAttribute("msg","邀请成功");
                jsonObj.put("code","1");
            }
        }else {
            model.addAttribute("msg","请勿重复邀请");
            jsonObj.put("code","2");
        }
       /* return "redirect:/postResumePage";*/
        JSONObject json = new JSONObject(jsonObj);
        response.getWriter().print(json);
        return;
    }

    /**
     *
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping("/ajaxUserInterV")
    public void ajaxUserInterV(HttpServletRequest request, HttpServletResponse response, InterView interView) throws Exception{
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        Map<String,Object> jsonObj = new HashMap<String, Object>();
        int resuID = Integer.parseInt(request.getParameter("resuID"));
        /*String sql = "AND JIV_RESUME_ID="+resuID;
        int pageNo = 1;
        Map<String,Object> param = new HashMap<String, Object>();
        Map<String,Object> jsonObj = new HashMap<String, Object>();
        String strPageNo = request.getParameter("1");
        if (null!=strPageNo && !"".equals(strPageNo)){
            pageNo = Integer.parseInt(strPageNo);
        }
        param.put("tableName","T_HRSYS_INTERVIEW");
        param.put("sqlWhere",sql);
        param.put("pageSize",10);
        param.put("pageNow",pageNo);*/
        List<InterView> interViews = interViewService.listAll(resuID,interView.getJivStatus());
        System.out.println(interViews);
        jsonObj.put("resultList",interViews);
        JSONObject json = new JSONObject(jsonObj);
        response.getWriter().print(json);
    }
    @RequestMapping("/ajaxAllInterV")
    public void ajaxAllInterV(InterView interView,HttpServletRequest request, HttpServletResponse response) throws Exception{
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        Map<String,Object> jsonObj = new HashMap<String, Object>();
        List<InterView> interViews = interViewService.listByStatus(interView.getJivStatus());
        System.out.println(interViews);
        jsonObj.put("resultList",interViews);
        System.out.println("**************");
        System.out.println(interViews);
        System.out.println("**************");
        JSONObject json = new JSONObject(jsonObj);
        response.getWriter().print(json);
    }
    /**
     *
     * @param interView
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/checkMyInterV")
    public String checkMyInterV(InterView interView, Model model) throws Exception{
        InterView interView1 = interViewService.finfIvById(interView);
        model.addAttribute("myInterV",interView1);
        return "checkMyInterView";
    }

    @RequestMapping("/acceptInterV")
    public void acceptInterV(InterView interView, HttpServletResponse response) throws Exception{
        Map<String,Object> jsonObj = new HashMap<String, Object>();
        interView.setJivStatus(1);
        InterView interView1 = interViewService.finfIvById(interView);
        if (interView1.getJivStatus()==0){
            interViewService.updateInterView(interView);
            jsonObj.put("code","1");
        }else {
            jsonObj.put("code","2");
        }
        JSONObject json = new JSONObject(jsonObj);
        response.getWriter().print(json);
        return;
    }

    @RequestMapping("/rejectInterV")
    public void rejectInterV(InterView interView, HttpServletResponse response) throws Exception{
        Map<String,Object> jsonObj = new HashMap<String, Object>();
        interView.setJivStatus(2);
        InterView interView1 = interViewService.finfIvById(interView);
        if (interView1.getJivStatus()==0){
            interViewService.updateInterView(interView);
            jsonObj.put("code","1");
        }else {
            jsonObj.put("code","2");
        }
        JSONObject json = new JSONObject(jsonObj);
        response.getWriter().print(json);
        return;
    }

    @RequestMapping("/acceptByInterV")
    public void acceptByInterV(InterView interView, Model model, HttpServletResponse response, HttpSession session) throws Exception{
        InterView interView1 = interViewService.finfIvById(interView);
        if (interView1.getJivStatus()==1){
          /*  model.addAttribute("newEmpInfo",interView1);*/
            session.setAttribute("newEmpInfo",interView1);
            System.out.println("****************");
            System.out.println(interView1);
            System.out.println("****************");
            response.getWriter().print("success");
        }else {

        }
    }
    @RequestMapping("/lostByInterV")
    public void lostByInterV(InterView interView) throws Exception{
        interView.setJivStatus(4);
        InterView interView1 = interViewService.finfIvById(interView);
        if (interView1.getJivStatus()==1){
            interViewService.updateInterView(interView);
        }
    }
}
