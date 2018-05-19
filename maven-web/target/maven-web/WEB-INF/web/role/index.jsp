<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="../common/taglibs.jsp" %>
<section class="content-header">
    <h1>
        角色信息
        <small>列表</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="javascript:void(0);" onclick="goIndex();"><i class="fa fa-dashboard"></i> 首页</a></li>
        <li><a href="#">系统管理</a></li>
        <li class="active">角色管理</li>
    </ol>
</section>
<section class="content">
    <%--<div class="row">--%>
    <div class="row">
        <div class="col-xs-6">
            <div class="box">

                <div class="box-body">
                    <div id="toolbar" class="btn-group">
                        <button id="btn_add" type="button" class="btn btn-default" data-toggle="modal"
                                onclick="openAddModel()">
                            <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
                        </button>
                        <button id="btn_edit" type="button" class="btn btn-default" onclick="openEditModel()">
                            <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改
                        </button>
                        <button id="btn_delete" type="button" class="btn btn-default" onclick="openDeleteModel()">
                            <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除
                        </button>
                        <button id="btn_edit" type="button" class="btn btn-default" onclick="openRoleModel()">
                            <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>绑定用户
                        </button>
                    </div>
                    <table id="roleTable" class="table table-bordered table-striped table-hover">
                    </table>
                </div>

                <!-- /.box-body -->
            </div>
        </div>
        <!-- /.col -->
        <%--</div>--%>
        <div class="col-xs-6">
            <div class="box">
                <div class="box-body">
                    <span style="float: left;"><h5>当前角色：</h5></span>
                    <span id="roleUserSpan" style="float: left;">
                    </span>
                </div>
                <div class=" box-body" id="searchDiv">

                    <form role="form" class="form-inline">
                        <div class="form-group">
                            用户名:<input id="userId" class="form-control" type="text"
                                       style="width: 100px;">
                            员工姓名:<input id="name" class="form-control" type="text"
                                        style="width: 100px;">
                            <div class="btn-group">
                                <button type="button" class="btn btn-primary" id="search" onclick="searchRole()">查询
                                </button>
                                <button type="reset" class="btn btn-default" id="reset1">重置</button>
                            </div>
                        </div>
                        <div style="float: right;">
                            <button type="button" class="btn btn-primary" onclick="deleteUserRole()">解除绑定
                            </button>
                        </div>
                    </form>

                </div>
                <div class="box-body">
                    <table id="userTable" class="table table-bordered table-striped table-hover">
                    </table>
                </div>
            </div>
            </table>

        </div>
    </div>
    <!-- /.row -->
</section>
<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">模态框（Modal）标题</h4>
            </div>
            <form id="rolefm" method="post" role="rolefm" class="form-horizontal">
                <div class="modal-body">
                    <input id="fmRoleId" name="roleId" type="hidden">
                    <div class="form-group row">
                        <label class="col-sm-2 control-label">角色名称:</label>
                        <div class="col-md-4">
                            <input name="roleName" id="ifRoleName" type="text" class="form-control" maxlength="32">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" onclick="save()">保存</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- 模态框（Modal） -->
<div class="modal fade" id="userModal" tabindex="-1" role="dialog" aria-labelledby="userModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="userModalLabel">模态框（Modal）标题</h4>
            </div>
            <div class="box-body">
                <%--<div class=" panel-default" id="searchDiv">--%>
                <%--<div class="panel-body">--%>
                <form role="userRoleFm" class="form-inline" id="userRoleFm">
                    <div class="row">
                        <label class="col-sm-2 control-label">用户名:</label>
                        <div class="col-md-4">
                            <input id="userIdSearch" class="form-control" type="text"
                                   style="width: 150px">
                        </div>
                        <label class="col-sm-2  control-label"> 员工姓名: </label>
                        <div class="col-md-4">
                            <input id="nameSearch" class="form-control" type="text"
                                   style="width: 150px;"></div>
                    </div>
                    <div class="row" style="margin-top: 5px">
                        <label class="col-sm-2 control-label">职员类型:</label>
                        <div class="col-md-4">
                            <select class="form-control" id="typeSearch" panelHeight="auto"
                                    style="width: 150px;">
                                <option value="">--请选择--</option>
                                <option value="01">保洁员</option>
                                <option value="02">销售</option>
                                <option value="03">财务</option>
                                <option value="04">客服</option>
                                <option value="05">工程</option>
                                <option value="06">培训师</option>
                                <option value="07">销售主管</option>
                                <option value="08">助理</option>
                                <option value="09">售后</option>
                                <option value="10">人事</option>
                                <option value="11">美工</option>  
                            </select>
                        </div>
                        <label class="col-sm-2 control-label">在职状态:</label>
                        <div class="col-md-4">
                            <select class="form-control" style="width: 150px;" id="stateSearch"
                                    panelHeight="auto">
                                <option value="">--请选择--</option>
                                <option value="01">在职</option>
                                <option value="02">离职</option>
                            </select>
                        </div>
                    </div>
                    <%--<div class="row">--%>
                    <div class=" btn-group" style="float:right;margin-top: 10px">
                        <button type="button" class="btn btn-primary" id="search2" onclick="initUserTable()">查询
                        </button>
                        <button type="reset" class="btn btn-default" id="reset">重置</button>
                        <%--</div>--%>
                    </div>
                </form>
                <%--</div>--%>
                <%--</div>--%>
            </div>
            <div class="box-body">
                <table id="userInfoTable" class="table table-bordered table-striped table-hover">
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" onclick="saveRole()">保存</button>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var url;
    function deleteUserRole() {

        var rowData2 = $("#roleTable").bootstrapTable('getSelections', function (row) {
            return row;
        });
        if (rowData2.length != 1) {
            $.globalMessenger().post({
                message: '请选择一条记录',//提示信息
                type: 'error',//消息类型。error、info、success
                hideAfter: 4,
                hideOnNavigate: true
            });
            return;
        }

        var rowData = $("#userTable").bootstrapTable('getSelections', function (row) {
            return row;
        });
        if (rowData.length != 1) {
            $.globalMessenger().post({
                message: '请选择要删除的用户',//提示信息
                type: 'error',//消息类型。error、info、success
                hideAfter: 4,
                hideOnNavigate: true
            });

        } else {
            BootstrapDialog.confirm({
                title: '删除',
                message: '确定删除用户[' + rowData[0].userId + '] 吗?',
                type: BootstrapDialog.TYPE_PRIMARY, // <-- Default value is
                closable: true, // <-- Default value is false，点击对话框以外的页面内容可关闭
                draggable: true, // <-- Default value is false，可拖拽
                btnCancelLabel: '取消', // <-- Default value is 'Cancel',
                btnOKLabel: '确定', // <-- Default value is 'OK',
                size: BootstrapDialog.SIZE_SMALL,
                // 对话框关闭的时候执行方法
                callback: function (result) {
                    // 点击确定按钮时，result为true
                    if (result) {
                        $.ajax({
                            url: '${ctx}/role/deleteUserRole.htm',
                            type: 'POST',//PUT DELETE POST
                            dataType: "json",
                            data: {'userRoleId': rowData[0].userRoleId},
                            success: function (data) {
//                                var data = JSON.parse(data);

                                if (data.result == 1) {
                                    initUserRoleTable(rowData2[0].roleId);
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
                }
            });
        }
    }

    function openRoleModel() {
        var rowData = $("#roleTable").bootstrapTable('getSelections', function (row) {
            return row;
        });
        if (rowData.length != 1) {
            $.globalMessenger().post({
                message: '请选择角色',//提示信息
                type: 'error',//消息类型。error、info、success
                hideAfter: 4,
                hideOnNavigate: true
            });
            return;
        }

        $("#userRoleFm input").val("");
        $('#userModal').modal('show');
        $("#userModalLabel").html('绑定用户');
        initUserTable();
    }
    function saveRole() {
        var rowData = $("#roleTable").bootstrapTable('getSelections', function (row) {
            return row;
        });
        if (rowData.length != 1) {
            $.globalMessenger().post({
                message: '请选择角色',//提示信息
                type: 'error',//消息类型。error、info、success
                hideAfter: 4,
                hideOnNavigate: true
            });
            return;
        }

        var userRowData = $("#userInfoTable").bootstrapTable('getSelections', function (row) {
            return row;
        });
        if (userRowData.length != 1) {
            $.globalMessenger().post({
                message: '请选择一条员工记录',//提示信息
                type: 'error',//消息类型。error、info、success
                hideAfter: 4,
                hideOnNavigate: true
            });
            return;
        }

        $.ajax({
            url: '${ctx}/role/addUserRole.htm',
            type: 'POST',//PUT DELETE POST
            dataType: "json",
            data: {'roleId': rowData[0].roleId, 'userId': userRowData[0].userId},
            success: function (data) {
//                var data = JSON.parse(data);

                if (data.result == 1) {
                    initUserTable();
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

    function searchRole() {
        var rowData = $("#roleTable").bootstrapTable('getSelections', function (row) {
            return row;
        });
        if (rowData.length != 1) {
            $.globalMessenger().post({
                message: '请选择一条记录',//提示信息
                type: 'error',//消息类型。error、info、success
                hideAfter: 4,
                hideOnNavigate: true
            });

        } else {
            initUserRoleTable(rowData[0].roleId);
        }
    }
    function openAddModel() {
        $("#rolefm input").val("");
        $('#rolefm').data('bootstrapValidator').resetForm(true);
        $('#myModal').modal('show');
        $("#myModalLabel").html('新增角色');
        url = '${ctx}/role/addRole.htm';
    }
    function openEditModel() {
        var rowData = $("#roleTable").bootstrapTable('getSelections', function (row) {
            return row;
        });
        if (rowData.length != 1) {
            $.globalMessenger().post({
                message: '请选择一条记录',//提示信息
                type: 'error',//消息类型。error、info、success
                hideAfter: 4,
                hideOnNavigate: true
            });

        } else {
            $("#rolefm input").val("");
            $('#rolefm').data('bootstrapValidator').resetForm(true);
            $('#myModal').modal('show');
            $("#myModalLabel").html('修改角色');
            url = '${ctx}/role/modifyRole.htm';

            $("#fmRoleId").val(rowData[0].roleId);
            $("#ifRoleName").val(rowData[0].roleName);
        }
    }
    function openDeleteModel() {
        var rowData = $("#roleTable").bootstrapTable('getSelections', function (row) {
            return row;
        });
        if (rowData.length != 1) {
            $.globalMessenger().post({
                message: '请选择一条记录',//提示信息
                type: 'error',//消息类型。error、info、success
                hideAfter: 4,
                hideOnNavigate: true
            });

        } else {
            BootstrapDialog.confirm({
                title: '删除',
                message: '确定删除角色[' + rowData[0].roleName + '] 吗?',
                type: BootstrapDialog.TYPE_PRIMARY, // <-- Default value is
                closable: true, // <-- Default value is false，点击对话框以外的页面内容可关闭
                draggable: true, // <-- Default value is false，可拖拽
                btnCancelLabel: '取消', // <-- Default value is 'Cancel',
                btnOKLabel: '确定', // <-- Default value is 'OK',
                size: BootstrapDialog.SIZE_SMALL,
                // 对话框关闭的时候执行方法
                callback: function (result) {
                    // 点击确定按钮时，result为true
                    if (result) {
                        $.ajax({
                            url: '${ctx}/role/deleteRole.htm',
                            type: 'POST',//PUT DELETE POST
                            dataType: "json",
                            data: {'roleId': rowData[0].roleId},
                            success: function (data) {
//                                var data = JSON.parse(data);

                                if (data.result == 1) {
                                    initTable();
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
                }
            });
        }
    }


    function save() {
        var bootstrapValidator = $("#rolefm").data('bootstrapValidator');
        bootstrapValidator.validate();
        if (bootstrapValidator.isValid()) {
            $.ajax({
                url: url,
                async: true,//同步，会阻塞操作
                type: 'POST',//PUT DELETE POST
                data: $("#rolefm").serialize(),
                dataType: "json",
                success: function (data) {
                    if (data.result == 1) {
                        $('#myModal').modal('hide');
                        initTable();
                    } else {
                        $.globalMessenger().post({
                            message: data.msg,//提示信息
                            type: 'error',//消息类型。error、info、success
                            hideAfter: 4,
//                            showCloseButton:true,
                            hideOnNavigate: true
                        });
                    }
                }
            })
        } else {
            return;
        }
    }


    $(document).ready(function () {
        //调用函数，初始化表格
        initTable();

        //当点击查询按钮的时候执行
        $('#rolefm').bootstrapValidator({
            message: 'This value is not valid',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                roleName: {
                    message: '角色名验证失败',
                    validators: {
                        notEmpty: {
                            message: '角色名不能为空'
                        },
                        stringLength: {
                            min: 1,
                            max: 32,
                            message: '角色名长度必须小于32'
                        }
                    }
                },
            }
        });
    });
    function initTable() {
        //先销毁表格
        $('#roleTable').bootstrapTable('destroy');
        //初始化表格,动态从服务器加载数据
        $("#roleTable").bootstrapTable({
            url: '${ctx}/role/queryAllRole.htm', //获取数据的Servlet地址
            striped: true,  //表格显示条纹
            locale: 'zh-CN',
            clickToSelect: true,
            singleSelect: true,
            method: 'post',
            contentType: 'application/x-www-form-urlencoded',
            cache: false,
            pageNumber: 1,
            checkboxHeader: true,
            smartDisplay: false,
            sortName: 'role_id',
            sortable: false,
            pageSize: 10,
            pageList: [10, 25, 50],
            toolbar: '#toolbar',
//            showToggle: true,
            pagination: true, //启动分页
//            showPaginationSwitch: true,
            search: false,  //是否启用查询
//            showColumns: true,  //显示下拉框勾选要显示的列
            showRefresh: true,  //显示刷新按钮
            sidePagination: "server", //表示服务端请求
            queryParamsType: "undefined",
            responseHandler: function (res) {
                if (res.result == 0) {
                    $.globalMessenger().post({
                        message: res.msg,//提示信息
                        type: 'error',//消息类型。error、info、success
                        hideAfter: 4,
//                            showCloseButton:true,
                        hideOnNavigate: true
                    });
                    return {};
                }
                return res.data;
            },
            onClickRow: function (item, $element) {
                $('.info').removeClass('info');//去除之前选中的行的，选中样式
                $element.toggleClass('info');//添加当前选中的 success样式用于区别
                return false;
            },
            onCheck: function (row) {

                $("#roleUserSpan").html("<h3 style='margin-top: 0px;'>【" + row.roleName + "】</h3>");
                initUserRoleTable(row.roleId);

            },
            columns: [[{
                checkbox: true
            }, {
                field: 'roleId',
                title: '编号',
                visible: false
            }, {
                field: 'roleName',
                title: '角色名称',
                width: '40%',
                align: 'left',
                halign: 'center',
            }, {
                field: 'createTime',
                title: '创建时间',
                width: '30%',
                align: 'left',
                halign: 'center',
                formatter: function (value, row, index) {
                    return new Date(value).format("yyyy-MM-dd HH:mm:ss");
                }
            }, {
                field: 'updateTime',
                title: '更新时间',
                width: '30%',
                align: 'left',
                halign: 'center',
                formatter: function (value, row, index) {
                    return new Date(value).format("yyyy-MM-dd HH:mm:ss");
                }
            }]]
        });
    }

    function initUserRoleTable(roleId) {
        //先销毁表格
        $('#userTable').bootstrapTable('destroy');
        //初始化表格,动态从服务器加载数据
        $("#userTable").bootstrapTable({
            url: "${ctx}/employee/queryEmployeesByRoleId.htm", //获取数据的Servlet地址
            striped: true,  //表格显示条纹
            locale: 'zh-CN',
            clickToSelect: true,
            singleSelect: true,
            method: 'post',
            contentType: 'application/x-www-form-urlencoded',
            cache: false,
            pageNumber: 1,
            checkboxHeader: true,
            smartDisplay: false,
            sortName: 'employee_Id',
            sortable: false,
            pageSize: 10,
            pageList: [10, 25, 50],
//            toolbar: '#rolespan',
//            showToggle: true,
            pagination: true, //启动分页
//            showPaginationSwitch: true,
            search: false,  //是否启用查询
//            showColumns: true,  //显示下拉框勾选要显示的列
//            showRefresh: true,  //显示刷新按钮
            sidePagination: "server", //表示服务端请求
            //设置为undefined可以获取pageNumber，pageSize，searchText，sortName，sortOrder
            //设置为limit可以获取limit, offset, search, sort, order
            queryParamsType: "undefined",
            responseHandler: function (res) {
                if (res.result == 0) {
                    $.globalMessenger().post({
                        message: res.msg,//提示信息
                        type: 'error',//消息类型。error、info、success
                        hideAfter: 4,
//                            showCloseButton:true,
                        hideOnNavigate: true
                    });
                    return {};
                }
                return res.data;
            },
            columns: [[{
                checkbox: true,
//                width: '10%',
            }, {
                field: 'userRoleId',
//                title: '编号',
                visible: false
            }, {
                field: 'employeeId',
//                title: '编号',
                visible: false
            }, {
                field: 'userId',
                title: '用户名称',
//                width: '10%',
                align: 'left',
                halign: 'center'
            }, {
                field: 'name',
                title: '员工姓名',
                align: 'left',
                halign: 'center'
//                width: '10%',
            }, {
                field: 'type',
                title: '员工类型',
//                width: '5%',
                align: 'left',
                halign: 'center',
                formatter: function (value, row, index) {
                    if (value == '01') {
                        return "保洁员";
                    } else if (value == '02') {
                        return "销售";
                    } else if (value == '03') {
                        return "财务";
                    } else if (value == '04') {
                        return "客服";
                    }
                }
            }, {
                field: 'state',
                title: '是否在职',
//                width: '5%',
                align: 'left',
                halign: 'center',
                formatter: function (value, row, index) {
                    if (value == '01') {
                        return "在职";
                    } else {
                        return "离职";
                    }
                }

            }]],
            onClickRow: function (item, $element) {
                $('.info').removeClass('info');//去除之前选中的行的，选中样式
                $element.toggleClass('info');//添加当前选中的 success样式用于区别
                return false;
            },
            queryParams: function queryParams(params) {   //设置查询参数
                var requestPage = {
                    pageNumber: params.pageNumber,
                    pageSize: params.pageSize,
                    sortName: params.sortName,
                    sortOrder: params.sortOrder,

                    userId: $("#userId").val(),
                    name: $("#name").val(),
                    roleId: roleId
                };
                return requestPage;
            },
        });
    }


    function initUserTable() {
        //先销毁表格
        $('#userInfoTable').bootstrapTable('destroy');
        //初始化表格,动态从服务器加载数据
        $("#userInfoTable").bootstrapTable({
            url: "${ctx}/employee/queryEmployeesForRole.htm", //获取数据的Servlet地址
            striped: true,  //表格显示条纹
            locale: 'zh-CN',
            clickToSelect: true,
            singleSelect: true,
            method: 'post',
            contentType: 'application/x-www-form-urlencoded',
            cache: false,
            pageNumber: 1,
            checkboxHeader: true,
            smartDisplay: false,
            smartDisplay: false,
            sortName: 'employee_Id',
            pageSize: 5,
//            pageList: [10, 25, 50],
//            toolbar: '#rolespan',
//            showToggle: true,
            pagination: true, //启动分页
//            showPaginationSwitch: true,
            search: false,  //是否启用查询
//            showColumns: true,  //显示下拉框勾选要显示的列
//            showRefresh: true,  //显示刷新按钮
            sidePagination: "server", //表示服务端请求
            //设置为undefined可以获取pageNumber，pageSize，searchText，sortName，sortOrder
            //设置为limit可以获取limit, offset, search, sort, order
            queryParamsType: "undefined",
            responseHandler: function (res) {
                if (res.result == 0) {
                    $.globalMessenger().post({
                        message: res.msg,//提示信息
                        type: 'error',//消息类型。error、info、success
                        hideAfter: 4,
//                            showCloseButton:true,
                        hideOnNavigate: true
                    });
                    return {};
                }
                return res.data;
            },
            columns: [[{
                checkbox: true,
//                width: '10%',
            }, {
                field: 'employeeId',
//                title: '编号',
                visible: false
            }, {
                field: 'userId',
                title: '用户名称',
//                width: '10%',
                align: 'left',
                halign: 'center',
            }, {
                field: 'name',
                title: '员工姓名',
//                width: '10%',
                align: 'left',
                halign: 'center',
            }, {
                field: 'type',
                title: '员工类型',
                align: 'left',
                halign: 'center',
                formatter: function (value, row, index) {
                    if (value == '01') {
                        return "保洁员";
                    } else if (value == '02') {
                        return "销售";
                    } else if (value == '03') {
                        return "财务";
                    } else if (value == '04') {
                        return "客服";
                    }
                }
            }, {
                field: 'state',
                title: '是否在职',
                align: 'left',
                halign: 'center',
                formatter: function (value, row, index) {
                    if (value == '01') {
                        return "在职";
                    } else {
                        return "离职";
                    }
                }

            }]],
            onClickRow: function (item, $element) {
                $('.info').removeClass('info');//去除之前选中的行的，选中样式
                $element.toggleClass('info');//添加当前选中的 success样式用于区别
                return false;
            },
            queryParams: function queryParams(params) {   //设置查询参数
                var requestPage = {
                    pageNumber: params.pageNumber,
                    pageSize: params.pageSize,
                    sortName: params.sortName,
                    sortOrder: params.sortOrder,

                    userId: $("#userIdSearch").val(),
                    name: $("#nameSearch").val(),
                    state: $("#stateSearch").val(),
                    type: $("#typeSearch").val(),
                };
                return requestPage;
            },
        });
    }
    
    function goIndex(){
    	loadPage("${ctx}/index/index.htm");
    }
</script>