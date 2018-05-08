package com.yao.controller;

import com.yao.biz.RecruitService;
import com.yao.model.Department;
import com.yao.model.JobPosition;
import com.yao.model.Recruit;
import com.yao.model.User;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class RecruitController {
    @Resource
    private RecruitService recruitService;
    @RequestMapping("/testPage")
    public String testPage() throws Exception{
        return "testPage";
    }
    @RequestMapping("/recruitAddPage")
    public String recruitAddPage() throws Exception{
        return "recruitAdd";
    }
    /**
     *
     * @param request
     * @param recruit
     * @param model
     * @param response
     * @throws Exception
     */
    @RequestMapping("/listAllRecruit")
    public void listAllRecruit(HttpServletRequest request, Recruit recruit, Model model, HttpServletResponse response) throws Exception{
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String sql = "";
        int pageNo = 1;
        Map<String,Object> param = new HashMap<String, Object>();
        Map<String,Object> jsonObj = new HashMap<String, Object>();
        String strPageNo = request.getParameter("pageIndex");
        if (null!=strPageNo && !"".equals(strPageNo)){
            pageNo = Integer.parseInt(strPageNo);
        }
        param.put("tableName","T_HRSYS_RECRUITINF");
        param.put("sqlWhere",sql);
        param.put("pageSize",10);
        param.put("pageNow",pageNo);
        recruitService.listAll(param);
        List<Recruit> recruitList = (List<Recruit>) param.get("result");

        int curPage = (Integer) param.get("pageNow");
        int totalRows = (Integer) param.get("rows"); //总记录条数
        int totalPages = (Integer) param.get("pageCount"); //总页数
        jsonObj.put("resultList",recruitList);
        jsonObj.put("totalpage",totalPages);
        JSONObject json = new JSONObject(jsonObj);
        response.getWriter().print(json);
        System.out.println(json);
        /*PrintWriter out = response.getWriter();
        out.print(json);*/
        model.addAttribute("pageNo",curPage);
        model.addAttribute("totalPages",totalPages);
    }

    /**
     *
     * @param session
     * @param recruit
     * @param model
     * @param response
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/findThisRecruit")
    public String findThisRecruit(HttpSession session, Recruit recruit, Model model, HttpServletResponse response, HttpServletRequest request) throws Exception{
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        User user = (User) session.getAttribute("user");
        System.out.println(recruit);
        recruit.setRiStatus(1);
        recruit = recruitService.findRecruit(recruit);
        System.out.println(recruit);
        model.addAttribute("thisRecruit",recruit);
        return "recruitPage";
    }

    /**
     * 管理员招聘信息
     * @param request
     * @param recruit
     * @param model
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("/recruitManag")
    public String recruitManag(HttpServletRequest request, Recruit recruit, Model model, HttpServletResponse response) throws Exception{
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String sql = "";
        int pageNo = 1;
        Map<String,Object> param = new HashMap<String, Object>();
        Map<String,Object> jsonObj = new HashMap<String, Object>();
        String strPageNo = request.getParameter("pageIndex");
        if (null!=strPageNo && !"".equals(strPageNo)){
            pageNo = Integer.parseInt(strPageNo);
        }
        param.put("tableName","T_HRSYS_RECRUITINF");
        param.put("sqlWhere",sql);
        param.put("pageSize",10);
        param.put("pageNow",pageNo);
        recruitService.listAll(param);
        List<Recruit> recruitList = (List<Recruit>) param.get("result");

        int curPage = (Integer) param.get("pageNow");
        int totalRows = (Integer) param.get("rows"); //总记录条数
        int totalPages = (Integer) param.get("pageCount"); //总页数
        jsonObj.put("resultList",recruitList);
        jsonObj.put("totalpage",totalPages);
        JSONObject json = new JSONObject(jsonObj);
        response.getWriter().print(json);
        /*PrintWriter out = response.getWriter();
        out.print(json);*/
        model.addAttribute("pageNo",curPage);
        model.addAttribute("totalPages",totalPages);
        return "recruitManager";
    }

    /**
     *
     * @param recruit
     * @param request
     * @param response
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/recruitModManag")
    public String recruitModManag(Recruit recruit,HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        System.out.println(recruit);
        recruit.setRiStatus(1);
        recruit = recruitService.findRecruit(recruit);
        model.addAttribute("thisRecruit",recruit);
        return "recruitMod";
    }
    @RequestMapping("/recruitUpdate")
    public void recruitUpdate(Recruit recruit, JobPosition jobPosition, Department department,HttpServletResponse response, HttpServletRequest request) throws Exception{
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        if (department!=null && jobPosition!=null){
            recruit.setRiDept(department);
            recruit.setRiJob(jobPosition);
        }
        Map<String,Object> jsonObj = new HashMap<String, Object>();
        if (null!=recruit){
            recruitService.updateRecruit(recruit);
            jsonObj.put("msg","更新成功");
        }else {
            jsonObj.put("msg","更新失败");
        }
        JSONObject json = new JSONObject(jsonObj);
        response.getWriter().print(json);
        return;
    }

    @RequestMapping("/recruitSaveManag")
    public String recruitSaveManag(Recruit recruit, Department dt, JobPosition jp, HttpServletRequest request) throws Exception{
        request.setCharacterEncoding("UTF-8");
        recruit.setRiJob(jp);
        recruit.setRiDept(dt);
        recruit.setRiStatus(1);
        System.out.println(recruit);
        if (recruitService.saveRecruit(recruit)){
            System.out.println("success");
        }
        return "/recruitAddPage";
    }
}
