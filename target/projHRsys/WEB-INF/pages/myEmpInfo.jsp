<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: AllenYao
  Date: 2018.04.27
  Time: 11:40
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
    <title>员工明细</title>
    <link rel="stylesheet" type="text/css" href="resources/js/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="resources/js/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="resources/js/demo.css">
    <link rel="stylesheet" type="text/css" href="resources/css/pagination.css">
    <script type="text/javascript" src="resources/js/jquery.min.js"></script>
    <script type="text/javascript" src="resources/js/jquery.easyui.min.js"></script>
</head>
<body>
<div style="margin:20px 0;"></div>
<div class="easyui-panel" style="width:100%;max-width:500px;padding:30px 60px;">
    <form id="ff" method="post">
        <input type="hidden" name="empID" value="${empInfo.empID}">
        <div>
            <input class="easyui-textbox"  name="empName" value="${empInfo.empName}" label="姓名:" labelPosition="top" style="width:50%;">
        </div>
        <div>
            <input class="easyui-textbox"  name="empSex" value="${empInfo.empSex}" label="性别:" labelPosition="top" style="width:50%;">
        </div>
        <div>
            <label for="empBirth" class="label-top">出生日期:</label>
            <input type="date" id="empBirth" name="empBirth" value="<fmt:formatDate value='${empInfo.empBirth}' type="date" pattern="yyyy-MM-dd"/>"  style="width:50%;">
        </div>
        <div>
            <input class="easyui-textbox"  name="empCity" value="${empInfo.empCity}" label="所在城市:" labelPosition="top" style="width:50%;">
        </div>
    </form>
        <div>
            <input class="easyui-textbox"  name="empEmail" value="${empInfo.empEmail}" readonly label="邮箱地址:" labelPosition="top" style="width:50%;">
        </div>
        <div>
            <input class="easyui-textbox"  name="deptID" id="riDept" readonly prompt="${empInfo.empDept.deptName}" label="所属部门:" labelPosition="top" style="width:50%;">
        </div>
        <div>
            <input class="easyui-textbox"  name="jobID" id="riJob" readonly  prompt="${empInfo.empJob.jobName}" label="所属职位:" labelPosition="top" style="width:50%;">
        </div>
        <div>
            <input class="easyui-textbox"  name="jobSalary" value="${empInfo.empJob.jobSalary}" readonly label="岗位工资:" labelPosition="top" style="width:50%;">
        </div>
    <form id="ff1" method="post" action="#">
        <div>
            <input type="hidden" name="empID" value="${empInfo.empID}">
            <input class="easyui-textbox"  name="empAttend" value="${empInfo.empAttend}" readonly label="当月考勤次数:" labelPosition="top" style="width:50%;">
            <input type="submit" value="考勤记录">
        </div>

    </form>

    <a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="confirm()" style="width:80px">更新基本信息</a>
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
                    url: 'updateBasisInfo',
                    data: $('#ff').serialize(),
                    success: function (data) {
                        console.log(data);
                    }
                })
            }
        })

    }
    function getTaskTime(strDate) {
        if(null==strDate || ""==strDate){
            return "";
        }
        var dateStr=strDate.trim().split(" ");
        var strGMT = dateStr[0]+" "+dateStr[1]+" "+dateStr[2]+" "+dateStr[5]+" "+dateStr[3]+" GMT+0800";
        var date = new Date(Date.parse(strGMT));
        var y = date.getFullYear();
        var m = date.getMonth() + 1;
        m = m < 10 ? ('0' + m) : m;
        var d = date.getDate();
        d = d < 10 ? ('0' + d) : d;
        var h = date.getHours();
        var minute = date.getMinutes();
        minute = minute < 10 ? ('0' + minute) : minute;
        var second = date.getSeconds();
        second = second < 10 ? ('0' + second) : second;

        return y+"-"+m+"-"+d+" "+h+":"+minute+":"+second;
    };
</script>
</body>
</html>
