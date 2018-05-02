<%--
  Created by IntelliJ IDEA.
  User: AllenYao
  Date: 2018.04.30
  Time: 13:08
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
    <title>培训编辑</title>
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
    <div data-options="region:'east',split:true" style="width:800px">
        <table class="table-7" id="trainnListUl" style="width: 700px">
            <thead>
            <th>员工编号</th>
            <th>员工姓名</th>
            </thead>
        </table >
        <div>
            <div >
                <select id="riDept" name="deptID" ></select>
            </div>
            <form id="ff" method="post">
                <input type="hidden" id="trIDm" name="trIDm" value="${trainn.trID}">
                <table class="table-7" id="empListUl" style="width: 700px">
                    <thead>
                    <th>参加培训</th>
                    <th>员工编号</th>
                    <th>员工姓名</th>
                    <th>所属部门</th>
                    <th>所属职位</th>
                    </thead>
                </table >
                <a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="confirmTr()" style="width:80px">创建</a>
            </form>

        </div>
    </div>

    <div data-options="region:'center'" style="padding:10px;">
        <div class="easyui-panel" style="width:100%;max-width:400px;padding:30px 60px;">
            <form  class="easyui-form" method="post" action="updateTrainn" data-options="novalidate:true">
                <div>
                    <input type="hidden" name="trID" value="${trainn.trID}">
                </div>
                <div style="margin-bottom:20px">
                    <input class="easyui-textbox" name="trTitle" prompt="${trainn.trTitle}" label="培训课题:" labelPosition="top" style="width:100%;">
                </div>
                <div style="margin-bottom:20px">
                    <input class="easyui-textbox" name="trContent" prompt="${trainn.trContent}" label="培训内容:" labelPosition="top" style="width:100%;">
                </div>
                <div style="margin-bottom:20px">
                    <input class="easyui-datetimebox" name="trBegin" value="${trainn.trBegin}" prompt="${trainn.trBegin}" label="开始时间:" labelPosition="top" style="width:100%;">
                </div>
                <div style="margin-bottom:20px">
                    <input class="easyui-datetimebox" name="trEnd" value="${trainn.trEnd}" prompt="${trainn.trEnd}" label="结束时间:" labelPosition="top"  style="width:100%">
                </div>
                <div style="margin-bottom:20px">
                    <input class="easyui-textbox" name="trLocal" prompt="${trainn.trLocal}" label="培训地点:" labelPosition="top" style="width:100%">
                </div>
                <div style="text-align:center;padding:5px 0">
                    <%--<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()" style="width:80px">Submit</a>--%>
                    <input class="easyui-linkbutton" type="submit" value="SAVE" style="width:80px">
                    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()" style="width:80px">Clear</a>
                </div>
            </form>
        </div>
    </div>
</div>

<script type="text/javascript">
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
    }

    var trID = ${trainn.trID};
    $.ajax({
        url: 'ajaxTrList',
        type: 'post',
        dataType: 'json',
        data: {"trID":trID},
        success: function (data) {
            var emp = data.result;
            for (var i=0;i<emp.length;i++){
                console.log(emp[i]);
                $("#trainnListUl").append(
                    $("<tr><td>"+
                        emp[i].employees[0].empID
                        +"</td><td>"+
                        emp[i].employees[0].empName
                        +"</td></tr>")
                )
            }
        }
    })

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

    /*员工*/
    $("#riDept").bind("change",function () {
        $("#empListUl tr td").empty();
        $("#empListUl tr td").remove();
        var deptId = $(this).val();
        $.ajax({
            type: 'post',
            dataType : 'json',
            data: {"deptID":deptId},
            async: false,
            url : 'ajaxListEmpByDept',
            success:function (data) {
                var emp = data.result;
                console.log(emp);
                var table = $("#empListUl");
                for (var i=0;i<emp.length;i++){
                    console.log(emp[i]);
                    table.append(
                        $("<tr><td>"+
                                "<input type='checkbox' name='empID' value='"+emp[i].empID+"'>"
                            +"</td><td>"+
                            emp[i].empID
                            +"</td><td>"+
                            emp[i].empName
                            +"</td><td>" +
                            emp[i].empDept.deptName
                            +"</td><td>"+
                            emp[i].empJob.jobName
                            +"</td></tr>")
                    );
                }
            }
        })
    })
    function confirmTr() {
        $('#ff').form('submit', {
            onSubmit: function () {
                return $(this).form('enableValidation').form('validate');
            },
            success: function () {
                var emp = $("input[name='empID']:checked").serialize();
                var tr = $("#trIDm").val();
                console.log(emp)
                console.log(tr)
                $.ajax({
                    type: 'post',
                    url: 'saveTrEmp',
                    data: {"empID":emp,"trIDm":tr},
                    success: function (data) {
                        console.log(data);
                    }
                })
            }
        })
    }
</script>
</body>
</html>
