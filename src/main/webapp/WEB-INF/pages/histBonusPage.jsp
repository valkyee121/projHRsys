<%--
  Created by IntelliJ IDEA.
  User: AllenYao
  Date: 2018.05.03
  Time: 12:55
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
    <title>奖惩记录</title>
    <link rel="stylesheet" type="text/css" href="resources/js/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="resources/js/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="resources/js/demo.css">
    <link rel="stylesheet" type="text/css" href="resources/css/pagination.css">
    <link rel="stylesheet" type="text/css" href="resources/css/table.css">
    <script type="text/javascript" src="resources/js/jquery.min.js"></script>
    <script type="text/javascript" src="resources/js/jquery.easyui.min.js"></script>
</head>
<body>
<div class="easyui-panel" style="width:20%;max-width:400px;padding:30px 60px;">
    <div>
        <form id="ff" method="post">
            <input class="easyui-datebox" id="checkMon" name="checkMon" data-options="formatter:myformatter,parser:myparser" style="width:100%;">
        </form>
        <a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="confirm()" style="width:80px">确认查看</a>
    </div>
</div>
<table id="dg" class="easyui-datagrid" style="height:auto"
       data-options="
        title : '奖惩',
        iconCls: 'icon-edit',
         fit : true,
        fitColumns : true,
        pagination : true,
        singleSelect : true,
         border : false,
        striped : true,
        url: '#',
        method:'post'
">
    <thead>
    <th data-options="field:'bmID',width:80,align: 'center'">序号</th>
    <th data-options="field:'bmMoney',width:250,align: 'center'">金额</th>
    <th data-options="field:'bmDate',width:250,align: 'center'">时间</th>
    <th data-options="field:'bmDetail',width:250,align: 'center'">原因</th>
    </thead>

</table>

<script type="text/javascript">
    $('#dg').datagrid({
        title : '考勤记录',
        fit : true,
        fitColumns : true,
        pagination : true,
        singleSelect : true,
        border : false,
        striped : true,
        url: '#',
        method:'post',
        columns : [[{
            field: 'bmID',
            title: '序号',
            width: 50,
            align: 'center',
        }, {
            field: 'bmMoney',
            title: '金额',
            width: 50,
            align: 'center',
            editor: 'text',
        }, {
            field : 'bmDate',
            title : '时间',
            width : 100,
            align : 'center',
            formatter: getTaskTime

        }, {
            field : 'bmDetail',
            title : '原因',
            width : 100,
            align : 'center'
        }
        ]]
    });

    /*日期格式*/
    function myformatter(date){
        var y = date.getFullYear();
        var m = date.getMonth()+1;
        /* var d = date.getDate();*/
        return y+'-'+(m<10?('0'+m):m)/*+'-'+(d<10?('0'+d):d)*/;
    }
    function myparser(s){
        if (!s) return new Date();
        var ss = (s.split('-'));
        var y = parseInt(ss[0],10);
        var m = parseInt(ss[1],10);
        /*  var d = parseInt(ss[2],10);*/
        if (!isNaN(y) && !isNaN(m)/* && !isNaN(d)*/){
            return new Date(y,m-1);
        } else {
            return new Date();
        }
    }

    function confirm() {
        $('#dg').datagrid('loadData',{total:0,rows:[]});
        $.ajax({
            type: 'post',
            url: 'ajaxMyBonus',
            dataType : 'json',
            data: $('#ff').serialize(),
            success: function (data) {
                var bonus = data.result;
                console.log(bonus)
                /*var intPageIndex = parseInt(pageIndex);
                显示数据列表
                var table = $("#deptListUl");*/
                for (var i = 0; i < bonus.length; i++) {
                    console.log(bonus[i]);
                    $("#dg").datagrid('appendRow',bonus[i]);
                }
            }
        })
    }
    function getTaskTime(strDate) {
        if(null==strDate || ""==strDate){
            return "";
        }
        var dateStr=strDate.trim().split(" ");
        var strGMT = dateStr[0]+" "+dateStr[1]+" "+dateStr[2]+" "+dateStr[5]+" "+dateStr[3]+" GMT+0800";
        var date = new Date(Date.parse(strGMT));
        var y = date.getFullYear();
        var m = date.getMonth() + 1;
        m = m < 10 ? ('0' + m) : m;
        var d = date.getDate();
        d = d < 10 ? ('0' + d) : d;
        var h = date.getHours();
        var minute = date.getMinutes();
        minute = minute < 10 ? ('0' + minute) : minute;
        var second = date.getSeconds();
        second = second < 10 ? ('0' + second) : second;

        return y+"-"+m+"-"+d+" "+h+":"+minute+":"+second;
    };
</script>
</body>
</html>
