package com.yao.controller;

import com.yao.biz.UserService;
import com.yao.model.Resume;
import com.yao.model.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
public class UserController {
    @Resource
    private UserService userService;
    @RequestMapping("/userRegPage")
    public String registerPage() throws Exception{
        return "registerPage";
    }
    @RequestMapping("/backToIndex")
    public String backToIndex() throws Exception{
        return "../../index";
    }
    @RequestMapping("/ajaxForRegist")
    public void ajaxForRegist(User user, HttpServletResponse response) throws Exception{
        System.out.println(user);
        /*boolean result = false;
        AjaxResponseMsg*/
        User user1 = userService.findUser(user);
        if (null!=user1 && !"".equals(user1)){
            response.getWriter().print(0);
        }else {
            response.getWriter().print(1);
        }
    }
    @RequestMapping("/userRegister")
    public String userRegister(User user) throws Exception{
        user.setuType(1);
        if (userService.saveUser(user)){
            System.out.println("success");
            return "../../index";
        }else {
            System.out.println("failure");
            return "../../index";
        }
    }

    @RequestMapping("/userLogin")
    public String userLogin(User user, HttpSession session) throws Exception{
        User user1 = userService.loginUser(user);
        if (null!=user1 && user1.getuType()==1){
            System.out.println("userLog:"+user1);
            User user2 = userService.findUserResume(user1);
            session.setAttribute("user",user1);
            session.setAttribute("myResume",user2);
            return "guestPage";
        }else if (null!=user1 && user1.getuType()==0){
            session.setAttribute("user",user1);
            return "managerPage";
        }else {
            return "../../index";
        }
    }

    @RequestMapping("/userMyResume")
    public String userMyResumes(Resume resume, Model model,HttpSession session) throws Exception{
        User user = (User) session.getAttribute("user");
        System.out.println(user);
        user = userService.findUserResume(user);
        System.out.println("**********");
        System.out.println(user);
        System.out.println("**********");
        if (null!=user){
            model.addAttribute("myResume",user);
        }else {
            model.addAttribute("msg","请先填写新简历");
        }
        return "myResumePage";
    }
}
