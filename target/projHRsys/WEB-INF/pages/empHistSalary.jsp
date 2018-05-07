<%--
  Created by IntelliJ IDEA.
  User: AllenYao
  Date: 2018.05.05
  Time: 16:09
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
    <title>每月薪资</title>
    <link rel="stylesheet" type="text/css" href="resources/js/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="resources/js/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="resources/js/demo.css">
    <link rel="stylesheet" type="text/css" href="resources/css/pagination.css">
    <link rel="stylesheet" type="text/css" href="resources/css/table.css">
    <script type="text/javascript" src="resources/js/jquery.min.js"></script>
    <script type="text/javascript" src="resources/js/jquery.easyui.min.js"></script>
</head>
<body>
<div class="easyui-layout" data-options="fit:true">
    <div data-options="region:'center',split:true" style="width:800px">
        <table id="dg" class="easyui-datagrid" style="height:auto"
               data-options="
        title : '薪资',
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
            <th data-options="field:'salID',width:80,align: 'center'">序号</th>
            <th data-options="field:'salBasis',width:150,align: 'center',editor: 'textbox'">基本工资</th>
            <th data-options="field:'salBonus',width:150,align: 'center'">绩效奖金</th>
            <th data-options="field:'salOT',width:150,align: 'center'">加班工资</th>
            <th data-options="field:'salPunish',width:150,align: 'center'">奖惩</th>
            <th data-options="field:'salSocial',width:150,align: 'center'">社保基金</th>
            <th data-options="field:'salRecon',width:150,align: 'center'">上月复议</th>
            <th data-options="field:'salTotal',width:150,align: 'center'">应发总额</th>
            <th data-options="field:'salDate',width:200,align: 'center'">结算月份</th>
            </thead>
        </table>
    </div>
    <div data-options="region:'south',split:true" style="width:800px;height: 100px">
        <div class="easyui-panel" >
            <form id="ff">
                <table class="table-7" >
                    <thead>
                    <th>复议内容</th>
                    <th>复议金额</th>
                    </thead>
                    <tr>
                        <td>
                            <input class="easyui-textbox" name="recoContent" required>
                        </td>
                        <td>
                            <input class="easyui-numberbox"  name="recoMoney" precision="2" style="width:100%;">
                        </td>
                        <td>
                            <a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="createRe()" style="width:80px">申请复议</a>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</div>

<script type="text/javascript">

    function createRe() {
        $('#ff').form('submit', {
            onSubmit: function () {
                return $(this).form('enableValidation').form('validate');
            },
            success: function () {
                $.ajax({
                    type: 'post',
                    url: 'saveNewReco',
                    data: $('#ff').serialize(),
                    success: function (data) {
                        console.log(data);
                    },error:function () {
                        alert("当月已申请复议，请勿重复申请")
                    }
                })
            }
        })
    }
    $('#dg').datagrid({
        title : '薪资记录',
        fit : true,
        fitColumns : true,
        pagination : true,
        singleSelect : true,
        border : false,
        striped : true,
        url: '#',
        method:'post',
        columns : [[{
            field: 'salID',
            title: '序号',
            width: 80,

        }, {
            field: 'salBasis',
            title: '基本工资',
            width: 150,
            align: 'center',

        }, {
            field : 'salBonus',
            title : '绩效奖金',
            width : 150,
            align : 'center',


        }, {
            field : 'salOT',
            title : '加班工资',
            width : 150,
            align : 'center',

        }, {
            field : 'salPunish',
            title : '奖惩',
            width : 150,
            align : 'center',

        }, {
            field : 'salSocial',
            title : '社保基金',
            width : 150,
            align : 'center',

        }, {
            field : 'salRecon',
            title : '上月复议',
            width : 150,
            align : 'center',

        }, {
            field : 'salTotal',
            title : '应发总额',
            width : 150,
            align : 'center',

            }, {
            field : 'salDate',
            title : '结算月份',
            width : 200,
            align : 'center',
            formatter: getTaskTime
        }
        ]]
    });
    $('#dg').datagrid('loadData',{total:0,rows:[]});
    $.ajax({
        type: 'post',
        url: 'empHistSalary',
        dataType : 'json',
        /*data: $('#ff').serialize(),*/
        success: function (data) {
            var sal = data.result;
            for (var i = 0; i < sal.length; i++) {
                console.log(sal[i]);
                $("#dg").datagrid('appendRow', sal[i]);
            }
        }
    })

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

        return y+"-"+m;
    };
</script>
</body>
</html>
