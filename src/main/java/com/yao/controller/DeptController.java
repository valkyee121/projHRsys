package com.yao.controller;

import com.yao.biz.DeptService;
import com.yao.dao.DeptMapper;
import com.yao.model.Department;
import com.yao.model.Recruit;
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
public class DeptController {
    @Resource
    private DeptService deptService;

    @RequestMapping("/deptManager")
    public String deptManager(HttpServletRequest request, HttpServletResponse response) throws Exception{
        return "departPage";
    }

    /**
     *
     * @param model
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping("/ajaxListAllDept")
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
        param.put("tableName","T_HRSYS_DEPT");
        param.put("sqlWhere",sql);
        param.put("pageSize",100);
        param.put("pageNow",pageNo);
        deptService.listAll(param);
        List<Department> departments = (List<Department>) param.get("result");

        int curPage = (Integer) param.get("pageNow");
        int totalRows = (Integer) param.get("rows"); //总记录条数
        int totalPages = (Integer) param.get("pageCount"); //总页数
        jsonObj.put("resultList",departments);
        jsonObj.put("totalpage",totalPages);
        JSONObject json = new JSONObject(jsonObj);
        response.getWriter().print(json);
        System.out.println(json);
        /*PrintWriter out = response.getWriter();
        out.print(json);*/
        model.addAttribute("pageNo",curPage);
        model.addAttribute("totalPages",totalPages);
    }

    @RequestMapping("/ajaxListDeptWithJob")
    public void ajaxListDeptWithJob(HttpServletResponse response, HttpServletRequest request) throws Exception{
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        List<DeptMapper> departments =  deptService.listWithJob();
        System.out.println(departments);
        Map<String,Object> jsonObj = new HashMap<String, Object>();
        jsonObj.put("resultList",departments);
        JSONObject json = new JSONObject(jsonObj);
        response.getWriter().print(json);
    }

    @RequestMapping("/ajaxFindJobByDept")
    public void ajaxFindJobByDept(HttpServletRequest request, HttpServletResponse response, Department department) throws Exception{
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        System.out.println(department);
        if (department.getDeptID()==0){
            department.setDeptID(1);
        }
        Department department1 = deptService.findDept(department);
        Map<String,Object> jsonObj = new HashMap<String, Object>();
        jsonObj.put("result",department1);
        System.out.println(department1);
        JSONObject json = new JSONObject(jsonObj);
        response.getWriter().print(json);
    }
    /**
     *
     * @param department
     * @param request
     * @throws Exception
     */
    @RequestMapping("/deptSave")
    public void deptSave(Department department, HttpServletRequest request) throws Exception{
        System.out.println(department);
        int status = department.getDeptStatus();
        request.setCharacterEncoding("UTF-8");
        Map<String,Object> param = new HashMap<String, Object>();
        param.put("deptName",department.getDeptName());
      /*  param.put("deptBuild",department.getDeptBuild());*/
       /* param.put("deptStatus",1);*/
        deptService.saveDept(param);
        int flag = (Integer) param.get("msg");
        if (flag==1){
            System.out.println("success");
        }else {
            System.out.println("error");
        }
    }

    @RequestMapping("/deptCancel")
    public void deptCancel(Department department) throws Exception{
        department.setDeptStatus(0);
        deptService.updateDept(department);
        System.out.println(department);
    }
}
