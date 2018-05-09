
<%--
  Created by IntelliJ IDEA.
  User: AllenYao
  Date: 2018.05.02
  Time: 19:08
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
    <title>考勤记录</title>
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
    <div style="margin-bottom:20px">
        <form id="ff" method="post">
            <input class="easyui-datebox" id="checkMon" name="checkMon" data-options="formatter:myformatter,parser:myparser" style="width:100%;">
        </form>
        <a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="confirm()" style="width:80px">确认查看</a>
    </div>
</div>
<table id="dg" class="easyui-datagrid" style="height:auto"
       data-options="
        title : '考勤',
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
        <th data-options="field:'atteID',width:80,align: 'center'">序号</th>
        <th data-options="field:'atteEmpID',width:250,align: 'center',editor: 'textbox'">员工编号</th>
        <th data-options="field:'atteBegin',width:250,align: 'center'">上班时间</th>
        <th data-options="field:'atteEnd',width:250,align: 'center'">下班时间</th>
        <%--<form action="deptSave" method="post">
            <tr>
                <td></td>
                <td>
                    <input type="text" name="deptName" required>
                </td>
                <td></td>
                <input type="submit" value="添加">
            </tr>
        </form>--%>
    </thead>
   <%-- <div id="tb" style="height:auto">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="append()">Append</a>
         <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="removeit()">Remove</a>
         <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="accept()">Accept</a>
       &lt;%&ndash;  <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="reject()">Reject</a>
         <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="getChanges()">GetChanges</a>&ndash;%&gt;
    </div>--%>
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
               field: 'atteID',
               title: '序号',
               width: 50,
               align: 'center',
           }, {
               field: 'atteEmpID',
               title: '员工编号',
               width: 50,
               align: 'center',
               editor: 'text',
           }, {
               field : 'atteBegin',
               title : '上班时间',
               width : 100,
               align : 'center',
               formatter: getTaskTime

           }, {
               field : 'atteEnd',
               title : '下班时间',
               width : 100,
               align : 'center',
               formatter: getTaskTime

           }
           ]]
       })

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
               url: 'historyAtte',
               dataType : 'json',
               data: $('#ff').serialize(),
               success: function (data) {

                   var atte = data.result;
                    console.log(atte)
                   /*var intPageIndex = parseInt(pageIndex);
                   显示数据列表
                   var table = $("#deptListUl");*/
                   for (var i = 0; i < atte.length; i++) {
                       console.log(atte[i]);
                       $("#dg").datagrid('appendRow', atte[i]);
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
       /*   Date.prototype.format = function (format) {
              var o = {
                  "M+": this.getMonth() + 1, // month
                  "d+": this.getDate(), // day
                  "h+": this.getHours(), // hour
                  "m+": this.getMinutes(), // minute
                  "s+": this.getSeconds(), // second
                  "q+": Math.floor((this.getMonth() + 3) / 3), // quarter
                  "S": this.getMilliseconds()
                  // millisecond
              }
              if (/(y+)/.test(format))
                  format = format.replace(RegExp.$1, (this.getFullYear() + "")
                      .substr(4 - RegExp.$1.length));
              for (var k in o)
                  if (new RegExp("(" + k + ")").test(format))
                      format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
              return format;
          }
          function formatDatebox(value) {
              if (value == null || value == '') {
                  return '';
              }
              /!*var dt;
              if (value instanceof Date) {
                  dt = value;
              } else {
                  dt = new Date(value);
              }*!/
              /!*json格式时间转js时间格式*!/
              value = value.substr(1, value.length - 2);
              var obj = eval('(' + "{Date: new " + value + "}" + ')');
              var dateValue = obj["Date"];
              if (dateValue.getFullYear() < 1900) {
                  return "";
              }

              return dateValue.format("yyyy-MM-dd hh:mm:ss"); //扩展的Date的format方法(上述插件实现)
          }*/
</script>
</body>
</html>
