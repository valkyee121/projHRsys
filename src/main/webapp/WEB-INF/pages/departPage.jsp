<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %><%--
  Created by IntelliJ IDEA.
  User: AllenYao
  Date: 2018.04.25
  Time: 15:19
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
    <title>部门管理</title>
    <link rel="stylesheet" type="text/css" href="resources/js/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="resources/js/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="resources/js/demo.css">
    <link rel="stylesheet" type="text/css" href="resources/css/pagination.css">
    <script type="text/javascript" src="resources/js/jquery.min.js"></script>
    <script type="text/javascript" src="resources/js/jquery.easyui.min.js"></script>
</head>
<body>
<%
    SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    Date currentTime = new Date();
%>
<%--<table id="dg" class="easyui-datagrid" style="height:auto"
       data-options="
				rownumbers:true,
				singleSelect: true,
				autoRowHeight:false,
				resizeHandle:'right'
			">
    <thead>
        <tr></tr>
    </thead>
</table>

<div id="tb" style="height:auto">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="append()">Append</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="removeit()">Remove</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="accept()">Accept</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="reject()">Reject</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="getChanges()">GetChanges</a>
</div>--%>
    <table id="deptListUl">

    </table>

    <form method="post" action="deptSave">
        <table>
            <tr>
                <th>部门名称</th>
                <th>建立时间</th>
                <th>启用部门</th>
            </tr>
            <tr>
                <td>
                    <input type="text" name="deptName" required>
                </td>
                <td>
                    <div style="text-align:left;margin-bottom:20px">
                        <input class="easyui-datetimebox" label="Select DateTime:" labelPosition="top" name="deptBuild" value="currentTime" style="text-align:left;width:20%;">
                    </div>
                </td>
                <td>
                    <input type="checkbox" name="deptStatus" value="1">
                </td>
            </tr>
            <<input type="submit" value="添加">
        </table>
    </form>
<script type="text/javascript">
    $(function () {
        $.ajax({
            url: 'ajaxListAllDept',
            type: 'post',
            dataType: 'json',
            success: function (data) {
                var dept = data.resultList;

                var table = $("#deptListUl");
                /*清除列表内容*/
                $("#deptListUl tr").remove();
                console.log(dept)
                for (var i=0;i<dept.length;i++){
                    table.append(
                        $("<tr><td>"+
                            "<a href='#="+dept[i].detpID+"'>"+
                            dept[i].deptName
                            +"</a></td><td>" +
                            dept[i].deptBuild
                            +"</td><td>"+
                            dept[i].deptStatus
                            +"</td></tr>")
                    );
                }
                /*$("#dg").datagrid({
                    columns: [data.title]
                });*/
                /*$("#dg").datagrid("loadData",dept.rows);*/
            }
        })
    })
</script>
</body>
</html>
