<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: AllenYao
  Date: 2018.04.23
  Time: 10:31
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
    <title>myResumePage</title>
    <link rel="stylesheet" type="text/css" href="resources/js/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="resources/js/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="resources/js/demo.css">
    <link rel="stylesheet" type="text/css" href="resources/css/pagination.css">
    <link rel="stylesheet" type="text/css" href="resources/css/sidebar.css">
    <link rel="stylesheet" type="text/css" href="resources/css/teal.css">
    <script type="text/javascript" src="resources/js/jquery.min.js"></script>
    <script type="text/javascript" src="resources/js/jquery.easyui.min.js"></script>
    <style>
        .div-inline{
            display: inline;
        }
        .easyui-panel div {
            margin: 10px 20px;
        }
    </style>
</head>
<body class="easyui-layout">
<div data-options="region:'north',border:true" style="height:60px;background:-webkit-linear-gradient(bottom,#EFF5FF,#E0ECFF);padding:10px">
    <nav class="nav">
        <ul >
            <li ><a href="guestPage">Home</a></li>
            <li><a href="userMyResume?uid=${sessionScope.user.uid}">个人简历 </a></li>
            <li><a href="myApplypage">职位申请 </a></li>
            <li><a href="interViewPage">我的面试 </a></li>
            <!-- Regular Menu Ends -->
        </ul>
    </nav>
</div>
<div data-options="region:'west',split:true,title:'West'" style="width:256px;padding:10px;">
    <%--LOGIN--%>
    <div class="row flat">
        <div class="col-lg-3 col-md-3 col-xs-6">
            <ul class="plan plan1">
                <li class="plan-name">
                    用户信息
                </li>
                <li class="plan-price">
                    姓名：<strong>${myResume.resume.resuName}</strong>
                </li>
                <li class="plan-price">
                    出生年月：<strong><fmt:formatDate value='${myResume.resume.resuBirth}' type="date" pattern="yyyy-MM-dd"/></strong>
                </li>
                <li class="plan-price">
                    居住地：<strong>${myResume.resume.resuCity}</strong>
                </li>
                <li class="plan-price">
                    手机：<strong>${myResume.resume.resuCell}</strong>
                </li>
                <li class="plan-price">
                    邮箱：<strong>${myResume.resume.resuEmail}</strong>
                </li>
                <li class="plan-action">
                    <a href="checkOut" class="btn btn-danger btn-lg">退出登录</a>
                </li>
            </ul>
        </div>
    </div>
</div>
<div data-options="region:'east',split:true,collapsed:true,title:'East'" style="width:100px;padding:10px;">

</div>
<div data-options="region:'center',title:'个人简历'">
    <div class="easyui-panel" title="简历填写" style="width:100%;max-width:800px;padding:30px 60px;">
        <form id="ff" class="easyui-form" method="post" action="saveMyResume" data-options="novalidate:true">
            <div class="div-inline"  style="margin-bottom:20px">
                <input class="easyui-textbox" name="resuName" value="${myResume.resume.resuName}" style="width:100%" data-options="label:'姓名:',required:true">
            </div>
            <div class="div-inline"  style="margin-bottom:20px">
                <label for="userSex" class="textbox-label">性别：</label>
                <input id="userSex" type="radio" name="resuSex" value="0" checked>女
                <input  type="radio" name="resuSex" value="1">男
            </div>
            <div  style="margin-bottom:20px">
                <input class="easyui-datebox" id="birth" name="resuBirth" value="${myResume.resume.resuBirth}"   label="出生日期：" labelPosition="left" style="width:50%;">
            </div>
            <div  style="margin-bottom:20px">
                <select class="easyui-combobox" name="resuCity" label="所在城市" style="width:50%">
                    <option value="北京" selected="selected">北京</option>
                    <option value="上海">上海</option>
                    <option value="杭州">杭州</option>
                    <option value="广州">广州</option>
                    <option value="深圳">深圳</option>
                </select>
            </div>
            <div style="margin-bottom:20px">
                <input class="easyui-numberbox" name="resuCell" value="${myResume.resume.resuCell}" label="手机号码"  style="width:50%">
            </div>
            <div style="margin-bottom:20px">
                <input class="easyui-textbox" name="resuEmail" value="${sessionScope.user.uEmail}" readonly style="width:60%" data-options="label:'Email:',required:true">
            </div>
            <div style="margin-bottom:20px">
                <input class="easyui-textbox" name="resuDegree" value="${myResume.resume.resuDegree}" style="width:50%" data-options="label:'学历:',required:true">
            </div>
            <div style="margin-bottom:20px">
                <input class="easyui-textbox" name="resuMajor" value="${myResume.resume.resuMajor}" style="width:50%" data-options="label:'专业:',required:true">
            </div>
            <div style="margin-bottom:20px">
                <input class="easyui-textbox" name="resuEdu" value="${myResume.resume.resuEdu}" style="width:100%;height:60px" data-options="label:'教育经历:',multiline:true">
            </div>
            <div style="margin-bottom:20px">
                <input class="easyui-textbox" name="resuJobEx" value="${myResume.resume.resuJobEx}" style="width:100%;height:60px" data-options="label:'工作经历:',multiline:true">
            </div>
            <div style="margin-bottom:20px">
                <input class="easyui-textbox" name="resuInfo" value="${myResume.resume.resuInfo}" style="width:100%;height:60px" data-options="label:'其他信息:',multiline:true">
            </div>
            <div style="text-align:center;padding:5px 0">
                <%--<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()" style="width:80px">Submit</a>--%>
                <input class="easyui-linkbutton" type="submit" value="SAVE" style="width:80px">
                <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()" style="width:80px">Clear</a>
            </div>
        </form>
        <%--<div style="text-align:center;padding:5px 0">
            &lt;%&ndash;<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()" style="width:80px">Submit</a>&ndash;%&gt;
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()" style="width:80px">Clear</a>
        </div>--%>
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
    </script>
    <%------------------------%>
    <%--<h2></h2>
    <p></p>
    <div style="margin:20px 0;"></div>
    <div &lt;%&ndash;class="easyui-dialog"&ndash;%&gt;class="easyui-panel" style="width:400px;padding:50px 60px; position: absolute;left: 50%;top: 50%; transform: translate(-50%,-50%);">
        <form id="ff" method="post" action="">

            <table cellpadding="0" cellspacing="0" border="1">

            </table>
        </form>
    </div>--%>
    <%--<a href="backToIndex">back</a>--%>
</div>
<div data-options="region:'south',border:false" style="height:50px;background:-webkit-linear-gradient(bottom,#EFF5FF,#E0ECFF);padding:10px;">
    页脚
</div>
<script type="text/javascript">
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
</script>
</body>
</html>
