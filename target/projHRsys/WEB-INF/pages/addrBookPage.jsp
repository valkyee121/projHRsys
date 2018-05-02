<%--
  Created by IntelliJ IDEA.
  User: AllenYao
  Date: 2018.05.01
  Time: 21:55
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
    <title>通讯录</title>
    <link rel="stylesheet" type="text/css" href="resources/js/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="resources/js/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="resources/js/demo.css">
    <link rel="stylesheet" type="text/css" href="resources/css/pagination.css">
    <link rel="stylesheet" type="text/css" href="resources/css/table.css">
    <script type="text/javascript" src="resources/js/jquery.min.js"></script>
    <script type="text/javascript" src="resources/js/jquery.easyui.min.js"></script>
</head>
<body>
<div >
    <select id="riDept" name="deptID" ></select>
</div>
<table class="table-7" id="empListUl" style="width: 700px">
    <thead>
    <th>姓名</th>
    <th>性别</th>
    <th>邮箱地址</th>
    <th>职位</th>
    </thead>
    <tr></tr>
</table >

<script type="text/javascript">
    /*部门*/
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
    /*员工*/
    $("#riDept").bind("change",function () {
        $("#empListUl tr td").empty();
        $("#empListUl tr td").remove();
        var deptId = $(this).val();
        $.ajax({
            type: 'post',
            dataType : 'json',
            data: {"deptID":deptId},
            async: false,
            url : 'ajaxListEmpByDept',
            success:function (data) {
                var emp = data.result;
                console.log(emp);
                var table = $("#empListUl");
                for (var i=0;i<emp.length;i++){
                    console.log(emp[i]);
                    table.append(
                        $("<tr><td>"+
                            emp[i].empName
                            +"</a></td><td>" +
                            emp[i].empSex
                            +"</td><td>"+
                            emp[i].empEmail
                            +"</td><td>"+
                            emp[i].empJob.jobName
                            +"</td></tr>")
                    );
                }
            }
        })
    })
</script>
</body>
</html>
