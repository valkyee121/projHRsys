<%--
  Created by IntelliJ IDEA.
  User: AllenYao
  Date: 2018.04.22
  Time: 16:06
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
    <title></title>
    <style type="text/css">
        DIV.yahoo2 {
            PADDING-RIGHT: 3px; PADDING-LEFT: 3px; FONT-SIZE: 0.85em; PADDING-BOTTOM: 3px; MARGIN: 3px; PADDING-TOP: 3px; FONT-FAMILY: Tahoma,Helvetica,sans-serif; TEXT-ALIGN: center
        }
        DIV.yahoo2 A {
            BORDER-RIGHT: #ccdbe4 1px solid; PADDING-RIGHT: 8px; BACKGROUND-POSITION: 50% bottom; BORDER-TOP: #ccdbe4 1px solid; PADDING-LEFT: 8px; PADDING-BOTTOM: 2px; BORDER-LEFT: #ccdbe4 1px solid; COLOR: #0061de; MARGIN-RIGHT: 3px; PADDING-TOP: 2px; BORDER-BOTTOM: #ccdbe4 1px solid; TEXT-DECORATION: none
        }
        DIV.yahoo2 A:hover {
            BORDER-RIGHT: #2b55af 1px solid; BORDER-TOP: #2b55af 1px solid; BACKGROUND-IMAGE: none; BORDER-LEFT: #2b55af 1px solid; COLOR: #fff; BORDER-BOTTOM: #2b55af 1px solid; BACKGROUND-COLOR: #3666d4
        }
        DIV.yahoo2 A:active {
            BORDER-RIGHT: #2b55af 1px solid; BORDER-TOP: #2b55af 1px solid; BACKGROUND-IMAGE: none; BORDER-LEFT: #2b55af 1px solid; COLOR: #fff; BORDER-BOTTOM: #2b55af 1px solid; BACKGROUND-COLOR: #3666d4
        }
        DIV.yahoo2 SPAN.current {
            PADDING-RIGHT: 6px; PADDING-LEFT: 6px; FONT-WEIGHT: bold; PADDING-BOTTOM: 2px; COLOR: #000; MARGIN-RIGHT: 3px; PADDING-TOP: 2px
        }
        DIV.yahoo2 SPAN.disabled {
            DISPLAY: none
        }
        DIV.yahoo2 A.next {
            BORDER-RIGHT: #ccdbe4 2px solid; BORDER-TOP: #ccdbe4 2px solid; MARGIN: 0px 0px 0px 10px; BORDER-LEFT: #ccdbe4 2px solid; BORDER-BOTTOM: #ccdbe4 2px solid
        }
        DIV.yahoo2 A.next:hover {
            BORDER-RIGHT: #2b55af 2px solid; BORDER-TOP: #2b55af 2px solid; BORDER-LEFT: #2b55af 2px solid; BORDER-BOTTOM: #2b55af 2px solid
        }
        DIV.yahoo2 A.prev {
            BORDER-RIGHT: #ccdbe4 2px solid; BORDER-TOP: #ccdbe4 2px solid; MARGIN: 0px 10px 0px 0px; BORDER-LEFT: #ccdbe4 2px solid; BORDER-BOTTOM: #ccdbe4 2px solid
        }
        DIV.yahoo2 A.prev:hover {
            BORDER-RIGHT: #2b55af 2px solid; BORDER-TOP: #2b55af 2px solid; BORDER-LEFT: #2b55af 2px solid; BORDER-BOTTOM: #2b55af 2px solid
        }

    </style>
    <script type="text/javascript" src="resources/js/jquery-3.1.0.js"></script>
</head>
<body>
<a href="listAllRecruit">search</a>

<table id="recruitListUl">

</table>
<ul  >
    <%--<c:forEach items="${recruitList}" var="rec">
        <li value="${rec.riid}">${rec.riName}</li>
    </c:forEach>--%>
</ul>

<div id="pager" class="yahoo2"></div>
<script type="text/javascript">

    Load();
    function Load() {

        $.post("listAllRecruit",null,function (result) {
            var totalPage = result.totalpage;
            console.log(totalPage);
            pageClick (1,totalPage,3);
        },"json");
        /*$.ajax({
            type: 'post',
            url: 'listAllRecruit',
            dataType: 'json',
            async: false,
            success:function (result) {
                var totalPage = result.totalpage;
                console.log(totalPage);
                pageClick (1,totalPage,3);
            }
        });*/
        pageClick = function (pageIndex, totalPage, spanInterval) {
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
                                    "<a href='#?riName=recruit[i].riName'>"+
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
