<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %><%--
  Created by IntelliJ IDEA.
  User: AllenYao
  Date: 2018.04.24
  Time: 16:04
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
    <title>筛选简历</title>
    <link rel="stylesheet" type="text/css" href="resources/js/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="resources/js/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="resources/js/demo.css">
    <link rel="stylesheet" type="text/css" href="resources/css/pagination.css">
    <script type="text/javascript" src="resources/js/jquery.min.js"></script>
    <script type="text/javascript" src="resources/js/jquery.easyui.min.js"></script>
</head>
<body>
    <%
        SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date currentTime = new Date();
    %>
    <div class="easyui-layout" data-options="fit:true">
        <div data-options="region:'east',split:true" style="width:100px">
            <div style="margin-bottom:20px">
                <input class="easyui-textbox" label="职位标题：" value="${userPostReRs.recruits[0].riName}" labelPosition="top" readonly style="width:100%;">
            </div>
            <div style="margin-bottom:20px">
                <input class="easyui-textbox" label="企业：" value="${userPostReRs.recruits[0].riCompany}" labelPosition="top" readonly style="width:100%;">
            </div>
            <div style="margin-bottom:20px">
                <input class="easyui-textbox" label="薪资标准：" value="${userPostReRs.recruits[0].riSalary}" labelPosition="top" readonly style="width:100%;">
            </div>
            <div style="margin-bottom:10px">
                <input class="easyui-textbox" prompt="${userPostReRs.recruits[0].riDept.deptName}" label="所属部门:" labelPosition="top" readonly  style="width:50%;" >
            </div>
            <div style="margin-bottom:10px">
                <input class="easyui-textbox" prompt="${userPostReRs.recruits[0].riJob.jobName}"  label="所属职位:" labelPosition="top" readonly style="width:50%;" />
            </div>
            <div style="margin-bottom:20px">
                <input class="easyui-textbox" label="岗位职责:" value="${userPostReRs.recruits[0].riDuty}"labelPosition="top" multiline="true" readonly style="width:100%;height:120px">
            </div>
            <div style="margin-bottom:20px">
                <input class="easyui-textbox" label="岗位要求:" value="${userPostReRs.recruits[0].riDesired}"labelPosition="top" multiline="true" readonly style="width:100%;height:120px">
            </div>
            <div style="margin-bottom:20px">
                <input class="easyui-textbox" label="其他说明:" value="${userPostReRs.recruits[0].riAddtion}"labelPosition="top" multiline="true" readonly style="width:100%;height:120px">
            </div>
            <div style="margin-bottom:20px">
                <input class="easyui-textbox" label="工作地点:" value="${userPostReRs.recruits[0].riLocation}"labelPosition="top" multiline="true" readonly style="width:100%;height:120px">
            </div>
        </div>
        <div data-options="region:'center'" style="padding:10px;">
            <div style="margin-bottom:20px">
                <input class="easyui-textbox" label="姓名：" value="${userPostReRs.resuName}" labelPosition="top" readonly style="width:100%;">
            </div>
            <div style="margin-bottom:20px">
                <input class="easyui-textbox" label="性别：" value="${userPostReRs.resuSex}" labelPosition="top" readonly style="width:100%;">
            </div>
            <div style="margin-bottom:20px">
                <input class="easyui-textbox" label="出生日期：" prompt="<fmt:formatDate value="${userPostReRs.resuBirth}" type="date" pattern="yyyy-MM-dd"/> " labelPosition="top" readonly style="width:100%;">
            </div>
            <div style="margin-bottom:20px">
                <input class="easyui-textbox" label="所在城市：" value="${userPostReRs.resuCity}" labelPosition="top" readonly style="width:100%;">
            </div>
            <div style="margin-bottom:20px">
                <input class="easyui-textbox" label="邮箱地址：" value="${userPostReRs.resuEmail}" labelPosition="top" readonly style="width:100%;">
            </div>
            <div style="margin-bottom:20px">
                <input class="easyui-textbox" label="联系电话：" value="${userPostReRs.resuCell}" labelPosition="top" readonly style="width:100%;">
            </div>
            <div style="margin-bottom:20px">
                <input class="easyui-textbox" label="学历：" value="${userPostReRs.resuDegree}" labelPosition="top" readonly style="width:100%;">
            </div>
            <div style="margin-bottom:20px">
                <input class="easyui-textbox" label="专业：" value="${userPostReRs.resuMajor}" labelPosition="top" readonly style="width:100%;">
            </div>
            <div style="margin-bottom:20px">
                <input class="easyui-textbox" label="教育经历:" value="${userPostReRs.resuEdu}"labelPosition="top" multiline="true" readonly style="width:100%;height:120px">
            </div>
            <div style="margin-bottom:20px">
                <input class="easyui-textbox" label="工作经历:" value="${userPostReRs.resuJobEx}"labelPosition="top" multiline="true" readonly style="width:100%;height:120px">
            </div>
            <div style="margin-bottom:20px">
                <input class="easyui-textbox" label="其他信息:" value="${userPostReRs.resuInfo}"labelPosition="top" multiline="true" readonly style="width:100%;height:120px">
            </div>
        </div>
        <div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;">
            <form id="ff" method="post" >
                <input type="hidden" name="resumeID" value="${userPostReRs.resuID}">
                <input type="hidden" name="recruitID" value="${userPostReRs.recruits[0].riid}">
                <div style="text-align:left;margin-bottom:20px">
                    <input class="easyui-datetimebox" label="Select DateTime:" labelPosition="top" name="jivDate" value="currentTime" style="text-align:left;width:20%;">
                </div>
                <div style="text-align:left;margin-bottom:20px">
                    <input class="easyui-textbox" label="Description:" labelPosition="top" name="jivLocal" multiline="true" style="text-align:left;width:30%;">
                </div>
                <a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="confirm()" style="width:80px">邀请面试</a>
                <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="reject()" style="width:80px">拒绝申请</a>
            </form>
        </div>
    </div>
<%--表单提交--%>
<script type="text/javascript">
    function confirm() {
        $.ajax({
            type: 'post',
            url :'interViewSave',
            data: $('#ff').serialize(),
            dataType: 'json',
            success: function (data) {
                if (data.code=='1'){
                    alert("邀请成功");
                    window.location.href = "postResumePage";
                }else if (data.code=='2'){
                    alert("请勿重复邀请");
                }
            },error:function () {
                alert("请填写完整信息")
            }
        })
        /*$('#ff').form('submit','action=interViewSave'),{
            /!*url: '../pages/interViewSave',*!/
            onSubmit:function () {
                var isValid = $(this).form('validate'); //验证表单填写要求
                if (!isValid){
                    $.alert('error');
                    $.messager.show({
                        title: 'error',
                        msg: 'error'
                    });
                }
                return isValid; //终止表单提交
            },
            success:function (data) {
                if(data>0){
                    $.alert('success');
                    $.messager.show({
                        title: '提示消息',
                        msg: '提交成功'
                    });
                }
            }
        }*/
    }
    function reject() {
        $.ajax({
            type: 'post',
            url :'rejectPost',
            dataType: 'json',
            data :$('#ff').serialize(),
            success: function (data) {
                if (data.code=='1'){
                    alert("简历已淘汰");
                }else if (data.code=='2'){
                    alert("已发出面试邀请，无法更改");
                }
            },error:function () {
                alert("操作错误")
            }
        })
    }

</script>
</body>
</html>
