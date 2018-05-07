<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
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
            <form id="ff">
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
                            <input class="easyui-textbox" name="trTitle" required>
                        </td>
                        <td>
                            <input  class="easyui-textbox" name="trContent" data-options="multiline:true" style="width: 200px;height: 80px">
                        </td>
                        <td style="margin-bottom:20px">

                            <input class="easyui-datetimebox" name="trBegin"  <%--data-options="formatter:ww4,parser:w4"--%> required style="width:100%;">
                          <%--  <input type="datetime-local" name="trBegin" required>--%>

                        </td>
                        <td style="margin-bottom:20px">

                            <input class="easyui-datetimebox"  name="trEnd" <%-- data-options="formatter:ww4,parser:w4"--%> required style="width:100%;">
                     <%--       <input type="datetime-local" name="trEnd" required>--%>
                        </td>
                        <td>
                            <input class="easyui-textbox" name="trLocal" required>
                        </td>
                        <td>
                            <a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="createTr()" style="width:80px">创建</a>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</div>

<script type="text/javascript">

    function createTr() {
        $('#ff').form('submit', {
            onSubmit: function () {
                return $(this).form('enableValidation').form('validate');
            },
            success: function () {
                $.ajax({
                    type: 'post',
                    url: 'newTrainSave',
                    data: $('#ff').serialize(),
                    success: function (data) {
                        console.log(data);
                    }
                })
            }
        })
    }

    $("#trStatus").bind("change",function () {
        var trStatus = $(this).val();
        $("#trainnListUl tr td").empty();
           console.log(trStatus);
        $.ajax({
            url: 'ajaxListTrainn',
            type: 'post',
            data: {"trStatus": trStatus},
            dataType: 'json',
            success: function (data) {
                var train = data.result;
                console.log(train);
                /*var intPageIndex = parseInt(pageIndex);*/
                /*显示数据列表*/
                var table = $("#trainnListUl");

                for (var i=0;i<train.length;i++){
                    table.append(
                        $("<tr><td>"+
                            train[i].trID
                            +"</td><td>"+
                            "<a href='findTrainn?trID="+train[i].trID+"'>"+
                            train[i].trTitle
                            +"</a></td><td>" +
                            train[i].trContent
                            +"</td><td>"+
                            getTaskTime(train[i].trBegin)
                            +"</td><td>"+
                            getTaskTime(train[i].trEnd)
                            +"</td><td>"+
                            train[i].trLocal
                           /* +"</td><td><input type='button' value='取消' onclick='cancelDept("#")'/>"+*/
                            +"</td></tr>")
                    );
                }
            }
        })
    })
    /*dateformat*/

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
    /*Date.prototype.format = function (fmt) { //author: meizz
        var o = {
            "M+": this.getMonth() + 1, //月份
            "d+": this.getDate(), //日
            "h+": this.getHours()-14, //小时
            "m+": this.getMinutes(), //分
            "s+": this.getSeconds(), //秒
            "q+": Math.floor((this.getMonth() + 3) / 3), //季度
            "S": this.getMilliseconds() //毫秒
        };
        if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var k in o)
            if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        return fmt;
    }*/


</script>
</body>
</html>
