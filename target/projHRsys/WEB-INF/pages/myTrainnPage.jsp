<%--
  Created by IntelliJ IDEA.
  User: AllenYao
  Date: 2018.05.01
  Time: 20:00
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
    <title>个人培训</title>
    <link rel="stylesheet" type="text/css" href="resources/js/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="resources/js/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="resources/js/demo.css">
    <link rel="stylesheet" type="text/css" href="resources/css/pagination.css">
    <link rel="stylesheet" type="text/css" href="resources/css/table.css">
    <script type="text/javascript" src="resources/js/jquery.min.js"></script>
    <script type="text/javascript" src="resources/js/jquery.easyui.min.js"></script>
</head>
<body>
<div style="margin-bottom:20px">
    <select name="trStatus" id="trStatus" label="查看培训记录" >
        <option value="0" selected="selected">当期培训</option>
        <option value="1">往期培训</option>
    </select>
</div>
<table class="table-7" id="trainnListUl" style="width: 700px">
    <thead>
    <th>序号</th>
    <th>标题</th>
    <th>内容</th>
    <th>开始时间</th>
    <th>结束时间</th>
    <th>地点</th>
    </thead>
</table >


<script>

    $("#trStatus").bind("change",function () {
        var trStatus = $(this).val();
        $("#trainnListUl tr td").empty();
        console.log(trStatus);
        $.ajax({
            url: 'ajaxMyTrainn',
            type: 'post',
          /*  data: {"trStatus": trStatus},*/
            dataType: 'json',
            success: function (data) {
                var trainn = data.result.trainns;

                /*var intPageIndex = parseInt(pageIndex);*/
                /*显示数据列表*/
                var table = $("#trainnListUl");

                for (var i=0;i<trainn.length;i++){
                    console.log(trainn[i]);
                    table.append(
                        $("<tr><td>"+
                            trainn[i].trID
                            +"</td><td>"+
                            trainn[i].trTitle
                            +"</a></td><td>" +
                            trainn[i].trContent
                            +"</td><td>"+
                            getTaskTime(trainn[i].trBegin)
                            +"</td><td>"+
                            getTaskTime(trainn[i].trEnd)
                            +"</td><td>"+
                            trainn[i].trLocal
                            +"</td></tr>")
                );
                   /* for (var j=0;j<emp[i].trainns.length;j++){

                    }*/
                }
            }
        })
    })
    /*dateformat*/

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
