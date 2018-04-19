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
    <title></title>
</head>
<body>
    <div style="border: 2px solid black; width: 300px">
        <h3>登录</h3>
        <form method="post" action="userLogin">
            <dl>
                <dt>用户名：</dt>
                <dd>
                    <input type="text" name="uName" />
                </dd>
                <dt>密码：</dt>
                <dd>
                    <input type="password" name="uPass" />
                </dd>
                <dd>
                    <input type="submit" value="登录" />
                </dd>
            </dl>
        </form>
        <a href="registerPage">还没有帐号？点击注册</a>
    </div>
</body>
</html>
