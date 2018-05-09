<%--
  Created by IntelliJ IDEA.
  User: AllenYao
  Date: 2018.05.07
  Time: 11:00
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
    <title>离职管理</title>
    <link rel="stylesheet" type="text/css" href="resources/js/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="resources/js/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="resources/js/demo.css">
    <link rel="stylesheet" type="text/css" href="resources/css/pagination.css">
    <link rel="stylesheet" type="text/css" href="resources/css/table.css">
    <script type="text/javascript" src="resources/js/jquery.min.js"></script>
    <script type="text/javascript" src="resources/js/jquery.easyui.min.js"></script>
</head>
<body>
<div class="easyui-layout" data-options="fit:true">
    <div data-options="region:'center'" style="padding:10px;">
        <div style="margin-bottom:20px">
            <select name="dmStatus" id="dmStatus" label="离职申请" >
                <option value="1" selected="selected">未处理申请</option>
                <option value="2">已处理申请</option>
            </select>
        </div>
        <table class="table-7" id="dmsListUl" style="width: 100%">
            <thead>
            <th>员工编号</th>
            <th>员工姓名</th>
            <th>员工所属部门</th>
            <th>员工所属职位</th>
            <th>离职原因</th>
            <th>申请时间</th>
            <th>操作</th>
            </thead>
        </table >
    </div>
</div>

<script type="text/javascript">
    $("#dmStatus").bind("change",function () {
        var dmStatus = $(this).val();
        $("#dmsListUl tr td").empty();
        $.ajax({
            url: 'ajaxListDms',
            type: 'post',
            data: {"dmStatus": dmStatus},
            dataType: 'json',
            success: function (data) {
                var dms = data.result;

                var table = $("#dmsListUl");
                for (var i=0;i<dms.length;i++){
                    console.log(dms[i]);
                    table.append(
                        $("<tr><td>"+
                            dms[i].empID
                            +"</td><td>"+
                            dms[i].empName
                            +"</td><td>" +
                            dms[i].empDept.deptName
                            +"</td><td>"+
                            dms[i].empJob.jobName
                            +"</td><td>"+
                            dms[i].dimission.dmContent
                            +"</td><td>" +
                            getTaskTime(dms[i].dimission.dmDate)
                            +"</td><td><input type='button' value='批准' onclick='confirmApply("+dms[i].empID+")'/>"+
                            +"</td></tr>")
                    );
                }
            }
        })
    });

    function confirmApply(id) {
        var empID = id;
        $.ajax({
            type: 'post',
            url: 'acceptDms',
            data: {"empID":empID},
            success: function (data) {
                console.log(data);
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

        return y+"-"+m+"-"+d;
    };
</script>
</body>
</html>
