<%--
  Created by IntelliJ IDEA.
  User: AllenYao
  Date: 2018.04.25
  Time: 23:19
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
    <title>职位管理</title>
    <link rel="stylesheet" type="text/css" href="resources/js/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="resources/js/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="resources/js/demo.css">
    <link rel="stylesheet" type="text/css" href="resources/css/pagination.css">
    <link rel="stylesheet" type="text/css" href="resources/css/table.css">
    <script type="text/javascript" src="resources/js/jquery.min.js"></script>
    <script type="text/javascript" src="resources/js/jquery.easyui.min.js"></script>
</head>
<body>
<table class="table-7" id="jobListUl" style="width: 700px">
    <thead>
    <th>职位编号</th>
    <th>职位名称</th>
    <th>所属部门</th>
    <th>薪酬标准</th>
    <th>状态</th>
    <th>取消职位</th>
    </thead>
    <tr></tr>
</table >
<form method="post" id="ff">
    <table class="table-7" style="width: 700px">
        <thead>
        <th>所属部门</th>
        <th>职位名称</th>
        <th>薪酬标准</th>
        <th>创建职位</th>
        </thead>
        <tr>
            <td>
                <input class="easyui-combobox" onchange="" id="riDept" name="deptID"   style="width:50%;" >
            </td>
            <td>
                <input type="text" name="jobName">
            </td>
            <td>
                <input type="number" name="jobSalary">
            </td>
            <td>
                <input type="button" value="创建" onclick="createJob()">
            </td>
        </tr>
    </table>
</form>

<script type="text/javascript">

    $(function () {
        $.ajax({
            url: 'ajaxListDeptWithJob',
            type: 'post',
            dataType: 'json',
            success: function (data) {
                var jobPos = data.resultList;

                /*var intPageIndex = parseInt(pageIndex);*/
                /*显示数据列表*/
                var table = $("#jobListUl");

                /*清除列表内容*/
                /*$("#deptListUl tr").empty();*/

                for (var i=0;i<jobPos.length;i++){
                    for (var j=0;j<jobPos[i].jobPositions.length;j++){
                        table.append(
                            $("<tr><td>"+
                                jobPos[i].jobPositions[j].jobID
                                +"</td><td>"+
                                /*"<a href='findThisRecruit?riid="+jobPos[i].jobPositions[j].jobID+"'>"+*/
                                jobPos[i].jobPositions[j].jobName
                                +"</td><td>" +
                                jobPos[i].deptName
                                +"</td><td>"+
                                jobPos[i].jobPositions[j].jobSalary
                                +"</td><td>"+
                                jobPos[i].jobPositions[j].jobStatus
                                +"</td><td><input type='button' value='取消' onclick='cancelJob("+jobPos[i].jobPositions[j].jobID+")'/>"+
                                +"</td></tr>")
                        );
                    }
                }
            }
        })
    })

    function createJob() {
        $.ajax({
            type: 'post',
            url: 'jobSave',
            data: $('#ff').serialize(),
            success: function (data) {
                console.log(data);
            }
        })
    }

    function cancelJob(id) {
        var jid = id;
        $.ajax({
            type: 'post',
            url: 'jobCancel',
            data: {"jobID":jid},
            success: function (data) {
                console.log(data);
            }
        })
    }

    /*ajaxDept*/
    loadDept();
    function loadDept() {
        $.ajax({
            type: 'post',
            dataType : 'json',
            data: {"pageIndex": 1},
            async: false,
            url : 'ajaxListAllDept',
            success:function (data) {
                var dept = data.resultList;
                for (var i=0;i<dept.length;i++){
                    $("#riDept").append(
                        $("<option value='"+dept[i].deptID+"'>" +
                            dept[i].deptName
                            +"</option>")
                    )
                }
            }
        })
    }
</script>
</body>
</html>
