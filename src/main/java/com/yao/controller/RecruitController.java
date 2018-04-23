package com.yao.controller;

import com.yao.biz.RecruitService;
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
    @RequestMapping("/listAllRecruit")
    public void listAllRecruit(HttpServletRequest request, Recruit recruit, Model model, HttpServletResponse response) throws Exception{
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
    }

    @RequestMapping("/findThisRecruit")
    public String findThisRecruit(HttpSession session, Recruit recruit, Model model) throws Exception{
        User user = (User) session.getAttribute("user");
        System.out.println(recruit);
        recruit.setRiStatus(1);
        recruit = recruitService.findRecruit(recruit);
        model.addAttribute("thisRecruit",recruit);
        return "recruitPage";
    }
}
