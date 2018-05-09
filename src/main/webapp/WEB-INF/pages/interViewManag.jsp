<%--
  Created by IntelliJ IDEA.
  User: AllenYao
  Date: 2018.04.26
  Time: 10:44
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
    <title>面试管理</title>
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
    <select name="jivStatus" id="jivStatus" label="查看邀请状态" >
        <option value="0" selected="selected">未处理</option>
        <option value="1">已接受</option>
        <option value="4">已拒绝</option>
    </select>
</div>
<form id="ff" method="post">
    <table class="table-7" id="interViewListUl" style="width: 100%">
        <thead>
        <th>录用</th>
        <th>应聘者姓名</th>
        <th>应聘部门</th>
        <th>应聘职位</th>
        <th>淘汰</th>
        </thead>
      <%--  <tr></tr>--%>
    </table>
</form>

<script type="text/javascript">
    $("#jivStatus").bind("change",function () {
        var jivStatus = $(this).val();
        $("#interViewListUl tr td").empty();
     /*   console.log(jivStatus);*/
        $.ajax({
            url: 'ajaxAllInterV',
            type: 'post',
            data: {"jivStatus": jivStatus},
            dataType: 'json',
            success: function (data) {
                var interV = data.resultList;

                /*var intPageIndex = parseInt(pageIndex);*/
                /*显示数据列表*/
                var table = $("#interViewListUl");

                /*清除列表内容*/
                /*$("#deptListUl tr").empty();*/
   /*         <input type='button' value='淘汰' onclick='reject("+interV[i].jivID+")'/>*/
                for (var i=0;i<interV.length;i++){
                    table.append(
                        $("<tr><td> <input type='button' value='录用' id='accept' onclick='acceptIV("+interV[i].jivID+");'></td>"+
                            "<td>"+
                            interV[i].resume.resuName
                            +"</td><td>" +
                            interV[i].recruit.riDept.deptName
                            +"</td><td>"+
                            interV[i].recruit.riJob.jobName
                            +"</td><td><input type='button' value='淘汰' id='reject' onclick='rejectIV("+interV[i].jivID+");'></td>"+
                            +"<td></td>"+
                            +"</tr>")
                    );
                }
            }
        })
    })

    function acceptIV(id) {
        var iV = id;
        $.ajax({
            type: 'post',
            url: 'acceptByInterV',
            data: {"jivID":iV},
            success: function (data) {
                console.log(data);
                if (data=='success'){
                    window.location.href="newEmployeePage";
                }
            }
        })
    }
    function rejectIV(id) {
        var iV = id;
        $.ajax({
            type: 'post',
            url :'lostByInterV',
            data: {"jivID":iV},
            success: function (data) {

            }
        })
    }
</script>
</body>
</html>
