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
		合同浏览
    </h1>
	<ol class="breadcrumb">
		<li><a href="javascript:void(0);" onclick="goIndex();"><i class="fa fa-dashboard"></i> 首页</a></li>
        <li><a href="#">订单管理</a></li>
        <li class="active">合同浏览</li>
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
		               	<input class="form-control datepicker" readonly="readonly" name="fmSignDate" id="fmSignDate" type="text" disabled="disabled">
		              </div>
		            </div>
		            <div class="form-group">
		              <label class="col-sm-2 control-label">销售人员:</label>
		              <div class="col-md-4">
		                <input name="saleId" id="fmSaleId" class="form-control" readonly="readonly">
		              </div>
		              <label class="col-sm-2 control-label">联系方式:</label>
		              <div class="col-md-4">
		                <input name="phone" class="form-control" readonly="readonly" id="fmPhone">
		              </div>
		            </div>
		            <div class="form-group">
		              <label class="col-sm-2 control-label">出生日期:</label>
		              <div class="col-md-4">
		              	<input class="form-control datepicker" readonly="readonly" name="fmbirthday" id="fmBirthday" type="text" disabled="disabled">
		              </div>
		              <label class="col-sm-2 control-label">客户名称</label>
		              <div class="col-md-4">
		                <input name="custId" id="fmCustId" class="form-control" readonly="readonly">
		              </div>
		            </div>
		            <div class="form-group">
		              <label class="col-sm-2 control-label">服务房产:</label>
		              <div class="col-md-10">
		                <select class="form-control" name="houseId" multiple="multiple" id="fmContractHouseId" disabled="disabled"></select>
		              </div>
		            </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">套餐名称</label>
                        <div class="col-md-4">
                        	<input name="productId" id="fmProductId" class="form-control" readonly="readonly">
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
                        	<select class="form-control" name="payMethod" id="fmPayMethod"  disabled="disabled">
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
                        	<input name="ruleId" id="fmRuleId" class="form-control" readonly="readonly">
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
		                <select class="js-example-data-ajax form-control" id="fmActivityIdSelect" name="fmActivityIdSelect" multiple="multiple" disabled="disabled"></select>
		              </div>
		            </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label serviceTime1" style="display: none;">第一次服务时间:</label>
                        <div class="col-md-4 serviceTime1" style="display: none;">
                            <input class="form-control datetimepicker" id="serviceDate1" name="serviceDate" readonly="readonly" type="text" readonly="readonly" disabled="disabled">
                        </div>
                        <label class="col-sm-2 control-label serviceTime2" style="display: none;">第二次服务时间:</label>
                        <div class="col-md-4 serviceTime2" style="display: none;">
                            <input class="form-control datetimepicker" id="serviceDate2" name="serviceDate" readonly="readonly" type="text" readonly="readonly" disabled="disabled">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label serviceTime3" style="display: none;">第三次服务时间:</label>
                        <div class="col-md-4 serviceTime3" style="display: none;">
                            <input class="form-control datetimepicker" id="serviceDate3" name="serviceDate" readonly="readonly" type="text" readonly="readonly" disabled="disabled">
                        </div>
                        <label class="col-sm-2 control-label serviceTime4" style="display: none;">第四次服务时间:</label>
                        <div class="col-md-4 serviceTime4" style="display: none;">
                            <input class="form-control datetimepicker" id="serviceDate4" name="serviceDate" readonly="readonly" type="text" readonly="readonly" disabled="disabled">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label serviceTime5" style="display: none;">第五次服务时间:</label>
                        <div class="col-md-4 serviceTime5" style="display: none;">
                            <input class="form-control datetimepicker" id="serviceDate5" name="serviceDate" readonly="readonly" type="text" readonly="readonly" disabled="disabled">
                        </div>
                        <label class="col-sm-2 control-label serviceTime6" style="display: none;">第六次服务时间:</label>
                        <div class="col-md-4 serviceTime6" style="display: none;">
                            <input class="form-control datetimepicker" id="serviceDate6" name="serviceDate" readonly="readonly" type="text" readonly="readonly" disabled="disabled">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label serviceTime7" style="display: none;">第七次服务时间:</label>
                        <div class="col-md-4 serviceTime7" style="display: none;">
                            <input class="form-control datetimepicker" id="serviceDate7" name="serviceDate" readonly="readonly" type="text" readonly="readonly" disabled="disabled">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">备注:</label>
                        <div class="col-sm-10">
                            <textarea name="contractRemarks" class="form-control" id="fmContractRemarks"
								style="height: 90px;" readonly="readonly"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">合同图片:</label>
                        <div class="col-sm-10" id="contractImage">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" onclick="goBack()">返回</button>
                </div>
	            </form>
                </div>
                </div>
            </div>
        </div>
    </div>
</section>

<script type="text/javascript">
    var contractImg = [];
    var imgMap = {};
    $('.datepicker').datepicker({
        autoclose: true, format: "yyyy-mm-dd", language: "zh-CN", clearBtn: true,//清除按钮
        todayBtn: true,//今日按钮
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
    });
    
    function getContractInfo() {
    	var contractId = '${requestScope.contractId }';
    	$("#fmContractId").val(contractId);
		$.ajax({
			type : 'post',
			url : '${ctx}/contract/queryContractsByContractId.htm',
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
				activityContractList = data.data.activityContractList==null?[]:data.data.activityContractList;
				
				$('#fmSignDate').datepicker('setDate',new Date(contract.signDate));
				$("#fmSaleId").val((employee==null||employee.name==null)?'':employee.name);
				$("#fmCustId").val(customer.name);
				$("#fmProductId").val(product.productName);
		  		$("#fmProductAmount").val(product.productAmount);
		  		$("#fmServiceCount").val(product.serviceCount);
		  		$("#fmServiceTime").val(product.serviceTime);
		  		$("#fmSaleRate").val(product.saleRate);
		  		$("#fmState").val(product.dataFlag);
		  		$("#fmRuleId").val(rule.ruleName);
		  		$("#fmRule").val(rule.rule);
		  		$("#fmDateNumber").val(rule.dateNumber);
		  		$("#fmDateCount").val(rule.dateCount);
		  		$("#fmDateFixed").val(rule.dateFixed);
		  		$("#fmContractRemarks").val(contract.contractRemarks);
		  		$("#fmPhone").val(customer.phone);
				$("#fmBirthday").datepicker('setDate',new Date(customer.birthday));
				$("#fmPayMethod").val(contract.payMethod);
		  		
		  		$("#fmContractHouseId").empty();
				var contractHouselist = "";
				if(customerHouseContractList != null && customerHouseContractList.length > 0){
			  		for(var i = 0; i < customerHouseContractList.length; i++){
			  			contractHouselist += "<option value='"+customerHouseContractList[i].houseId+"'>"+customerHouseContractList[i].addressName+"</option>";
			  		}
					$("#fmContractHouseId").append(contractHouselist);
			  	}
				
				var activityContractStr = "";
				if(activityContractList != null && activityContractList.length > 0){
			  		for(var i = 0; i < activityContractList.length; i++){
			  			var activity="";
						if(activityContractList[i].activityType=='1')
							activity = activityContractList[i].activityName +"--套餐增加次数:"+activityContractList[i].count;
						else if(activityContractList[i].activityType=='2')
							activity = activityContractList[i].activityName +"--赠品增加次数数:"+activityContractList[i].count;
						else if(activityContractList[i].activityType=='3')
							activity = activityContractList[i].activityName +"--折扣:"+activityContractList[i].rebate;
			  			activityContractStr += "<option value='"+activityContractList[i].activityId+"'>"+activity+"</option>";
			  		}
					$("#fmActivityIdSelect").append(activityContractStr);
			  	}
				
				var imglist = "";
				if(contractImageList != null && contractImageList.length > 0){
			  		for(var i = 0; i < contractImageList.length; i++){
			  			imglist += "<img src='${ctx}/image/"+contractImageList[i].imageUrl+"' height='150' width='300' style='margin-right: 35px; margin-bottom: 10px;'/>";
			  		}
					document.getElementById("contractImage").innerHTML=imglist;
			  	}
				
		  		if("2"==rule.rule){
			  		for(i = 1; i <= rule.dateCount; i++){
		  				$(".serviceTime"+i).css("display", "block");
		  				$(".serviceTime"+i+" input").val("");
		  			}
			  		for(i = rule.dateCount+1; i <= 7; i++){
				  		$(".serviceTime"+i).css("display", "none");
			  			$(".serviceTime"+i+" input").val("");
			  		}
		  		}else if("1"!=rule.rule){
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
				if(dateList != null && dateList.length > 0){
			  		for(var i = 0; i < dateList.length; i++){
		  				$('#serviceDate'+(i+1)).datetimepicker('setDate',new Date(dateList[i]));
		  			}
				}
				
			},
			error : function() {
				goBack();
            }
		});
    }
    
	function goBack(){
    	
    	var flag = '${requestScope.flag }';
    	console.log(flag);
    	if(flag=='1'){
    		loadPage('${ctx}/contract/index.htm');
    	}
    	else if(flag=='2'){
    		loadPage('${ctx}/contract/checkContractIndex.htm');
    	}
    }
    
    function goIndex(){
    	loadPage("${ctx}/index/index.htm");
    }
    
</script>