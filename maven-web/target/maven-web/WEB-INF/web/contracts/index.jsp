<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="../common/taglibs.jsp" %>
<style type="text/css">
.select2-container--default .select2-selection--multiple .select2-selection__choice{
    background-color: #f00;
}
</style>
<section class="content-header">
    <h1>
        	合同管理
        <small>列表</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="javascript:void(0);" onclick="goIndex();"><i class="fa fa-dashboard"></i> 首页</a></li>
        <li><a href="#">订单管理</a></li>
        <li class="active">合同管理</li>
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
						                                合同编号:<input id="contractId" class="form-control" type="text" style="width: 200px;" /> 
						                                签约时间从:
                                <input type="text" id="signDateFrom" readonly="readonly"
                                       style="width: 180px;" class="form-control datepicker">
								   到:
                                <input class="form-control datepicker" readonly="readonly"
                                       style="width: 180px;" id="signDateTo" type="text">
                            </div>
                            <div class="form-group" style="width: 100%; margin-top: 15px;">
                            	<span style="float: left;line-height: 28px;margin: 0px 4px;">套餐名称:</span>
                            	<span style="float: left;width: 200px;display: block;">
                            		<select class="js-example-data-ajax form-control" id="productId"></select>
                            	</span>
                               	<span style="float: left;line-height: 28px;margin: 0px 4px;">销售人员:</span>
                               	<span style="float: left;width: 200px;display: block;">
                              		<select class="js-example-data-ajax form-control" id="saleId"></select>
                              	</span>
                              	<span style="float: left;line-height: 28px;margin: 0px 4px;">客户名称:</span>
                              	<span style="float: left;width: 200px;display: block;">
                              		<select class="js-example-data-ajax form-control" id="custId"></select>
                              	</span>
				               
                            </div>
                            <div class="form-group" style="width: 100%; margin-top: 15px;">
								客户居住小区:<input id="zone" class="form-control" type="text"
									style="width: 250px;" /> 
								客户居住地址:<input id="address"
									class="form-control" type="text" style="width: 380px;" />
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
                        <button id="btn_edit" type="button" class="btn btn-default">
                            <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改
                        </button>
                        <button id="btn_browse" type="button" class="btn btn-default">
                            <span class="glyphicon glyphicon-search" aria-hidden="true"></span>浏览
                        </button>
                        <button id="btn_delete" type="button" class="btn btn-default">
                            <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除
                        </button>
                    </div>
                    <table id="contract_table" class="table table-bordered table-striped table-hover">
                    </table>
                </div>

                <!-- /.box-body -->
            </div>
        </div>
        <!-- /.col -->
    </div>
    <!-- /.row -->
</section>

<script type="text/javascript">
    var url;
    $('.datepicker').datepicker({
        autoclose: true, format: "yyyy-mm-dd", language: "zh-CN", clearBtn: true,//清除按钮
        todayBtn: true,//今日按钮
    });
    function initTable() {
        //先销毁表格
        $('#contract_table').bootstrapTable('destroy');
        //初始化表格,动态从服务器加载数据
        $("#contract_table").bootstrapTable({
            url: "${ctx}/contract/queryContracts.htm", //获取数据的Servlet地址
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
                field: 'contractId',
                title: '合同编号',
                sortable: false,
            },{
    			field : 'signDate',
    			title : '签约日期',
    			sortable : false,
    			formatter : function(value, row, index) {
					if (null != value && "" != value) {
						return new Date(value).format("yyyy-MM-dd");
					}
				}
    		}, {
    			field : 'saleName',
    			title : '销售人员',
    		}, {
    			field : 'custName',
    			title : '客户名称',
    		},{
    			field : 'productName',
    			title : '套餐名称',
    		},{
    			field : 'ruleName',
    			title : '规则名称',
    		},{
    			field : 'checkFlag',
    			title : '复核状态',
    			formatter : function(value, row, index) {
    				if(value=='-1'){
    					return "未复核";
    				}else if(value=='1'){
    					return "已复核";
    				}else if(value=='2'){
    					return "复核不通过";
    				}
    			}
    		}]],
            queryParams: function queryParams(params) {   //设置查询参数
                var requestPage = {
                    pageNumber: params.pageNumber,
                    pageSize: params.pageSize,
                    saleId: $("#saleId").val(),
                    custId: $("#custId").val(),
                    productId: $("#productId").val(),
                    //saleId: $("#saleId").select2().val()==null?"":$("#saleId").select2().val(),
                   // custId: $("#custId").select2().val()==null?"":$("#custId").select2().val(),
                   // productId: $("#productId").select2().val()==null?"":$("#productId").select2().val(),
                	contractId: $("#contractId").val(),
                    signDateFrom: $("#signDateFrom").val(),
                    signDateTo: $("#signDateTo").val(),
                    zone : $("#zone").val(),
					address : $("#address").val(),
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
        $("#btn_edit").bind("click", openEditModel);
        $("#btn_delete").bind("click", openDeleteModel);
        $("#btn_browse").bind("click", openBrowseModel);
        
    	function openDeleteModel() {
	        var rowData = $("#contract_table").bootstrapTable('getSelections',function(row){return row;});
	        if(rowData.length != 1) {
	            $.globalMessenger().post({
	                message: '请选择一条记录',//提示信息
	                type: 'error',//消息类型。error、info、success
	                hideAfter: 4,
	                hideOnNavigate: true
	            });
	            return;
	        }
	        BootstrapDialog.confirm({
	            title : '确认',
	            message : '确定删除合同['+rowData[0].contractId+']吗?',
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
	                	if(rowData[0].checkFlag == '1'){
	                		$.globalMessenger().post({
                                message: '合同已复核，不可删除',//提示信息
                                type: 'error',//消息类型。error、info、success
                                hideAfter: 4,
                                hideOnNavigate: true
                            });
	                		return;
	                	}
	                    $.ajax({
	                        url: '${ctx}/contract/deleteContracts.htm',
	                        dataType: "json",
	                        type: 'POST',//PUT DELETE POST
	                        data:{'contractId':rowData[0].contractId },
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
	        /* $("#contractfm input").val("");
	        $('#contractfm').data('bootstrapValidator').resetForm(true);
	        $('#myModal').modal('show');
	        $("#myModalLabel").html('新增套餐信息');
	        url = '${ctx}/contract/addContracts.htm';
			$(".contractProductInfo").css("display", "none");
			$("#fmSaleIdSelect").select2("val", "");
			$("#fmCustIdSelect").select2("val", "");
			$("#fmProductIdSelect").select2("val", ""); */
    		loadPage('${ctx}/contract/goAddContracts.htm');
	    }
    	
    	function openBrowseModel() {
    		var rowData = $("#contract_table").bootstrapTable('getSelections',function(row){return row;});
	        if(rowData.length != 1){
	            $.globalMessenger().post({
	                message: '请选择一条记录',//提示信息
	                type: 'error',//消息类型。error、info、success
	                hideAfter: 4,
	                hideOnNavigate: true
	            });
				
	        }else{
	        	loadPage('${ctx}/contract/goBrowseContracts.htm?contractId='+rowData[0].contractId+'&&flag=1');
	        }
	    }
    	
    	function openEditModel() {
	        var rowData = $("#contract_table").bootstrapTable('getSelections',function(row){return row;});
	        if(rowData.length != 1){
	            $.globalMessenger().post({
	                message: '请选择一条记录',//提示信息
	                type: 'error',//消息类型。error、info、success
	                hideAfter: 4,
	                hideOnNavigate: true
	            });
				
	        }else{
	        	if(rowData[0].checkFlag == '1'){
            		$.globalMessenger().post({
                        message: '合同已复核，不可修改',//提示信息
                        type: 'error',//消息类型。error、info、success
                        hideAfter: 4,
                        hideOnNavigate: true
                    });
            		return;
            	}
	        	loadPage('${ctx}/contract/goEditContracts.htm?contractId='+rowData[0].contractId);
	        }
	    }

		$("#saleId").select2({
	  		ajax: {
		  	    url: "${ctx}/employee/queryEmployees.htm",
		  	    dataType: 'json',
		        method : 'post',
		        contentType : 'application/x-www-form-urlencoded',
		  	    delay: 250,
		  	    data: function (params) {
		  	    	console.log(params);
		  	      	return {
		  	    		name: params.term, // search term
		  	    		type: '02',
		  	        	pageNumber: params.page,
		  	        	pageSize: 10
		  	      	};
		  	    },
  	    		processResults: function (data, params) {
		  	    	params.page = params.page || 1;
  	   
           			(data.data.rows).forEach(function (d, employeeId) {
		            	//Just assign a unique number or your own unique id
		                console.log(d);
		                console.log(d.employeeId);
		                d.id = d.employeeId; // or e.id = e.userId;
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
      		width: "100%", //设置下拉框的宽度
      		placeholder: "请选择",
      		language: "zh-CN",         //中文
      		allowClear: true,    //选中之后，可手动点击删除  
  	  		escapeMarkup: function (markup) { return markup; }, // let our custom formatter work
  	  		minimumInputLength: 1,
  	  		templateResult: formatSale,
  	  		templateSelection: formatSaleSelection
  		});
	
  		function formatSale (repo) {
  	  		if (repo.loading) {
  	    		return repo.text;
  	  		}
			var markup="<div class='select2-result-repository__meta'>";
			markup += '<div class="clearfix">' +  
			"<div class='select2-result-repository__stargazers'><i class='fa fa-star'></i> " + repo.name + "</div>" +
		    '</div></div>';  

  	  		return markup;
  		}

  		function formatSaleSelection (repo) {
  			return repo.name || repo.text;
  		}
  	
  		$("#custId").select2({
    	  	ajax: {
    	    	url: "${ctx}/customer/queryCustomer.htm",
    	    	dataType: 'json',
	    	    method : 'post',
	            contentType : 'application/x-www-form-urlencoded',
	    	    delay: 250,
	    	    data: function (params) {
    	    		console.log(params);
    	      		return {
		    	    	name: params.term, // search term
		    	        pageNumber: params.page,
		    	        pageSize: 30
    	      		};
    	    	},
    	    	processResults: function (data, params) {
    	      		// parse the results into the format expected by Select2
	    	      	// since we are using custom formatting functions we do not need to
	    	      	// alter the remote JSON data, except to indicate that infinite
	    	     	// scrolling can be used
	    	      	params.page = params.page || 1;
    	   
            		//data is an array of results
             		(data.data.rows).forEach(function (d, employeeId) {
                 		//Just assign a unique number or your own unique id
                 		console.log(d);
                 		console.log(d.custId);
                 		d.id = d.custId; // or e.id = e.userId;
             		})
                  	console.log(data.data.rows);

    	      		return {
    	        		results: data.data.rows,
    	        		pagination: {
    	          			more: (params.page * 30) < data.data.total
    	        		}
    	      		};
    	    	},
    	    	cache: true
    	  	},
	        width: "100%", //设置下拉框的宽度
	        placeholder: "请选择",
	        language: "zh-CN",         //中文
	        allowClear: true,    //选中之后，可手动点击删除  
	    	escapeMarkup: function (markup) { return markup; }, // let our custom formatter work
	    	minimumInputLength: 1,
	    	templateResult: formatCustQuery,
	    	templateSelection: formatCustQuerySelection
    	}).on('change', function(e) {
    		var data = $(this).val();
    	});
  	
  		function formatCustQuery (repo) {
	  	  	if (repo.loading) {
	  	    	return repo.text;
	  	  	}
			var markup="<div class='select2-result-repository__meta'>";
			markup += '<div class="clearfix">' +  
			"<div class='select2-result-repository__stargazers'><i class='fa fa-user'></i> " + repo.name + "</div>" +
	 	    "<div class='select2-result-repository__forks'><i class='fa fa-address-card'></i> " + repo.idNo + "</div>" +
		    '</div></div>';  

	  	  	return markup;
	  	}

	  	function formatCustQuerySelection (repo) {
	  		return repo.name || repo.text;
	  	}
	  	
		$("#productId").select2({
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
		  	          		more: (params.page * 30) < data.data.total
		  	        	}
		  	      	};
		  	    },
		  	    cache: true
			},
	      	width: "100%", //设置下拉框的宽度
	      	placeholder: "请选择",
	      	language: "zh-CN",         //中文
	      	allowClear: true,    //选中之后，可手动点击删除  
	  	  	escapeMarkup: function (markup) { return markup; }, // let our custom formatter work
	  	  	minimumInputLength: 1,
	  	  	templateResult: formatProductQuery,
	  	  	templateSelection: formatProductQuerySelection
	  	});
		
	  	function formatProductQuery (repo) {
	  	  if (repo.loading) {
	  	    return repo.text;
	  	  }
			var markup="<div class='select2-result-repository__meta'>";
			markup += '<div class="clearfix">' +  
			"<div class='select2-result-repository__stargazers'><i class='fa fa-star'></i> " + repo.productName + "</div>" +
		    '</div></div>';  

	  	  return markup;
	  	}

	  	function formatProductQuerySelection (repo) {
	  		return repo.productName || repo.text;
	  	}
    });
	
    function goIndex(){
    	loadPage("${ctx}/index/index.htm");
    }

</script>