<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp"%>
<section class="content-header">
	<h1>
		客户信息 <small>列表</small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="javascript:void(0);" onclick="goIndex();"><i class="fa fa-dashboard"></i> 首页</a></li>
		<li><a href="#">业务管理</a></li>
		<li class="active">客户管理</li>
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
								客户姓名:<input id="name" class="form-control" type="text"
									style="width: 120px;" /> 
								证件号码:<input id="idNo"
									class="form-control" type="text" style="width: 180px;" />
								联系方式:<input id="phone" class="form-control" type="text"
									style="width: 150px;" /> 
								客户类型:<select class="form-control"
									id="custType" panelHeight="auto" style="width: 140px;">
									<option value="">--请选择--</option>
									<option value="1">个人</option>
									<option value="2">企业</option>
								</select>
							</div>
							<div class="form-group" style="width: 100%; margin-top: 15px;">
								客户居住小区:<input id="zone" class="form-control" type="text"
									style="width: 250px;" /> 
								客户居住地址:<input id="address"
									class="form-control" type="text" style="width: 380px;" />
								<div class="btn-group" style="float: right;">
									<button type="button" class="btn btn-primary" id="search"
										onclick="initTable()">查询</button>
									<button type="reset" class="btn btn-default" id="reset">重置</button>
								</div>
							</div>
						</form>
					</div>
				</div>

				<div class="box-body" id="box-body">
					<div id="toolbar" class="btn-group">
						<button id="btn_add" type="button" class="btn btn-default"
							data-toggle="modal" onclick="openAddModel()">
							<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
						</button>
						<button id="btn_edit" type="button" class="btn btn-default"
							onclick="openEditModel()">
							<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改
						</button>
						<button id="btn_delete" type="button" class="btn btn-default"
							onclick="openDeleteModel()">
							<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除
						</button>
					</div>
					<table id="user_table"
						class="table table-bordered table-striped table-hover">
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
			<form id="customerfm" method="post" role="customerfm"
				class="form-horizontal">
				<div class="modal-body">
					<input id="fmCustId" name="custId" type="hidden">
					<input id="fmHouseId" name="houseId" type="hidden">
					<div class="form-group customerInfo">
						<label class="col-sm-2 control-label">客户姓名:</label>
						<div class="col-md-4">
							<input name="name" id="fmName" type="text" class="form-control"
								maxlength="20">
						</div>
						<label class="col-sm-2 control-label">客户类型:</label>
						<div class="col-md-4">
							<select class="form-control" name="custType" id="fmCustType"
								onchange="getIdType(this.options[this.selectedIndex].value)">
								<option value="1">个人</option>
								<option value="2">企业</option>
							</select>
						</div>
					</div>
					<div class="form-group customerInfo">
						<label class="col-sm-2 control-label">证件类型:</label>
						<div class="col-md-4">
							<select class="form-control" name="idType" id="fmIdType"
								onchange="cleanIdNo()">
								<option value="">--请选择--</option>
							</select>
						</div>
						<label class="col-sm-2 control-label">证件号码:</label>
						<div class="col-md-4">
							<input name="idNo" class="form-control" id="fmIdNo">
						</div>
					</div>
					<div class="form-group customerInfo">
						<label class="col-sm-2 control-label">联系方式:</label>
						<div class="col-md-4">
							<input name="phone" class="form-control" maxlength="11"
								id="fmPhone">
						</div>
						<label class="col-sm-2 control-label">出生日期:</label>
						<div class="col-md-4">
							<input type="text" name="fmbirthday" id="fmBirthday"
								readonly="readonly" class="form-control datepicker"> <input
								type="hidden" name="birthday" id="birthday" disabled="disabled">
						</div>
					</div>
					<div class="form-group customerInfo">
						<label class="col-sm-2 control-label">备注:</label>
						<div class="col-md-10">
							<textarea name="memo" class="form-control" id="fmMemo"
								style="height: 90px;"></textarea>
						</div>
					</div>
					<div class="form-group customerHouseInfo">
						<label class="col-sm-2 control-label">房屋地址:</label>
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
						<div class="col-md-3" id='townSelect'>
							<select class="form-control" name="town" id="town">
							</select>
						</div>
					</div>
					<div class="form-group customerHouseInfo">
						<label class="col-sm-2 control-label">所在小区:</label>
						<div class="col-md-4">
							<input name="zone" class="form-control" id="fmZone" />
						</div>
						<label class="col-sm-2 control-label">房屋面积:</label>
						<div class="col-md-4">
							<input name="area" class="form-control" id="fmArea" />
						</div>
					</div>
					<div class="form-group customerHouseInfo">
						<label class="col-sm-2 control-label">详细地址:</label>
						<div class="col-md-10">
							<input name="address" class="form-control" id="fmAddress" />
						</div>
					</div>
					<div class="form-group customerHouseInfo">
						<label class="col-sm-2 m">备注:</label>
						<div class="col-md-10">
							<textarea name="houseMemo" class="form-control" id="fmHouseMemo"
								style="height: 90px;"></textarea>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
						<button type="button" class="btn btn-primary customerInfoButton"
							onclick="save()">下一步</button>
						<button type="button"
							class="btn btn-primary customerHouseInfoButton"
							onclick="saveHouse(0)">添加房产</button>
						<button type="button"
							class="btn btn-primary customerHouseInfoButton save"
							onclick="saveHouse(1)">保存</button>
					</div>
				</div>
			</form>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->
</div>

<script type="text/javascript">
	var url;
	var cur_table;
	$('.datepicker').datepicker({
		autoclose : true,
		format : "yyyy-mm-dd",
		language : "zh-CN",
		clearBtn : true,//清除按钮
		todayBtn : true,//今日按钮
	});
	function initTable() {
		//先销毁表格
		$('#user_table').bootstrapTable('destroy');
		//初始化表格,动态从服务器加载数据
		$("#user_table").bootstrapTable({
			url : "${ctx}/customer/queryCustomer.htm", //获取数据的Servlet地址
			striped : true, //表格显示条纹
			locale : 'zh-CN',
			clickToSelect : true,
			singleSelect : true,
			//            cardView: true,
			method : 'post',
			contentType : 'application/x-www-form-urlencoded',
			cache : false,
			pageNumber : 1,
			checkboxHeader : true,
			smartDisplay : false,
			sortName : 'cust_id',
			pageSize : 10,
			pageList : [ 10, 25, 50 ],
			toolbar : '#toolbar',
			showToggle : true,
			pagination : true, //启动分页
			showPaginationSwitch : true,
			detailView : true,
			search : false, //是否启用查询
			showColumns : true, //显示下拉框勾选要显示的列
			showRefresh : true, //显示刷新按钮
			sidePagination : "server", //表示服务端请求
			//设置为undefined可以获取pageNumber，pageSize，searchText，sortName，sortOrder
			//设置为limit可以获取limit, offset, search, sort, order
			queryParamsType : "undefined",
			responseHandler : function(res) {
				return res.data;
			},
			columns : [ [ {
				checkbox : true
			}, {
				field : 'custId',
				//                title: '编号',
				visible : false
			}, {
				field : 'name',
				title : '客户姓名',
				width : '10%',
				align : 'left',
				halign : 'center',
			}, {
				field : 'custType',
				title : '客户类型',
				width : '5%',
				align : 'left',
				halign : 'center',
				formatter : function(value, row, index) {
					if (value == '1') {
						return "个人";
					} else if (value == '2') {
						return "企业";
					}
				}
			}, {
				field : 'idType',
				title : '证件类型',
				width : '10%',
				align : 'left',
				halign : 'center',
				formatter : function(value, row, index) {
					if ("1" == row.custType) {
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
						} else if (value == 't') {
							return "台胞证";
						}
					} else {
						if (value == '1') {
							return "企业代码";
						} else if (value == '2') {
							return "营业执照";
						} else if (value == '3') {
							return "社会团体证";
						} else if (value == '4') {
							return "其他";
						} else if (value == '5') {
							return "社会信用代码";
						}
					}
				}
			}, {
				field : 'idNo',
				title : '证件号码',
				width : '18%',
				align : 'left',
				halign : 'center',
			}, {
				field : 'phone',
				title : '联系方式',
				width : '12%',
				align : 'left',
				halign : 'center',
			}, {
				field : 'birthday',
				title : '出生日期',
				width : '10%',
				align : 'left',
				halign : 'center',
				formatter : function(value, row, index) {
					if (null != value && "" != value) {
						return new Date(value).format("yyyy-MM-dd");
					}
				}
			}, {
				field : 'createTime',
				title : '注册时间',
				width : '10%',
				align : 'left',
				halign : 'center',
				formatter : function(value, row, index) {
					return new Date(value).format("yyyy-MM-dd");
				}
			}, {
				field : 'custStatus',
				title : '客户状态',
				width : '5%',
				align : 'left',
				halign : 'center',
				formatter : function(value, row, index) {
					if (value == '0') {
						return "停用";
					} else {
						return "启用";
					}
				}
			}, {
				field : 'memo',
				title : '备注',
				width : '20%',
				align : 'left',
				halign : 'center',
			} ] ],
			//index：父表当前行的行索引。
			//row：父表当前行的Json数据对象。
			//$detail：当前行下面创建的新行里面的td对象。
			onExpandRow : function(index, row, $detail) {
				InitSubTable(index, row, $detail);
			},
			queryParams : function queryParams(params) { //设置查询参数
				var requestPage = {
					pageNumber : params.pageNumber,
					pageSize : params.pageSize,
					sortName : params.sortName,
					sortOrder : params.sortOrder,

					name : $("#name").val(),
					idNo : $("#idNo").val(),
					phone : $("#phone").val(),
					custType : $("#custType").val(),
					zone : $("#zone").val(),
					address : $("#address").val(),
				};
				return requestPage;
			},
			onClickRow : function(item, $element) {
				$('.info').removeClass('info');//去除之前选中的行的，选中样式
				$element.toggleClass('info');//添加当前选中的 success样式用于区别
				return false;
			}
		});
	}

	function InitSubTable(index, row, $detail) {
		var custId = row.custId;
		var parent = document.getElementById("box-body");
    	var div = document.createElement("div");
    	div.setAttribute('id', 'toolbar1');
    	div.setAttribute('class', 'btn-group');
    	div.innerHTML = "<button id='btn_add' type='button' class='btn btn-default' data-toggle='modal' onclick='openAddHouseModel(\""+custId+"\")'>"
    					+"<span class='glyphicon glyphicon-plus' aria-hidden='true'></span>新增房产</button>"
    					+"<button id='btn_edit' type='button' class='btn btn-default' onclick='openEditHouseModel()'>"
    					+"<span class='glyphicon glyphicon-pencil' aria-hidden='true'></span>修改房产</button>"
    					+"<button id='btn_delete' type='button' class='btn btn-default' onclick='openDeleteHouseModel()'>"
    					+"<span class='glyphicon glyphicon-remove' aria-hidden='true'></span>删除 房产</button>";
    	parent.appendChild(div);
		
		cur_table = $detail.html('<table></table>').find('table');
		$(cur_table).bootstrapTable({
			url : '${ctx}/customer/queryCustomerHouse.htm',
			method : 'get',
			striped : true, //表格显示条纹
			locale : 'zh-CN',
			clickToSelect : true,
			singleSelect : true,
			showRefresh : true, //显示刷新按钮
			queryParams : {
				'custId' : custId
			},
			ajaxOptions : {
				'custId' : custId
			},
			clickToSelect : true,
			//             detailView: true,//父子表
			uniqueId : "custId",
			pageSize : 10,
			pageList : [ 10, 25 ],
			toolbar : '#toolbar1',
			columns : [ {
				checkbox : true
			}, {
				field : 'customerHouseId',
				//                title: '编号',
				visible : false
			}, {
				field : 'addressName',
				title : '房产地址',
				width : '65%',
				align : 'left',
				halign : 'center'
			}, {
				field : 'area',
				title : '房产面积(㎡)',
				width : '10%',
				align : 'left',
				halign : 'center',
			}, {
				field : 'memo',
				title : '备注',
				width : '20%',
				align : 'left',
				halign : 'center',
			} ]
		});
	}

	$(document).ready(
		function() {
			//调用函数，初始化表格
			initTable();

			//当点击查询按钮的时候执行
			$('#customerfm').bootstrapValidator({
				message : 'This value is not valid',
				feedbackIcons : {
					valid : 'glyphicon glyphicon-ok',
					invalid : 'glyphicon glyphicon-remove',
					validating : 'glyphicon glyphicon-refresh'
				},
				fields : {
					name : {
						validators : {
							notEmpty : {
								message : '客户姓名不能为空'
							},
							stringLength : {
								min : 1,
								max : 10,
								message : '客户姓名长度必须在1到10位之间'
							},
						}
					},
					custType : {
						validators : {
							notEmpty : {
								message : '客户类型不能为空'
							}
						}
					},
					idType : {
						validators : {
							notEmpty : {
								message : '证件类型不能为空'
							}
						}
					},
					idNo : {
						validators : {
							callback : {
								message : '请输入正确的身份证号',
								callback : function(value, validator, $field) {
									if ('1' == $("#fmCustType").val() && '1' == $("#fmIdType").val()
											&& null != value && "" != value) {
										var reg = /(^[1-9]\d{5}(18|19|([23]\d))\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$)|(^[1-9]\d{5}\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{2}$)/;
										if (reg.test(value)) {
											if (null == $("#fmBirthday").val() || "" == $("#fmBirthday").val()) {
												var year = value.substr(6, 4);
												var month = value.substr(10, 2);
												month = parseInt(month) - 1;
												var day = value.substr(12, 2)
												var now = new Date(year, month, day, 00, 00, 00);
												var exp_date = new Date(now);
												$('#fmBirthday').datepicker('setDate',exp_date);
											}
											return true;
										} else {
											return false;
										}
									} else {
										return true;
									}
								}
							}
						}
					},
					phone : {
						validators : {
							notEmpty : {
								message : '联系方式不能为空'
							},
							stringLength : {
								min : 11,
								max : 11,
								message : '请输入11位手机号码'
							},
							regexp : {
								regexp : /^1[3|5|8]{1}[0-9]{9}$/,
								message : '请输入正确的手机号码'
							}
						}
					},
					province : {
						validators : {
							notEmpty : {
								message : '请选择省'
							},
						}
					},
					city : {
						validators : {
							notEmpty : {
								message : '请选择市'
							},
						}
					},
					town : {
						validators : {
							notEmpty : {
								message : '请选择区'
							},
						}
					},
					address : {
						validators : {
							notEmpty : {
								message : '详细地址不能为空'
							},
							stringLength : {
								min : 1,
								max : 40,
								message : '详细地址长度必须在1到40位之间'
							},
						}
					},
					area : {
						validators : {
							notEmpty : {
								message : '房屋面积不能为空'
							},
							regexp : {
								regexp : /^([1-9][\d]{0,8})(\.[\d]{1,2})?$/,
								message : '请输入正确的房屋面积'
							},
						}
					},
					memo : {
						validators : {
							stringLength : {
								max : 100,
								message : '备注字数不能大于100'
							},
						}
					},
					houseMemo : {
						validators : {
							stringLength : {
								max : 100,
								message : '备注字数不能大于100'
							},
						}
					}
				}
			});
		});

	function openDeleteModel() {
		var rowData = $("#user_table").bootstrapTable('getSelections',
				function(row) {
					return row;
				});
		if (rowData.length != 1) {
			$.globalMessenger().post({
				message : '请选择一条记录',//提示信息
				type : 'error',//消息类型。error、info、success
				hideAfter : 4,
				hideOnNavigate : true
			});
			return;
		}
		BootstrapDialog.confirm({
			title : '确认',
			message : '确定删除客户[' + rowData[0].name + ']吗?',
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
						url : '${ctx}/customer/deleteCustomer.htm',
						type : 'POST',//PUT DELETE POST
						data : {
							'custId' : rowData[0].custId
						},
						dataType : "json",
						success : function(data) {
							if (data.result == 1) {
								initTable();
							} else {
								$.globalMessenger().post({
									message : data.msg,//提示信息
									type : 'error',//消息类型。error、info、success
									hideAfter : 4,
									hideOnNavigate : true
								});
							}
						}
					})
				}
			}
		});
	}
	
	function openDeleteHouseModel() {
		var rowData = $(cur_table).bootstrapTable('getSelections',
				function(row) {
					return row;
				});
		if (rowData.length != 1) {
			$.globalMessenger().post({
				message : '请选择一条记录',//提示信息
				type : 'error',//消息类型。error、info、success
				hideAfter : 4,
				hideOnNavigate : true
			});
			return;
		}
		BootstrapDialog.confirm({
			title : '确认',
			message : '确定删除客户[' + rowData[0].addressName + ']的房产信息吗?',
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
						url : '${ctx}/customer/deleteCustomerHouse.htm',
						type : 'POST',//PUT DELETE POST
						data : {
							'custId' : rowData[0].custId,
							'customerHouseId' : rowData[0].customerHouseId
						},
						dataType : "json",
						success : function(data) {
							if (data.result == 1) {
								$("#user_table button[name='refresh']").click();
							} else {
								$.globalMessenger().post({
									message : data.msg,//提示信息
									type : 'error',//消息类型。error、info、success
									hideAfter : 4,
									hideOnNavigate : true
								});
							}
						}
					})
				}
			}
		});

	}
	
	function openAddModel() {
		$("#customerfm input").val("");
		$('#customerfm').data('bootstrapValidator').resetForm(true);
		$('#myModal').modal('show');
		$("#myModalLabel").html('新增客户信息');
		$("#city").empty();
		$("#fmCustType").val('1');
		getIdType('1');
		getRegion('0', 'province');
		$("#province").val('31');
		getRegion('31', 'city');
		$("#city").val('3102');
		getRegion('3102', 'town');
		$("#birthday").attr("disabled", "disabled");
		$(".customerInfo").css("display", "block");
		$(".customerHouseInfo").css("display", "none");
		$(".customerInfoButton").css("display", "inline-block");
		$(".customerHouseInfoButton").css("display", "none");
		url = '${ctx}/customer/addCustomer.htm';
	}
	function openAddHouseModel(custId) {
		$("#customerfm input").val("");
		$("#fmCustId").val(custId);
		$('#customerfm').data('bootstrapValidator').resetForm(true);
		$('#myModal').modal('show');
		$("#myModalLabel").html('新增客户房产信息');
		$("#city").empty();
		getRegion('0', 'province');
		$("#province").val('31');
		getRegion('31', 'city');
		$("#city").val('3102');
		getRegion('3102', 'town');
		$(".customerInfo").css("display", "none");
		$(".customerHouseInfo").css("display", "block");
		$(".customerInfoButton").css("display", "none");
		$(".customerHouseInfoButton").css("display", "inline-block");
		url = '${ctx}/customer/addCustomerHouse.htm';
	}

	function openEditModel() {
		var rowData = $("#user_table").bootstrapTable('getSelections',
			function(row) {
				return row;
			});
		if (rowData.length != 1) {
			$.globalMessenger().post({
				message : '请选择一条记录',//提示信息
				type : 'error',//消息类型。error、info、success
				hideAfter : 4,
				hideOnNavigate : true
			});
		} else {
			$('#customerfm').data('bootstrapValidator').resetForm(true);
			$('#myModal').modal('show');
			$("#myModalLabel").html('修改客户信息');
			$("#birthday").attr("disabled", "disabled");
			$(".customerInfo").css("display", "block");
			$(".customerHouseInfo").css("display", "none");
			$(".customerInfoButton").css("display", "none");
			$(".customerHouseInfoButton").css("display", "none");
			$(".save").css("display", "inline-block");
			url = '${ctx}/customer/modifyCustomer.htm';
			getIdType(rowData[0].custType);
			$("#fmCustId").val(rowData[0].custId);
			$("#fmName").val(rowData[0].name);
			$("#fmCustType").val(rowData[0].custType);
			$("#fmIdType").val(rowData[0].idType);
			$("#fmIdNo").val(rowData[0].idNo);
			$("#fmPhone").val(rowData[0].phone);
			$("#fmMemo").val(rowData[0].memo);
			if (null != rowData[0].birthday && "" != rowData[0].birthday) {
				$("#fmBirthday").datepicker('setDate',
						new Date(rowData[0].birthday));
			}
		}
	}

	function openEditHouseModel() {
		var rowData = $(cur_table).bootstrapTable('getSelections',
			function(row) {
				return row;
			});
		if (rowData.length != 1) {
			$.globalMessenger().post({
				message : '请选择一条记录',//提示信息
				type : 'error',//消息类型。error、info、success
				hideAfter : 4,
				hideOnNavigate : true
			});
		} else {
			$('#customerfm').data('bootstrapValidator').resetForm(true);
			$('#myModal').modal('show');
			$("#myModalLabel").html('修改客户房产信息');
			$(".customerInfo").css("display", "none");
			$(".customerHouseInfo").css("display", "block");
			$(".customerInfoButton").css("display", "none");
			$(".customerHouseInfoButton").css("display", "none");
			$(".save").css("display", "inline-block");
			$("#fmCustId").val(rowData[0].custId);
			$("#fmHouseId").val(rowData[0].houseId);
			getRegion('0', 'province');
			$("#province").val(rowData[0].province);
			getRegion(rowData[0].province, 'city');
			$("#city").val(rowData[0].city);
			getRegion(rowData[0].city, 'town');
			$("#town").val(rowData[0].town);
			$("#fmZone").val(rowData[0].zone);
			$("#fmArea").val(rowData[0].area);
			$("#fmAddress").val(rowData[0].address);
			$("#fmHouseMemo").val(rowData[0].memo);
			url = '${ctx}/customer/modifyCustomerHouse.htm';
		}
	}
	
	function save() {
		var bootstrapValidator = $("#customerfm").data('bootstrapValidator');
		bootstrapValidator.validate();
		if (bootstrapValidator.isValid()) {
			if (null != $("#fmBirthday").val() && "" != $("#fmBirthday").val()) {
				$("#birthday").removeAttr("disabled");
				$("#birthday").val(new Date($("#fmBirthday").val()));
			}
			$.ajax({
				url : url,
				async : true,//同步，会阻塞操作
				type : 'POST',//PUT DELETE POST
				data : $("#customerfm").serialize(),
				dataType : "json",
				success : function(data) {
					if (data.result == 1) {
						$(".customerInfo").css("display", "none");
						$(".customerHouseInfo").css("display", "block");
						$(".customerInfoButton").css("display", "none");
						$(".customerHouseInfoButton").css("display",
								"inline-block");
						url = '${ctx}/customer/addCustomerHouse.htm';
						$("#fmCustId").val(data.data);
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

	function saveHouse(saveType) {
		var bootstrapValidator = $("#customerfm").data('bootstrapValidator');
		bootstrapValidator.validate();
		if (bootstrapValidator.isValid()) {
			if (null != $("#fmBirthday").val() && "" != $("#fmBirthday").val()) {
				$("#birthday").removeAttr("disabled");
				$("#birthday").val(new Date($("#fmBirthday").val()));
			}
			$("#fmMemo").val($("#fmHouseMemo").val());
			$.ajax({
				url : url,
				async : true,//同步，会阻塞操作
				type : 'POST',//PUT DELETE POST
				data : $("#customerfm").serialize(),
				dataType : "json",
				success : function(data) {
					if (data.result == 1) {
						if ("0" == saveType) {
							$(".customerHouseInfo input").val("");
							$('#customerfm').data('bootstrapValidator')
									.resetForm(true);
							$("#province").val('31');
							getRegion('31', 'city');
							$("#city").val('3102');
							getRegion('3102', 'town');
							$(".customerInfo").css("display", "none");
							$(".customerHouseInfo").css("display", "block");
							$(".customerInfoButton").css("display", "none");
							$(".customerHouseInfoButton").css("display",
									"inline-block");
							if(url == '${ctx}/customer/addCustomerHouse.htm'){
								$("#user_table button[name='refresh']").click();
							}
						} else {
							$('#myModal').modal('hide');
							if(url == '${ctx}/customer/addCustomerHouse.htm' || url == '${ctx}/customer/modifyCustomerHouse.htm'){
								$("#user_table button[name='refresh']").click();
							}else{
								initTable();
							}
						}
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

	function getRegion(areaId, divId) {
		$("#" + divId).empty();
		$("#town").empty();
		$.ajax({
			type : 'post',
			url : '${ctx }/region/getRegion.htm',
			dataType : "json",
			async : false,
			data : {
				'areaId' : areaId
			},
			success : function(data) {
				var depart_list = data;
				if ("town" == divId && depart_list.length < 1) {
					$("#townSelect").css("display", "none");
					return;
				} else {
					$("#townSelect").css("display", "block");
				}
				var opts = "<option value=''>---请选择---</option>";
				for (var depart_index = 0; depart_index < depart_list.length; depart_index++) {
					var depart = depart_list[depart_index];
					opts += "<option value='" + depart.regionCode + "'>"
							+ depart.regionName + "</option>";
				}
				$("#" + divId).append(opts);

			}
		});
	}

	function getIdType(custType) {
		$("#fmIdType").empty();
		var idTypelist = "";
		if ("1" == custType) {
			idTypelist += "<option value='1' selected>身份证</option>";
			idTypelist += "<option value='2'>户口簿</option>";
			idTypelist += "<option value='3'>军人证</option>";
			idTypelist += "<option value='4'>武警证</option>";
			idTypelist += "<option value='5'>回乡证</option>";
			idTypelist += "<option value='6'>港澳台通行证</option>";
			idTypelist += "<option value='7'>护照</option>";
			idTypelist += "<option value='8'>临时身份证</option>";
			idTypelist += "<option value='t'>台胞证</option>";
		} else {
			idTypelist += "<option value='1' selected>企业代码</option>";
			idTypelist += "<option value='2'>营业执照</option>";
			idTypelist += "<option value='3'>社会团体证</option>";
			idTypelist += "<option value='4'>其他</option>";
			idTypelist += "<option value='5'>社会信用代码</option>";
		}
		$("#fmIdType").append(idTypelist);
	}

	function cleanIdNo() {
		if (null != $("#fmIdNo").val() && "" != $("#fmIdNo").val()) {
			var bootstrapValidator = $("#customerfm")
					.data('bootstrapValidator');
			bootstrapValidator.updateStatus('idNo', 'NOT_VALIDATED')
					.validateField('idNo');
		}
	}
	
    function goIndex(){
    	loadPage("${ctx}/index/index.htm");
    }
</script>
