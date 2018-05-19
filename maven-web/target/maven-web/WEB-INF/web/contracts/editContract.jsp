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
		合同修改
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
                <form id="contractfm" method="post" role="contractfm" class="form-horizontal" >
		          <div class="modal-body">
		            <div class="form-group">
		              <label class="col-sm-2 control-label">合同编号:</label>
		              <div class="col-md-4">
		                <input name="contractId" id="fmContractId" type="text" class="form-control" maxlength="32" readonly="readonly">
		              </div>
		              <label class="col-sm-2 control-label">签约日期:</label>
		              <div class="col-md-4">
		              	<input type="hidden" name="signDate" id="signDate">
		               	<input class="form-control datepicker" readonly="readonly" name="fmSignDate" id="fmSignDate" type="text">
		              </div>
		            </div>
		            <div class="form-group">
		              <label class="col-sm-2 control-label">销售人员:</label>
		              <div class="col-md-4">
		                <input name="saleId" id="fmSaleId" class="form-control" type="hidden">
		                <select class="js-example-data-ajax form-control saleId" id="fmSaleIdSelect" name="fmSaleIdSelect"></select>
		              </div>
		              <label class="col-sm-2 control-label">联系方式</label>
		              <div class="col-md-4">
		                <input name="custId" id="fmCustId" class="form-control" type="hidden">
		                <select class="js-example-data-ajax form-control custId" id="fmCustIdSelect" name="fmCustIdSelect"></select>
		              </div>
		            </div>
		            <div class="form-group">
		              <label class="col-sm-2 control-label">出生日期:</label>
		              <div class="col-md-4">
		              	<input class="form-control datepicker" readonly="readonly" name="fmbirthday" id="fmBirthday" type="text" disabled="disabled">
		              </div>
		              <label class="col-sm-2 control-label">客户名称:</label>
		              <div class="col-md-4">
		                <input name="name" class="form-control" readonly="readonly" id="fmName">
		              </div>
		            </div>
		            <div class="form-group">
		              <label class="col-sm-2 control-label">服务房产:</label>
		              <div class="col-md-10">
		                <select class="js-example-programmatic-multi js-states form-control" name="houseId" multiple="multiple" id="fmContractHouseId"></select>
		              </div>
		            </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">套餐名称</label>
                        <div class="col-md-4">
                        	<input name="productId" id="fmProductId" class="form-control" type="hidden">
                        	<select class="js-example-data-ajax form-control productId" id="fmProductIdSelect" name="fmProductIdSelect"></select>
                        </div>
                        <label class="col-sm-2 control-label">套餐金额:</label>
                        <div class="col-md-4">
                            <input id="fmProductAmount" class="form-control" readonly="readonly">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">服务次数:</label>
                        <div class="col-md-4">
                            <input id="fmServiceCount" class="form-control" readonly="readonly">
                        </div>
                        <label class="col-sm-2 control-label">每次服务时长(h):</label>
                        <div class="col-md-4">
                            <input id="fmServiceTime" class="form-control" readonly="readonly">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">销售费率:</label>
                        <div class="col-md-4">
                            <input id="fmSaleRate" class="form-control" readonly="readonly">
                        </div>
                        <label class="col-sm-2 control-label">付款方式:</label>
                        <div class="col-md-4">
                        	<select class="form-control" name="payMethod" id="fmPayMethod">
                        		<option value=""></option>
                                <option value="1">对公账户</option>
								<option value="2">现金</option>
								<option value="3">微信1</option>
								<option value="4">微信2</option>
								<option value="5">微信3</option>
								<option value="6">支付宝</option>
								<option value="7">农商 行卡</option>
								<option value="8">家政pos机</option>
								<option value="9">置业pos机</option>
								<option value="10">市民卡</option>
								<option value="11">其他</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                    	<label class="col-sm-2 control-label">规则名称:</label>
                        <div class="col-md-4">
                        	<input name="ruleId" id="fmRuleId" class="form-control" type="hidden">
                        	<select class="js-example-data-ajax form-control ruleId" id="fmRuleIdSelect" name="fmRuleIdSelect"></select>
                        </div>
                        <label class="col-sm-2 control-label">规则类型:</label>
                        <div class="col-md-4">
                            <select class="form-control" id="fmRule" disabled="disabled">
                                <option value=""></option>
								<option value="1">待定</option>
								<option value="2">一周多次</option>
								<option value="3">多周一次</option>
								<option value="4">多月一次</option>
								<option value="5">每月固定第一次周几</option>
								<option value="6">多日一次</option>
                            </select>
                        </div>
                        
                    </div>

                    <div class="form-group">
                    	<label class="col-sm-2 control-label">几日/周/月:</label>
                        <div class="col-md-4">
                            <input id="fmDateNumber" class="form-control" readonly="readonly">
                        </div>
                        <label class="col-sm-2 control-label">每日/周/月次数:</label>
                        <div class="col-md-4">
                            <input id="fmDateCount" class="form-control" readonly="readonly">
                        </div>

                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">周期固定日期:</label>
                        <div class="col-md-4">
                            <input id="fmDateFixed" class="form-control" readonly="readonly">
                        </div>
                        <label class="col-sm-2 control-label">是否有效:</label>
                        <div class="col-md-4">
                            <select class="form-control" id="fmDataFlag" disabled="disabled">
                                <option value="1">有效</option>
								<option value="-1">无效</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
		              <label class="col-sm-2 control-label">参与活动:</label>
		              <div class="col-md-10">
		              	<input name="activityId" id="fmActivityId" class="form-control" type="hidden">
		                <select class="js-example-data-ajax form-control" id="fmActivityIdSelect" name="fmActivityIdSelect" multiple="multiple"></select>
		              </div>
		            </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label serviceTime1" style="display: none;">第一次服务时间:</label>
                        <div class="col-md-4 serviceTime1" style="display: none;">
                            <input class="form-control datetimepicker" id="serviceDate1" name="serviceDate" readonly="readonly" type="text" readonly="readonly">
                        </div>
                        <label class="col-sm-2 control-label serviceTime2" style="display: none;">第二次服务时间:</label>
                        <div class="col-md-4 serviceTime2" style="display: none;">
                            <input class="form-control datetimepicker" id="serviceDate2" name="serviceDate" readonly="readonly" type="text" readonly="readonly">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label serviceTime3" style="display: none;">第三次服务时间:</label>
                        <div class="col-md-4 serviceTime3" style="display: none;">
                            <input class="form-control datetimepicker" id="serviceDate3" name="serviceDate" readonly="readonly" type="text" readonly="readonly">
                        </div>
                        <label class="col-sm-2 control-label serviceTime4" style="display: none;">第四次服务时间:</label>
                        <div class="col-md-4 serviceTime4" style="display: none;">
                            <input class="form-control datetimepicker" id="serviceDate4" name="serviceDate" readonly="readonly" type="text" readonly="readonly">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label serviceTime5" style="display: none;">第五次服务时间:</label>
                        <div class="col-md-4 serviceTime5" style="display: none;">
                            <input class="form-control datetimepicker" id="serviceDate5" name="serviceDate" readonly="readonly" type="text" readonly="readonly">
                        </div>
                        <label class="col-sm-2 control-label serviceTime6" style="display: none;">第六次服务时间:</label>
                        <div class="col-md-4 serviceTime6" style="display: none;">
                            <input class="form-control datetimepicker" id="serviceDate6" name="serviceDate" readonly="readonly" type="text" readonly="readonly">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label serviceTime7" style="display: none;">第七次服务时间:</label>
                        <div class="col-md-4 serviceTime7" style="display: none;">
                            <input class="form-control datetimepicker" id="serviceDate7" name="serviceDate" readonly="readonly" type="text" readonly="readonly">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">备注:</label>
                        <div class="col-sm-10">
                            <textarea name="contractRemarks" class="form-control" id="fmContractRemarks"
								style="height: 90px;"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">合同图片:</label>
                        <div class="col-sm-10" id="contractImage">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" onclick="goBack()">取消</button>
                    <button type="button" class="btn btn-primary" onclick="save()">保存</button>
                </div>
	            </form>
                </div>
                </div>
            </div>
        </div>
    </div>
</section>

<script type="text/javascript">
    var url;
    var contractImg = [];
    var imgMap = {};
    url = "${ctx}/contract/modifyContracts.htm";
    $('.datepicker').datepicker({
        autoclose: true, format: "yyyy-mm-dd", language: "zh-CN", clearBtn: true,//清除按钮
        todayBtn: true, //今日按钮
        todayHighlight: true,//今天高亮
    });

    $(".datetimepicker").datetimepicker({
    	format: 'yyyy-mm-dd hh:ii',
        autoclose: true,
        language: "zh-CN",
        clearBtn: true,
        todayBtn: true,
        minView: 0,
        minuteStep:1
    });
    
    $(document).ready(function () {
    	getContractInfo();
		
        $('#contractfm').bootstrapValidator({
            message: 'This value is not valid',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
            	fmSignDate: {
                    validators: {
                        notEmpty: {
                            message: '签约日期不能为空'
                        },
                    }
                },
                fmSaleIdSelect: {
                    validators: {
                    	/* notEmpty: {
                    		message : '销售人员不能为空',
                    	} */
                    }
                },
                fmCustIdSelect: {
                    validators: {
                    	notEmpty: {
                    		message : '联系方式不能为空',
                    	}
                    }
                },
                houseId: {
                    validators: {
                        notEmpty: {
                            message: '请选择服务房产'
                        },
                    }
                },
                fmProductIdSelect: {
                    validators: {
                    	notEmpty: {
                            message: '套餐名称不能为空'
                        },
                    }
                },fmRuleIdSelect: {
                    validators: {
                    	notEmpty: {
                            message: '规则名称不能为空',
                        },
                    }
                },contractRemarks: {
                    validators: {
                        stringLength: {
                            min: 0,
                            max: 255,
                            message: '备注长度必须怒能大于255位'
                        },
                    }
                },
                serviceDate: {
                	validators: {
						callback : {
							message : '请按顺序选择服务时间',
							callback : function(value, validator, $field) {
								if("2"==$("#fmRule").val()){
									if(null == $(".serviceTime"+$("#fmDateCount").val()+" input").val() || "" == $(".serviceTime"+$("#fmDateCount").val()+" input").val()){
						  				return false;
						  			}
									for(i = $("#fmDateCount").val(); i >= 2; i--){
							  			if(null == $(".serviceTime"+(i-1)+" input").val() || "" == $(".serviceTime"+(i-1)+" input").val()){
							  				return false;
							  			}
							  			if((new Date($(".serviceTime"+i+" input").val().substring(0, $(".serviceTime"+i+" input").val().indexOf(' ')).replace(/-/g,"\/"))) <= 
							  				(new Date($(".serviceTime"+(i-1)+" input").val().substring(0, $(".serviceTime"+(i-1)+" input").val().indexOf(' ')).replace(/-/g,"\/")))){
							  				return false;
							  			}
						  			}
						  		}else if("1"!=$("#fmRule").val()){
						  			if(null == $(".serviceTime1 input").val() || "" == $(".serviceTime1 input").val()){
						  				return false;
						  			}
						  		}
								return true;
							}
						},
                    }
                }
            }
        });
    });
    
    function getContractInfo() {
    	var contractId = '${requestScope.contractId }';
    	$("#fmContractId").val(contractId);
		$.ajax({
			type : 'post',
			url : '${ctx }/contract/queryContractsByContractId.htm',
			dataType : "json",
			async : true,
			data : {
				'contractId' : contractId
			},
			success : function(data) {
				if("1" != data.result){
					goBack();
					return;
				}
				var contract = data.data.contract;
				var customer = data.data.customer;
				var employee = data.data.employee;
				var product = data.data.product;
				var rule = data.data.rule;
				var dateList = data.data.dateList;
				var contractImageList = data.data.contractImageList;
				var customerHouseContractList = []
				customerHouseContractList = data.data.customerHouseContractList;
				var activityContractList = [];
				var activityContractIdList = [];
				activityContractList = data.data.activityContractList==null?[]:data.data.activityContractList;
				if(activityContractList != null && activityContractList.length > 0){
			  		for(var i = 0; i < activityContractList.length; i++){
			  			activityContractList[i].id = activityContractList[i].activityId;
			  			activityContractList[i].text = activityContractList[i].activityName;
			  			activityContractIdList.push(activityContractList[i].activityId);
			  		}
			  	}
				$("#fmActivityId").val(activityContractIdList);
				
				$('#fmSignDate').datepicker('setDate',new Date(contract.signDate));
				$("#fmContractRemarks").val(contract.contractRemarks);
				$("#fmPayMethod").val(contract.payMethod);
				var imglist = "";
				if(contractImageList != null && contractImageList.length > 0){
			  		for(var i = 0; i < contractImageList.length; i++){
			  			imglist += "<img src='${ctx}/image/"+contractImageList[i].imageUrl+"' height='150' width='300' style='margin-right: 35px; margin-bottom: 10px;'/>";
			  		}
			  		document.getElementById("contractImage").innerHTML=imglist;
			  	}
				$("#fmSaleIdSelect").select2({
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
					data:[{id:(employee==null||employee.employeeId==null)?'':employee.employeeId,
							text:(employee==null||employee.name==null)?'':employee.name,
							employeeId:(employee==null||employee.employeeId==null)?'':employee.employeeId}],
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
				  		$("#fmSaleId").val("");
						return;
					}
				}).val((employee==null||employee.employeeId==null)?'':employee.employeeId).trigger('change');
				
				
				$("#fmActivityIdSelect").select2({
			  	  	ajax: {
			  	    	url: "${ctx}/activity/queryActivitys.htm",
			  	    	dataType: 'json',
			        	method : 'post',
			        	contentType : 'application/x-www-form-urlencoded',
			  	    	delay: 250,
			  	    	data: function (params) {
			  	    		console.log(params);
				  	      	return {
					  	      	activityName: encodeURI(params.term), // search term
				  	    		dataFlag: '1',
				  	        	pageNumber: params.page,
				  	        	pageSize: 10
				  	      	};
			  	    	},
				  	    processResults: function (data, params) {
				  	    	params.page = params.page || 1;
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
					data:activityContractList,
			      	width: "100%", //设置下拉框的宽度
			      	placeholder: "请选择",
			      	language: "zh-CN",         //中文
			      	allowClear: true,    //选中之后，可手动点击删除  
			  	  	escapeMarkup: function (markup) { return markup; }, // let our custom formatter work
			  	  	minimumInputLength: 1,
			  	  	templateResult: formatActivity,
				  	templateSelection: formatActivitySelection
				}).on('change', function(e) {
					var activityId = $(this).val();
				  	if(activityId==null){
				  		$("#fmActivityId").val("");
				  		return;
				  	}else{
				  		$("#fmActivityId").val($(this).val());
				  	}
				}).val(activityContractIdList).trigger('change');
				
				function formatActivity (repo) {
					if (repo.loading) {
				    	return repo.text;
				  	}
					var activity="";
					if(repo.activityType=='1')
						activity = repo.activityName+"--套餐增加次数:"+repo.count;
					else if(repo.activityType=='2')
						activity = repo.activityName+"--赠品增加次数数:"+repo.count;
					else if(repo.activityType=='3')
						activity = repo.activityName+"--折扣:"+repo.rebate;
					var markup="<div class='select2-result-repository__meta'>";
					markup += '<div class="clearfix">' +  
					"<div class='select2-result-repository__stargazers'><i class='fa fa-star'></i> " + activity + "</div>" +
					'</div></div>';  

				  	return markup;
				}

				function formatActivitySelection (repo) {
			  		if(null == repo.id || "" == repo.id){
			  			return repo.activityName || repo.text;
			  		}
			  		
			  		return repo.activityName || repo.text;
			  	}
				
				
				$("#fmCustIdSelect").select2({
					ajax: {
						url: "${ctx}/customer/queryCustomer.htm",
						dataType: 'json',
						method : 'post',
						contentType : 'application/x-www-form-urlencoded',
						delay: 250,
						data: function (params) {
							console.log(params);
							return {
								phone: params.term, // search term
				    	        pageNumber: params.page,
				    	        pageSize: 10
							};
						},
						processResults: function (data, params) {
							params.page = params.page || 1;
				    	   
							(data.data.rows).forEach(function (d, custId) {
								console.log(d);
				                console.log(d.custId);
				                d.id = d.custId; // or e.id = e.userId;
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
					data:[{id:customer.custId,text:customer.phone,custId:customer.custId,phone:customer.phone,birthday:customer.birthday,name:customer.name}],
					width: "100%", //设置下拉框的宽度
					placeholder: "请选择",
					language: "zh-CN",         //中文
					allowClear: true,    //选中之后，可手动点击删除  
					escapeMarkup: function (markup) { return markup; }, // let our custom formatter work
					minimumInputLength: 4,
					templateResult: formatCust,
					templateSelection: formatCustSelection
				}).on('change', function(e) {
					var data = $(this).val();
					if(data==null){
				  		$("#fmCustId").val("");
				  		$("#fmName").val("");
				  		$("#fmBirthday").val("");
						$("#fmContractHouseId").empty();
						return;
					}
			   		$.ajax({
			   	        url:"${ctx}/customer/queryCustomerHouse.htm",
			   	        dataType: "JSON",
			   	        data: {'custId': data},
			   	        type: "GET",
			   	        success:function (data) {
			   	        	var data_rows = data.data;
			   	            var gradeNum= data_rows.length;
			   	            $("#fmContractHouseId").empty();
			   	            var option = "";
			   	            if(data.data[0].custId==customer.custId){
				   	            if(gradeNum>0){
				   	                for(var i = 0;i<gradeNum;i++){
				   	                    option += "<option value='"+data_rows[i].houseId+"'>"+data_rows[i].addressName+"</option>";
				   	                }
					   	            $("#fmContractHouseId").html(option);
				   	            }
				   	            var list = [];
				   	         	for(var i = 0; i < customerHouseContractList.length; i++){
				   	         		list.push(customerHouseContractList[i].houseId);
						  		}
				   	      		$("#fmContractHouseId").val(list).trigger('change') 
			   	            }else{
			   	            	if(gradeNum>0){
			   	   	                for(var i = 0;i<gradeNum;i++){
			   	   	                    option += "<option value='"+data_rows[i].houseId+"' SELECTED>"+data_rows[i].addressName+"</option>";
			   	   	                }
			   		   	            $("#fmContractHouseId").html(option);
			   	   	            }
			   	            }
			   	           // $("#class").val(Id); //编辑时绑定
			   	            $("#fmContractHouseId").select2({ minimumResultsForSearch: -1 });//加载样式
			   	        },
			   	        error:function(e) {
			   	            layer.alert("系统异常，请稍候重试！");
			   	        }
			   	    });
				}).val(customer.custId).trigger('change');
				
				
				$("#fmProductIdSelect").select2({
					ajax: {
				  	    url: "${ctx}/product/queryProducts.htm",
				  	    dataType: 'json',
				  	    delay: 250,
				  	    data: function (params) {
				  	    	console.log(params);
				  	    	return {
				  	    		productName: encodeURI(params.term), // search term
				  	    		dataFlag: '1',
				  	        	pageNumber: params.page,
				  	        	pageSize: 10
				  	      	};
				  	    },
				  	    processResults: function (data, params) {
				  	    	params.page = params.page || 1;
				  	   		
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
					data:[{id:product.productId,
						   text:product.productName,
						   productId:product.productId,
						   productAmount:product.productAmount,
			  			   serviceCount:product.serviceCount,
			  			   serviceTime:product.serviceTime,
			  			   saleRate:product.saleRate,
			  			   dataFlag:product.dataFlag,
					}],
					width: "100%", //设置下拉框的宽度
				    placeholder: "请选择",
				    language: "zh-CN",         //中文
				    allowClear: true,    //选中之后，可手动点击删除  
				  	escapeMarkup: function (markup) { return markup; }, // let our custom formatter work
				  	minimumInputLength: 1,
				  	templateResult: formatProduct,
				  	templateSelection: formatProductSelection
				}).on('change', function(e) {
				  	var productId = $(this).val();
				  	if(productId==null){
				  		$("#fmProductId").val("");
				  		return;
				  	}
				}).val(product.productId).trigger('change');
				
				
				$("#fmRuleIdSelect").select2({
					ajax: {
				  	    url: "${ctx}/rule/queryRules.htm",
				  	    dataType: 'json',
				  	    delay: 250,
				  	    data: function (params) {
				  	    	console.log(params);
				  	    	return {
				  	    		productName: encodeURI(params.term), // search term
				  	    		dataFlag: '1',
				  	        	pageNumber: params.page,
				  	        	pageSize: 10
				  	      	};
				  	    },
				  	    processResults: function (data, params) {
				  	    	params.page = params.page || 1;
				  	   		
				            (data.data.rows).forEach(function (d, ruleId) {
				                //Just assign a unique number or your own unique id
				            	console.log(d);
				                console.log(d.ruleId);
				                d.id = d.ruleId; // or e.id = e.userId;
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
					data:[{id:rule.ruleId,
						   text:rule.ruleName,
						   dataFlag:rule.dataFlag,
			  			   rule:rule.rule,
			  			   dateNumber:rule.dateNumber,
			  			   dateCount:rule.dateCount,
			  			   dateFixed:rule.dateFixed,
			  			   ruleId:rule.ruleId,
					}],
					width: "100%", //设置下拉框的宽度
				    placeholder: "请选择",
				    language: "zh-CN",         //中文
				    allowClear: true,    //选中之后，可手动点击删除  
				  	escapeMarkup: function (markup) { return markup; }, // let our custom formatter work
				  	minimumInputLength: 1,
				  	templateResult: formatRule,
				  	templateSelection: formatRuleSelection
				}).on('change', function(e) {
				  	var ruleId = $(this).val();
				  	if(ruleId==null){
				  		$("#fmRuleId").val("");
				  		for(i = 1; i <= 7; i++){
				  			$(".serviceTime"+i).css("display", "none");
				  			$(".serviceTime"+i+" input").val("");
				  		}
				  		return;
				  	}
				}).val(rule.ruleId).trigger('change');
				
				
				if(dateList != null && dateList.length > 0){
			  		for(i = 0; i <= dateList.length; i++){
		  				$('#serviceDate'+(i+1)).datetimepicker('setDate',new Date(dateList[i]));
		  			}
				}
				
			},
			error : function() {
				goBack();
            }
		});
    }
    
    function save() {
    	$("#signDate").val(new Date($("#fmSignDate").val()));
        var bootstrapValidator = $("#contractfm").data('bootstrapValidator');
        bootstrapValidator.updateStatus('fmSignDate', 'NOT_VALIDATED');
        bootstrapValidator.updateStatus('houseId', 'NOT_VALIDATED');
        bootstrapValidator.updateStatus('serviceDate', 'NOT_VALIDATED');
        bootstrapValidator.validate();
        if (bootstrapValidator.isValid()) {
            $.ajax({
                url: url,
                async: true,//同步，会阻塞操作
                dataType: "json",
                type: 'POST',//PUT DELETE POST
                data: $("#contractfm").serialize(),
                success: function (result) {
                    if (result.result == 1) {
                    	goBack();
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
        } else {
            return;
        }
    }
  	
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
  		$("#fmSaleId").val(repo.employeeId);
  		return repo.name || repo.text;
  	}
	  	
	function formatCust (repo) {
		if (repo.loading) {
			return repo.text;
		}
		var markup="<div class='select2-result-repository__meta'>";
		markup += '<div class="clearfix">' +  
		"<div class='select2-result-repository__stargazers'><i class='fa fa-user'></i> " + repo.phone + "</div>" +
		"<div class='select2-result-repository__stargazers'><i class='fa fa-user'></i> " + repo.name + "</div>" +
 	    "<div class='select2-result-repository__forks'><i class='fa fa-address-card'></i> " + repo.idNo + "</div>" +
	    '</div></div>';  

  	 	return markup;
	}

	function formatCustSelection (repo) {
		$("#fmCustId").val(repo.custId);
		$("#fmName").val(repo.name);
		$("#fmBirthday").datepicker('setDate',new Date(repo.birthday));
	 	return repo.phone || repo.text;
	}
	
	function formatProduct (repo) {
		if (repo.loading) {
	    	return repo.text;
	  	}
		var markup="<div class='select2-result-repository__meta'>";
		markup += '<div class="clearfix">' +  
		"<div class='select2-result-repository__stargazers'><i class='fa fa-star'></i> " + repo.productName + "</div>" +
		'</div></div>';  

	  	return markup;
	}

	function formatProductSelection (repo) {
  		if(null == repo.id || "" == repo.id){
  			return repo.productName || repo.text;
  		}
  		$("#fmProductAmount").val(repo.productAmount);
  		$("#fmServiceCount").val(repo.serviceCount);
  		$("#fmServiceTime").val(repo.serviceTime);
  		$("#fmSaleRate").val(repo.saleRate);
  		$("#fmState").val(repo.dataFlag);
  		$("#fmProductId").val(repo.productId);
  		return repo.productName || repo.text;
  	}
	
	function formatRule (repo) {
		if (repo.loading) {
	    	return repo.text;
	  	}
		var markup="<div class='select2-result-repository__meta'>";
		markup += '<div class="clearfix">' +  
		"<div class='select2-result-repository__stargazers'><i class='fa fa-star'></i> " + repo.ruleName + "</div>" +
		'</div></div>';  

	  	return markup;
	}

	function formatRuleSelection (repo) {
  		if(null == repo.id || "" == repo.id){
  			return repo.ruleName || repo.text;
  		}
  		$("#fmDataFlag").val(repo.dataFlag);
  		$("#fmRule").val(repo.rule);
  		$("#fmDateNumber").val(repo.dateNumber);
  		$("#fmDateCount").val(repo.dateCount);
  		$("#fmDateFixed").val(repo.dateFixed);
  		$("#fmRuleId").val(repo.ruleId);
  		if("2"==repo.rule){
	  		for(i = 1; i <= repo.dateCount; i++){
  				$(".serviceTime"+i).css("display", "block");
  				$(".serviceTime"+i+" input").val("");
  			}
	  		for(i = repo.dateCount+1; i <= 7; i++){
		  		$(".serviceTime"+i).css("display", "none");
	  			$(".serviceTime"+i+" input").val("");
	  		}
  		}else if("1"!=repo.rule){
  			$(".serviceTime1").css("display", "block");
			$(".serviceTime1 input").val("");
			for(i = 2; i <= 7; i++){
		  		$(".serviceTime"+i).css("display", "none");
	  			$(".serviceTime"+i+" input").val("");
	  		}
  		}else{
  			for(i = 1; i <= 7; i++){
		  		$(".serviceTime"+i).css("display", "none");
	  			$(".serviceTime"+i+" input").val("");
	  		}
  		}
  		return repo.ruleName || repo.text;
  	}
    
    function goBack(){
    	loadPage('${ctx}/contract/index.htm');
    }
    
    function goIndex(){
    	loadPage("${ctx}/index/index.htm");
    }
</script>