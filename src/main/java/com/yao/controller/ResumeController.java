package com.yao.controller;

import com.yao.biz.ResumeService;
import com.yao.biz.UserService;
import com.yao.model.InterView;
import com.yao.model.Recruit;
import com.yao.model.Resume;
import com.yao.model.User;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.beans.PropertyEditorSupport;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ResumeController {
    @Resource
    private ResumeService resumeService;
    @Resource
    private UserService userService;

    @InitBinder
    public void InitBinder(WebDataBinder dataBinder)
    {
        dataBinder.registerCustomEditor(Date.class, new PropertyEditorSupport() {
            public void setAsText(String value) {
                try {
                    setValue(new SimpleDateFormat("yyyy-MM-dd").parse(value));
                } catch(ParseException e) {
                    setValue(null);
                }
            }
            public String getAsText() {
                return new SimpleDateFormat("yyyy-MM-dd").format((Date) getValue());
            }
        });
    }
    @RequestMapping("/myApplypage")
    public String myApplypage() throws Exception{
        return "myApplication";
    }
    @RequestMapping("/postResumePage")
    public String postResumePage() throws Exception{
        return "postResumePage";
    }
    /**
     * 个人简历添加
     * @param user
     * @param resume
     * @param session
     * @return
     * @throws Exception
     */
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

    /**
     * 游客申请职位
     * @param session
     * @param recruit
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/applyThisJob")
    public void applyThisJob(HttpSession session, Recruit recruit, HttpServletRequest request, HttpServletResponse response) throws Exception{
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        User user1 = (User) session.getAttribute("user");
        Map<String,Object> jsonObj = new HashMap<String, Object>();
        if (null!=user1 && !"".equals(user1)){
            User user = userService.findUserResume(user1);
            if (null!=user && !"".equals(user)){
                System.out.println(recruit);
                resumeService.savePostResume(recruit.getRiid(),user.getResume().getResuID(),0);
                jsonObj.put("code","1");
                /*mav.setViewName("/myApplypage");*/
            }else {
                System.out.println("请先填写简历");
           /*     mav.addObject("msg","请先填写简历");*/
                jsonObj.put("code","2");
                /*mav.setViewName("/userMyResume");*/
            }
        }else {
            System.out.println("请先登录游客帐号");
            /*mav.addObject("msg","请先登录游客帐号");*/
            jsonObj.put("code","3");
            /*mav.setViewName("../../index");*/
           /* return "../../index";*/
        }
        JSONObject json = new JSONObject(jsonObj);
        response.getWriter().print(json);
        return;
    }

    /**
     * 游客投递简历状态
     * @param session
     * @param request
     * @param response
     * @param resume
     * @throws Exception
     */
    @RequestMapping("/ajaxListMyApply")
    public void ajaxListMyApply(HttpSession session, HttpServletRequest request, HttpServletResponse response, Resume resume) throws Exception{
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
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

    /**
     *
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping("/ajaxPostResume")
    public void ajaxPostResume(HttpServletRequest request, HttpServletResponse response) throws Exception{
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        int postStatus = Integer.parseInt(request.getParameter("postStatus"));
        List<Resume> resumeList = resumeService.listAllPost(postStatus);
        Map<String,Object> jsonObj = new HashMap<String, Object>();
        jsonObj.put("resultList",resumeList);
        JSONObject json = new JSONObject(jsonObj);
        response.getWriter().print(json);
    }

    @RequestMapping("/checkUserPost")
    public String checkUserPost(HttpServletRequest request, Model model) throws Exception{
        int postRsId = Integer.parseInt(request.getParameter("postRsId"));
        int postReId = Integer.parseInt(request.getParameter("postReId"));
        Resume resume = resumeService.findThisResume(postRsId,postReId);
        if (resume.getInternalPost().getPostStatus()<1){
            resumeService.updatePostResume(postReId,postRsId,1);
        }
        System.out.println(resume);
        model.addAttribute("userPostReRs",resume);
        return "checkUserPost";
    }

    @RequestMapping("/rejectPost")
    public void rejectPost(HttpServletRequest request, Model model, InterView iv) throws Exception{
        request.setCharacterEncoding("UTF-8");
        int resuID = Integer.parseInt(request.getParameter("resumeID"));
        int recruID = Integer.parseInt(request.getParameter("recruitID"));
        Resume resume = resumeService.findThisResume(resuID,recruID);
        if (resume.getInternalPost().getPostStatus()!=2){
            if (resumeService.updatePostResume(recruID,resuID,3)){
                System.out.println("淘汰");
            }
        }
    }
}
