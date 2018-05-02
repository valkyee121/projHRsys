<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: AllenYao
  Date: 2018.05.02
  Time: 8:52
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
    <title>每日打卡</title>
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
    <div data-options="region:'east',split:true" style="width:800px">
        <table class="table-7" id="atteListUl" style="width: 700px">
            <thead>
            <th>员工编号</th>
            <th>上班打卡</th>
            <th>下班打卡</th>
            </thead>
        </table >
    </div>

    <div data-options="region:'center'" style="padding:10px;">
        <div class="easyui-panel" style="width:100%;max-width:400px;padding:30px 60px;">
            <a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="clockIn()" style="width:80px">上班打卡</a>
        </div>
        <div class="easyui-panel" style="width:100%;max-width:400px;padding:30px 60px;">
            <a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="clockOut()" style="width:80px">下班打卡</a>
        </div>
    </div>
</div>

<script type="text/javascript">

    function clockIn() {
        $.ajax({
            type: 'post',
            url: 'saveAtteToday',
          /*  data: $('#ff').serialize(),*/
            success: function (data) {
                console.log(data);
            }
        })
    }

    function clockOut() {
        $.ajax({
            type: 'post',
            url :'updateAtteToday',
           /* data :$('#ff').serialize(),*/
            success: function (data) {
                console.log(data)
            }
        })
    }

    $(function () {
        $.ajax({
            url: 'ajaxActAtte',
            type: 'post',
            dataType: 'json',
            async: 'false',
            success: function (data) {
                var atte = data.result;
                var table = $("#atteListUl");
                for (var i=0;i<atte.length;i++){
                    table.append(
                        $("<tr><td>"+
                            atte[i].atteEmpID
                            +"</td><td>"+
                             getTaskTime(atte[i].atteBegin)
                            +"</td><td>"+
                            getTaskTime(atte[i].atteEnd)
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

        return y+"-"+m+"-"+d+" "+h+":"+minute+":"+second;
    };
</script>
</body>
</html>
