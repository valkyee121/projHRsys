<%--
  Created by IntelliJ IDEA.
  User: AllenYao
  Date: 2018.04.21
  Time: 18:22
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
    <title>managerPage</title>
    <link rel="stylesheet" type="text/css" href="resources/js/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="resources/js/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="resources/js/demo.css">
    <link rel="stylesheet" type="text/css" href="resources/css/pagination.css">
    <script type="text/javascript" src="resources/js/jquery.min.js"></script>
    <script type="text/javascript" src="resources/js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="resources/js/main.js"></script>
</head>
<body class="easyui-layout">
<%--MAINPAGE--%>
<div data-options="region:'north',border:true" style="height:60px;background:-webkit-linear-gradient(bottom,#EFF5FF,#E0ECFF);padding:10px">
    <a href="checkOut" class="btn btn-danger btn-lg">退出登录</a>
</div>
<div data-options="region:'west',split:true,title:'West'" style="width:220px;padding:10px;">
    <div style="margin:20px 0;"></div>
    <ul id="tree"></ul>

</div>
<div data-options="region:'east',split:true,collapsed:true,title:'East'" style="width:100px;padding:10px;">

</div>
<div data-options="region:'south',border:false" style="height:50px;background:-webkit-linear-gradient(bottom,#EFF5FF,#E0ECFF);padding:10px;">
    页脚
</div>
<div data-options="region:'center',title:'信息'">
    <div class="easyui-tabs" fit="true" border="false" id="tabs">
        <div title="首页"></div>
    </div>
    <%--<table id="recruitListUl" style="border: black;">
        <tr>
            <th>序号</th>
            <th>标题</th>
            <th>企业</th>
            <th>薪酬标准</th>
            <th>信息状态</th>
        </tr>
    </table>
    <div style="margin:20px 0;"></div>
    <div class="easyui-panel">
        <div id="pager" class="yahoo2"></div>
    </div>--%>

</div>

    <%--招聘信息--%>

</body>
</html>
