<%--
  Created by IntelliJ IDEA.
  User: AllenYao
  Date: 2018.04.24
  Time: 16:04
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
    <title>筛选简历</title>
    <link rel="stylesheet" type="text/css" href="resources/js/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="resources/js/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="resources/js/demo.css">
    <link rel="stylesheet" type="text/css" href="resources/css/pagination.css">
    <script type="text/javascript" src="resources/js/jquery.min.js"></script>
    <script type="text/javascript" src="resources/js/jquery.easyui.min.js"></script>
</head>
<body>
    <div class="easyui-layout" data-options="fit:true">
        <div data-options="region:'east',split:true" style="width:100px">
            <div style="margin-bottom:20px">
                <input class="easyui-textbox" label="职位标题：" value="${userPostReRs.recruits[0].riName}" labelPosition="top" readonly style="width:100%;">
            </div>
            <div style="margin-bottom:20px">
                <input class="easyui-textbox" label="企业：" value="${userPostReRs.recruits[0].riCompany}" labelPosition="top" readonly style="width:100%;">
            </div>
            <div style="margin-bottom:20px">
                <input class="easyui-textbox" label="薪资标准：" value="${userPostReRs.recruits[0].riSalary}" labelPosition="top" readonly style="width:100%;">
            </div>
            <div style="margin-bottom:20px">
                <input class="easyui-textbox" label="岗位职责:" value="${userPostReRs.recruits[0].riDuty}"labelPosition="top" multiline="true" readonly style="width:100%;height:120px">
            </div>
            <div style="margin-bottom:20px">
                <input class="easyui-textbox" label="岗位要求:" value="${userPostReRs.recruits[0].riDesired}"labelPosition="top" multiline="true" readonly style="width:100%;height:120px">
            </div>
            <div style="margin-bottom:20px">
                <input class="easyui-textbox" label="其他说明:" value="${userPostReRs.recruits[0].riAddtion}"labelPosition="top" multiline="true" readonly style="width:100%;height:120px">
            </div>
            <div style="margin-bottom:20px">
                <input class="easyui-textbox" label="工作地点:" value="${userPostReRs.recruits[0].riLocation}"labelPosition="top" multiline="true" readonly style="width:100%;height:120px">
            </div>
        </div>
        <div data-options="region:'center'" style="padding:10px;">
            <div style="margin-bottom:20px">
                <input class="easyui-textbox" label="姓名：" value="${userPostReRs.resuName}" labelPosition="top" readonly style="width:100%;">
            </div>
            <div style="margin-bottom:20px">
                <input class="easyui-textbox" label="性别：" value="${userPostReRs.resuSex}" labelPosition="top" readonly style="width:100%;">
            </div>
            <div style="margin-bottom:20px">
                <input class="easyui-textbox" label="出生日期：" value="${userPostReRs.resuBirth}" labelPosition="top" readonly style="width:100%;">
            </div>
            <div style="margin-bottom:20px">
                <input class="easyui-textbox" label="所在城市：" value="${userPostReRs.resuCity}" labelPosition="top" readonly style="width:100%;">
            </div>
            <div style="margin-bottom:20px">
                <input class="easyui-textbox" label="邮箱地址：" value="${userPostReRs.resuEmail}" labelPosition="top" readonly style="width:100%;">
            </div>
            <div style="margin-bottom:20px">
                <input class="easyui-textbox" label="联系电话：" value="${userPostReRs.resuCell}" labelPosition="top" readonly style="width:100%;">
            </div>
            <div style="margin-bottom:20px">
                <input class="easyui-textbox" label="其他信息:" value="${userPostReRs.resuInfo}"labelPosition="top" multiline="true" readonly style="width:100%;height:120px">
            </div>
        </div>
        <div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;">
            <a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="javascript:alert('通过筛选')" style="width:80px">邀请面试</a>
            <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="javascript:alert('未通过')" style="width:80px">拒绝申请</a>
        </div>
    </div>
</body>
</html>
