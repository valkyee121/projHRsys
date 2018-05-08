<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <script type="text/javascript" src="resources/js/jquery.min.js"></script>
    <script type="text/javascript" src="resources/js/jquery.easyui.min.js"></script>
</head>
<body class="easyui-layout">
<div data-options="region:'north',border:false" style="height:60px;background:#B3DFDA;padding:10px">
    导航栏
    <c:if test="${sessionScope.user != null}">
        <a href="userMyResume?uid=${sessionScope.user.uid}">我的简历</a>
        <a href="myApplypage">我的职位申请</a>
        <a href="interViewPage">我的面试</a>
    </c:if>

</div>
<div data-options="region:'west',split:true,title:'West'" style="width:220px;padding:10px;">
    <%--LOGIN--%>
    <h2>用户信息</h2>
    <div style="margin:20px 0;"></div>
    <div style="margin-bottom:10px">
        <p>${user.uEmail}</p>
        <table>
            <tr>
                <th>姓名</th>
                <td>${myResume.resume.resuName}</td>
            </tr>
            <tr>
                <th>性别</th>
                <td>${myResume.resume.resuSex}</td>
            </tr>
            <tr>
                <th>出生年月</th>
                <td>${myResume.resume.resuBirth}</td>
            </tr>
            <tr>
                <th>所在城市</th>
                <td>${myResume.resume.resuCity}</td>
            </tr>
            <tr>
                <th>联系电话</th>
                <td>${myResume.resume.resuCell}</td>
            </tr>
            <tr>
                <th>邮箱地址</th>
                <td>${myResume.resume.resuEmail}</td>
            </tr>
            <tr>
                <th>其他信息</th>
                <td>${myResume.resume.resuInfo}</td>
            </tr>
        </table>
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
    <a href="backToIndex">back</a>
</div>
<div data-options="region:'south',border:false" style="height:50px;background:#A9FACD;padding:10px;">
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
