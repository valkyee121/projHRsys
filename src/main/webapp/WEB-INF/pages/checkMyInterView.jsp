<%--
  Created by IntelliJ IDEA.
  User: AllenYao
  Date: 2018.04.25
  Time: 14:16
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
    <title>我的面试</title>
    <link rel="stylesheet" type="text/css" href="resources/js/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="resources/js/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="resources/js/demo.css">
    <link rel="stylesheet" type="text/css" href="resources/css/pagination.css">
    <script type="text/javascript" src="resources/js/jquery.min.js"></script>
    <script type="text/javascript" src="resources/js/jquery.easyui.min.js"></script>
</head>
<body>
<div class="easyui-layout" data-options="fit:true">
    <div data-options="region:'center'" style="padding:10px;">
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" label="标题：" value="${myInterV.recruit.riName}" labelPosition="top" readonly style="width:100%;">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" label="应聘人姓名：" value="${myInterV.resume.resuName}" labelPosition="top" readonly style="width:100%;">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" label="企业：" value="${myInterV.recruit.riCompany}" labelPosition="top" readonly style="width:100%;">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" label="薪酬标准：" value="${myInterV.recruit.riSalary}" labelPosition="top" readonly style="width:100%;">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" label="岗位职责：" value="${myInterV.recruit.riDuty}" labelPosition="top" readonly style="width:100%;">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" label="岗位要求：" value="${myInterV.recruit.riDesired}" labelPosition="top" readonly style="width:100%;">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" label="其他信息：" value="${myInterV.recruit.riAddtion}" labelPosition="top" readonly style="width:100%;">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" label="工作地点:" value="${myInterV.recruit.riLocation}"labelPosition="top" multiline="true" readonly style="width:100%;height:120px">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" label="面试时间：" value="<fmt:formatDate value='${myInterV.jivDate}' type="date" pattern="yyyy-MM-dd"/> " labelPosition="top" readonly style="width:100%;">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" label="面试地点：" value="${myInterV.jivLocal}" labelPosition="top" readonly style="width:100%;">
        </div>
    </div>
    <div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;">
        <form id="ff" method="post" >
            <input type="hidden" name="jivID" value="${myInterV.jivID}">
            <a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="confirm()" style="width:80px">接受面试</a>
            <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="reject()" style="width:80px">拒绝面试</a>
        </form>
    </div>
</div>
<%--表单提交--%>
<script type="text/javascript">
    function confirm() {
        $.ajax({
            type: 'post',
            url: 'acceptInterV',
            data: $('#ff').serialize(),
            success: function (data) {
                console.log(data);
            }
        });
    }
    function reject() {
        $.ajax({
            type: 'post',
            url :'rejectInterV',
            data :$('#ff').serialize(),
            success: function (data) {
                console.log(data)
            }
        })
    }
</script>
</body>
</html>
