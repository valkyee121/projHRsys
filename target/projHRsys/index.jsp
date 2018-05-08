<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: AllenYao
  Date: 2018.04.15
  Time: 10:38
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
    <title>UserLogin</title>

    <link rel="stylesheet" type="text/css" href="resources/js/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="resources/js/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="resources/js/demo.css">
    <link rel="stylesheet" type="text/css" href="resources/css/pagination.css">
    <link rel="stylesheet" type="text/css" href="resources/css/table.css">
    <script type="text/javascript" src="resources/js/jquery.min.js"></script>
    <script type="text/javascript" src="resources/js/jquery.easyui.min.js"></script>
</head>
<body class="easyui-layout">
    <%--MAINPAGE--%>
    <div data-options="region:'north',border:true" style="height:60px;background:-webkit-linear-gradient(bottom,#EFF5FF,#E0ECFF);padding:10px">
    </div>
    <div data-options="region:'west',split:true,title:'West'" style="width:220px;padding:10px;">
        <%--LOGIN--%>
        <h2>用户登录</h2>
        <div style="margin:20px 0;"></div>
        <form method="post" action="userLogin">
            <div style="margin-bottom:10px">
                <input name="uEmail" class="easyui-textbox" style="width:100%;height:40px;padding:12px" data-options="prompt:'请输入邮箱',iconCls:'icon-man',iconWidth:38">
            </div>
            <div style="margin-bottom:20px">
                <input name="uPass" class="easyui-textbox" type="password" style="width:100%;height:40px;padding:12px" data-options="prompt:'请输入密码',iconCls:'icon-lock',iconWidth:38">
            </div>
            <%--<div style="margin-bottom:20px">
                <input type="checkbox" checked="checked">
                <span>Remember me</span>
            </div>--%>
            <div>
                <input type="submit" value="Login" class="easyui-linkbutton"  style="padding:5px 0px;width:100%;font-size:14px;">
                <a href="userRegPage" style="padding:5px 0px;width:100%;font-size:14px;">还没有帐号？立即注册</a>
            </div>
        </form>
    </div>
    <%--<div data-options="region:'east',split:true,collapsed:true,title:'East'" style="width:100px;padding:10px;">

    </div>--%>
    <div data-options="region:'south',border:false" style="height:50px;background:-webkit-linear-gradient(bottom,#EFF5FF,#E0ECFF);padding:10px;">
        页脚
    </div>
    <div data-options="region:'center',title:'招聘资讯'">

        <table class="table-7" id="recruitListUl" style="width: 100%">
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
        <div style="margin:20px 0;"></div>
        <div class="easyui-panel">
            <div id="pager" class="yahoo2"></div>
        </div>
    </div>
    <script type="text/javascript">
        Load();
        function Load() {
            $.post("listAllRecruit",null,function (result) {
                var totalPage = result.totalpage;
                console.log(totalPage);
                pageClick (1,totalPage,3);
            },"json");
            pageClick = function (pageIndex, totalPage, spanInterval) {
                console.log(pageIndex);
                console.log(totalPage);
                console.log(spanInterval);
               /* $("#recruitListUl tr").remove();*/
                $.ajax({
                    type: 'post',
                    url: 'listAllRecruit',
                    data: {"pageIndex": pageIndex},
                    dataType: 'json',
                    async: false,
                    success:function (data) {
                        var recruit = data.resultList;
                        console.log(recruit);
                        /*首页显示*/
                        var intPageIndex = parseInt(pageIndex);
                        /*显示数据列表*/
                        var table = $("#recruitListUl");
                        /*清除列表内容*/

                        /*填入内容*/
                        for (var i=0;i<recruit.length;i++){
                            table.append(
                                $("<tr><td>"+
                                    "<a href='findThisRecruit?riid="+recruit[i].riid+"'>"+
                                    recruit[i].riName
                                    +"</a></td><td>" +
                                    recruit[i].riCompany
                                    +"</td><td>"+
                                    recruit[i].riSalary
                                    +"元</td></tr>")
                            );
                        }
                        /*创建分页*/
                        /**/
                        var pageS = totalPage;
                        var $pager = $("#pager");

                        $("#pager span").remove();
                        $("#pager a").remove();

                        if (intPageIndex == 1){
                            $pager.append("<span class='disabled'>第一页</span>");
                        }else {
                            var first = $("<a href='javascript:void(0)' first='"+1+"'>第一页</a>").click(function () {
                                pageClick($(this).attr('first'),totalPage,spanInterval);
                                return false;
                            });
                            $pager.append(first);
                        }
                        /*添加上一页*/
                        if (intPageIndex == 1){
                            $pager.append("<span class='disabled'>上一页</span>");
                        }else {
                            var previous = $("<a href='javascript:void(0) previous='"+(intPageIndex-1)+"'>上一页</a>").click(function () {
                                pageClick($(this).attr('previous'),totalPage,spanInterval);
                                return false;
                            });
                            $pager.append(previous);
                        }
                        /*设置分页格式*/
                        var interval = parseInt(spanInterval); //间距
                        var start = Math.max(1,intPageIndex - interval); //起始页
                        var end = Math.min(intPageIndex + interval, pageS) //末页

                        if (intPageIndex < interval +1){
                            end = (2* interval +1) >pageS ? pageS : (2* interval +1);
                        }
                        if (intPageIndex +interval > pageS){
                            start = (pageS -2* interval) <1 ? 1 : (pageS -2* interval);
                        }
                        /*页码*/
                        for (var j=start; j<end +1; j++){
                            if (j == intPageIndex){
                                var spanSelected = $("<span class='current'>"+ j +"</span>");
                                $pager.append(spanSelected);
                            }else {
                                var  a = $("<a href='javascript:void(0)'>"+ j +"</a>").click(function () {
                                    pageClick(($(this).text(),totalPage,spanInterval));
                                    return false;
                                });
                                $pager.append(a);
                            }
                        }
                        /*下一页*/
                        if (intPageIndex == totalPage){
                            $pager.append("<span class='disabled'>下一页</span>");
                        }else {
                            var next = $("<a href='javascript:void(0)' next='"+ (intPageIndex +1) +"'>下一页</a>").click(function () {
                                pageClick($(this).attr("next"),totalPage,spanInterval);
                                return false;
                            });
                            $pager.append(next);
                        }
                        /*最后一页*/
                        if (intPageIndex == pageS){
                            $pager.append("<span class='disabled'>末页</span>");
                        }else {
                            var last = $("<a href='javascript:void(0)'last='"+ pageS +"'>末页</a>").click(function () {
                                pageClick(($(this).attr("last"),totalPage,spanInterval));
                                return false;
                            });
                            $pager.append(last);
                        }
                    }
                })
            }
        }
    </script>
</body>
</html>
