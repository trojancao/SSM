<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="../common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@ include file="../common/header.jsp" %>
    <title>后台登录</title>
</head>
<body class="hold-transition login-page">
<div class="login-box">
    <!-- /.login-logo -->
    <div class="login-logo">
        <b>后台管理系统</b>
    </div>
    <div class="login-box-body">

        <form method="post" id="login-form" action="${ctx}/login/loginIn.htm">
            <div class="form-group has-feedback">
                <input type="text" class="form-control" name="userName" placeholder="请输入登录名">
                <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
            </div>
            <div class="form-group has-feedback">
                <input type="password" class="form-control" name="password" placeholder="请输入密码">
                <span class="glyphicon glyphicon-lock form-control-feedback"></span>
            </div>
            <div class="form-group has-feedback">
                <div class="row">
                    <div class="col-xs-8">
                <input type="text" class="form-control" name="code" placeholder="请输入验证码">
                        </div>
                    <div class="col-xs-4">
                    <img id="imgObj" alt="验证码"
                         src="${ctx}/getCode"><a href="javascript:void(0);" onclick="changeImg()">换一张</a>
                    </div>
                    </div>
                <%--<span class="glyphicon glyphicon-lock form-control-feedback"></span>--%>
            </div>
            <div class="row">
                <div class="col-xs-6">
                    <div class="checkbox icheck">
                        <label>
                            <input type="checkbox" name="rememberMe"> 记住用户
                        </label>
                    </div>
                </div>
                <!-- /.col -->
            </div>
            <div class="row">
                <div class="col-xs-12">
                    <button type="submit" class="btn btn-danger btn-block btn-flat">登 录</button>
                </div>
            </div>
        </form>

        <!-- /.login-box-body -->
    </div>
    <!-- /.login-box -->
</div>
<script type="text/javascript">

    $(function () {
        $('input').iCheck({
            checkboxClass: 'icheckbox_square-red',
            radioClass: 'iradio_square-red',
            increaseArea: '20%' // optional
        });

        fillbackLoginForm();
        $("#login-form").bootstrapValidator({
            message: '请输入用户名/密码',
            submitHandler: function (valiadtor, loginForm, submitButton) {
                rememberMe($("input[name='rememberMe']").is(":checked"));

                $.ajax({
                    url: $("#login-form").attr('action'),
                    async: true,//同步，会阻塞操作
                    type: 'POST',//PUT DELETE POST
                    data: $("#login-form").serialize(),
                    dataType: "json",
                    success: function (data) {
                        if (data.result == 1) {
                            window.location.href = '${ctx}/main/index.htm';
                        } else {
                            $("#login-form input").val("");
                            changeImg();
                            $.globalMessenger().post({
                                message: data.msg,//提示信息
                                type: 'error',//消息类型。error、info、success
                                hideAfter: 4,
                                hideOnNavigate: true
                            });
                        }
                    }
                })
            },

            fields: {
                userName: {
                    validators: {
                        notEmpty: {
                            message: '用户名不能为空'
                        }
                    }
                },
                password: {
                    validators: {
                        notEmpty: {
                            message: '密码不能为空'
                        }
                    }
                },
                code: {
                    validators: {
                        notEmpty: {
                            message: '验证码不能为空'
                        }
                    }
                }
            }
        });

    });


    //使用本地缓存记住用户名密码
    function rememberMe(rm_flag) {
        //remember me
        if (rm_flag) {
            localStorage.userName = $("input[name='userName']").val();
            localStorage.password = $("input[name='password']").val();
            localStorage.rememberMe = 1;
        }
        //delete remember msg
        else {
            localStorage.userName = null;
            localStorage.password = null;
            localStorage.rememberMe = 0;
        }
    }

    //记住回填
    function fillbackLoginForm() {
        if (localStorage.rememberMe && localStorage.rememberMe == "1") {
            $("input[name='userName']").val(localStorage.userName);
            $("input[name='password']").val(localStorage.password);
            $("input[name='rememberMe']").iCheck('check');
            $("input[name='rememberMe']").iCheck('update');
        }
    }

    function changeImg() {
        var imgSrc = $("#imgObj");
        var src = imgSrc.attr("src");
        imgSrc.attr("src", chgUrl(src));
    }

    // 时间戳
    // 为了使每次生成图片不一致，即不让浏览器读缓存，所以需要加上时间戳
    function chgUrl(url) {
        var timestamp = (new Date()).valueOf();
        url = url.substring(0, 20);
        if ((url.indexOf("&") >= 0)) {
            url = url + "×tamp=" + timestamp;
        } else {
            url = url + "?timestamp=" + timestamp;
        }
        return url;
    }
</script>
</body>

</html>