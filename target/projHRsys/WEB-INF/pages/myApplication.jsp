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
    <script type="text/javascript" src="resources/js/jquery.min.js"></script>
    <script type="text/javascript" src="resources/js/jquery.easyui.min.js"></script>
</head>
<body class="easyui-layout">
<%--MAINPAGE--%>
<div data-options="region:'north',border:false" style="height:60px;background:#B3DFDA;padding:10px">
    导航栏
    <a href="userMyResume?uid=${sessionScope.user.uid}">我的简历</a>
    <a href="#">我的职位申请</a>
</div>
<div data-options="region:'west',split:true,title:'West'" style="width:220px;padding:10px;">
    <%--LOGIN--%>
    <h2>用户信息</h2>
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
    </div>
</div>
<%--<div data-options="region:'east',split:true,collapsed:true,title:'East'" style="width:100px;padding:10px;">

</div>--%>
<div data-options="region:'south',border:false" style="height:50px;background:#A9FACD;padding:10px;">
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
    <table id="applyListUl">

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
                table.empty();
                /*清除列表内容*/
                $("#applyListUl tr").remove();
                /*填入内容*/
                for (var i=0;i<apply.length;i++){
                    table.append(
                        $("<tr><td>"+
                            "<a href='#="+apply[i].recruits[0].riid+"'>"+
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
