<%--
  Created by IntelliJ IDEA.
  User: AllenYao
  Date: 2018.04.24
  Time: 11:40
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
    <title>简历投递记录</title>
    <link rel="stylesheet" type="text/css" href="resources/js/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="resources/js/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="resources/js/demo.css">
    <link rel="stylesheet" type="text/css" href="resources/css/pagination.css">
    <script type="text/javascript" src="resources/js/jquery.min.js"></script>
    <script type="text/javascript" src="resources/js/jquery.easyui.min.js"></script>
</head>
<body>
<div style="margin-bottom:20px">
    <select name="postStatu" id="postStatu" label="查看投递状态" >
        <option value="0" selected="selected">已投递</option>
        <option value="1">已查阅</option>
        <option value="2">通过筛选，等待面试</option>
        <option value="3">未通过筛选</option>
    </select>
</div>
<%--

<table id="dg" title="Client Side Pagination"  data-options="
				rownumbers:true,
				singleSelect:true,
				autoRowHeight:false,
				pagination:true,
				pageSize:10">
    <thead>
    <tr>
        <th field="resuN" width="80">职位申请人</th>
        <th field="resuE" width="100">申请人邮箱</th>
        <th field="resuC" width="80">申请人手机号</th>
        <th field="recruN" width="80" align="right">申请职位</th>
        <th field="postInS" width="80" align="right">申请流程</th>
    </tr>
    </thead>
</table>
--%>
<table <%--class="easyui-datalist" --%>id="postListUl" title="Basic DataGrid">
    <%--<thead>
    <tr>
        <th data-options="field:'resuN',width:80">职位申请人</th>
        <th data-options="field:'resuE',width:100">申请人邮箱</th>
        <th data-options="field:'resuC',width:80,align:'right'">申请人手机号</th>
        <th data-options="field:'recruN',width:80,align:'right'">申请职位</th>
        <th data-options="field:'postInS',width:250">申请流程</th>
    </tr>
    </thead>--%>
</table>

<script>
    $("#postStatu").bind("change",function () {
        var postStatu = $(this).val();
        console.log(postStatu);
        $.ajax({
            type: 'post',
            url: 'ajaxPostResume',
            data: {"postStatus": postStatu},
            dataType: 'json',
            async: false,
            success:function (data) {
                var apply = data;
                /*console.log(apply.resultList[0].recruits[0]);*/
                /*显示数据列表*/
                var table = $("#postListUl");
                table.empty();
                /*清除列表内容*/
                $("#postListUl tr").remove();
                /*填入内容*/
                for (var i=0;i<apply.resultList.length;i++){
                    for (var j=0;j<apply.resultList[i].recruits
                        .length;j++){
                        table.append(
                            $("<tr><td>"+
                                "<a id='activ' href='checkUserPost?postRsId="+apply.resultList[i].resuID+"&postReId="+apply.resultList[i].recruits[j].riid+"' >"+
                                apply.resultList[i].resuName
                                +"</a></td><td>" +
                                apply.resultList[i].resuEmail
                                +"</td><td>"+
                                apply.resultList[i].resuCell
                                +"</td><td>"+
                                apply.resultList[i].recruits[j].riName
                                +"</td></tr>")
                        )
                    }
                }
            }
        })
    })

</script>
</body>
</html>
