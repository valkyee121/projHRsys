package com.yao.controller;

import com.yao.biz.ResumeService;
import com.yao.biz.UserService;
import com.yao.model.Recruit;
import com.yao.model.Resume;
import com.yao.model.User;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ResumeController {
    @Resource
    private ResumeService resumeService;
    @Resource
    private UserService userService;

    @RequestMapping("/myApplypage")
    public String myApplypage() throws Exception{
        return "myApplication";
    }
    @RequestMapping("/saveMyResume")
    public String saveMyResume(User user, Resume resume, HttpSession session) throws Exception{
        user = (User) session.getAttribute("user");
        User user1 = userService.findUserResume(user);
        resume.setUid(user.getUid());

        if (null!=user1 && !"".equals(user1)){
            resumeService.updateResume(resume);
        }else {
            resumeService.saveResume(resume);
        }
        return "redirect:/userMyResume";
        /*return ;*/
    }

    @RequestMapping("/applyThisJob")
    public String applyThisJob(HttpSession session, Recruit recruit, HttpServletRequest request) throws Exception{
        User user = userService.findUserResume((User) session.getAttribute("user"));
        if (null!=user && !"".equals(user)){
            System.out.println(recruit);
            resumeService.postResume(recruit.getRiid(),user.getResume().getResuID(),0);
            return "../../index";
        }else {
            System.out.println("请先填写简历");
            return "forward:/userMyResume";
        }
    }

    @RequestMapping("/ajaxListMyApply")
    public void ajaxListMyApply(HttpSession session, HttpServletRequest request, HttpServletResponse response, Resume resume) throws Exception{
        User user =
        userService.findUserResume((User) session.getAttribute("user"));
        int postStatus = Integer.parseInt(request.getParameter("postStatus"));
        resume.setUid(user.getUid());
        List<Resume> resumeList = resumeService.listMyPost(user.getUid(),postStatus);
        for (Resume r:resumeList){
            System.out.println(r);
        }
        Map<String,Object> jsonObj = new HashMap<String, Object>();
        jsonObj.put("resultList",resumeList);
        JSONObject json = new JSONObject(jsonObj);
        response.getWriter().print(json);
        System.out.println("**************");
        System.out.println(user);
        System.out.println(resumeList);
        System.out.println("**************");

       /* String sql = "";
        int pageNo = 1;
        Map<String,Object> param = new HashMap<String, Object>();
        Map<String,Object> jsonObj = new HashMap<String, Object>();
        String strPageNo = request.getParameter("pageIndex");
        if (null!=strPageNo && !"".equals(strPageNo)){
            pageNo = Integer.parseInt(strPageNo);
        }
        param.put("tableName","T_HRSYS_RESUME rs JOIN T_HRSYS_POSTINTER po ON rs.RESU_ID = po.POST_RESUID JOIN T_HRSYS_RECRUITINF re ON po.POST_RI_ID = re.RI_ID");
        param.put("sqlWhere",sql);
        param.put("pageSize",10);
        param.put("pageNow",pageNo);
        resumeService.listMyPost(param);
        List<Resume> resumeList = (List<Resume>) param.get("result");
        System.out.println(resumeList);*/

    }
}
