<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %><%--
  Created by IntelliJ IDEA.
  User: AllenYao
  Date: 2018.04.26
  Time: 13:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <base href="<%=basePath%>"/>
    <meta charset="UTF-8">
    <title>员工入职</title>
    <link rel="stylesheet" type="text/css" href="resources/js/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="resources/js/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="resources/js/demo.css">
    <link rel="stylesheet" type="text/css" href="resources/css/pagination.css">
    <script type="text/javascript" src="resources/js/jquery.min.js"></script>
    <script type="text/javascript" src="resources/js/jquery.easyui.min.js"></script>
</head>
<body>
<div class="easyui-panel" title="新员工入职表" style="width:100%;max-width:400px;padding:30px 60px;">
    <form id="ff" class="easyui-form" method="post" action="saveNewEmp" data-options="novalidate:true">
        <input type="hidden" name="jivID" value="${sessionScope.newEmpInfo.jivID}">
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" name="empName" value="${sessionScope.newEmpInfo.resume.resuName}" style="width:100%" data-options="label:'姓名:',required:true">
        </div>
        <div style="margin-bottom:20px">
            <label for="userSex" class="textbox-label">性别：</label>
            <input id="userSex" type="radio" name="resuSex" value="0" checked>女
            <input  type="radio" name="resuSex" value="1">男
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" id="birth" name="empBirth" value="<fmt:formatDate value='${sessionScope.newEmpInfo.resume.resuBirth}' type="date" pattern="yyyy-MM-dd"/>"   label="出生日期：" labelPosition="top" style="width:100%;">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" id="city" name="empCity" value="${sessionScope.newEmpInfo.resume.resuCity}" label="所在城市：" labelPosition="top" style="width:100%;">
        </div>
      <%--  <div style="margin-bottom:20px">
            <input class="easyui-textbox" name="resuCell" value="${myResume.resume.resuCell}" label="手机号码" >
        </div>--%>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" name="empEmail" value="${sessionScope.newEmpInfo.resume.resuEmail}" readonly style="width:100%" data-options="label:'Email:'">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" name="deptID" value="${sessionScope.newEmpInfo.recruit.riDept.deptID}" readonly style="width:100%" data-options="label:'所属部门编号:'">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" name="jobID" value="${sessionScope.newEmpInfo.recruit.riJob.jobID}" readonly style="width:100%" data-options="label:'所属职位编号:'">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" name="jobSalary" value="${sessionScope.newEmpInfo.recruit.riJob.jobSalary}" readonly style="width:100%" data-options="label:'职位薪酬:'">
        </div>
        <div style="text-align:center;padding:5px 0">
            <%--<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()" style="width:80px">Submit</a>--%>
            <input class="easyui-linkbutton" type="submit" value="SAVE" style="width:80px">
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()" style="width:80px">Clear</a>
        </div>
    </form>
    <%--<div style="text-align:center;padding:5px 0">
        &lt;%&ndash;<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()" style="width:80px">Submit</a>&ndash;%&gt;
        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()" style="width:80px">Clear</a>
    </div>--%>
</div>
</body>
</html>
