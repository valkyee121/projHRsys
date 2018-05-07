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
    <link rel="stylesheet" type="text/css" href="resources/css/table.css">
    <script type="text/javascript" src="resources/js/jquery.min.js"></script>
    <script type="text/javascript" src="resources/js/jquery.easyui.min.js"></script>
</head>
<body>
<%
    SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    Date currentTime = new Date();
%>
<table class="table-7" id="deptListUl" style="width: 700px">
    <thead>
        <th>部门编号</th>
        <th>部门名称</th>
        <th>建立时间</th>
        <th>状态</th>
        <th>取消部门</th>
    </thead>
    <tr></tr>
</table >
<form method="post" id="ff">
    <table class="table-7" style="width: 700px">
        <thead>
        <th>部门名称</th>
        <th>创建部门</th>
        </thead>
        <tr>
            <td>
                <input type="text" name="deptName">
            </td>
          <%--  <td>
                <input type="checkbox" name="deptStatus">
            </td>--%>
            <td>
                <input type="button" value="创建" onclick="createDept()">
            </td>
        </tr>
    </table>
</form>
<script type="text/javascript">
 /*   $('#dg').datagrid({
        title : '部门列表',
        fit : true,
        fitColumns : true,
        pagination : true,
        singleSelect : true,
        border : false,
        striped : true,
        url: '#',
        method:'post',
        columns : [[{
            field: 'deptID',
            title: '部门编号',
            width: 50,
            align: 'center',
        }, {
            field: 'deptName',
            title: '部门名称',
            width: 100,
            align: 'center',
            editor: 'text',
        }, {
            field : 'deptBuild',
            title : '成立时间',
            width : 100,
            align : 'center'
        }]]
    })
*/
    $(function () {
        $.ajax({
            url: 'ajaxListAllDept',
            type: 'post',
            dataType: 'json',
            success: function (data) {
                var dept = data.resultList;
                /*var intPageIndex = parseInt(pageIndex);*/
                /*显示数据列表*/
                var table = $("#deptListUl");
                /*清除列表内容*/
                /*$("#deptListUl tr").empty();*/
                for (var i=0;i<dept.length;i++){
                    table.append(
                        $("<tr><td>"+
                            dept[i].deptID
                            +"</td><td>"+
                        /*    "<a href='findThisRecruit?riid="+dept[i].deptID+"'>"+*/
                            dept[i].deptName
                            +"</td><td>" +
                            getTaskTime(dept[i].deptBuild)
                            +"</td><td>"+
                            dept[i].deptStatus
                            +"</td><td><input type='button' value='取消' onclick='cancelDept("+dept[i].deptID+")'/>"+
                            +"</td></tr>")
                    );
                }
                /*for (var i=0;i<dept.length;i++){
                    console.log(dept[i]);
                    $("#dg").datagrid('appendRow',dept[i]);
                }*/
            }
        })
    })
 function createDept() {
     $.ajax({
         type: 'post',
         url: 'deptSave',
         data: $('#ff').serialize(),
         success: function (data) {
             console.log(data);
         }
     })
 }

 function cancelDept(id) {
        var did = id;
     $.ajax({
         type: 'post',
         url: 'deptCancel',
         data: {"deptID":did},
         dataType: 'json',
         success: function (data) {
             alert(data.msg)
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
     return y+"-"+m+"-"+d;
 };
  /*  /!*编辑*!/
    $.extend($.fn.datagrid.methods, {
        editCell: function(jq,param){
            return jq.each(function(){
                var opts = $(this).datagrid('options');
                var fields = $(this).datagrid('getColumnFields',true).concat($(this).datagrid('getColumnFields'));
                for(var i=0; i<fields.length; i++){
                    var col = $(this).datagrid('getColumnOption', fields[i]);
                    col.editor1 = col.editor;
                    if (fields[i] != param.field){
                        col.editor = null;
                    }
                }
                $(this).datagrid('beginEdit', param.index);
                var ed = $(this).datagrid('getEditor', param);
                if (ed){
                    if ($(ed.target).hasClass('textbox-f')){
                        $(ed.target).textbox('textbox').focus();
                    } else {
                        $(ed.target).focus();
                    }
                }
                for(var i=0; i<fields.length; i++){
                    var col = $(this).datagrid('getColumnOption', fields[i]);
                    col.editor = col.editor1;
                }
            });
        },
        enableCellEditing: function(jq){
            return jq.each(function(){
                var dg = $(this);
                var opts = dg.datagrid('options');
                opts.oldOnClickCell = opts.onClickCell;
                opts.onClickCell = function(index, field){
                    if (opts.editIndex != undefined){
                        if (dg.datagrid('validateRow', opts.editIndex)){
                            dg.datagrid('endEdit', opts.editIndex);
                            opts.editIndex = undefined;
                        } else {
                            return;
                        }
                    }
                    dg.datagrid('selectRow', index).datagrid('editCell', {
                        index: index,
                        field: field
                    });
                    opts.editIndex = index;
                    opts.oldOnClickCell.call(this, index, field);
                }
            });
        }
    });

    $(function(){
        $('#dg').datagrid().datagrid('enableCellEditing');
    })

    /!*增删*!/
 var editIndex = undefined;
 function endEditing(){
     if (editIndex == undefined){return true}
     if ($('#dg').datagrid('validateRow', editIndex)){
         $('#dg').datagrid('endEdit', editIndex);
         editIndex = undefined;
         return true;
     } else {
         return false;
     }
 }
 function onClickCell(index, field){
     if (editIndex != index){
         if (endEditing()){
             $('#dg').datagrid('selectRow', index)
                 .datagrid('beginEdit', index);
             var ed = $('#dg').datagrid('getEditor', {index:index,field:field});
             if (ed){
                 ($(ed.target).data('textbox') ? $(ed.target).textbox('textbox') : $(ed.target)).focus();
             }
             editIndex = index;
         } else {
             setTimeout(function(){
                 $('#dg').datagrid('selectRow', editIndex);
             },0);
         }
     }
 }
 function onEndEdit(index, row){
     var ed = $(this).datagrid('getEditor', {
         index: index,
         field: 'productid'
     });
     /!*row.productname = $(ed.target).combobox('getText');*!/
 }
 function append(){
     if (endEditing()){
         $('#dg').datagrid('appendRow',{status:'P'});
         editIndex = $('#dg').datagrid('getRows').length-1;
         $('#dg').datagrid('selectRow', editIndex)
             .datagrid('beginEdit', editIndex);
     }
 }
 function removeit(){
     if (editIndex == undefined){return}
     $('#dg').datagrid('cancelEdit', editIndex)
         .datagrid('deleteRow', editIndex);
     editIndex = undefined;
 }
 function accept(){
     if (endEditing()){
         $('#dg').datagrid('acceptChanges');
     }
 }
 function reject(){
     $('#dg').datagrid('rejectChanges');
     editIndex = undefined;
 }
 function getChanges(){
     var rows = $('#dg').datagrid('getChanges');
     alert(rows.length+' rows are changed!');
 }*/
</script>
</body>
</html>
