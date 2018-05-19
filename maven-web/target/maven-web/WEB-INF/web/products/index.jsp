<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="../common/taglibs.jsp" %>
<section class="content-header">
    <h1>
        套餐管理
        <small>列表</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="javascript:void(0);" onclick="goIndex();"><i class="fa fa-dashboard"></i> 首页</a></li>
        <li><a href="#">订单管理</a></li>
        <li class="active">套餐管理</li>
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
						                                套餐名称:<select class="js-example-data-ajax form-control"></select>
						                                套餐状态:<select class="form-control" id="state" panelHeight="auto" style="width: 150px;">
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
                    <table id="product_table" class="table table-bordered table-striped table-hover">
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
            <form id="productfm" method="post" role="productfm" class="form-horizontal" >
                <div class="modal-body">
                    <input id="fmProductId" name="productId" type="hidden">
                    <input id="fmRuleId" name="ruleId" type="hidden">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">套餐名称:</label>
                        <div class="col-md-4">
                            <input name="productName" id="fmProductName" type="text" class="form-control" maxlength="20">
                        </div>
                        <label class="col-sm-2 control-label">套餐金额:</label>
                        <div class="col-md-4">
                            <input name="productAmount" id="fmProductAmount" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">服务次数:</label>
                        <div class="col-md-4">
                            <input id="fmServiceCount" name="serviceCount" class="form-control">
                        </div>
                        <label class="col-sm-2 control-label">每次服务时长(h):</label>
                        <div class="col-md-4">
                            <input id="fmServiceTime" name="serviceTime" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">销售费率:</label>
                        <div class="col-md-4">
                            <input id="fmSaleRate" name="saleRate" class="form-control">
                        </div>
                        <label class="col-sm-2 control-label">是否有效:</label>
                        <div class="col-md-4">
                            <select class="form-control" name="state" id="fmState">
                                <option value="1" selected>有效</option>
								<option value="-1">无效</option>
                            </select>
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
        $('#product_table').bootstrapTable('destroy');
        //初始化表格,动态从服务器加载数据
        $("#product_table").bootstrapTable({
            url: "${ctx}/product/queryProducts.htm", //获取数据的Servlet地址
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
                field: 'productId',
//                title: '编号',
                visible: false
            },{
    			field : 'productName',
    			title : '套餐名称',
    			sortable : false,
    		}, {
    			field : 'productAmount',
    			title : '套餐金额',
    			formatter : function(value, row, index) {
    				return value.toFixed(2);
    			}
    		}, {
    			field : 'serviceTime',
    			title : '每次服务时间',
    			formatter : function(value, row, index) {
    				return value.toFixed(2) + "小时"
    			}
    		},{
    			field : 'serviceCount',
    			title : '服务次数',
    		},{
    			field : 'saleRate',
    			title : '销售费率',
    			formatter : function(value, row, index) {
    				return (value*100).toFixed(2) + "%";
    			}
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
    		}]],
            queryParams: function queryParams(params) {   //设置查询参数
                var requestPage = {
                    pageNumber: params.pageNumber,
                    pageSize: params.pageSize,
                    productId: $(".js-example-data-ajax").select2("val"),
                    dataFlag: $("#state").val()
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
        $('#productfm').bootstrapValidator({
            message: 'This value is not valid',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
//            submitButtons: 'button[type="submit"]',
            fields: {
                productName: {
                    validators: {
                        notEmpty: {
                            message: '套餐名称不能为空'
                        },
                        stringLength: {
                            min: 1,
                            max: 40,
                            message: '套餐名称长度必须在1到40位之间'
                        },
                    }
                },
                productAmount: {
                    validators: {
                        notEmpty: {
                            message: '套餐金额不能为空'
                        },
                        regexp: {
                            regexp: /(^[1-9]\d{0,7}(\.\d{1,2})?$)|(^(0){1}$)|(^\d\.\d{1,2}?$)/,
                            message: '请输入正确的套餐金额'
                        }
                    }
                },
                serviceTime: {
                    validators: {
                        notEmpty: {
                            message: '每次服务时长不能为空'
                        },
                        regexp: {
                            regexp: /(^[1-9]\d{0,7}(\.\d{1,2})?$)|(^(0){1}$)|(^\d\.\d{1,2}?$)/,
                            message: '请输入正确的服务时长'
                        }
                    }
                },
                serviceCount: {
                    validators: {
                        notEmpty: {
                            message: '服务次数不能为空'
                        },
                        regexp: {
                            regexp: /^[1-9]\d*$/,
                            message: '请输入正确的服务次数'
                        }

                    }
                },
                saleRate:{
                    validators: {
                        notEmpty: {
                            message: '销售费率不能为空'
                        },
                        regexp: {
                            regexp: /^[0]\.\d{0,1}[1-9]$/,
                            message: '请输入正确的销售费率'
                        }

                    }

                },
                state:{
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
        var rowData = $("#product_table").bootstrapTable('getSelections',function(row){return row;});
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
                message: '该套餐已停用',//提示信息
                type: 'error',//消息类型。error、info、success
                hideAfter: 4,
                hideOnNavigate: true
            });
            return;
        }
        BootstrapDialog.confirm({
            title : '确认',
            message : '套餐停用后，现有的合同、订单不会受到影响，但以后将无法购买此套餐。确定停用套餐['+rowData[0].productName+']吗?',
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
                        url: '${ctx}/product/deleteProducts.htm',
                        dataType: "json",
                        type: 'POST',//PUT DELETE POST
                        data:{'productId':rowData[0].productId,'dataFlag':'-1' },
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
        var rowData = $("#product_table").bootstrapTable('getSelections',function(row){return row;});
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
                message: '该套餐已启用',//提示信息
                type: 'error',//消息类型。error、info、success
                hideAfter: 4,
                hideOnNavigate: true
            });
            return;
        }
        BootstrapDialog.confirm({
            title : '确认',
            message : '确定启用套餐['+rowData[0].productName+']吗?',
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
                        url: '${ctx}/product/deleteProducts.htm',
                        dataType: "json",
                        type: 'POST',//PUT DELETE POST
                        data:{'productId':rowData[0].productId,'dataFlag':'1' },
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
        $("#productfm input").val("");
        $('#productfm').data('bootstrapValidator').resetForm(true);
        $('#myModal').modal('show');
        $("#myModalLabel").html('新增套餐信息');
        url = '${ctx}/product/addProducts.htm';
    }
    function openEditModel() {
        var rowData = $("#product_table").bootstrapTable('getSelections',function(row){return row;});
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
                message : '套餐修改后，现有的相关合同、订单也将受到影响。确定修改套餐['+rowData[0].productName+']吗?',
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
                    	$('#productfm').data('bootstrapValidator').resetForm(true);
                        $('#myModal').modal('show');
                        $("#myModalLabel").html('修改套餐信息');
                        url = '${ctx}/product/modifyProducts.htm';
                        
                    	$("#fmProductId").val(rowData[0].productId);
                    	$("#fmProductAmount").val(rowData[0].productAmount);
                    	$("#fmProductName").val(rowData[0].productName);
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
        var bootstrapValidator = $("#productfm").data('bootstrapValidator');
        bootstrapValidator.validate();
        if (bootstrapValidator.isValid()) {
            $.ajax({
                url: url,
                async: true,//同步，会阻塞操作
                dataType: "json",
                type: 'POST',//PUT DELETE POST
                data: $("#productfm").serialize(),
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
  	    url: "${ctx}/product/queryProducts.htm",
  	    dataType: 'json',
  	    delay: 250,
  	    data: function (params) {
  	    	console.log(params);
  	      return {
  	    	
  	    	productName: encodeURI(params.term), // search term
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
           (data.data.rows).forEach(function (d, productId) {
               //Just assign a unique number or your own unique id
               console.log(d);
               console.log(d.productId);
               d.id = d.productId; // or e.id = e.userId;
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
		/* markup += "<div class='select2-result-repository__description'>" + repo.productId + "</div>"+
	      "<div class='select2-result-repository__title'>" + repo.productName + "</div>"; */
		markup += '<div class="clearfix">' +  
		"<div class='select2-result-repository__stargazers'><i class='fa fa-star'></i> " + repo.productName + "</div>" +
/* 	    "<div class='select2-result-repository__forks'><i class='fa fa-flash'></i> " + repo.productId+ "</div>" +
	    "<div class='select2-result-repository__watchers'><i class='fa fa-eye'></i> " + repo.productName + "</div>" + */
	    '</div></div>';  

  	  return markup;
  	}

  	function formatRepoSelection (repo) {
  		return repo.productName || repo.text;
  	}
</script>