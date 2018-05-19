<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="../common/taglibs.jsp" %>
<section class="content-header">
    <h1>
        员工信息
        <small>列表</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="javascript:void(0);" onclick="goIndex();"><i class="fa fa-dashboard"></i> 首页</a></li>
        <li><a href="#">部门管理</a></li>
        <li class="active">员工管理</li>
    </ol>
</section>

<section class="content">
    <div class="row">
        <div class="col-xs-12">
            <div class="box">
                <div class=" panel-default" id="searchDiv">
                    <div class="panel-body">
                        <form role="form" class="form-inline">
                            <div class="form-group">
                                用户名:<input id="userId" class="form-control" type="text"
                                            style="width: 100px;">
                                员工姓名:<input id="name" class="form-control" type="text"
                                            style="width: 100px;">
                                入职时间从:
                                <input type="text" id="entryDateFrom" readonly="readonly"
                                       style="width: 100px;" class="form-control datepicker">
                                到:
                                <input class="form-control datepicker" readonly="readonly"
                                       style="width: 100px;" id="entryDateTo" type="text">
                                职员类型:<select class="form-control" id="type" panelHeight="auto"
                                             style="width: 100px;">
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

                                在职状态: <select class="form-control" style="width: 100px;" id="state"
                                              panelHeight="auto">
                                <option value="">--请选择--</option>
                                <option value="01">在职</option>
                                <option value="02">离职</option>
                            </select>
                                <div class="btn-group">
                                    <button type="button" class="btn btn-primary" id="search" onclick="initTable()">查询</button>
                                    <button type="reset" class="btn btn-default" id="reset">重置</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <div class="box-body">
                    <div id="toolbar" class="btn-group">
                        <button id="btn_add" type="button" class="btn btn-default" data-toggle="modal" onclick="openAddModel()">
                            <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
                        </button>
                        <button id="btn_edit" type="button" class="btn btn-default" onclick="openEditModel()">
                            <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改
                        </button>
                       
                        <button id="btn_init" type="button" class="btn btn-default" onclick="initPassword()">
                            <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>初始化密码
                        </button>
                        <span style="color: red">（*初始密码：123456）</span>
                    </div>
                    <table id="user_table" class="table table-bordered table-striped table-hover">
                    </table>
                </div>

                <!-- /.box-body -->
            </div>
        </div>
        <!-- /.col -->
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
            <form id="employeefm" method="post" role="employeefm" class="form-horizontal">
                <div class="modal-body">
                    <input id="fmEmployeeId" name="employeeId" type="hidden">
                    <input id="fmAddressId" name="addressId" type="hidden">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">员工姓名:</label>
                        <div class="col-md-4">
                            <input name="name" id="fmName" type="text" class="form-control" maxlength="20">
                        </div>
                        <label class="col-sm-2 control-label">登陆名称:</label>
                        <div class="col-md-4">
                            <input id="fmUserId" name="userId" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">证件类型:</label>
                        <div class="col-md-4">
                            <select class="form-control" name="idType" id="fmIdType"  onchange="changeIdType()">
                                <option value="1">身份证</option>
                                <option value="2">户口簿</option>
                                <option value="3">军人证</option>
                                <option value="4">武警证</option>
                                <option value="5">回乡证</option>
                                <option value="6">港澳台通行证</option>
                                <option value="7">护照</option>
                                <option value="8">临时身份证</option>
                            </select>
                        </div>
                        <label class="col-sm-2 control-label">电话号码:</label>
                        <div class="col-md-4">
                            <input name="phone" class="form-control" maxlength="20" id="fmPhone">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">证件号码:</label>
                        <div class="col-md-4">
                            <input name="idNo" class="form-control" id="fmIdNo">
                        </div>

                        <label class="col-sm-2 control-label">入职日期:</label>
                        <div class="col-md-4">
                        <input type="text" name="entryDateTmp" readonly="readonly" class="form-control datepicker">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">员工类型:</label>
                        <div class="col-md-4">
                            <select class="form-control" name="type" id="fmType">
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
                            <select class="form-control" name="state" id="fmState">
                                <option value="01">在职</option>
                                <option value="02">离职</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">地址:</label>
                        <div class="col-md-3">
                            <select class="form-control" name="province" id="province"
                                    onchange="getRegion(this.options[this.selectedIndex].value,'city')">
                            </select>
                        </div>
                        <div class="col-md-3">
                            <select class="form-control" name="city" id="city"
                                    onchange="getRegion(this.options[this.selectedIndex].value,'town')">
                            </select>
                        </div>
                        <div class="col-md-3">
                            <select class="form-control" name="town" id="town">
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">详细地址:</label>
                        <div class="col-md-10">
                            <input name="address" class="form-control" id="fmAddress"/>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" onclick="save()">保存</button>
                </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<script type="text/javascript">
    var url;
    $('.datepicker').datepicker({
        autoclose: true, format: "yyyy-mm-dd", language: "zh-CN", clearBtn: true,//清除按钮
        todayBtn: true,//今日按钮
    });
    function initTable() {
        //先销毁表格
        $('#user_table').bootstrapTable('destroy');
        //初始化表格,动态从服务器加载数据
        $("#user_table").bootstrapTable({
            url: "${ctx}/employee/queryEmployees.htm", //获取数据的Servlet地址
            striped: true,  //表格显示条纹
            locale: 'zh-CN',
            clickToSelect: true,
            singleSelect: true,
//            cardView: true,
            method: 'post',
            contentType: 'application/x-www-form-urlencoded',
            cache: false,
            pageNumber: 1,
            checkboxHeader: true,
            smartDisplay: false,
            sortName:'employee_Id',
            pageSize: 10,
            pageList: [10, 25, 50],
            toolbar: '#toolbar',
            showToggle: true,
            pagination: true, //启动分页
            showPaginationSwitch: true,
//            detailView:true,
            search: false,  //是否启用查询
            showColumns: true,  //显示下拉框勾选要显示的列
            showRefresh: true,  //显示刷新按钮
            sidePagination: "server", //表示服务端请求
            //设置为undefined可以获取pageNumber，pageSize，searchText，sortName，sortOrder
            //设置为limit可以获取limit, offset, search, sort, order
            queryParamsType: "undefined",
            responseHandler: function (res) {
                return res.data;
            },
            columns: [[{
                checkbox: true
            }, {
                field: 'employeeId',
//                title: '编号',
                visible: false
            }, {
                field: 'addressId',
                visible: false
            }, {
                field: 'province',
                visible: false
            }, {
                field: 'city',
                visible: false
            }, {
                field: 'town',
                visible: false
            }, {
                field: 'address',
                visible: false
            }, {
                field: 'userId',
                title: '用户名称',
                width: '10%',
                align:'left',
                halign:'center',
            }, {
                field: 'name',
                title: '员工姓名',
                width: '10%',
                align:'left',
                halign:'center',
            }, {
                field: 'idType',
                title: '证件类型',
                width: '5%',
                align:'left',
                halign:'center',
                formatter: function (value, row, index) {
                    if (value == '1') {
                        return "身份证";
                    } else if (value == '2') {
                        return "户口簿";
                    } else if (value == '3') {
                        return "军人证";
                    } else if (value == '4') {
                        return "武警证";
                    } else if (value == '5') {
                        return "回乡证";
                    } else if (value == '6') {
                        return "港澳台通行证";
                    } else if (value == '7') {
                        return "护照";
                    } else if (value == '8') {
                        return "临时身份证";
                    }
                }
            }, {
                field: 'idNo',
                title: '证件号码',
                width: '15%',
                align:'left',
                halign:'center',
            }, {
                field: 'phone',
                title: '电话号码',
                width: '10%',
                align:'left',
                halign:'center',
            }, {
                field: 'type',
                title: '员工类型',
                width: '5%',
                align:'left',
                halign:'center',
                formatter: function (value, row, index) {
                    if (value == '01') {
                        return "保洁员";
                    } else if (value == '02') {
                        return "销售";
                    } else if (value == '03') {
                        return "财务";
                    } else if (value == '04') {
                        return "客服";
                    } else if (value == '05') {
                        return "工程";
                    }else if (value == '06') {
                        return "培训师";
                    } else if (value == '07') {
                        return "销售主管";
                    } else if (value == '08') {
                        return "助理";
                    } else if (value == '09') {
                        return "售后";
                    } else if (value == '10') {
                        return "人事";
                    } else if (value == '11') {
                        return "美工";
                    }
                }
            }, {
                field: 'state',
                title: '是否在职',
                width: '5%',
                align:'left',
                halign:'center',
                formatter: function (value, row, index) {
                    if (value == '01') {
                        return "在职";
                    } else {
                        return "离职";
                    }
                }

            }, {
                field: 'addressName',
                width: '30%',
                title: '员工地址',
                align:'left',
                halign:'center',
            }, {
                field: 'entryDate',
                title: '入职日期',
                width: '10%',
                align:'left',
                halign:'center',
                formatter: function (value, row, index) {
                    return new Date(value).format("yyyy-MM-dd");
                }
            }]],
            queryParams: function queryParams(params) {   //设置查询参数
                var requestPage = {
                    pageNumber: params.pageNumber,
                    pageSize: params.pageSize,
                    sortName:params.sortName,
                    sortOrder:params.sortOrder,

                    name: $("#name").val(),
                    state: $("#state").val(),
                    entryDateFrom: $("#entryDateFrom").val(),
                    entryDateTo: $("#entryDateTo").val(),
                    type: $("#type").val(),
                    userId:$("#userId").val()
                };
                return requestPage;
            },
            onClickRow: function (item, $element) {
                $('.info').removeClass('info');//去除之前选中的行的，选中样式
                $element.toggleClass('info');//添加当前选中的 success样式用于区别
                return false;
            }
        });
    }

    $(document).ready(function () {
        //调用函数，初始化表格
        initTable();

        //当点击查询按钮的时候执行
        $('#employeefm').bootstrapValidator({
            message: 'This value is not valid',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                userId: {
                    message: '用户名验证失败',
                    validators: {
                        notEmpty: {
                            message: '用户名不能为空'
                        },
                        stringLength: {
                            min: 5,
                            max: 18,
                            message: '用户名长度必须在5到18位之间'
                        },
                        regexp: {
                            regexp: /^[a-zA-Z0-9_]+$/,
                            message: '用户名只能包含大写、小写、数字和下划线'
                        }
                    }
                },
                name: {
                    validators: {
                        notEmpty: {
                            message: '员工姓名不能为空'
                        },
                        stringLength: {
                            min: 1,
                            max: 10,
                            message: '员工姓名长度必须在1到10位之间'
                        },
                    }
                },
                idNo: {
                    validators: {
                        notEmpty: {
                            message: '证件号码不能为空'
                        },
                        callback: {
                            message: '请输入正确的身份证号',
                            callback: function (value, validator, $field) {
                                if('1' == $("#fmIdType").val()){
                                    var reg = /(^[1-9]\d{5}(18|19|([23]\d))\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$)|(^[1-9]\d{5}\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{2}$)/;
                                    return reg.test(value);
                                }else{
                                    return true;
                                }
                            }
                        },
                    }

                },
                phone: {
                    validators: {
                        notEmpty: {
                            message: '电话号码不能为空'
                        },
                        stringLength: {
                            min: 11,
                            max: 11,
                            message: '请输入11位手机号码'
                        },
                        regexp: {
                            regexp: /^1[3|5|8]{1}[0-9]{9}$/,
                            message: '请输入正确的手机号码'
                        }

                    }
                },
                province: {
                    validators: {
                        notEmpty: {
                            message: '请选择省'
                        },

                    }

                },
                city: {
                    validators: {
                        notEmpty: {
                            message: '请选择市'
                        },
                    }
                },
                address: {
                    validators: {
                        notEmpty: {
                            message: '详细地址不能为空'
                        },
                        stringLength: {
                            min: 1,
                            max: 80,
                            message: '详细地址长度必须在1到80位之间'
                        },
                    }
                }
            }
        });

    });

    function openAddModel() {
        $("#fmUserId").attr('disabled',false);
        $("#employeefm input").val("");
        $('#employeefm').data('bootstrapValidator').resetForm(true);
        $('#myModal').modal('show');
        $("#myModalLabel").html('新增员工信息');
        $("#city").empty();
        getRegion('0', 'province');
        url = '${ctx}/employee/addEmployees.htm';
    }
    function openEditModel() {
        var rowData = $("#user_table").bootstrapTable('getSelections', function (row) {
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
            $('#employeefm').data('bootstrapValidator').resetForm(true);
            $('#myModal').modal('show');
            $("#myModalLabel").html('修改员工信息');
            $("#city").empty();
            getRegion('0', 'province');
            url = '${ctx}/employee/modifyEmployees.htm';

            $("#fmName").val(rowData[0].name);
            $("#fmUserId").val(rowData[0].userId);
            $("#fmEmployeeId").val(rowData[0].employeeId);
            $("#fmAddressId").val(rowData[0].addressId);
            $("#fmIdType").val(rowData[0].idType);
            $("#fmIdNo").val(rowData[0].idNo);
            $("#fmState").val(rowData[0].state);
            $("#fmPhone").val(rowData[0].phone);
            $("#province").val(rowData[0].province);
            $("#fmAddress").val(rowData[0].address);

            $("#fmUserId").attr('disabled',true);

            getRegion($("#province").val(), 'city');
            getRegion(rowData[0].city, 'town');
            $("#city").val(rowData[0].city);
            $("#town").val(rowData[0].town);
        }
    }


    function initPassword(){
        var rowData = $("#user_table").bootstrapTable('getSelections', function (row) {
            return row;
        });
        if (rowData.length != 1) {
            $.globalMessenger().post({
                message: '请选择一条记录',//提示信息
                type: 'error',//消息类型。error、info、success
                hideAfter: 4,
                hideOnNavigate: true
            });

        }else{
            BootstrapDialog.confirm({
                title: '确认',
                message: '确定修改员工[' + rowData[0].name + ']的密码为<span style="color: red"> 123456</span> 吗?',
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
                            url: '${ctx}/employee/initEmployeesPasswd.htm',
                            type: 'POST',//PUT DELETE POST
                            data: {'employeeId': rowData[0].employeeId},
                            dataType: "json",
                            success: function (data) {
//                                var  data = JSON.parse(data);
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
        var bootstrapValidator = $("#employeefm").data('bootstrapValidator');
        bootstrapValidator.validate();
        if (bootstrapValidator.isValid()) {
            $.ajax({
                url: url,
                async: true,//同步，会阻塞操作
                type: 'POST',//PUT DELETE POST
                data: $("#employeefm").serialize(),
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

    function getRegion(areaId, divId) {
        $("#" + divId).empty();
        $("#town").empty();

        if(areaId == null || areaId==''){
            return;
        }
        $.ajax({
            type: 'post',
            url: '${ctx }/region/getRegion.htm',
            dataType: "json",
            async: false,
            data: {'areaId': areaId},
            success: function (data) {
                var depart_list = data;
                var opts = "<option value=''>---请选择---</option>";
                for (var depart_index = 0; depart_index < depart_list.length; depart_index++) {
                    var depart = depart_list[depart_index];
                    opts += "<option value='" + depart.regionCode + "'>" + depart.regionName + "</option>";
                }
                $("#" + divId).append(opts);

            }
        });
    }
    
    function changeIdType(){
        $("#employeefm").data('bootstrapValidator').updateStatus('idNo', 'NOT_VALIDATED').validateField('idNo');
    }
    
    function goIndex(){
    	loadPage("${ctx}/index/index.htm");
    }
</script>
