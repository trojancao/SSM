<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ include file="../common/taglibs.jsp" %>
<head>
    <%@ include file="../common/header.jsp" %>
    <title>后台管理平台</title>
</head>
<body class="hold-transition skin-blue sidebar-mini fixed">


<a name="main"></a>
<div class="wrapper">
    <header class="main-header">
        <!-- Logo -->
        <a href="#" class="logo">
            <span class="logo-lg">后台管理系统</span>
        </a>
        <!-- Header Navbar: style can be found in header.less -->
        <nav class="navbar navbar-static-top">
            <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
                <span class="sr-only">Toggle navigation</span>
            </a>

            <div class="navbar-custom-menu">
                <ul class="nav navbar-nav">
                    <li>
                        <a href="#"><b>用户名：${userid}</b></a>
                    </li>
                    <li>
                        <a href="${ctx}/login/loginOut.htm">退出登陆</a>
                    </li>
                    <li>
                        <a href="javascript:void(0);" onclick="changePassword();">修改密码</a>
                    </li>
                </ul>
            </div>
        </nav>
    </header>
    <!-- Left side column. contains the logo and sidebar -->
    <aside class="main-sidebar">
        <!-- sidebar: style can be found in sidebar.less -->
        <section class="sidebar">
            <!-- sidebar menu: : style can be found in sidebar.less -->
            <ul class="sidebar-menu">
                <li class="header">目录</li>
                <li class="treeview"><a href="#" onclick="goto(this);"><i class="fa fa-link"></i><span>首页</span></a>
                </li>
                <c:forEach items="${parentMenus }" var="menu">
                    <li class="treeview">
                        <a href="#"><i class="fa fa-link"></i> <span>${menu.description}</span>
                            <span class="pull-right-container">
                                 <i class="fa fa-angle-left pull-right"></i>
                               </span>
                        </a>

                        <ul class="treeview-menu">
                            <c:forEach items="${ menu.menus}" var="childMenu">
                                <li><a href="javascript:void(0);" data-url='${ctx}${childMenu.menu}'>${childMenu.description}</a>
                                </li>
                            </c:forEach>

                        </ul>
                    </li>

                </c:forEach>
            </ul>
        </section>
        <!-- /.sidebar -->
    </aside>

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper" id="mainDiv">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                Page Header
                <small>Optional description</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
                <li class="active">Here</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content container-fluid">

            <!--------------------------
              | Your Page Content Here |
              -------------------------->

        </section>
        <!-- /.content -->

    </div>
</div>
<!-- 模态框（Modal） -->
<div class="modal fade" id="pwdModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="pwdModalLabel">模态框（Modal）标题</h4>
            </div>
            <form id="pwdfm" method="post" role="pwdfm" class="form-horizontal">
                <div class="modal-body">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">旧密码:</label>
                        <div class="col-md-7">
                            <input name="oldPwd" type="password" class="form-control" >
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">新密码:</label>
                        <div class="col-md-7">
                            <input name="newPwd" class="form-control"  type="password" >
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">确认新密码:</label>
                        <div class="col-md-7">
                            <input name="okNewPwd" class="form-control" type="password">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-primary" onclick="savePwd()">保存</button>
                    </div>
                </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<script>

    function goto(obj){
        loadPage("${ctx}/index/index.htm");
        $("ul.treeview-menu li").removeClass("active");
        $("li.treeview").removeClass("active");
        $(obj).parent().addClass("active");

    }
    $(function () {
    	loadPage("${ctx}/index/index.htm");
        //首页默认加载
        $("a[data-url]").click(function (evt) {
            loadPage($(this).data("url"));
            $("ul.treeview-menu li").removeClass("active");
            $(this).parent().addClass("active");

        });

        //当点击查询按钮的时候执行
        $('#pwdfm').bootstrapValidator({
            message: 'This value is not valid',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                oldPwd: {
                    message: '密码验证失败',
                    validators: {
                        notEmpty: {
                            message: '旧密码不能为空'
                        },

                    }
                },
                newPwd: {
                    validators: {
                        notEmpty: {
                            message: '新密码不能为空'
                        },
                        stringLength: {
                            min: 6,
                            message: '密码长度必须大于6位'
                        },
                        validators: {
                            identical: {
                                field: 'okNewPwd',
                                message: '两次输入的密码不相符'
                            }
                        },
                    }
                },
                okNewPwd:{
                    validators: {
                        notEmpty: {
                            message: '新密码不能为空'
                        },
                        stringLength: {
                            min: 6,
                            message: '密码长度必须大于6位'
                        },
                        validators: {
                            identical: {
                                field: 'newPwd',
                                message: '两次输入的密码不相符'
                            }
                        },
                    }
                }
            }
        });

    });

    function changePassword() {
        $("#pwdfm input").val("");
        $('#pwdfm').data('bootstrapValidator').resetForm(true);
        $('#pwdModal').modal('show');
        $("#pwdModalLabel").html('修改密码');
    }

    function savePwd(){
        $.ajax({
            url: '${ctx}/employee/changeEmployeesPasswd.htm',
            type: 'POST',//PUT DELETE POST
            data: $("#pwdfm").serialize(),
            dataType: "json",
            success: function (data) {
                if (data.result == 1) {
//                    $('#pwdModal').modal('hide');
//                    $("#pwdfm input").val("");
                    window.location.href='${ctx}/login/index.htm';
//                    initTable();
                } else {
                    $.globalMessenger().post({
                        message: data.msg,//提示信息
                        type: 'error',//消息类型。error、info、success
                        hideAfter: 4,
                        hideOnNavigate: true
                    });
                }
            }
        })
    }
</script>
</body>
</html>
