<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: AllenYao
  Date: 2018.04.25
  Time: 10:52
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
    <title>myINterView</title>
    <link rel="stylesheet" type="text/css" href="resources/js/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="resources/js/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="resources/js/demo.css">
    <link rel="stylesheet" type="text/css" href="resources/css/pagination.css">
    <link rel="stylesheet" type="text/css" href="resources/css/sidebar.css">
    <link rel="stylesheet" type="text/css" href="resources/css/teal.css">
    <link rel="stylesheet" type="text/css" href="resources/css/table.css">
    <script type="text/javascript" src="resources/js/jquery.min.js"></script>
    <script type="text/javascript" src="resources/js/jquery.easyui.min.js"></script>
</head>
<body class="easyui-layout">
<%--MAINPAGE--%>
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
<%--<div data-options="region:'east',split:true,collapsed:true,title:'East'" style="width:100px;padding:10px;">

</div>--%>
<div data-options="region:'south',border:false" style="height:50px;background:-webkit-linear-gradient(bottom,#EFF5FF,#E0ECFF);padding:10px;">
    页脚
</div>
<div data-options="region:'center',title:'面试信息'">
    <div style="margin-bottom:20px">
        <select name="jivStatus" id="jivStatus" label="查看邀请状态" >
            <option value="0" selected="selected">未处理</option>
            <option value="1">已接受</option>
            <option value="2">已拒绝</option>
        </select>
    </div>
    <table class="table-7" id="intervListUl" style="width: 100%">
        <thead>
        <th>应聘职位</th>
        <th>公司名称</th>
        <th>薪资待遇</th>
        <th>应聘者姓名</th>
        <th>面试时间</th>
        <th>面试地点</th>
        </thead>
    </table>
    <%-- <ul class="easyui-datalist" id="recruitListUl" style="display: block">
         &lt;%&ndash;<c:forEach items="${recruitList}" var="rec">
             <li value="${rec.riid}">${rec.riName}</li>
         </c:forEach>&ndash;%&gt;
     </ul>--%>
</div>
<script type="text/javascript">
    $("#jivStatus").bind("change",function () {
        var jivStatus = $(this).val();
        var resuID = ${myResume.resume.resuID};
        /*清除列表内容*/
        $("#intervListUl tr td").remove();
        $.ajax({
            type: 'post',
            url: 'ajaxUserInterV',
            data: {"jivStatus": jivStatus, "resuID":resuID},
            dataType: 'json',
            async: false,
            success:function (data) {
                var apply = data.resultList;

                /*显示数据列表*/
                var table = $("#intervListUl");
                /*table.empty();*/

                /*填入内容*/
                console.log(apply);
                for (var i=0;i<apply.length;i++){
                    table.append(
                        $("<tr><td>"+
                            "<a href='checkMyInterV?jivID="+apply[i].jivID+"'>"+
                            apply[i].recruit.riName
                            +"</a></td><td>" +
                            apply[i].recruit.riCompany
                            +"</td><td>"+
                            apply[i].recruit.riSalary
                            +"</td><td>"+
                            apply[i].resume.resuName
                            +"</td><td>"+
                            apply[i].jivDate
                            +"</td><td>"+
                            apply[i].jivLocal
                            +"</td></tr>")
                    );
                }
            }
        })
    })

</script>
</body>
</html>
