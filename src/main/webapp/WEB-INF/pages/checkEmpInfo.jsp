<%--
  Created by IntelliJ IDEA.
  User: AllenYao
  Date: 2018.04.27
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
    <title>员工明细</title>
    <link rel="stylesheet" type="text/css" href="resources/js/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="resources/js/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="resources/js/demo.css">
    <link rel="stylesheet" type="text/css" href="resources/css/pagination.css">
    <script type="text/javascript" src="resources/js/jquery.min.js"></script>
    <script type="text/javascript" src="resources/js/jquery.easyui.min.js"></script>
</head>
<body>
<div style="margin:20px 0;"></div>
<div class="easyui-panel" style="width:100%;max-width:600px;padding:30px 60px;">
    <div>
        <input class="easyui-textbox"  name="empName" value="${empInfo.empName}" readonly label="姓名:" labelPosition="top" style="width:50%;">
    </div>
    <div>
        <input class="easyui-textbox"  name="empSex" value="${empInfo.empSex}" readonly label="性别:" labelPosition="top" style="width:50%;">
    </div>
    <div>
        <input class="easyui-textbox"  name="empBirth" value="${empInfo.empBirth}" readonly label="出生日期:" labelPosition="top" style="width:50%;">
    </div>
    <div>
        <input class="easyui-textbox"  name="empCity" value="${empInfo.empCity}" readonly label="所在城市:" labelPosition="top" style="width:50%;">
    </div>
    <div>
        <input class="easyui-textbox"  name="empEmail" value="${empInfo.empEmail}" readonly label="邮箱地址:" labelPosition="top" style="width:50%;">
    </div>
    <form id="ff" method="post">
        <div>
            <input type="hidden" name="empID" value="${empInfo.empID}">
        </div>
        <div>
            <input class="easyui-combobox"  name="deptID" id="riDept" required prompt="${empInfo.empDept.deptName}" label="所属部门:" labelPosition="top" style="width:50%;">
        </div>
        <div>
            <input class="easyui-combobox"  name="jobID" id="riJob" required  prompt="${empInfo.empJob.jobName}" label="所属职位:" labelPosition="top" style="width:50%;">
        </div>
    </form>
    <div>
        <input class="easyui-textbox"  name="jobSalary" value="${empInfo.empJob.jobSalary}" readonly label="岗位工资:" labelPosition="top" style="width:50%;">
    </div>
    <form id="ff1" method="post" action="#">
        <div>
            <input type="hidden" name="empID" value="${empInfo.empID}">
            <input class="easyui-textbox"  name="empAttend" value="${empInfo.empAttend}" readonly label="当月考勤次数:" labelPosition="top" style="width:50%;">
            <input type="submit" value="考勤记录">
        </div>

    </form>

    <div  style="text-align:right;padding:5px 0 0;">
        <a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="confirm()" style="width:80px">确认调岗</a>
    </div>
</div>

<script type="text/javascript">
    function confirm() {
        $('#ff').form('submit',{
            onSubmit:function () {
                return $(this).form('enableValidation').form('validate');
            },
            success:function () {
                $.ajax({
                    type: 'post',
                    url: 'updateDeptByMana',
                    data: $('#ff').serialize(),
                    success: function (data) {
                        console.log(data);
                    }
                })
            }
        })

    }
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
        onChange:function (n) {
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
                        textField:'jobName'
                    })
                }
            })
        }
    })
</script>
</body>
</html>
