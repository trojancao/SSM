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
        	合同复核
        <small>列表</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="javascript:void(0);" onclick="goIndex();"><i class="fa fa-dashboard"></i> 首页</a></li>
        <li><a href="#">订单管理</a></li>
        <li class="active">合同复核</li>
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
                                                                                                                复核状态:<select class="form-control"
									id="checkFlag" panelHeight="auto" style="width: 140px;">
									<option value="">--请选择--</option>
									<option value="-1">未复核</option>
									<option value="1">已复核</option>
									<option value="2">复核不通过</option>
								</select>
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
                        <!-- <button id="btn_add" type="button" class="btn btn-default" data-toggle="modal">
                            <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>复核
                        </button> -->
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
            columns: [[ {
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
    		},{
                field: 'checkFlag',
                title: '操作',
                align: 'center',
                formatter:function(value,row,index){
                  	if(value=='-1'){
                  		return '<a href="#" onclick="openCheckModel(\''+row.contractId+'\''+','+row.checkFlag+')">复核</a>';
    				}else if(value=='1'){
                  		return '<a href="#" onclick="openBrowseModel(\''+row.contractId+'\')">浏览</a>';
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
                    checkFlag: $("#checkFlag").val(),
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

	function openCheckModel(contractId, checkFlag) {
    	if(checkFlag != '-1'){
       		$.globalMessenger().post({
          		message: '合同已复核，请勿重复复核',//提示信息
            	type: 'error',//消息类型。error、info、success
            	hideAfter: 4,
            	hideOnNavigate: true
           	});
       		return;
       	}
    	loadPage('${ctx}/contract/goCheckContracts.htm?contractId='+contractId);
    }
	
	function openBrowseModel(contractId) {	
        loadPage('${ctx}/contract/goBrowseContracts.htm?contractId='+contractId+'&&flag=2');
    }
	
    $(document).ready(function () {
        //调用函数，初始化表格
        initTable();

        //当点击查询按钮的时候执行
        $("#search").bind("click", initTable);
    	
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