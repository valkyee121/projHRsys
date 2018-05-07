<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: AllenYao
  Date: 2018.05.06
  Time: 14:24
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
    <title>复议</title>
    <link rel="stylesheet" type="text/css" href="resources/js/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="resources/js/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="resources/js/demo.css">
    <link rel="stylesheet" type="text/css" href="resources/css/pagination.css">
    <link rel="stylesheet" type="text/css" href="resources/css/table.css">
    <script type="text/javascript" src="resources/js/jquery.min.js"></script>
    <script type="text/javascript" src="resources/js/jquery.easyui.min.js"></script>
</head>
<body>
    <div>
        <table class="table-7" style="width: 700px">
            <thead>
            <th>序号</th>
            <th>复议内容</th>
            <th>复议金额</th>
            <th>复议时间</th>
            <th>修改</th>
            <th>删除</th>
            </thead>
            <c:forEach items="${reco}" var="myReco">
                <form id="ff">
                    <tr>
                        <td>
                            <input name="recoID" type="number" value="${myReco.recoID}" readonly>
                        </td>
                        <td>
                            <input name="recoContent" type="text" value="${myReco.recoContent}">
                        </td>
                        <td>
                            <input name="recoMoney" type="number" value="${myReco.recoMoney}">
                        </td>
                        <td>
                            <input type="text" value="<fmt:formatDate value='${myReco.recoDate}' type="date" pattern="yyyy-MM-dd"/> " readonly>
                        </td>
                        <td>
                            <a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="confirm()" style="width:80px">修改</a>
                        </td>
                        <td>
                            <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="cancel()" style="width:80px">删除</a>
                        </td>
                    </tr>
                </form>
            </c:forEach>
        </table>
    </div>
    <script type="text/javascript">
        function confirm() {
            $.ajax({
                type: 'post',
                url: 'updateReco',
                data: $('#ff').serialize(),
                success: function (data) {
                    console.log(data);
                }
            });
        }
        function cancel() {
            $.ajax({
                type: 'post',
                url :'deleteReco',
                data :$('#ff').serialize(),
                success: function (data) {
                    console.log(data)
                }
            })
        }
    </script>
</body>
</html>
