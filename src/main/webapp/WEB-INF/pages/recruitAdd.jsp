<%--
  Created by IntelliJ IDEA.
  User: AllenYao
  Date: 2018.04.24
  Time: 11:22
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
    <title>recruitAdd</title>
    <link rel="stylesheet" type="text/css" href="resources/js/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="resources/js/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="resources/js/demo.css">
    <link rel="stylesheet" type="text/css" href="resources/css/pagination.css">
    <script type="text/javascript" src="resources/js/jquery.min.js"></script>
    <script type="text/javascript" src="resources/js/jquery.easyui.min.js"></script>
</head>
<body>
<div style="margin:20px 0;"></div>
<div class="easyui-panel" style="width:100%;max-width:400px;padding:30px 60px;">
    <form id="ff" class="easyui-form" method="post" action="recruitSaveManag" data-options="novalidate:true">

        <div style="margin-bottom:20px">
            <input class="easyui-textbox" name="riName"  label="标题:" labelPosition="top" style="width:100%;">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" name="riCompany"  label="企业:" labelPosition="top" style="width:100%;">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox"  id="riSal" name="riSalary"  label="薪酬标准:" labelPosition="top" readonly style="width:50%;">元
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-combobox" id="riDept" name="deptID" label="所属部门:" labelPosition="top"  style="width:50%;" >
        </div>
        <div style="margin-bottom:20px">
            <select class="easyui-combobox"  id="riJob" name="jobID"  label="所属职位:" labelPosition="top"  style="width:50%;" />
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" name="riDuty"  label="岗位职责:" labelPosition="top" multiline="true" style="width:100%;height:120px">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" name="riDesired"  label="岗位要求:" labelPosition="top" multiline="true"  style="width:100%;height:120px">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" name="riAddtion" label="其他信息:" labelPosition="top" multiline="true" style="width:100%;height:120px">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" name="riLocation"  label="工作地点:" labelPosition="top" multiline="true" style="width:100%;height:120px">
        </div>
        <div style="text-align:center;padding:5px 0">
            <%--<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()" style="width:80px">Submit</a>--%>
            <input class="easyui-linkbutton" type="submit" value="SAVE" style="width:80px">
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()" style="width:80px">Clear</a>
        </div>
    </form>
</div>

<script>
    function submitForm(){
        $('#ff').form('save',{
            onSubmit:function(){
                return $(this).form('validate');
            }
        });
    }
    function clearForm(){
        $('#ff').form('clear');
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

        $("#riDept").combobox({
            onChange:function (n,o) {
                $.ajax({
                    type: 'post',
                    dataType : 'json',
                    data: {"deptID":n},
                    async: false,
                    url : 'ajaxFindJobByDept',
                    success:function (data) {
                        var job = data.result.jobPositions;
                        $("#riJob").combobox({
                            data: job,
                            valueField:'jobID',
                            textField:'jobName',

                        })
                    }
                })
            }
        })
    $("#riJob").combobox({
        onChange:function (n) {
            $.ajax({
                type: 'post',
                dataType : 'json',
                data: {'jobID':n},
                async : false,
                url : 'ajaxFindJob',
                success : function (data) {
                    $("#riSal").textbox('setValue',data.result.jobSalary);
                }
            })
        }
    })
</script>
</body>
</html>
