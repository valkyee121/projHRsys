<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: AllenYao
  Date: 2018.04.23
  Time: 9:26
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
    <title>recruitPage</title>
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

<div data-options="region:'north',border:true" style="height:60px;background:-webkit-linear-gradient(bottom,#EFF5FF,#E0ECFF);padding:10px">
    <nav class="nav">
        <ul>
            <c:if test="${sessionScope.user != null}">
                <li ><a href="guestPage">Home</a></li>
                <li><a href="userMyResume?uid=${sessionScope.user.uid}">个人简历 </a></li>
                <li><a href="myApplypage">职位申请 </a></li>
                <li><a href="interViewPage">我的面试 </a></li>
                <!-- Regular Menu Ends -->
            </c:if>
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
                <c:if test="${sessionScope.user != null}">
                <li class="plan-action">
                    <a href="checkOut" class="btn btn-danger btn-lg">退出登录</a>
                </li>
                </c:if>
            </ul>
        </div>
    </div>
</div>
<div data-options="region:'east',split:true,collapsed:true,title:'East'" style="width:100px;padding:10px;">

</div>
<div data-options="region:'center',title:'招聘信息'">
    <div style="margin:20px 0;"></div>
    <div <%--class="easyui-dialog"--%>class="easyui-panel" style="width:600px;padding:10px 10px; position: absolute;left: 50%;top: 50%; transform: translate(-50%,-50%);">
        <form id="ff" method="post" <%--action="applyThisJob"--%>>
            <div>
                <input type="hidden" name="riid" value="${thisRecruit.riid}">
            </div>
            <div style="margin-bottom:10px">
                <input class="easyui-textbox" value="${thisRecruit.riName}" label="标题:" labelPosition="top" readonly style="width:100%;">
            </div>
            <div style="margin-bottom:10px">
                <input class="easyui-textbox" value="${thisRecruit.riCompany}" label="企业名称:" labelPosition="top" readonly style="width:100%;">
            </div>
            <div style="margin-bottom:10px">
                <input class="easyui-textbox" value="${thisRecruit.riSalary}" label="薪酬标准:" labelPosition="top" readonly style="width:50%;">
            </div>
            <div style="margin-bottom:10px">
                <input class="easyui-textbox" prompt="${thisRecruit.riDept.deptName}" label="所属部门:" labelPosition="top" readonly  style="width:50%;" >
            </div>
            <div style="margin-bottom:10px">
                <input class="easyui-textbox" prompt="${thisRecruit.riJob.jobName}"  label="所属职位:" labelPosition="top" readonly style="width:50%;" />
            </div>
            <div style="margin-bottom:10px">
                <input class="easyui-textbox" value="${thisRecruit.riDuty}" label="岗位职责:" labelPosition="top" multiline="true" readonly style="width:100%;height:120px">
            </div>
            <div style="margin-bottom:10px">
                <input class="easyui-textbox" value="${thisRecruit.riDesired}" label="岗位要求:" labelPosition="top" multiline="true" readonly style="width:100%;height:120px">
            </div>
            <div style="margin-bottom:10px">
                <input class="easyui-textbox" value="${thisRecruit.riAddtion}" label="其他信息:" labelPosition="top" multiline="true" readonly style="width:100%;height:120px">
            </div>
            <div style="margin-bottom:10px">
                <input class="easyui-textbox" value="${thisRecruit.riLocation}" label="工作地点:" labelPosition="top" style="width:100%">
            </div>
            <input type="button" class="easyui-linkbutton" onclick="submitForm()" value="申请该职位">
        </form>
    </div>
    <%--<a href="backToIndex">back</a>--%>
</div>
<div data-options="region:'south',border:false" style="height:50px;background:-webkit-linear-gradient(bottom,#EFF5FF,#E0ECFF);padding:10px;">
    页脚
</div>
<script type="text/javascript">
    function submitForm(){
        $.ajax({
            type: 'post',
            url: 'applyThisJob',
            dataType: 'json',
            data: $('#ff').serialize(),
            success: function (data) {
                if (data.code=='1'){
                    alert("申请成功");
                    window.location.href = "myApplypage";
                }else if (data.code=="2"){
                    alert("请先填写简历");
                    window.location.href = "userMyResume?uid=${sessionScope.user.uid}";
                }else {
                    alert("请先登录游客帐号");
                    window.location.href = "index.jsp";
                }
               /* alert(data.code)*/
            }
        })
    }
</script>
</body>
</html>
