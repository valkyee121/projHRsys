<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: AllenYao
  Date: 2018.05.07
  Time: 9:25
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
    <title>离职</title>
    <link rel="stylesheet" type="text/css" href="resources/js/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="resources/js/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="resources/js/demo.css">
    <link rel="stylesheet" type="text/css" href="resources/css/pagination.css">
    <script type="text/javascript" src="resources/js/jquery.min.js"></script>
    <script type="text/javascript" src="resources/js/jquery.easyui.min.js"></script>
</head>
<body>
<div class="easyui-panel" style="width:100%;max-width:500px;padding:30px 60px;">
    <form id="ff" method="post">
        <input type="hidden" name="empID" value="${myDms.empID}">
        <div>
            <input class="easyui-textbox"  name="empName" value="${myDms.empName}" readonly label="姓名:" labelPosition="top" style="width:50%;">
        </div>
        <div>
            <input class="easyui-textbox"  name="deptName" value="${myDms.empDept.deptName}" readonly label="所属部门:" labelPosition="top" style="width:50%;">
        </div>
        <div>
            <input class="easyui-textbox"  name="jobName" value="${myDms.empJob.jobName}" readonly label="所属职位:" labelPosition="top" style="width:50%;">
        </div>
        <div>
            <input class="easyui-textbox"  name="dmContent" value="${myDms.dimission.dmContent}" label="离职原因:" labelPosition="top" multiline="true" style="width:50%;height:120px">
        </div>
        <div>
            <label for="dmDate" class="label-top">申请日期:</label>
            <input type="date" id="dmDate" name="dmDate" value="<fmt:formatDate value='${myDms.dimission.dmDate}' type="date" pattern="yyyy-MM-dd"/>"  style="width:50%;">
        </div>

    </form>
    <a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="confirm()" style="width:80px">提交申请</a>
</div>
<script type="text/javascript">
    function confirm() {
        $('#ff').form('submit',{
            onSubmit:function () {
                return $(this).form('enableValidation').form('validate');
            },
            success:function () {
                $.ajax({
                    type: 'post',
                    url: 'saveDmsApply',
                    data: $('#ff').serialize(),
                    success: function (data) {
                        console.log(data);
                    }
                })
            }
        })
    }
</script>
</body>
</html>
