<%--
  Created by IntelliJ IDEA.
  User: AllenYao
  Date: 2018.04.20
  Time: 13:45
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
    <title>guestPage</title>
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
        <a href="myApplypage">我的职位申请</a>
        <a href="interViewPage">我的面试</a>
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
    <div data-options="region:'center',title:'招聘资讯'">
        <table id="recruitListUl">

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
                    $("#recruitListUl tr").remove();
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
                                +"</td></tr>")
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
