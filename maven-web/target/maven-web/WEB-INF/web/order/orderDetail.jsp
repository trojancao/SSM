<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="../common/taglibs.jsp" %>
<style type="text/css">
.select2-container--default .select2-selection--multiple .select2-selection__choice{
    background-color: #f00;
}
#fmActivityId,.select2-container--default{
	width: 100% !important;
}
</style>
<section class="content-header">
    <h1>
       	订单详情
        <small>列表</small>
    </h1>
	<ol class="breadcrumb">
		<li><a href="javascript:void(0);" onclick="goIndex();"><i class="fa fa-dashboard"></i> 首页</a></li>
        <li><a href="#">订单管理</a></li>
        <li class="active">订单管理</li>
    </ol>
</section>
<section class="content">
    <div class="row">
        <div class="col-xs-12">
            <div class="box">
                <div class=" panel-default" id="searchDiv">
                    <div class="panel-body">
                        <div class="form-group" style="display: -webkit-box;">
                          <label class="col-sm-1 control-label">订单编号:</label>
			              <div class="col-md-3">
			                <input id="fmOrderId" class="form-control" readonly="readonly">
			              </div>
			              <label class="col-sm-1 control-label">合同编号:</label>
			              <div class="col-md-3">
			                <input id="fmContractId" class="form-control" readonly="readonly">
			              </div>
			              <label class="col-sm-1 control-label">客户名称:</label>
			              <div class="col-md-3">
			                <input id="fmCustId" class="form-control" readonly="readonly">
			              </div>
			            </div>
			            <div class="form-group" style="display: -webkit-box;">
			              <label class="col-sm-1 control-label">套餐名称:</label>
			              <div class="col-md-3">
			                <input id="fmProductId" class="form-control" readonly="readonly">
			              </div>
			              <label class="col-sm-1 control-label">订单金额:</label>
                          <div class="col-md-3">
                            <input id="fmAmount" class="form-control" readonly="readonly">
                          </div>
			              <label class="col-sm-1 control-label">订单状态:</label>
			              <div class="col-md-3">
			              	<input id="fmState" class="form-control" readonly="readonly">
			              </div>
			            </div>
			            <div class="form-group" style="display: -webkit-box;">
			              <label class="col-sm-1 control-label">支付方式:</label>
			              <div class="col-md-3">
			                <input id="fmPayType" class="form-control" readonly="readonly">
			              </div>
			              <label class="col-sm-1 control-label">销售佣金:</label>
                          <div class="col-md-3">
                            <input id="fmCommissionFee" class="form-control" readonly="readonly">
                          </div>
			            </div>
                    </div>
                </div>

                <div class="box-body">
                    <div id="toolbar" class="btn-group">
                    </div>
                    <table id="order_table" class="table table-bordered table-striped table-hover">
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
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">模态框（Modal）标题</h4>
			</div>
			<form id="orderfm" method="post" role="orderfm"
				class="form-horizontal">
				<div class="modal-body">
					<input id="fmOrderDetailId" name="orderDetailId" type="hidden">
					<div class="form-group">
						<label class="col-sm-2 control-label">客户姓名:</label>
						<div class="col-md-4">
							<input id="fmName" type="text" class="form-control"
								maxlength="20" readonly="readonly">
						</div>
						<label class="col-sm-2 control-label">服务时间:</label>
						<div class="col-md-4">
							<input class="form-control datetimepicker" id="fmBeginTime" name="fmBeginTime" readonly="readonly" type="text" readonly="readonly">
							<input type="hidden" name="beginTime" id="beginTime">
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">服务地址:</label>
						<div class="col-md-10">
							<select class="form-control" name="houseId" id="fmHouseId"
								onchange="changeHouse()">
								<option value="">--请选择--</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">房屋面积:</label>
						<div class="col-md-4">
							<input name="area" class="form-control" id="fmArea" readonly="readonly"/>
						</div>
						<label class="col-sm-2 control-label">服务佣金:</label>
                        <div class="col-md-4">
                            <input id="fmServiceFee" name="serviceFee" class="form-control">
                        </div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">服务人员:</label>
		              	<div class="col-md-10">
		                	<select class="js-example-programmatic-multi js-states form-control" style="height: 34px;" multiple="multiple" id="fmEmployeeId" name="employeeIdList"></select>
		              	</div>
					</div>
					<div class="form-group" id="activity">
						<label class="col-sm-2 control-label">参与活动:</label>
		              	<div class="col-md-10">
		                	<select class="js-example-programmatic-multi js-states form-control" multiple="multiple" id="fmActivityId" name="activityIdList"></select>
		              	</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">备注:</label>
						<div class="col-md-10">
							<textarea name="memo" class="form-control" id="fmMemo"
								style="height: 90px;"></textarea>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
						<button type="button"
							class="btn btn-primary customerHouseInfoButton"
							onclick="save()">派单</button>
					</div>
				</div>
			</form>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->
</div>

<script type="text/javascript">
	var houseMap = {};
    $(".datetimepicker").datetimepicker({
    	format: 'yyyy-mm-dd hh:ii',
        autoclose: true,
        language: "zh-CN",
        clearBtn: true,
        todayBtn: true,
        minView: 0,
        minuteStep:1
    });
    $("#fmOrderId").val('${requestScope.order.orderId}');
    $("#fmContractId").val('${requestScope.order.contractId}');
    $("#fmCustId").val('${requestScope.order.custName}');
    $("#fmProductId").val('${requestScope.order.productName}');
    $("#fmAmount").val('${requestScope.order.amount}');
    if('-3'=='${requestScope.order.state}'){
		$("#fmState").val("用户拒收");
	}else if('-2'=='${requestScope.order.state}'){
		$("#fmState").val("未支付");
	}else if('-1'=='${requestScope.order.state}'){
		$("#fmState").val("用户取消");
	}else if('1'=='${requestScope.order.state}'){
		$("#fmState").val("未派单");
	}else if('2'=='${requestScope.order.state}'){
		$("#fmState").val("已派单");
	}else if('3'=='${requestScope.order.state}'){
		$("#fmState").val("用户确认完成");
	}else if('4'=='${requestScope.order.state}'){
		$("#fmState").val("未复核");
	}
    if('1'=='${requestScope.order.payType}'){
		$("#fmPayType").val("线下付款");
	}else if('2'=='${requestScope.order.payType}'){
		$("#fmPayType").val("在线支付");
	}
    $("#fmCommissionFee").val('${requestScope.order.commissionFee}');
    function initTable() {
        //先销毁表格
        $('#order_table').bootstrapTable('destroy');
        //初始化表格,动态从服务器加载数据
        $("#order_table").bootstrapTable({
            url: "${ctx}/order/queryOrderDetail.htm", //获取数据的Servlet地址
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
            sortName : 'begin_time',
            sortOrder: 'asc',
            pageSize: 20,
            pageList: [20, 35, 50],
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
                field: 'orderDetailId',
                title: '明细编号',
                sortable: false,
            }, {
    			field : 'beginTime',
    			title : '服务时间',
    			formatter : function(value, row, index) {
					if (null != value && "" != value) {
						return new Date(value).format("yyyy-MM-dd HH:mm:ss");
					}
				}
    		}, {
    			field : 'serviceFee',
    			title : '服务佣金',
    			formatter : function(value, row, index) {
    				if (null != value && "" != value) {
    					return value.toFixed(2);
    				}
    			}
    		}, {
    			field : 'assignTime',
    			title : '派单时间',
    			sortable : false,
    			formatter : function(value, row, index) {
					if (null != value && "" != value) {
						return new Date(value).format("yyyy-MM-dd HH:mm:ss");
					}
				}
    		}, {
    			field : 'state',
    			title : '状态',
    			formatter : function(value, row, index) {
    				if(value=='00'){
    					return "未派单";
    				}else if(value=='01'){
    					return "已派单";
    				}else if(value=='02'){
    					return "已使用";
    				}else if(value=='03'){
    					return "安排未成";
    				}else if(value=='04'){
    					return "未复核";
    				}
    			}
    		}, {
                field: 'action',
                title: '操作',
                align: 'center',
                formatter:function(value,row,index){
                	if(row.state=='00'){
                		return '<a href="#" onclick="openAssignModel(\''+row.orderDetailId+'\','+row.beginTime+')">派单</a> ';
    				}else if(row.state=='01'){
    					return '<a href="#">查看详情</a> ';
    				}else if(row.state=='02'){
    					return '<a href="#">查看详情</a> ';
    				}else if(row.state=='03'){
    					return '<a href="#" onclick="openAssignModel(\''+row.orderDetailId+'\','+row.beginTime+')">派单</a> ';
    				}else if(row.state=='04'){
    					return '<a href="#">查看详情</a> ';
    				}
               		
                } 
            }]],
            queryParams: function queryParams(params) {   //设置查询参数
                var requestPage = {
                    pageNumber: params.pageNumber,
                    pageSize: params.pageSize,
                    orderId: $("#fmOrderId").val(),
                };
                return requestPage;
            },
            onClickRow: function (item, $element) {
                $('.info').removeClass('info');//去除之前选中的行的，选中样式
                $element.toggleClass('info');//添加当前选中的 success样式用于区别
                return false;
            },
            onClickCell: function(field, value, row, $element){
            	if("action" == field && (row.state=='01' || row.state=='02' || row.state=='04')){
            		$("#orderfm input").val("");
            		$("#fmEmployeeId").empty();
            		$('#myModal').modal('show');
            		$("#myModalLabel").html('派单详情');
            		getOrderDetailHouse();
            		$("#fmName").val('${requestScope.order.custName}');
            		$("#fmHouseId").val(row.houseId);
            		$("#fmServiceFee").val(row.serviceFee);
            		$("#fmMemo").val(row.memo);
            		if(null!=row.beginTime && ""!=row.beginTime){
            			$('#fmBeginTime').datetimepicker('setDate',new Date(row.beginTime));
            		}
            		changeHouse();
            		
            		$("#fmActivityId").empty();
                    var activityOption = "";
                   	if(row.activityList != null && row.activityList.length>0){
                   		$("#activity").css("display", "block");
                    	for(var i = 0;i<row.activityList.length;i++){
                    		activityOption += "<option value='"+row.activityList[i]+"' SELECTED>"+row.activityList[i]+"</option>";
                        }
             	        $("#fmActivityId").html(activityOption);
                    }else{
                    	$("#activity").css("display", "none");
                    }
            		
            		$("#fmEmployeeId").empty();
                    var option = "";
                   	if(row.employeeList.length>0){
                    	for(var i = 0;i<row.employeeList.length;i++){
                        	option += "<option value='"+row.employeeList[i]+"' SELECTED>"+row.employeeList[i]+"</option>";
                        }
             	        $("#fmEmployeeId").html(option);
                    }
                   	
                   	$("#fmHouseId").attr("disabled",'true');
            		$("#fmServiceFee").attr("readOnly",'true');
            		$("#fmMemo").attr("readOnly",'true');
            		$('#fmBeginTime').attr("disabled",'true');
            		$("#fmEmployeeId").attr("disabled",'true');
            		$("#fmActivityId").attr("disabled",'true');
            		$(".customerHouseInfoButton").css("display", "none");
            	}
            }
        });
    }

	function openAssignModel(orderDetailId, beginTime) {
		$("#fmHouseId").removeAttr("disabled");
		$("#fmServiceFee").removeAttr("readOnly");
		$("#fmMemo").removeAttr("readOnly");
		$('#fmBeginTime').removeAttr("disabled");
		$("#fmEmployeeId").removeAttr("disabled");
		$("#fmActivityId").removeAttr("disabled");
		$(".customerHouseInfoButton").css("display", "inline-block");
		
		$("#orderfm input").val("");
		$("#fmEmployeeId").empty(); 
		$('#orderfm').data('bootstrapValidator').resetForm(true);
		$('#myModal').modal('show');
		$("#myModalLabel").html('派单');
		getOrderDetailHouse();
		getOrderActivity();
		$("#fmName").val('${requestScope.order.custName}');
		$("#fmOrderDetailId").val(orderDetailId);
		if(null!=beginTime && ""!=beginTime){
			$('#fmBeginTime').datetimepicker('setDate',new Date(beginTime));
		}
		url = '${ctx}/order/dispatchOrder.htm';
	}
	
	function getOrderActivity() {
   		$.ajax({
   	        url:"${ctx }/order/queryOrderActivity.htm",
   	        dataType: "JSON",
   	        data: {'contractId' : '${requestScope.order.contractId}'},
   	        type: "GET",
   	        success:function (data) {
   	        	var data_rows = data.data;
   	            var gradeNum= data_rows.length;
   	            if(gradeNum<=0){
   	            	$("#activity").css("display", "none");
   	            	return;
   	            }
	            $("#fmActivityId").empty();
   	            var option = "";
   	            if(gradeNum>0){
   	            	$("#activity").css("display", "block");
   	                for(var i = 0;i<gradeNum;i++){
   	                    option += "<option value='"+data_rows[i].activityContractId+"' SELECTED>"+data_rows[i].activityName+"</option>";
   	                }
	   	            $("#fmActivityId").html(option);
   	            }
   	           // $("#class").val(Id); //编辑时绑定
   	            $("#fmActivityId").select2({ minimumResultsForSearch: 1 });//加载样式
   	        },
   	        error:function(e) {
   	            layer.alert("系统异常，请稍候重试！");
   	        }
   	    });
	}
	
	function getOrderDetailHouse() {
		$("#fmHouseId").empty();
		$.ajax({
			type : 'post',
			url : '${ctx }/order/getOrderDetailHouse.htm',
			dataType : "json",
			async : false,
			data : {
				'orderId' : '${requestScope.order.orderId}'
			},
			success : function(data) {
				var depart_list = data.data;
				var opts = "<option value=''>---请选择---</option>";
				for (var depart_index = 0; depart_index < depart_list.length; depart_index++) {
					var depart = depart_list[depart_index];
					opts += "<option value='" + depart.houseId + "'>"
							+ depart.addressName + "</option>";
					houseMap[depart.houseId] = depart.area;
				}
				$("#fmHouseId").append(opts);

			}
		});
	}

	function changeHouse() {
		if(null != $("#fmHouseId").val() && "" != $("#fmHouseId").val()){
			$("#fmArea").val(houseMap[$("#fmHouseId").val()]);
		}else{
			$("#fmArea").val("");
		}
	}
	
	function save() {
		var bootstrapValidator = $("#orderfm").data('bootstrapValidator');
		bootstrapValidator.validate();
		if (bootstrapValidator.isValid()) {
			if (null != $("#fmBeginTime").val() && "" != $("#fmBeginTime").val()) {
				$("#beginTime").val(new Date($("#fmBeginTime").val()));
			}
			$.ajax({
				url : url,
				async : true,//同步，会阻塞操作
				type : 'POST',//PUT DELETE POST
				data : $("#orderfm").serialize(),
				dataType : "json",
				success : function(data) {
					if (data.result == 1) {
						$('#myModal').modal('hide');
						initTable();
					} else {
						$.globalMessenger().post({
							message : data.msg,//提示信息
							type : 'error',//消息类型。error、info、success
							hideAfter : 4,
							//                            showCloseButton:true,
							hideOnNavigate : true
						});
					}
				}
			})
		} else {
			return;
		}
	}
	
	$("#fmActivityId").select2({
      	width: "100%", //设置下拉框的宽度
      	placeholder: "请选择",
      	language: "zh-CN",         //中文
      	allowClear: true,    //选中之后，可手动点击删除  
  	  	escapeMarkup: function (markup) { return markup; }, // let our custom formatter work
  	  	minimumInputLength: 1,
  	  	templateResult: formatSale,
  	  	templateSelection: formatSaleSelection
	}).on('change', function(e) {
		var data = $(this).val();
		if(data==null){
			return;
		}
	});
	
	$("#fmEmployeeId").select2({
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
	  	    		typeList: '01,05',
	  	    		state: '01',
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
	}).on('change', function(e) {
		var data = $(this).val();
		if(data==null){
			return;
		}
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
  	
    $(document).ready(function () {
        //调用函数，初始化表格
        initTable();
      //当点击查询按钮的时候执行
		$('#orderfm').bootstrapValidator({
			message : 'This value is not valid',
			feedbackIcons : {
				valid : 'glyphicon glyphicon-ok',
				invalid : 'glyphicon glyphicon-remove',
				validating : 'glyphicon glyphicon-refresh'
			},
			fields : {
				houseId : {
					validators : {
						notEmpty : {
							message : '服务房屋不能为空'
						},
					}
				},
				employeeIdList : {
					validators : {
						notEmpty : {
							message : '服务人员不能为空'
						}
					}
				},
				beginTime : {
					validators : {
						notEmpty : {
							message : '服务时间不能为空'
						}
					}
				},
				serviceFee : {
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
				memo : {
					validators : {
						stringLength : {
							max : 100,
							message : '备注字数不能大于100'
						},
					}
				}
			}
		});
        //当点击查询按钮的时候执行
        $("#search").bind("click", initTable);
    });
	
    function goIndex(){
    	loadPage("${ctx}/index/index.htm");
    }
</script>