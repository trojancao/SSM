<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="../common/taglibs.jsp" %>
<section class="content-header">
    <h1>
        活动管理
        <small>列表</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="javascript:void(0);" onclick="goIndex();"><i class="fa fa-dashboard"></i> 首页</a></li>
        <li><a href="#">订单管理</a></li>
        <li class="active">活动管理</li>
    </ol>
</section>
<section class="content">
    <div class="row">
        <div class="col-xs-12">
            <div class="box">
                <div class=" panel-default" id="searchDiv">
                    <div class="panel-body">
                        <form role="form" class="form-inline">
                            <div class="form-group" style="width: 100%;">
						                                活动名称:<select class="js-example-data-ajax form-control"></select>
						                                活动状态:<select class="form-control" id="dataFlag" panelHeight="auto" style="width: 150px;">
											<option value="">--请选择--</option>
											<option value="1">有效</option>
											<option value="-1">无效</option>
						               </select>
				               <div class="btn-group" style="float: right;">
				                   <button type="button" class="btn btn-primary" id="search">查询</button>
				                   <button type="reset" class="btn btn-default" id="reset">重置</button>
				               </div>
                            </div>
                        </form>
                    </div>
                </div>

                <div class="box-body">
                    <div id="toolbar" class="btn-group">
                        <button id="btn_add" type="button" class="btn btn-default" data-toggle="modal">
                            <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
                        </button>
                        <!-- <button id="btn_edit" type="button" class="btn btn-default">
                            <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改
                        </button> -->
                        <button id="btn_delete" type="button" class="btn btn-default">
                            <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>停用
                        </button>
                        <button id="btn_open" type="button" class="btn btn-default">
                            <span class="glyphicon glyphicon-open" aria-hidden="true"></span>启用
                        </button>
                    </div>
                    <table id="activity_table" class="table table-bordered table-striped table-hover">
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
<div class="modal fade" id="myModal" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">模态框（Modal）标题</h4>
            </div>
            <form id="activityfm" method="post" role="activityfm" class="form-horizontal" >
                <div class="modal-body">
                    <input id="fmActivityId" name="activityId" type="hidden">
                    <input id="fmRuleId" name="ruleId" type="hidden">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">活动名称:</label>
                        <div class="col-md-4">
                            <input name="activityName" id="fmActivityName" type="text" class="form-control" maxlength="20">
                        </div>
                        <label class="col-sm-2 control-label">活动类型:</label>
                        <div class="col-md-4">
                            <select class="form-control" name="activityType" id="fmActivityType">
                                <option value="1" selected>套餐增加次数</option>
								<option value="2">赠品增加次数</option>
<!-- 								<option value="3">折扣</option> -->
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">增加次数:</label>
                        <div class="col-md-4">
                            <input id="fmCount" name="count" class="form-control">
                        </div>
                        <!-- <label class="col-sm-2 control-label">折扣率:</label>
                        <div class="col-md-4">
                            <input id="fmRebate" name="rebate" class="form-control">
                        </div> -->
                        <label class="col-sm-2 control-label">是否有效:</label>
                        <div class="col-md-4">
                            <select class="form-control" name="dataFlag" id="fmDataFlag">
                                <option value="1" selected>有效</option>
								<option value="-1">无效</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">备注:</label>
                        <div class="col-sm-10">
                            <textarea name="activityRemarks" class="form-control" id="fmActivityRemarks"
								style="height: 90px;"></textarea>
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
        $('#activity_table').bootstrapTable('destroy');
        //初始化表格,动态从服务器加载数据
        $("#activity_table").bootstrapTable({
            url: "${ctx}/activity/queryActivitys.htm", //获取数据的Servlet地址
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
            columns: [[{ checkbox: true
            }, {
                field: 'activityId',
//                title: '编号',
                visible: false
            },{
    			field : 'activityName',
    			title : '活动名称',
    			sortable : false,
    		}, {
    			field : 'activityType',
    			title : '活动类型',
    			formatter : function(value, row, index) {
    				if(value=='1'){
    					return "套餐增加次数";
    				}else if(value=='2'){
    					return "赠品增加次数";
    				}else if(value=='3'){
    					return "折扣率";
    				}
    			}
    		},{
    			field : 'count',
    			title : '增加次数',
    		}, {
    			field : 'dataFlag',
    			title : '套餐状态',
    			formatter : function(value, row, index) {
    				if(value=='1'){
    					return "有效";
    				}else if(value=='-1'){
    					return "无效";
    				}
    			}
    		}, {
    			field : 'activityRemarks',
    			title : '备注',
    		}]],
            queryParams: function queryParams(params) {   //设置查询参数
                var requestPage = {
                    pageNumber: params.pageNumber,
                    pageSize: params.pageSize,
                    activityId: $(".js-example-data-ajax").select2("val"),
                    dataFlag: $("#dataFlag").val()
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
        $("#search").bind("click", initTable);
        $("#btn_add").bind("click", openAddModel);
 /*        $("#btn_edit").bind("click", openEditModel); */
        $("#btn_delete").bind("click", openDeleteModel);
        $("#btn_open").bind("click", openOpenModel);
        $('#activityfm').bootstrapValidator({
            message: 'This value is not valid',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
//            submitButtons: 'button[type="submit"]',
            fields: {
                activityName: {
                    validators: {
                        notEmpty: {
                            message: '规则名称不能为空'
                        },
                        stringLength: {
                            min: 1,
                            max: 40,
                            message: '规则名称长度必须在1到40位之间'
                        },
                    }
                },
                activityType:{
                    validators: {
                        notEmpty: {
                            message: '请选择活动类型'
                        },
                    }
                },
                count: {
                    validators: {
                    	notEmpty: {
                            message: '增加次数不能为空'
                        },
                        regexp: {
                            regexp: /^[1-9]\d*$/,
                            message: '请输入正确的服务增加'
                        }
                    }
                },
                dataFlag:{
                    validators: {
                        notEmpty: {
                            message: '请选择是否有效'
                        },
                    }
                }
            }
        });

    });


    function openDeleteModel() {
        var rowData = $("#activity_table").bootstrapTable('getSelections',function(row){return row;});
        if(rowData.length != 1) {
            $.globalMessenger().post({
                message: '请选择一条记录',//提示信息
                type: 'error',//消息类型。error、info、success
                hideAfter: 4,
                hideOnNavigate: true
            });
            return;
        }
        if(rowData[0].dataFlag == -1) {
            $.globalMessenger().post({
                message: '该活动已停用',//提示信息
                type: 'error',//消息类型。error、info、success
                hideAfter: 4,
                hideOnNavigate: true
            });
            return;
        }
        BootstrapDialog.confirm({
            title : '确认',
            message : '活动停用后，现有的合同、订单不会受到影响，但以后将无法购买此活动。确定停用活动['+rowData[0].activityName+']吗?',
            type : BootstrapDialog.TYPE_PRIMARY, // <-- Default value is
            closable : true, // <-- Default value is false，点击对话框以外的页面内容可关闭
            draggable : true, // <-- Default value is false，可拖拽
            btnCancelLabel : '取消', // <-- Default value is 'Cancel',
            btnOKLabel : '确定', // <-- Default value is 'OK',
            size : BootstrapDialog.SIZE_SMALL,
            // 对话框关闭的时候执行方法
            callback : function(result) {
                // 点击确定按钮时，result为true
                if (result) {
                    $.ajax({
                        url: '${ctx}/activity/deleteActivitys.htm',
                        dataType: "json",
                        type: 'POST',//PUT DELETE POST
                        data:{'activityId':rowData[0].activityId,'dataFlag':'-1' },
                        success: function (result) {
                            if (result.result == 1) {
                                initTable();
                            } else {
                                $.globalMessenger().post({
                                    message: result.msg,//提示信息
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
    
    function openOpenModel() {
        var rowData = $("#activity_table").bootstrapTable('getSelections',function(row){return row;});
        if(rowData.length != 1) {
            $.globalMessenger().post({
                message: '请选择一条记录',//提示信息
                type: 'error',//消息类型。error、info、success
                hideAfter: 4,
                hideOnNavigate: true
            });
            return;
        }
        if(rowData[0].dataFlag == 1) {
            $.globalMessenger().post({
                message: '该活动已启用',//提示信息
                type: 'error',//消息类型。error、info、success
                hideAfter: 4,
                hideOnNavigate: true
            });
            return;
        }
        BootstrapDialog.confirm({
            title : '确认',
            message : '确定启用活动['+rowData[0].activityName+']吗?',
            type : BootstrapDialog.TYPE_PRIMARY, // <-- Default value is
            closable : true, // <-- Default value is false，点击对话框以外的页面内容可关闭
            draggable : true, // <-- Default value is false，可拖拽
            btnCancelLabel : '取消', // <-- Default value is 'Cancel',
            btnOKLabel : '确定', // <-- Default value is 'OK',
            size : BootstrapDialog.SIZE_SMALL,
            // 对话框关闭的时候执行方法
            callback : function(result) {
                // 点击确定按钮时，result为true
                if (result) {
                    $.ajax({
                        url: '${ctx}/activity/deleteActivitys.htm',
                        dataType: "json",
                        type: 'POST',//PUT DELETE POST
                        data:{'activityId':rowData[0].activityId,'dataFlag':'1' },
                        success: function (result) {
                            if (result.result == 1) {
                                initTable();
                            } else {
                                $.globalMessenger().post({
                                    message: result.msg,//提示信息
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
    
    function openAddModel() {
        $("#activityfm input").val("");
        $('#activityfm').data('bootstrapValidator').resetForm(true);
        $('#myModal').modal('show');
        $("#myModalLabel").html('新增套餐信息');
        url = '${ctx}/activity/addActivitys.htm';
    }
    function openEditModel() {
        var rowData = $("#activity_table").bootstrapTable('getSelections',function(row){return row;});
        if(rowData.length != 1){
            $.globalMessenger().post({
                message: '请选择一条记录',//提示信息
                type: 'error',//消息类型。error、info、success
                hideAfter: 4,
                hideOnNavigate: true
            });
			
        }else{
            BootstrapDialog.confirm({
                title : '确认',
                message : '套餐修改后，现有的相关合同、订单也将受到影响。确定修改套餐['+rowData[0].activityName+']吗?',
                type : BootstrapDialog.TYPE_PRIMARY, // <-- Default value is
                closable : true, // <-- Default value is false，点击对话框以外的页面内容可关闭
                draggable : true, // <-- Default value is false，可拖拽
                btnCancelLabel : '取消', // <-- Default value is 'Cancel',
                btnOKLabel : '确定', // <-- Default value is 'OK',
                size : BootstrapDialog.SIZE_SMALL,
                // 对话框关闭的时候执行方法
                callback : function(result) {
                    // 点击确定按钮时，result为true
                    if (result) {
                    	$('#activityfm').data('bootstrapValidator').resetForm(true);
                        $('#myModal').modal('show');
                        $("#myModalLabel").html('修改套餐信息');
                        url = '${ctx}/activity/modifyActivitys.htm';
                        
                    	$("#fmActivityId").val(rowData[0].activityId);
                    	$("#fmActivityAmount").val(rowData[0].activityAmount);
                    	$("#fmActivityName").val(rowData[0].activityName);
                    	$("#fmServiceCount").val(rowData[0].serviceCount);
                    	$("#fmServiceTime").val(rowData[0].serviceTime);
                    	$("#fmSaleRate").val(rowData[0].saleRate);
                    	$("#fmState").val(rowData[0].dataFlag);
                    }
                }
            });
        	
        }


    }

    function save() {
        var bootstrapValidator = $("#activityfm").data('bootstrapValidator');
        bootstrapValidator.validate();
        if (bootstrapValidator.isValid()) {
            $.ajax({
                url: url,
                async: true,//同步，会阻塞操作
                dataType: "json",
                type: 'POST',//PUT DELETE POST
                data: $("#activityfm").serialize(),
                success: function (result) {
                    if (result.result == 1) {
                        $('#myModal').modal('hide');
                        initTable();
                    } else {
                        $.globalMessenger().post({
                            message: result.msg,//提示信息
                            type: 'error',//消息类型。error、info、success
                            hideAfter: 4,
//                            showCloseButton:true,
                            hideOnNavigate: true
                        });
                    }
                }
            })
        } else
            {
                return;
            }
        }


	$(".js-example-data-ajax").select2({
  	  ajax: {
  	    url: "${ctx}/activity/queryActivitys.htm",
  	    dataType: 'json',
  	    delay: 250,
  	    data: function (params) {
  	    	console.log(params);
  	      return {
  	    	
  	    	activityName: encodeURI(params.term), // search term
  	        pageNumber: params.page,
  	        pageSize: 10
  	      };
  	    },
  	    processResults: function (data, params) {
  	      // parse the results into the format expected by Select2
  	      // since we are using custom formatting functions we do not need to
  	      // alter the remote JSON data, except to indicate that infinite
  	      // scrolling can be used
  	      params.page = params.page || 1;
  	   
          //data is an array of results
           (data.data.rows).forEach(function (d, activityId) {
               //Just assign a unique number or your own unique id
               console.log(d);
               console.log(d.activityId);
               d.id = d.activityId; // or e.id = e.userId;
           })
                	   console.log(data.data.rows);

  	      return {
  	        results: data.data.rows,
  	        pagination: {
  	          more: (params.page * 10) < data.data.total
  	        }
  	      };
  	    },
  	    cache: true
  	  },
      width: "200px", //设置下拉框的宽度
      placeholder: "请选择",
      language: "zh-CN",         //中文
      allowClear: true,    //选中之后，可手动点击删除  
  	  escapeMarkup: function (markup) { return markup; }, // let our custom formatter work
  	  minimumInputLength: 1,
  	  templateResult: formatRepo,
  	  templateSelection: formatRepoSelection
  	});
	
  
  	function formatRepo (repo) {
  	  if (repo.loading) {
  	    return repo.text;
  	  }
		var markup="<div class='select2-result-repository__meta'>";
		/* markup += "<div class='select2-result-repository__description'>" + repo.activityId + "</div>"+
	      "<div class='select2-result-repository__title'>" + repo.activityName + "</div>"; */
		markup += '<div class="clearfix">' +  
		"<div class='select2-result-repository__stargazers'><i class='fa fa-star'></i> " + repo.activityName + "</div>" +
/* 	    "<div class='select2-result-repository__forks'><i class='fa fa-flash'></i> " + repo.activityId+ "</div>" +
	    "<div class='select2-result-repository__watchers'><i class='fa fa-eye'></i> " + repo.activityName + "</div>" + */
	    '</div></div>';  

  	  return markup;
  	}

  	function formatRepoSelection (repo) {
  		return repo.activityName || repo.text;
  	}
</script>