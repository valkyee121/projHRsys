<%--
  Created by IntelliJ IDEA.
  User: AllenYao
  Date: 2018.04.15
  Time: 10:38
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
    <title>UserLogin</title>
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
        <h2>用户登录</h2>
        <div style="margin:20px 0;"></div>
        <form method="post" action="userLogin">
            <div style="margin-bottom:10px">
                <input name="uEmail" class="easyui-textbox" style="width:100%;height:40px;padding:12px" data-options="prompt:'请输入邮箱',iconCls:'icon-man',iconWidth:38">
            </div>
            <div style="margin-bottom:20px">
                <input name="uPass" class="easyui-textbox" type="password" style="width:100%;height:40px;padding:12px" data-options="prompt:'请输入密码',iconCls:'icon-lock',iconWidth:38">
            </div>
            <div style="margin-bottom:20px">
                <input type="checkbox" checked="checked">
                <span>Remember me</span>
            </div>
            <div>
                <input type="submit" value="Login" class="easyui-linkbutton"  style="padding:5px 0px;width:100%;font-size:14px;">
                <a href="userRegPage" style="padding:5px 0px;width:100%;font-size:14px;">还没有帐号？立即注册</a>
            </div>
        </form>
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
