<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: AllenYao
  Date: 2018.04.23
  Time: 16:10
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
    <title>myApplication</title>
    <link rel="stylesheet" type="text/css" href="resources/js/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="resources/js/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="resources/js/demo.css">
    <link rel="stylesheet" type="text/css" href="resources/css/pagination.css">
    <link rel="stylesheet" type="text/css" href="resources/css/table.css">
    <link rel="stylesheet" type="text/css" href="resources/css/sidebar.css">
    <link rel="stylesheet" type="text/css" href="resources/css/teal.css">
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
    <%--<h2>用户信息</h2>
    <div style="margin:20px 0;"></div>
    <div style="margin-bottom:10px">
        <p>${sessionScope.user.uEmail}</p>
        <table>
            <tr>
                <th>姓名</th>
                <td>${myResume.resume.resuName}</td>
            </tr>
            <tr>
                <th>性别</th>
                <td>${myResume.resume.resuSex}</td>
            </tr>
            <tr>
                <th>出生年月</th>
                <td>${myResume.resume.resuBirth}</td>
            </tr>
            <tr>
                <th>所在城市</th>
                <td>${myResume.resume.resuCity}</td>
            </tr>
            <tr>
                <th>联系电话</th>
                <td>${myResume.resume.resuCell}</td>
            </tr>
            <tr>
                <th>邮箱地址</th>
                <td>${myResume.resume.resuEmail}</td>
            </tr>
            <tr>
                <th>其他信息</th>
                <td>${myResume.resume.resuInfo}</td>
            </tr>
        </table>
    </div>--%>
</div>
<%--<div data-options="region:'east',split:true,collapsed:true,title:'East'" style="width:100px;padding:10px;">

</div>--%>
<div data-options="region:'south',border:false" style="height:50px;background:-webkit-linear-gradient(bottom,#EFF5FF,#E0ECFF);padding:10px;">
    页脚
</div>
<div data-options="region:'center',title:'投递信息'">
    <div style="margin-bottom:20px">
        <select name="postStatu" id="postStatu" label="查看投递状态" >
            <option value="0" selected="selected">已投递</option>
            <option value="1">已查阅</option>
            <option value="2">通过筛选，等待面试</option>
            <option value="3">未通过筛选</option>
        </select>
    </div>
    <table class="table-7" id="applyListUl" style="width: 100%">
        <thead>
            <th>招聘职位</th>
            <th>公司名称</th>
            <th>薪酬</th>
        </thead>
    </table>
    <%-- <ul class="easyui-datalist" id="recruitListUl" style="display: block">
         &lt;%&ndash;<c:forEach items="${recruitList}" var="rec">
             <li value="${rec.riid}">${rec.riName}</li>
         </c:forEach>&ndash;%&gt;
     </ul>--%>
</div>
<script type="text/javascript">
    $("#postStatu").bind("change",function () {
        var postStatu = $(this).val();
        console.log(postStatu);
        $("#applyListUl tr td").empty();
        $.ajax({
            type: 'get',
            url: 'ajaxListMyApply',
            data: {"postStatus": postStatu},
            dataType: 'json',
            async: false,
            success:function (data) {
                var apply = data.resultList;

                /*显示数据列表*/
                var table = $("#applyListUl");
                /*table.empty();*/
                /*清除列表内容*/

                /*填入内容*/
                for (var i=0;i<apply.length;i++){
                    table.append(
                        $("<tr><td>"+
                            "<a href='findThisRecruit?riid="+apply[i].recruits[0].riid+"'>"+
                            apply[i].recruits[0].riName
                            +"</a></td><td>" +
                            apply[i].recruits[0].riCompany
                            +"</td><td>"+
                            apply[i].recruits[0].riSalary
                            +"</td></tr>")
                    );
                }
            }
        })
    })

</script>
</body>
</html>
