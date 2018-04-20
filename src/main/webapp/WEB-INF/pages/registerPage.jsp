<%--
  Created by IntelliJ IDEA.
  User: AllenYao
  Date: 2018.04.20
  Time: 14:44
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
    <title>UserRegist</title>
    <link rel="stylesheet" type="text/css" href="resources/css/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="resources/css/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="resources/css/demo.css">
    <script type="text/javascript" src="resources/js/jquery.min.js"></script>
    <script type="text/javascript" src="resources/js/jquery.easyui.min.js"></script>
</head>
<body class="easyui-layout">
<%--MAINPAGE--%>
    <div data-options="region:'north',border:false" style="height:60px;background:#B3DFDA;padding:10px">
        导航栏
    </div>
    <div data-options="region:'center',title:'用户注册'">
        <h2>Validate Password</h2>
        <p>This example shows how to validate whether a user enters the same password.</p>
        <div style="margin:20px 0;"></div>
        <div class="easyui-panel" style="width:400px;padding:50px 60px; position: absolute;left: 50%;top: 50%; transform: translate(-50%,-50%);">
            <form id="" method="post" action="userRegister">
                <div style="margin-bottom:20px">
                    <input id="email" class="easyui-textbox" label="Email:" labelPosition="top" name="uEmail" data-options="prompt:'请输入正确的邮箱...',validType:'email'" style="width:100%;height:52px">
                    <span id="showmsg"></span>
                </div>
                <div style="margin-bottom:20px">
                    <input id="pass" class="easyui-passwordbox" label="密码：" labelPosition="top" prompt="请输入密码" iconWidth="28" style="width:100%;height:52px;padding:10px">
                </div>
                <div style="margin-bottom:20px">
                    <input class="easyui-passwordbox" label="确认密码：" labelPosition="top" name="uPass" type="password" prompt="请再次输入密码" iconWidth="28" validType="confirmPass['#pass']" style="width:100%;height:52px;padding:10px">
                </div>
                <div style="margin-bottom: 20px">
                    <input type="submit" value="Register" class="easyui-linkbutton" style="padding:5px 0px;width:100%;font-size:14px;">
                </div>
            </form>
        </div>
    </div>
    <div data-options="region:'south',border:false" style="height:50px;background:#A9FACD;padding:10px;">
        页脚
    </div>
    <script type="text/javascript">
        $.extend($.fn.validatebox.defaults.rules, {
            confirmPass: {
                validator: function(value, param){
                    var pass = $(param[0]).passwordbox('getValue');
                    return value == pass;
                },
                message: 'Password does not match confirmation.'
            }
        })
       $.extend($.fn.validatebox.defaults.rules,{
           myvalidate:{
               validator:function (value, param) {
                   var usermail = $("#email").val().trim();
                   console.log(usermail);
                   var hah = " ";
                   $.ajax({
                       type:'post',
                       url:'ajaxForRegist',
                       data:{"usermail":usermail},
                       success:function (data) {
                           hah = data;
                       }
                   });
                   console.log(hah);
                   return hah.indexOf("true");
               },
               message: '用户名已经占用'
           }
       })
       /* $(document).ready(function () {
            $("#email").mouseout(function () {
                $.ajax({
                    type:"post",
                    url:"ajaxForRegist",
                    data:{"email":$("input[name='uEmail']").val()},
                    success:function (data) {
                        if ("no"==data){
                            alert("bad");
                            $("#showmsg").html("该用户已经存在");
                        }else if ("yes"==data){
                            alert("ok");
                            $("#showmsg").html("用户名可用");
                        }
                    },
                    error: function () {
                        alert("异常");
                    }
                })
            })
        })*/
</script>
</body>
</html>
