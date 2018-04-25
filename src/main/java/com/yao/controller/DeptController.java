package com.yao.controller;

import com.yao.biz.DeptService;
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
        param.put("pageSize",10);
        param.put("pageNow",pageNo);
        deptService.listAll(param);
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

    @RequestMapping("/deptSave")
    public void deptSave(Department department, HttpServletRequest request) throws Exception{
        request.setCharacterEncoding("UTF-8");
        if (deptService.saveDept(department)){
            System.out.println("success");
        }
    }
}
