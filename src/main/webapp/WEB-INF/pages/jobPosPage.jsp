<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: AllenYao
  Date: 2018.04.25
  Time: 23:19
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
    <title>职位管理</title>
    <link rel="stylesheet" type="text/css" href="resources/js/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="resources/js/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="resources/js/demo.css">
    <link rel="stylesheet" type="text/css" href="resources/css/pagination.css">
    <link rel="stylesheet" type="text/css" href="resources/css/table.css">
    <script type="text/javascript" src="resources/js/jquery.min.js"></script>
    <script type="text/javascript" src="resources/js/jquery.easyui.min.js"></script>
</head>
<body>
<%--<form id="ff1" method="post">
    <table class="table-7" id="jobListUl" style="width: 700px">
        <thead>
        <th>职位编号</th>
        <th>职位名称</th>
        <th>所属部门</th>
        <th>薪酬标准</th>
        <th>状态</th>
        <th>取消职位</th>
        </thead>
        <c:forEach items="${jobList}" var="jobs">
            <tr>
                <td>
                    <input type="text" name="jobID" value="${jobs.jobPositions.jobID}">
                </td>
                <td>
                    <input type="text" name="jobName" value="${jobs.jobPositions.jobName}">
                </td>
            </tr>
        </c:forEach>
    </table >
</form>--%>
<table id="tt"></table>
<%--<table id="dg" class="easyui-datagrid" title="Row Editing in DataGrid" style="width:700px;height:auto"
       data-options="
				iconCls: 'icon-edit',
				singleSelect: true,
				toolbar: '#tb',
                idField:'jobID',
                url:'ajaxListAllJob',
				method: 'post',
				onClickRow: onClickRow
			">
    <thead>
        <tr>
            <td data-option="field:'jobID',width:60">职位编号</td>
            <td data-option="field:'jobName',width:100,editor:'text'">职位名称</td>
            <td data-option="field:'deptName',width:80,align:'right'">所属部门</td>
            <td data-option="field:'jobSalary',width:80,align:'right',editor:'numberbox'">基本工资</td>
            <td data-option="field:'jobStatus',width:50,align:'center',
                    editor:{
                        type:'checkbox',
                        options:{
                            on: 'P',
                            off: ''">状态</td>
        </tr>
    </thead>
</table>--%>

<form method="post" id="ff">
    <table class="table-7" style="width: 700px">
        <thead>
        <th>所属部门</th>
        <th>职位名称</th>
        <th>薪酬标准</th>
        <th>创建职位</th>
        </thead>
        <tr>
            <td>
                <input class="easyui-combobox" onchange="" id="riDept" name="deptID"   style="width:50%;" >
            </td>
            <td>
                <input type="text" name="jobName">
            </td>
            <td>
                <input type="number" name="jobSalary">
            </td>
            <td>
                <input type="button" value="创建" onclick="createJob()">
            </td>
        </tr>
    </table>
</form>

<script type="text/javascript">

    function createJob() {
        $.ajax({
            type: 'post',
            url: 'jobSave',
            data: $('#ff').serialize(),
            success: function (data) {
                console.log(data);
            }
        })
    }

    function modJob(id) {
        var jid = id;
        $.ajax({
            type: 'post',
            url: 'jobModify',
            /*data: {"jobID":jid},*/
            data: $('#ff1').serialize(),
            success: function (data) {
                console.log(data);
            }
        })
    }

    /*ajaxDept*/
    loadDept();
    function loadDept() {
        $.ajax({
            type: 'post',
            dataType : 'json',
            data: {"pageIndex": 1},
            async: false,
            url : 'ajaxListAllDept',
            success:function (data) {
                var dept = data.resultList;
                for (var i=0;i<dept.length;i++){
                    $("#riDept").append(
                        $("<option value='"+dept[i].deptID+"'>" +
                            dept[i].deptName
                            +"</option>")
                    )
                }
            }
        })
    }

    /**/
    $(function(){
        var editRow = undefined;
        $('#tt').datagrid({
            /*title:'Editable DataGrid',*/
            iconCls:'icon-edit',
            /*width:800,
            height:250,*/

            fitColumn: true,
            singleSelect:true,
            border: false,
            idField:'jobID',
            url:'ajaxListAllJob',
            columns:[[
                {field:'jobID',title:'职位编号',width:100},
                {field:'jobName',title:'职位名称',width:250,editor:'text'},
                {field:'deptName',title:'所属部门',width:250,align:'right'},
                {field:'jobSalary',title:'基本工资',width:200,align:'right',editor:'numberbox'},
                {field:'jobStatus',title:'状态',width:150,align:'center',
                    editor:{
                        type:'checkbox',
                        options:{
                            on: 1,
                            off: 0
                        }
                    }
                },
            ]],
            toolbar: [
                { text: '修改', iconCls: 'icon-edit', handler: function () {
                        //修改时要获取选择到的行
                        var rows = $("#tt").datagrid("getSelections");
                        //如果只选择了一行则可以进行修改，否则不操作
                        if (rows.length == 1) {
                            //修改之前先关闭已经开启的编辑行，当调用endEdit该方法时会触发onAfterEdit事件
                            if (editRow != undefined) {
                                $("#tt").datagrid("endEdit", editRow);
                            }
                            //当无编辑行时
                            if (editRow == undefined) {
                                //获取到当前选择行的下标
                                var index = $("#tt").datagrid("getRowIndex", rows[0]);
                                //开启编辑
                                $("#tt").datagrid("beginEdit", index);
                                //把当前开启编辑的行赋值给全局变量editRow
                                editRow = index;
                                //当开启了当前选择行的编辑状态之后，
                                //应该取消当前列表的所有选择行，要不然双击之后无法再选择其他行进行编辑
                                $("#tt").datagrid("unselectAll");
                            }
                        }
                    }
                }, '-',
                { text: '保存', iconCls: 'icon-save', handler: function () {
                        //保存时结束当前编辑的行，自动触发onAfterEdit事件如果要与后台交互可将数据通过Ajax提交后台
                        $("#tt").datagrid("endEdit", editRow);
                    }
                }, '-',
                { text: '取消编辑', iconCls: 'icon-redo', handler: function () {
                        //取消当前编辑行把当前编辑行罢undefined回滚改变的数据,取消选择的行
                        editRow = undefined;
                        $("#tt").datagrid("rejectChanges");
                        $("#tt").datagrid("unselectAll");
                    }
                }, '-'],
            onAfterEdit: function (rowIndex, rowData, changes) {
                //endEdit该方法触发此事件，保存代码是否这里写？？？
                //还需要判断combobox是否选中性别，而不是默认值
                $.ajax({
                    url: 'jobModify',
                    data: rowData,
                    type: 'post',
                    complete:function (xhr) {
                        alert(xhr.responseText)
                    }
                });
                console.info(rowData);
                editRow = undefined;
            },
            onDblClickRow: function (rowIndex, rowData) {
                //双击开启编辑行
                if (editRow != undefined) {
                    $("#tt").datagrid("endEdit", editRow);
                }
                if (editRow == undefined) {
                    $("#tt").datagrid("beginEdit", rowIndex);
                    editRow = rowIndex;
                }
            }
            /*onAfterEdit: function (rowIndex, rowData, changes) {
                //endEdit该方法触发此事件
                alert(changes);
                console.info(rowData);
                $.ajax({
                    url: 'jobModify',
                    data: rowData,
                    type: 'post',
                    complete:function (xhr) {
                        alert(xhr.responseText)
                    }
                });
                editRow = undefined;
            },
            onBeforeEdit: function (index, row) {
                row.editing = true;
                $('#tt').datagrid('refreshRow', index);
            },
            onAfterEdit: function (index, row) {
                row.editing = false;
                $('#tt').datagrid('refreshRow', index);
            },
            onCancelEdit: function (index, row) {
                row.editing = false;
                $('#tt').datagrid('refreshRow', index);
            }*/
        });
    });
    /*var editRow = undefined;
    function doEdit(index) {
        if (editRow != undefined) {
            $("#tt").datagrid('cancelEdit', editRow);
            editRow = undefined;
        }
        $("#tt").datagrid('selectRow', index);
        var rows = $("#tt").datagrid('getSelections');
        if (rows.length == 1) {
            if (editRow == undefined) {
                $("#tt").datagrid('beginEdit', index);
                editRow = index;
            }
        }
    }
    function doSave(index) {
        $("#tt").datagrid('endEdit', editRow);
        editRow = undefined;
    }*/
</script>
</body>
</html>
