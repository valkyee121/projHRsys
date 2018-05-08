<%--
  Created by IntelliJ IDEA.
  User: AllenYao
  Date: 2018.04.24
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
    <title>recruitManager</title>
    <link rel="stylesheet" type="text/css" href="resources/js/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="resources/js/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="resources/js/demo.css">
    <link rel="stylesheet" type="text/css" href="resources/css/pagination.css">
    <link rel="stylesheet" type="text/css" href="resources/css/table.css">
    <script type="text/javascript" src="resources/js/jquery.min.js"></script>
    <script type="text/javascript" src="resources/js/jquery.easyui.min.js"></script>
</head>
<body>
<table id="recruitListUl" class="table-7" style="width: 100%">
    <thead>
        <th>序号</th>
        <th>标题</th>
        <th>企业</th>
        <th>薪酬标准</th>
        <th>信息状态</th>
    </thead>
</table>
<div style="margin:20px 0;"></div>
<div class="easyui-panel">
    <div id="pager" class="yahoo2"></div>
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
            /*/!*清除列表内容*!/
            $("#recruitListUl tr").remove();*/
            $.ajax({
                type: 'post',
                url: 'listAllRecruit',
                data: {"pageIndex": pageIndex},
                dataType: 'json',
                async: false,
                success:function (data) {
                    var recruit = data.resultList;
                    /*首页显示*/
                    var intPageIndex = parseInt(pageIndex);
                    /*显示数据列表*/
                    var table = $("#recruitListUl");
                    /*填入内容*/
                    for (var i=0;i<recruit.length;i++){
                        table.append(
                            $("<tr><td>"+
                                recruit[i].riid
                                +"</td><td>"+
                                "<a href='recruitModManag?riid="+recruit[i].riid+"'>"+
                                recruit[i].riName
                                +"</a></td><td>" +
                                recruit[i].riCompany
                                +"</td><td>"+
                                recruit[i].riSalary
                                +"</td><td>" +
                                recruit[i].riStatus
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
