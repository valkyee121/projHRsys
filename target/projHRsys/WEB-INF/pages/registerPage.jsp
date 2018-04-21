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
        <div <%--class="easyui-dialog"--%>class="easyui-panel" style="width:400px;padding:50px 60px; position: absolute;left: 50%;top: 50%; transform: translate(-50%,-50%);">
            <form id="ff" method="post" action="userRegister">
                <div style="margin-bottom:20px">
                    <input id="email" class="easyui-textbox" label="Email:" labelPosition="top" type="email" name="uEmail" data-options="required:true, prompt:'请输入正确的邮箱...',validType:['email','myvalidate']" style="width:100%;height:52px">
                    <span id="showmsg"></span>
                </div>
                <div style="margin-bottom:20px">
                    <input id="pass" class="easyui-passwordbox" label="密码：" labelPosition="top"  prompt="请输入密码" iconWidth="28" required="true" validType="passFormat" style="width:100%;height:52px;padding:10px">
                    <span>请输入6-16位，以字母开头的密码</span>
                </div>
                <div style="margin-bottom:20px">
                    <input class="easyui-passwordbox" label="确认密码：" labelPosition="top" name="uPass" type="password" prompt="请再次输入密码" required="true" iconWidth="28" validType="confirmPass['#pass']" style="width:100%;height:52px;padding:10px">
                </div>
                <div style="margin-bottom: 20px">
                    <input type="submit" value="Register" class="easyui-linkbutton" id="register"  style="padding:5px 0px;width:100%;font-size:14px;">
                </div>
            </form>
        </div>
    </div>
    <div data-options="region:'south',border:false" style="height:50px;background:#A9FACD;padding:10px;">
        页脚
    </div>
    <script type="text/javascript">
        var mailResult = false;
        var passResult = false;
        /*密码一致性验证*/
        $.extend($.fn.validatebox.defaults.rules, {
            confirmPass: {
                validator: function(value, param){
                    var pass = $(param[0]).val();
                    return value == pass;
                    /*$(this).blur(function () {
                        console.log(pass);
                    })*/
                },
                message: '密码不一致'
            }
        })
        $.extend($.fn.validatebox.defaults.rules,{
            passFormat:{
                validator:function (value) {
                    return /^[a-zA-Z][a-zA-z0-9_]{5,15}$/i.test(value);
                },
                message:'密码格式非法'
            }
        })
        /*邮箱重复验证*/
       $.extend($.fn.validatebox.defaults.rules,{
           myvalidate:{
               validator:function (value) {
                   console.log(value);
                   var result = checkEmail(value);
                   if (result==0){
                       return false;
                   }else if (result==1){
                       return true;
                   }
/*                   var result=true;
                   $(this).blur(function () {
                       $.ajax({
                           type:'post',
                           url:'ajaxForRegist',
                           data:{"uEmail":$("input[name='uEmail']").val().trim()},
                           async: false,
                           success:function (data) {
                               console.log(data);
                               if (data == 1){
                                  result=true;
                               }else if (data == 0){
                                   result=false;
                               }
                               /!*value == data;
                               console.log(value);
                               console.log(email);*!/
                               /!*if ("no"==data){
                                   mailResult = false;
                                   $("#showmsg").html("该用户已经存在").css({"color":"red"});
                               }else if ("yes"==data){
                                   mailResult = true;
                                   $("#showmsg").html("用户名可用").css({"color":"green"});
                               }
                               checkAll()*!/
                           }
                       });
                   })*/
                   console.log(result);
                   /*return result;*/
               },
               message: '用户名已经占用'
           }
       })
        function checkEmail(value) {
            var result = 0;
            $.ajax({
                type:'post',
                async:false,
                url:'ajaxForRegist',
                /*data:{"uEmail":$("input[name='uEmail']").val().trim()},*/
                data:{"uEmail":value},
                success:function (data) {
                    result = data;
                }
            });
            return result;
        }

        $('#ff').form({
            /*url:'http://localhost:8088/userRegister',*/
            onSubmit:function(){
                var isValid = $(this).form('validate');
                if (!isValid){
                    $.messager.progress('close');
                }
                return isValid;
            },
            success:function(data){
                $.messager.alert('Info', data, 'info');
                messager.progress('close');
            }
        });
        /*function checkAll() {
            var oL = document.getElementById('register');
            /!*console.log(mailResult);*!/
            console.log(passResult);
            if (mailResult&&passResult){
                oL.removeAttribute("disabled");
            }else {
                oL.setAttribute("disabled","true");
            }
        }*/
</script>
</body>
</html>
