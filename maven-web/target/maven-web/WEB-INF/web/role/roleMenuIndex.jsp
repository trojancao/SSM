<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="../common/taglibs.jsp" %>
<section class="content-header">
    <h1>
        角色授权
        <small>列表</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="javascript:void(0);" onclick="goIndex();"><i class="fa fa-dashboard"></i> 首页</a></li>
        <li><a href="#">系统管理</a></li>
        <li class="active">角色授权</li>
    </ol>
</section>
<section class="content">
    <%--<div class="row">--%>
    <div class="row">
        <div class="col-xs-8">
            <div class="box">
                <div class="box-body">
                    <table id="roleTable" class="table table-bordered table-striped table-hover">
                    </table>
                </div>
            </div>
            <!-- /.box-body -->
        </div>
        <!-- /.col -->
        <%--</div>--%>
        <div class="col-xs-4">
            <div class="box">
                <div class="box-body">
                    <span style="float: left;"><h5>当前角色：</h5></span>
                    <span id="roleUserSpan" style="float: left;">
                    </span>
                </div>
                <div class=" box-body" id="searchDiv">
                    <div style="float: right;">
                        <button type="button" class="btn btn-primary" onclick="editRoleMenu()">授权
                        </button>
                    </div>

                </div>
                <div class="box-body">
                    <div id="tree"></div>
                </div>
            </div>
            </table>

        </div>
    </div>
    <!-- /.row -->
</section>

<script type="text/javascript">
    function editRoleMenu() {

        var rowData2 = $("#roleTable").bootstrapTable('getSelections', function (row) {
            return row;
        });
        if (rowData2.length != 1) {
            $.globalMessenger().post({
                message: '请选择一条记录',//提示信息
                type: 'error',//消息类型。error、info、success
                hideAfter: 4,
                hideOnNavigate: true
            });
            return;
        }

        BootstrapDialog.confirm({
            title: '提示',
            message: '确定要给角色[' + rowData2[0].roleName + '] 授权吗?',
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
                    var checkedNodes=$("#tree").treeview('getChecked');
                    var menuIdList =[];
                    for(var i in checkedNodes){
                        menuIdList.push(checkedNodes[i].id);
                    }
                    $.ajax({
                        url: '${ctx}/roleMenu/modifyRoleMenuByRoleId.htm',
                        type: 'POST',//PUT DELETE POST
                        dataType: "json",
                        data: {'roleId': rowData2[0].roleId,'menuIdList':menuIdList},
                        success: function (data) {

                            if (data.result == 1) {
                                initTree('${ctx}/roleMenu/queryRoleMenuByRoleId.htm',rowData2[0].roleId);
                                $.globalMessenger().post({
                                    message: data.msg,//提示信息
                                    type: 'success',//消息类型。error、info、success
                                    hideAfter: 4,
                                    hideOnNavigate: true
                                });
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


    $(document).ready(function () {
        //调用函数，初始化表格
        initTable();
        initTree('${ctx}/roleMenu/queryAllMenu.htm', null);

    });
    function initTable() {
        //先销毁表格
        $('#roleTable').bootstrapTable('destroy');
        //初始化表格,动态从服务器加载数据
        $("#roleTable").bootstrapTable({
            url: '${ctx}/role/queryAllRole.htm', //获取数据的Servlet地址
            striped: true,  //表格显示条纹
            locale: 'zh-CN',
            clickToSelect: true,
            singleSelect: true,
            method: 'post',
            contentType: 'application/x-www-form-urlencoded',
            cache: false,
            sortName:'role_id',
            sortable: false,
            pageNumber: 1,
            checkboxHeader: true,
            smartDisplay: false,
            pageSize: 10,
            pageList: [10, 25, 50],
            toolbar: '#toolbar',
//            showToggle: true,
            pagination: true, //启动分页
//            showPaginationSwitch: true,
            search: false,  //是否启用查询
//            showColumns: true,  //显示下拉框勾选要显示的列
            showRefresh: true,  //显示刷新按钮
            sidePagination: "server", //表示服务端请求
            queryParamsType: "undefined",
            responseHandler: function (res) {
                if (res.result == 0) {
                    $.globalMessenger().post({
                        message: res.msg,//提示信息
                        type: 'error',//消息类型。error、info、success
                        hideAfter: 4,
//                            showCloseButton:true,
                        hideOnNavigate: true
                    });
                    return {};
                }
                return res.data;
            },
            onClickRow: function (item, $element) {
                $('.info').removeClass('info');//去除之前选中的行的，选中样式
                $element.toggleClass('info');//添加当前选中的 success样式用于区别
                return false;
            },
            onCheck:function(row) {
                $("#roleUserSpan").html("<h3 style='margin-top: 0px;'>【" + row.roleName + "】</h3>");
                initTree('${ctx}/roleMenu/queryRoleMenuByRoleId.htm', row.roleId);
            },
            columns: [[{
                checkbox: true
            }, {
                field: 'roleId',
                title: '编号',
                visible: false
            }, {
                field: 'roleName',
                title: '角色名称',
                width: '40%',
                sortable: true,
//                sortName:'role_name',
                align:'left',
                halign:'center'
            }, {
                field: 'createTime',
                title: '创建时间',
                width: '30%',
                sortable: true,
//                sortName:'create_time',
                align:'left',
                halign:'center',
                formatter: function (value, row, index) {
                    return new Date(value).format("yyyy-MM-dd HH:mm:ss");
                }
            }, {
                field: 'updateTime',
                title: '更新时间',
                width: '30%',
                align:'left',
                halign:'center',
                formatter: function (value, row, index) {
                    return new Date(value).format("yyyy-MM-dd HH:mm:ss");
                }
            }]]
        });
    }

    var allCheck = true;
    function initTree(url, roleId) {
        allCheck = true;
        $.ajax({
            url: url,//'${ctx}/roleMenu/queryAllMenu.htm',
            type: 'POST',//PUT DELETE POST
            dataType: "json",
            data: {'roleId': roleId},
            success: function (data) {
                if (data.result == 1) {
                    parseData(data.data);
                    $('#tree').treeview({
                        data: data.data,
                        levels: 2,
                        showBorder: true,
                        multiSelect: true,
                        showCheckbox: true,
                        showIcon: false,
                        onNodeChecked: function (event, node) { //选中节点
                            if(!allCheck){
                                return;
                            }
                            var selectNodes = getChildNodeIdArr(node); //获取所有子节点
                            if (selectNodes) { //子节点不为空，则选中所有子节点
                                $('#tree').treeview('checkNode', [selectNodes, {silent: true}]);
                            }
                            var parentNode = $("#tree").treeview("getNode", node.parentId);
                            setParentNodeCheck(node);
                        },
                        onNodeUnchecked: function (event, node) { //取消选中节点
                            // 取消父节点 子节点取消
//                            var selectNodes = setChildNodeUncheck(node); //获取未被选中的子节点
                            var childNodes = getChildNodeIdArr(node);    //获取所有子节点
                            if (childNodes && childNodes.length > 0) { //子节点不为空，则取消选中所有子节点
//                                console.log("反选");
                                $('#tree').treeview('uncheckNode', [childNodes, {silent: true}]);
                            }
                            // 取消节点 父节点取消
                            setParentNodeCheck(node);
                        }
                    });
                } else {
                    $.globalMessenger().post({
                        message: data.msg,//提示信息
                        type: 'error',//消息类型。error、info、success
                        hideAfter: 4,
                        hideOnNavigate: true
                    });
                }
            }
        });

    }

    function parseData(data) {
        for (var d in data) {
            if (data[d].checked) {
                data[d].state = {checked: data[d].checked};
            }
            data[d].nodeId = data[d].id;
            if (data[d].nodes) {
                parseData(data[d].nodes);
            }
        }
    }
    // 选中父节点时，选中所有子节点
    function getChildNodeIdArr(node) {
        var ts = [];
        if (node.nodes) {
            for (x in node.nodes) {
//                console.log(node.nodes[x].nodeId);
//                console.log(node.nodes[x].id);
                ts.push(node.nodes[x].nodeId);
                if (node.nodes[x].nodes) {
                    var getNodeDieDai = getChildNodeIdArr(node.nodes[x]);
                    for (j in getNodeDieDai) {
                        ts.push(getNodeDieDai[j]);
                    }
                }
            }
        } else {
            ts.push(node.nodeId);
        }
        return ts;
    }

    // 选中所有子节点时，选中父节点 取消子节点时取消父节点
    function setParentNodeCheck(node) {

        var parentNode = $("#tree").treeview("getNode", node.parentId);
        if (parentNode.nodes) {
            var checkedCount = 0;
            for (x in parentNode.nodes) {
                if (parentNode.nodes[x].state.checked) {
                    checkedCount++;
                }
            }
            if (checkedCount >0) {  //如果子节点全部被选 父全选
//            if (checkedCount == parentNode.nodes.length) {  //如果子节点全部被选 父全选
                allCheck=false;
                $("#tree").treeview("checkNode", parentNode.nodeId);
                setParentNodeCheck(parentNode);
                allCheck=true;
            } else if(checkedCount==0){   //如果子节点未全部被选 父未全选
                $('#tree').treeview('uncheckNode', parentNode.nodeId);
                setParentNodeCheck(parentNode);
            }
        }
    }
    // 取消父节点时 取消所有子节点
    function setChildNodeUncheck(node) {
        if (node.nodes) {
            var ts = [];    //当前节点子集中未被选中的集合
            for (x in node.nodes) {
                if (!node.nodes[x].state.checked) {
                    ts.push(node.nodes[x].nodeId);
                }
                if (node.nodes[x].nodes) {
                    var getNodeDieDai = node.nodes[x];
//                    console.log(getNodeDieDai);
                    for (j in getNodeDieDai) {
                        if (!getNodeDieDai.nodes[x].state.checked) {
                            ts.push(getNodeDieDai[j]);
                        }
                    }
                }
            }
        }
        return ts;
    }
    
    function goIndex(){
    	loadPage("${ctx}/index/index.htm");
    }
</script>