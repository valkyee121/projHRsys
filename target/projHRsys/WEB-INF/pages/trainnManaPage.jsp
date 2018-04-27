<%--
  Created by IntelliJ IDEA.
  User: AllenYao
  Date: 2018.04.27
  Time: 15:29
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
    <title>培训记录</title>
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

    <div data-options="region:'center'" style="padding:10px;">
        <div style="margin-bottom:20px">
            <select name="trStatus" id="trStatus" label="查看培训记录" >
                <option value="0" selected="selected">当期培训</option>
                <option value="1">往期培训</option>
            </select>
        </div>
        <table class="table-7" id="trainnListUl" style="width: 700px">
            <thead>
            <th>序号</th>
            <th>标题</th>
            <th>内容</th>
            <th>开始时间</th>
            <th>结束时间</th>
            <th>地点</th>
            </thead>
        </table >
    </div>
    <div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;height: 150px">
        <div class="easyui-panel" >
            <form method="post" id="ff">
                <table class="table-7" >
                    <thead>
                    <th>标题</th>
                    <th>内容</th>
                    <th>开始时间</th>
                    <th>结束时间</th>
                    <th>地点</th>
                    </thead>
                    <tr>
                        <td>
                            <input type="text" name="trTitle">
                        </td>
                        <td>
                            <input  class="easyui-textbox" name="trContent" data-options="multiline:true" style="height: 80px">
                        </td>
                        <td style="margin-bottom:20px">

                            <input class="easyui-datetimebox" name="trBegin" value="10/11/2015 2:3:56"  style="width:100%;">

                        </td>
                        <td style="margin-bottom:20px">

                            <input class="easyui-datetimebox"  name="trEnd" value="10/11/2015 2:3:56"  style="width:100%;">

                        </td>
                        <td>
                            <input type="text" name="trLocal">
                        </td>
                        <td>
                            <input type="button" value="创建" onclick="createTr()">
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</div>

<script type="text/javascript">

    function createTr() {
        $.ajax({
            type: 'post',
            url: 'newTrainSave',
            data: $('#ff').serialize(),
            success: function (data) {
                console.log(data);
            }
        })
    }

    /*dateformat*/
    function myformatter(date){
        var y = date.getFullYear();
        var m = date.getMonth()+1;
        var d = date.getDate();
        return y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d);
    }
    function myparser(s){
        if (!s) return new Date();
        var ss = (s.split('-'));
        var y = parseInt(ss[0],10);
        var m = parseInt(ss[1],10);
        var d = parseInt(ss[2],10);
        if (!isNaN(y) && !isNaN(m) && !isNaN(d)){
            return new Date(y,m-1,d);
        } else {
            return new Date();
        }
    }
    /*function myformatter(date){
        var y = date.getFullYear();
        var m = date.getMonth()+1;
        var d = date.getDate();
        var h = date.getHours();
        var mm = date.getMinutes();
        var s = date.getSeconds();
        return y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d)+' '+(h<10?('0'+h):h)+':'+(mm<10?('0'+mm):mm)+':'+(s<10?('0'+s):s);
    }
    function myparser(s){
        if (!s) return new Date();
        var ss = (s.split('-'));
        var y = parseInt(ss[0],10);
        var m = parseInt(ss[1],10);
        var d = parseInt(ss[2],10);
        var h = parseInt(ss[3],10);
        var mm = parseInt(ss[4],10);
        var s = parseInt(ss[5],10);
        if (!isNaN(y) && !isNaN(m) && !isNaN(d) && !isNaN(h) && !isNaN(mm) && !isNaN(s)){
            return new Date(y,m-1,d);
        } else {
            return new Date();
        }
    }*/
</script>
</body>
</html>
