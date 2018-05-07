<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <link rel="stylesheet" type="text/css" href="resources/css/table.css">
    <script type="text/javascript" src="resources/js/jquery.min.js"></script>
    <script type="text/javascript" src="resources/js/jquery.easyui.min.js"></script>
    <%--<script type="text/javascript" src="resources/js/jquery-3.1.0.js"></script>--%>
</head>
<body>
<div class="easyui-layout" data-options="fit:true">
    <div data-options="region:'center',split:true" style="width:800px">
        <div class="easyui-panel" style="width:100%;max-width:500px;padding:30px 60px;">
            <div>
                <input class="easyui-textbox"  name="empName" value="${empInfo.empName}" readonly label="姓名:" labelPosition="top" style="width:50%;">
            </div>
            <div>
                <input class="easyui-textbox"  name="empSex" value="${empInfo.empSex}" readonly label="性别:" labelPosition="top" style="width:50%;">
            </div>
            <div>
                <input class="easyui-textbox"  name="empBirth" value="<fmt:formatDate value='${empInfo.empBirth}' type="date" pattern="yyyy-MM-dd"/> " readonly label="出生日期:" labelPosition="top" style="width:50%;">
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
                <div  style="text-align:left;padding:5px 0 0;">
                    <a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="confirm()" style="width:80px">确认调岗</a>
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
        </div>
    </div>
    <div data-options="region:'east',split:true" style="width:800px">

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
        <form id="ff2">
        <table class="table-7" id="recoListUI" style="width: 700px">
            <thead>
            <th>批准</th>
            <th>序号</th>
            <th>复议内容</th>
            <th>复议金额</th>
            <th>复议时间</th>
            <th>拒绝</th>
            </thead>

                <%--<tr>
                    <td>
                        <input name="recoID" type="number" value="${myReco.recoID}" readonly>
                    </td>
                    <td>
                        <input name="recoContent" type="text" value="${myReco.recoContent}" readonly>
                    </td>
                    <td>
                        <input name="recoMoney" type="number" value="${myReco.recoMoney}" readonly>
                    </td>
                    <td>
                        <input type="text" value="<fmt:formatDate value='${myReco.recoDate}' type="date" pattern="yyyy-MM-dd"/> " readonly>
                    </td>
                    <td>
                        <a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="confirm()" style="width:80px">批准</a>
                    </td>
                    <td>
                        <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="cancel()" style="width:80px">拒绝</a>
                    </td>
                </tr>--%>
        </table>
        </form>
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
                        alert("更新成功")
                    },error:function(xhr){
                        alert(xhr.responseText);
                        alert("更新失败")
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
    showSal();
    function showSal() {
        var empID = ${empInfo.empID};
        $('#dg').datagrid('loadData',{total:0,rows:[]});
        $.ajax({
            type: 'post',
            url: 'ajaxFindEmpSal',
            data: {"empID":empID, "salStatus":0},
            dataType : 'json',
            success: function (data) {
                if (data.result.salaries!=null){
                    var sal = data.result.salaries;
                    for (var i = 0; i < sal.length; i++) {
                        console.log(sal[i]);
                        $("#dg").datagrid('appendRow', sal[i]);
                    }
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

        return y+"-"+m;
    };
    showReco();
    function showReco() {
        var empID = ${empInfo.empID};
        $.ajax({
            type: 'post',
            dataType : 'json',
            data: {"empID":empID},
            async: false,
            url : 'ajaxFindReco',
            success:function (data) {
                var reco = data.result;
                var table = $("#recoListUI");
                for (var i=0;i<reco.length;i++) {
                    console.log(reco[i]);
                    table.append(
                        $("<tr><td><input type='button' value='批准' id='confirm' onclick='acceptRe("+reco[i].recoID+")'/></td><td>" +
                            reco[i].recoID
                            + "</td><td>" +
                            reco[i].recoContent
                            + "</td><td>" +
                            reco[i].recoMoney
                            + "</td><td>" +
                            getTaskTime(reco[i].recoDate)
                            + "</td><td><input type='button' value='拒绝' id='cancel' onclick='cancelRe("+reco[i].recoID+")'> " +
                            + "</td></tr>")
                    );
                }
            }
        })
    }
    function acceptRe(value) {
        var id = value;
        $.ajax({
            type: 'post',
            url: 'acceptReco',
            data: {"recoID":id},
            success: function (data) {
                console.log(data);
            }
        });
    }
    function cancelRe(value) {
        var id = value;
        $.ajax({
            type: 'post',
            url :'',
            data: {"recoID":id},
            success: function (data) {
                console.log(data)
            }
        })
    }
</script>
</body>
</html>
