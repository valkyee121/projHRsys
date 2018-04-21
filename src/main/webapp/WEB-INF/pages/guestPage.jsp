<%--
  Created by IntelliJ IDEA.
  User: AllenYao
  Date: 2018.04.20
  Time: 13:45
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
    <title>guestPage</title>
    <link rel="stylesheet" type="text/css" href="resources/css/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="resources/css/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="resources/css/demo.css">
    <script type="text/javascript" src="resources/js/jquery.min.js"></script>
    <script type="text/javascript" src="resources/js/jquery.easyui.min.js"></script>
</head>
<body class="easyui-layout">
<%--MAINPAGE--%>
    <div data-options="region:'north',border:false" style="height:60px;background:#B3DFDA;padding:10px">
        导航栏
    </div>
    <div data-options="region:'west',split:true,title:'West'" style="width:220px;padding:10px;">
        <%--LOGIN--%>
        <h2>用户信息</h2>

        <div style="margin:20px 0;"></div>
    </div>
    <%--<div data-options="region:'east',split:true,collapsed:true,title:'East'" style="width:100px;padding:10px;">

    </div>--%>
    <div data-options="region:'south',border:false" style="height:50px;background:#A9FACD;padding:10px;">
        页脚
    </div>
    <div data-options="region:'center',title:'招聘资讯'">
        sssssssssssssssss
    </div>
</body>
</html>
