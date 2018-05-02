package com.yao.controller;

import com.yao.biz.JobPosService;
import com.yao.model.Department;
import com.yao.model.JobPosition;
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
public class JobPosController {
    @Resource
    private JobPosService jobPosService;

    @RequestMapping("/jobManager")
    public String deptManager(HttpServletRequest request, HttpServletResponse response) throws Exception{
        return "jobPosPage";
    }
    @RequestMapping("/ajaxListAllJob")
    public void ajaxListAllDept(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception{
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
        param.put("tableName","T_HRSYS_JOB");
        param.put("sqlWhere",sql);
        param.put("pageSize",100);
        param.put("pageNow",pageNo);
        jobPosService.listAll(param);
        List<JobPosition> jobPositions = (List<JobPosition>) param.get("result");

        int curPage = (Integer) param.get("pageNow");
        int totalRows = (Integer) param.get("rows"); //总记录条数
        int totalPages = (Integer) param.get("pageCount"); //总页数
        jsonObj.put("resultList",jobPositions);
        jsonObj.put("totalpage",totalPages);
        JSONObject json = new JSONObject(jsonObj);
        response.getWriter().print(json);
        System.out.println(json);
        /*PrintWriter out = response.getWriter();
        out.print(json);*/
        model.addAttribute("pageNo",curPage);
        model.addAttribute("totalPages",totalPages);
    }

    @RequestMapping("/jobSave")
    public void deptSave(Department department,JobPosition jobPosition, HttpServletRequest request) throws Exception{
        request.setCharacterEncoding("UTF-8");
        System.out.println(jobPosition);
        jobPosition.setDepartment(department);
        int status = jobPosition.getJobStatus();
        Map<String,Object> param = new HashMap<String, Object>();
        param.put("jobName",jobPosition.getJobName());
        param.put("jobSal",jobPosition.getJobSalary());
        param.put("jobDept",department.getDeptID());
        /* param.put("deptStatus",1);*/
        System.out.println(param);
        jobPosService.saveJobPos(param);
        int flag = (Integer) param.get("msg");
        if (flag==1){
            System.out.println("success");
        }else {
            System.out.println("error");
        }
    }

    @RequestMapping("/jobCancel")
    public void deptCancel(JobPosition jobPosition) throws Exception{
        jobPosition.setJobStatus(0);
        jobPosService.updateJobPos(jobPosition);
        System.out.println(jobPosition);
    }

    @RequestMapping("/ajaxFindJob")
    public void ajaxFindJob(HttpServletResponse response,JobPosition jobPosition) throws Exception{
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        System.out.println(jobPosition);
        JobPosition jobPosition1 = jobPosService.findJobPos(jobPosition);
        Map<String,Object> jsonObj = new HashMap<String, Object>();
        jsonObj.put("result",jobPosition1);
        JSONObject json = new JSONObject(jsonObj);
        response.getWriter().print(json);
    }
}
