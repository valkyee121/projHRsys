<%--
  Created by IntelliJ IDEA.
  User: AllenYao
  Date: 2018.04.23
  Time: 9:26
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
    <title>recruitPage</title>
    <link rel="stylesheet" type="text/css" href="resources/js/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="resources/js/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="resources/js/demo.css">
    <link rel="stylesheet" type="text/css" href="resources/css/pagination.css">
    <script type="text/javascript" src="resources/js/jquery.min.js"></script>
    <script type="text/javascript" src="resources/js/jquery.easyui.min.js"></script>
</head>
<body class="easyui-layout">
<div data-options="region:'north',border:false" style="height:60px;background:#B3DFDA;padding:10px">
    导航栏
</div>
<div data-options="region:'west',split:true,title:'West'" style="width:220px;padding:10px;">
    <%--LOGIN--%>
    <h2>用户信息</h2>
    <div style="margin:20px 0;"></div>
    <div style="margin-bottom:10px">
        <p>${user.uEmail}</p>
        <table>
            <tr>
                <th>姓名</th>
                <td>${myResume.resume.resuName}</td>
            </tr>
            <tr>
                <th>性别</th>
                <td>${myResume.resume.resuSex}</td>
            </tr>
            <tr>
                <th>出生年月</th>
                <td>${myResume.resume.resuBirth}</td>
            </tr>
            <tr>
                <th>所在城市</th>
                <td>${myResume.resume.resuCity}</td>
            </tr>
            <tr>
                <th>联系电话</th>
                <td>${myResume.resume.resuCell}</td>
            </tr>
            <tr>
                <th>邮箱地址</th>
                <td>${myResume.resume.resuEmail}</td>
            </tr>
            <tr>
                <th>其他信息</th>
                <td>${myResume.resume.resuInfo}</td>
            </tr>
        </table>
    </div>
</div>
<div data-options="region:'east',split:true,collapsed:true,title:'East'" style="width:100px;padding:10px;">

</div>
<div data-options="region:'center',title:'招聘信息'">
    <h2></h2>
    <p></p>
    <div style="margin:20px 0;"></div>
    <div <%--class="easyui-dialog"--%>class="easyui-panel" style="width:400px;padding:50px 60px; position: absolute;left: 50%;top: 50%; transform: translate(-50%,-50%);">
        <form id="ff" method="post" action="applyThisJob">
            <table cellpadding="0" cellspacing="0" border="1">
                <input type="hidden" name="riid" value="${thisRecruit.riid}">
                <tr>
                    <th>招聘信息标题</th>
                    <td>${thisRecruit.riName}</td>
                </tr>
                <tr>
                    <th>企业名称</th>
                    <td>${thisRecruit.riCompany}</td>
                </tr>
                <tr>
                    <th>职位薪酬</th>
                    <td>${thisRecruit.riSalary}</td>
                </tr>
                <tr>
                    <th>职位职责</th>
                    <td>${thisRecruit.riDuty}</td>
                </tr>
                <tr>
                    <th>职位要求</th>
                    <td>${thisRecruit.riDesired}</td>
                </tr>
                <tr>
                    <th>其他描述</th>
                    <td>${thisRecruit.riAddtion}</td>
                </tr>
                <tr>
                    <th>工作地点</th>
                    <td>${thisRecruit.riLocation}</td>
                </tr>
            </table>
            <input type="submit" value="申请该职位">
        </form>
    </div>
    <a href="backToIndex">back</a>
</div>
<div data-options="region:'south',border:false" style="height:50px;background:#A9FACD;padding:10px;">
    页脚
</div>

</body>
</html>
