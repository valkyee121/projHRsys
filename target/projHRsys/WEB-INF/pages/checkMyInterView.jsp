<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %><%--
  Created by IntelliJ IDEA.
  User: AllenYao
  Date: 2018.04.25
  Time: 14:16
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
    <title>我的面试</title>
    <link rel="stylesheet" type="text/css" href="resources/js/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="resources/js/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="resources/js/demo.css">
    <link rel="stylesheet" type="text/css" href="resources/css/pagination.css">
    <link rel="stylesheet" type="text/css" href="resources/css/sidebar.css">
    <link rel="stylesheet" type="text/css" href="resources/css/teal.css">
    <script type="text/javascript" src="resources/js/jquery.min.js"></script>
    <script type="text/javascript" src="resources/js/jquery.easyui.min.js"></script>
</head>
<body class="easyui-layout">
<%--MAINPAGE--%>
<div data-options="region:'north',border:true" style="height:60px;background:-webkit-linear-gradient(bottom,#EFF5FF,#E0ECFF);padding:10px">
    <nav class="nav">
        <ul >
            <li ><a href="guestPage">Home</a></li>
            <li><a href="userMyResume?uid=${sessionScope.user.uid}">个人简历 </a></li>
            <li><a href="myApplypage">职位申请 </a></li>
            <li><a href="interViewPage">我的面试 </a></li>
            <!-- Regular Menu Ends -->
        </ul>
    </nav>
</div>
<div data-options="region:'west',split:true,title:'West'" style="width:256px;padding:10px;">
    <%--LOGIN--%>
    <div class="row flat">
        <div class="col-lg-3 col-md-3 col-xs-6">
            <ul class="plan plan1">
                <li class="plan-name">
                    用户信息
                </li>
                <li class="plan-price">
                    姓名：<strong>${myResume.resume.resuName}</strong>
                </li>
                <li class="plan-price">
                    出生年月：<strong><fmt:formatDate value='${myResume.resume.resuBirth}' type="date" pattern="yyyy-MM-dd"/></strong>
                </li>
                <li class="plan-price">
                    居住地：<strong>${myResume.resume.resuCity}</strong>
                </li>
                <li class="plan-price">
                    手机：<strong>${myResume.resume.resuCell}</strong>
                </li>
                <li class="plan-price">
                    邮箱：<strong>${myResume.resume.resuEmail}</strong>
                </li>
                <li class="plan-action">
                    <a href="checkOut" class="btn btn-danger btn-lg">退出登录</a>
                </li>
            </ul>
        </div>
    </div>
</div>
<div data-options="region:'south',border:false" style="height:50px;background:-webkit-linear-gradient(bottom,#EFF5FF,#E0ECFF);padding:10px;">
    页脚
</div>
<div data-options="region:'center',title:'投递信息'">
    <div style="margin-bottom:20px">
        <input class="easyui-textbox" label="标题：" value="${myInterV.recruit.riName}" labelPosition="top" readonly style="width:50%;">
    </div>
    <div style="margin-bottom:20px">
        <input class="easyui-textbox" label="应聘人姓名：" value="${myInterV.resume.resuName}" labelPosition="top" readonly style="width:50%;">
    </div>
    <div style="margin-bottom:20px">
        <input class="easyui-textbox" label="企业：" value="${myInterV.recruit.riCompany}" labelPosition="top" readonly style="width:50%;">
    </div>
    <div style="margin-bottom:20px">
        <input class="easyui-textbox" label="薪酬标准：" value="${myInterV.recruit.riSalary}" labelPosition="top" readonly style="width:50%;">
    </div>
    <div style="margin-bottom:20px">
        <input class="easyui-textbox"  value="${myInterV.recruit.riDept.deptName}" label="所属部门:" labelPosition="top" readonly style="width:50%;" >
    </div>
    <div style="margin-bottom:20px">
        <input class="easyui-textbox"  value="${myInterV.recruit.riJob.jobName}"  label="所属职位:" labelPosition="top" readonly style="width:50%;" />
    </div>
    <div style="margin-bottom:20px">
        <input class="easyui-textbox" label="岗位职责：" value="${myInterV.recruit.riDuty}" labelPosition="top" readonly multiline="true" style="width:50%;height:120px">
    </div>
    <div style="margin-bottom:20px">
        <input class="easyui-textbox" label="岗位要求：" value="${myInterV.recruit.riDesired}" labelPosition="top" readonly multiline="true" style="width:50%;height:120px">
    </div>
    <div style="margin-bottom:20px">
        <input class="easyui-textbox" label="其他信息：" value="${myInterV.recruit.riAddtion}" labelPosition="top" readonly multiline="true" style="width:50%;height:120px">
    </div>
    <div style="margin-bottom:20px">
        <input class="easyui-textbox" label="工作地点:" value="${myInterV.recruit.riLocation}"labelPosition="top" readonly style="width:50%;">
    </div>
    <div style="margin-bottom:20px">
        <input class="easyui-textbox" label="面试时间：" value="<fmt:formatDate value='${myInterV.jivDate}' type="date" pattern="yyyy-MM-dd"/> " labelPosition="top" readonly style="width:50%;">
    </div>
    <div style="margin-bottom:20px">
        <input class="easyui-textbox" label="面试地点：" value="${myInterV.jivLocal}" labelPosition="top" readonly style="width:50%;">
    </div>
    <form id="ff" method="post" >
        <input type="hidden" name="jivID" value="${myInterV.jivID}">
        <a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="confirm()" style="width:80px">接受面试</a>
        <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="reject()" style="width:80px">拒绝面试</a>
    </form>
</div>
</div>

<%--表单提交--%>
<script type="text/javascript">
    function confirm() {
        $.ajax({
            type: 'post',
            url: 'acceptInterV',
            data: $('#ff').serialize(),
            success: function (data) {
                if (data.code=='1'){
                    alert("接受面试");
                    window.location.href = "interViewPage";
                }else if (data.code=='2'){
                    alert("无效面试邀请");
                }
            },error:function () {
                alert("错误操作")
            }
        });
    }
    function reject() {
        $.ajax({
            type: 'post',
            url :'rejectInterV',
            data :$('#ff').serialize(),
            success: function (data) {
                if (data.code=='1'){
                    alert("拒绝面试");
                    window.location.href = "interViewPage";
                }else if (data.code=='2'){
                    alert("已接受面试，不发更改");
                }
            },error:function () {
                alert("错误操作")
            }
        })
    }
</script>
</body>
</html>
