package com.yao.controller;

import com.yao.biz.JobPosService;
import com.yao.model.Department;
import com.yao.model.JobPosition;

import net.sf.json.JSONArray;
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
    public String jobManager(HttpServletRequest request, HttpServletResponse response) throws Exception{
        return "jobPosPage";
    }
    @RequestMapping("/ajaxListAllJob")
    public void ajaxListAllJob(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception{
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        JSONObject json = new JSONObject();
        List<JobPosition> jobPositions = jobPosService.listAll();
        Map<String,Object> jsonObj = new HashMap<String, Object>();
        JSONArray array = new JSONArray();
        for (int i=0;i<jobPositions.size();i++){
            jsonObj.put("jobID",jobPositions.get(i).getJobID());
            jsonObj.put("jobName",jobPositions.get(i).getJobName());
            jsonObj.put("deptName",jobPositions.get(i).getDepartment().getDeptName());
            jsonObj.put("jobSalary",jobPositions.get(i).getJobSalary());
            jsonObj.put("jobStatus",jobPositions.get(i).getJobStatus());
            array.add(jsonObj);
        }
        response.getWriter().print(array);
    }

    @RequestMapping("/jobSave")
    public void jobSave(Department department,JobPosition jobPosition, HttpServletRequest request) throws Exception{
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

    @RequestMapping("/jobModify")
    public void jobModify(JobPosition jobPosition, HttpServletResponse response) throws Exception{
        /*jobPosition.setJobStatus(0);*/
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        Map<String,Object> jsonObj = new HashMap<String, Object>();
        if (jobPosService.updateJobPos(jobPosition)){
            jsonObj.put("msg","更新成功");
        }else {
            jsonObj.put("msg","更新失败");
        }
        System.out.println(jobPosition);
        JSONObject json = new JSONObject(jsonObj);
        response.getWriter().print(json);
        return;
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
