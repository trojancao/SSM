<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="../common/taglibs.jsp" %>
<section class="content-header">
    <h1>
        	首页
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 首页</a></li>
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
                            <button type="button" class="btn btn-default" id="date0" onclick="queryOrder('0')"></button>
                            <button type="button" class="btn btn-default" id="date1" onclick="queryOrder('1')"></button>
                            <button type="button" class="btn btn-default" id="date2" onclick="queryOrder('2')"></button>
                            <button type="button" class="btn btn-default" id="date3" onclick="queryOrder('3')"></button>
                            <button type="button" class="btn btn-default" id="date4" onclick="queryOrder('4')"></button>
                            <button type="button" class="btn btn-default" id="date5" onclick="queryOrder('5')"></button>
                            <button type="button" class="btn btn-default" id="date6" onclick="queryOrder('6')"></button>
                                                                                                                派单状态:<select class="form-control"
									id="state" panelHeight="auto" style="width: 140px;" onchange="queryOrder()">
									<option value="">--请选择--</option>
									<option value="00">未派单</option>
									<option value="01">已派单</option>
									<option value="02">已使用</option>
									<option value="03">安排未成</option>
								</select>
                            </div>
                        </form>
                    </div>
                </div>
                
                <div class="box-body">
                    <div id="toolbar" class="btn-group">
                    </div>
                    <table id="order_table" class="table table-bordered table-striped table-hover">
                    </table>
                </div>
                
                <div class="box-body">
                    <div id="toolbar" class="btn-group">
                    </div>
                    <table id="cust_table" class="table table-bordered table-striped table-hover">
                    </table>
                </div>
            </div>
        </div>
        <!-- /.col -->
    </div>
    <!-- /.row -->
</section>

<script type="text/javascript">
    var dataList = [];
    var serviceDate;
    function initTable() {
        //先销毁表格
        $('#order_table').bootstrapTable('destroy');
        //初始化表格,动态从服务器加载数据
        $("#order_table").bootstrapTable({
            url: "${ctx}/order/queryOrder.htm", //获取数据的Servlet地址
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
            sortName : 'create_time',
            sortOrder: 'desc',
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
                field: 'orderId',
                title: '订单编号',
                sortable: false,
            }, {
                field: 'contractId',
                title: '合同编号',
                sortable: false,
            }, {
    			field : 'custName',
    			title : '客户名称',
    		}, {
    			field : 'productName',
    			title : '套餐名称',
    		}, {
    			field : 'amount',
    			title : '订单金额',
    			formatter : function(value, row, index) {
    				return value.toFixed(2);
    			}
    		}, {
    			field : 'totalCount',
    			title : '服务次数',
    		}, {
    			field : 'remainCount',
    			title : '剩余次数',
    		}, {
    			field : 'payType',
    			title : '支付方式',
    			formatter : function(value, row, index) {
    				if(value=='1'){
    					return "线下付款";
    				}else if(value=='2'){
    					return "在线支付";
    				}
    			}
    		}, {
    			field : 'commissionFee',
    			title : '销售佣金',
    			formatter : function(value, row, index) {
    				return value.toFixed(2);
    			}
    		}, {
    			field : 'createTime',
    			title : '下单时间',
    			sortable : false,
    			formatter : function(value, row, index) {
					if (null != value && "" != value) {
						return new Date(value).format("yyyy-MM-dd HH:mm:ss");
					}
				}
    		}, {
                field: 'orderDetailState',
                title: '操作',
                align: 'center',
                formatter:function(value,row,index){
                	if("00" == value){
	               		return '<a href="#" onclick="openDetailModel(\''+row.orderId+'\')">派单</a> ';
                	}
                } 
            }]],
            queryParams: function queryParams(params) {   //设置查询参数
                var requestPage = {
                    pageNumber: params.pageNumber,
                    pageSize: params.pageSize,
                    orderDetailState : $("#state").val(),
                    serviceDate: serviceDate,
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
    
    function initCustTable() {
        //先销毁表格
        $('#cust_table').bootstrapTable('destroy');
        //初始化表格,动态从服务器加载数据
        $("#cust_table").bootstrapTable({
            url: "${ctx}/customer/queryCustomerByBirthday.htm", //获取数据的Servlet地址
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
            sortName : 'cust_id',
            sortOrder: 'desc',
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
				field : 'custId',
				//                title: '编号',
				visible : false
			}, {
				field : 'name',
				title : '客户姓名',
				width : '20%',
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
			}]],
            queryParams: function queryParams(params) {   //设置查询参数
                var requestPage = {
                    pageNumber: params.pageNumber,
                    pageSize: params.pageSize,
                    birthdayMonth: (new Date(serviceDate)).getMonth()+1,
                    birthdayDate: (new Date(serviceDate)).getDate(),
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
    	getSysDate();
    });
    
	function openDetailModel(orderId) {
		loadPage('${ctx}/order/goOrderDetail.htm?orderId='+orderId);
    }
    
    function getSysDate() {
		$.ajax({
			type : 'post',
			url : '${ctx }/index/getSysDate.htm',
			dataType : "json",
			async : true,
			success : function(data) {
				dataList = data.data;
				for(var i = 0;i < 7; i++){
					$("#date"+i).text(data.data[i]);
				}
				queryOrder('1');
			}
		});
    }
    
    function queryOrder(item) {
    	if(item != null && item != ''){
    		serviceDate = $("#date"+item).text();
    		for(var i = 0;i < 7; i++){
				$("#date"+i).removeClass('btn-warning');
				$("#date"+i).addClass('btn-default');
			}
    		$("#date"+item).removeClass('btn-default');
			$("#date"+item).addClass('btn-warning');
    	}
    	//调用函数，初始化表格
        initTable();
        initCustTable();
    }
		  	
</script>