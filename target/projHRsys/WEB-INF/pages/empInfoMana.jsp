<%--
  Created by IntelliJ IDEA.
  User: AllenYao
  Date: 2018.04.27
  Time: 9:18
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
    <title>员工管理</title>
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
<table class="table-7" id="empListUl" style="width: 100%">
    <thead>
    <th>员工编号</th>
    <th>员工姓名</th>
    <th>出生年月</th>
    <th>员工年龄</th>
    <th>所属部门</th>
    <th>所属职位</th>
    </thead>
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
                            emp[i].empID
                            +"</td><td>"+
                            "<a href='empDetails?empID="+emp[i].empID+"'>"+
                            emp[i].empName
                            +"</a></td><td>" +
                            emp[i].empSex
                            +"</td><td>"+
                            getTaskTime(emp[i].empBirth)
                            +"</td><td>"+
                            emp[i].empDept.deptName
                            +"</td><td>"+
                            emp[i].empJob.jobName
                            +"</td></tr>")
                    );
                }
            }
        })
    })
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
        return y+"-"+m+"-"+d;
    };
    /*员工*/
   /* $("#riDept").combobox({
        onChange:function (deptId) {
            $.ajax({
                type: 'post',
                dataType: 'json',
                data :{"deptID" :deptId},
                async: false,
                url: 'ajaxListEmpByDept',
                success: function (data) {
                    var emp = data.result;
                    $("#empListUl").combobox({
                        data: emp,
                        valueField:'empID',
                        textField:'empID',
                        valueField:'empName',
                        textField:'empName',
                    })
                }
            })
        }
    })*/
</script>
</body>
</html>
