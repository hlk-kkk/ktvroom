<%@page isELIgnored="false" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html >
<head>
    <meta name="renderer" content="webkit">

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <%@include file="link.jsp" %>
    <script>


    </script>
</head>
<body class="easyui-layout">
<div id="goodsstock_tb">
    <a href="#" class="easyui-linkbutton" onclick="goodsstock.add()" title="添加库存"
       data-options="iconCls:'icon-add',plain:true"/>
    <a href="#" class="easyui-linkbutton" onclick="goodsstock.update1()" title="修改库存信息"
       data-options="iconCls:'icon-reload',plain:true"/>
    <a href="#" class="easyui-linkbutton" onclick="goodsstock.delete()" title="删除选中"
       data-options="iconCls:'icon-cancel',plain:true"/>
</div>
<div id="goodsstock_add" hidden>
    <form id="goodsstock_ff2" method="post" enctype="multipart/form-data">
        <table style="font-size:15px;font-family: 楷体">
            <tr style="height: 30px">
                <td>商品名称</td>
                <td>
                    <input type="text" class="easyui-textbox" data-options="required:true"
                           style="width:100px;text-align: left" name="goods.goodsname"/></td>
            </tr>
            <tr style="height: 30px">
                <td>商品类型</td>
                <td>
                    <input class="easyui-combobox" name="goods.goodstype.goodstypeid"
                           data-options="valueField:'goodstypeid',textField:'goodsname',url:'${pageContext.request.contextPath}/goodstype/showAll'"/>
            </tr>
            <tr style="height: 30px">
                <td>商品数量</td>
                <td>
                    <input type="text" class="easyui-textbox" data-options="required:true"
                           style="width:100px;text-align: left" name="goodsnum"/></td>
            </tr>
            <tr style="height: 30px">
                <td>商品进价</td>
                <td>
                    <input type="text" class="easyui-textbox" data-options="required:true"
                           style="width:100px;text-align: left" name="goodsinprice"/></td>
            </tr>
            <tr style="height: 30px">
                <td>商品售价</td>
                <td>
                    <input type="text" class="easyui-textbox" data-options="required:true"
                           style="width:100px;text-align: left" name="goodsoutprice"/></td>
            </tr>
        </table>
    </form>
</div>
<div id="goodsstock_update" hidden>
    <form id="goodsstock_ff1" method="post" enctype="multipart/form-data">
        <table style="font-size:15px;font-family: 楷体">
            <tr style="height: 30px">
                <td>商品名称<input type="hidden" class="easyui-textbox" style="display:none" name="goodsstockid"/>
                    <input type="hidden" id="goods_id" class="easyui-textbox" name="goods.goodsid"/>
                </td>
                <td>
                    <input type="text" id="goods_name" class="easyui-textbox"
                           data-options="required:true," style="width:100px;text-align: left"/></td>
            </tr>
            <tr style="height: 30px">
                <td>商品类型</td>
                <td>
                    <input class="easyui-combobox" name="goods.goodstype.goodstypeid"
                           data-options="required:true,valueField:'goodstypeid',textField:'goodsname',url:'${pageContext.request.contextPath}/goodstype/showAll'"/>
            </tr>
            <tr style="height: 30px">
                <td>商品数量</td>
                <td>
                    <input type="text" class="easyui-textbox" data-options="required:true"
                           style="width:100px;text-align: left" name="goodsnum"/></td>
            </tr>
            <tr style="height: 30px">
                <td>商品进价</td>
                <td>
                    <input type="text" class="easyui-textbox" data-options="required:true"
                           style="width:100px;text-align: left" name="goodsinprice"/></td>
            </tr>
            <tr style="height: 30px">
                <td>商品售价</td>
                <td>
                    <input type="text" class="easyui-textbox" data-options="required:true"
                           style="width:100px;text-align: left" name="goodsoutprice"/></td>
            </tr>
        </table>
    </form>
</div>
<div id="goodsstock_selects" hidden>
    <input id="goodsstock_select"/>
</div>
<table id="goodsstock_tt"></table>
<script type="text/javascript">
    var goodsname1;
    var goodsid1;
    goodsstock = {
        delete: function () {
            var as = $("#goodsstock_tt").datagrid('getChecked');
            if (as[0] == null) {
                $.messager.show({
                    title: '提示',
                    msg: '请选择一个库存'
                })
            } else {
                var param = "";
                for (var i = 0; i < as.length; i++) {
                    var id = as[i].goodsstockid;
                    if (i == 0) {
                        param = param + "ids=" + id;
                    } else {
                        param = param + "&ids=" + id;
                    }
                }
                $.messager.confirm('确认对话框', '您确定要删除吗？', function (r) {
                    if (r) {
                        $.ajax({
                            url: "${pageContext.request.contextPath}/goodsstock/removes",
                            type: "post",
                            data: param,
                            dataType: "json",
                            success: function (json) {
                                //1. 重新加载当前页面的信息。
                                $("#goodsstock_tt").datagrid('reload');
                                //2. 提示信息。
                                $.messager.show({
                                    title: "提示",
                                    msg: json.msg,
                                });
                            }
                        });
                    }
                })
            }
        },
        add: function (id) {
            $("#goodsstock_add").dialog({
                title: '添加库存信息',
                width: 500,
                height: 350,
                cache: false,
                modal: true,
                closed: false,
                shadow: true,
                buttons: [{
                    text: '添加',
                    handler: function () {
                        $('#goodsstock_ff2').form('submit', {
                            url: "${pageContext.request.contextPath}/goodsstock/insert",
                            success: function (data) {
                                $.messager.show({
                                    title: "提示",
                                    msg: '添加成功',
                                    timeout: 5000,
                                    showType: 'slide'
                                })
                                $('#goodsstock_tt').datagrid("reload");
                                $("#goodsstock_ff2").form("clear");
                                $("#goodsstock_add").dialog({
                                    closed: true,
                                });
                            }
                        })
                    }
                }, {
                    text: '关闭',
                    handler: function () {
                        $("#goodsstock_ff2").form("clear");
                        $("#goodsstock_add").dialog({
                            closed: true,
                        })
                    }
                }]
            })
        },
        searcher: function (value) {
            $("#goodsstock_tt").datagrid('load', {
                goodsstockname: value
            });
        },
        update1: function () {
            $("#goodsstock_selects").dialog({
                closed: false,
                modal: true,
                title: '请选择需要修改的库存',
                onOpen: function () {
                    $("#goodsstock_select").combobox({
                        url: '${pageContext.request.contextPath}/goodsstock/showAll',
                        valueField: 'goodsstockid',
                        textField: 'goods',
                        formatter: function (row) {
                            var opts = $(this).combobox('options');
                            return row[opts.textField].goodsname;
                        },
                        editable: false,
                        onSelect: function (rec) {
                            goodsname1 = rec.goods.goodsname;
                            goodsid1 = rec.goods.goodsid;
                            goodsstock.update(rec.goodsstockid)
                            $("#goodsstock_selects").dialog({
                                modal: true,
                                closed: true
                            })
                            $("#goodsstock_select").combobox('clear')
                        }
                    })
                }
            })
        },
        update: function (id) {
            $("#goods_name").textbox('setValue', goodsname1);
            $("#goods_id").textbox('setValue', goodsid1);
            $("#goodsstock_ff1").form('load', "${pageContext.request.contextPath}/goodsstock/selectById?goodsstockid=" + id);
            $("#goodsstock_update").dialog({
                title: '修改库存信息',
                width: 500,
                height: 350,
                cache: false,
                modal: true,
                closed: false,
                shadow: true,
                buttons: [{
                    text: '修改',
                    handler: function () {
                        $('#goodsstock_ff1').form('submit', {
                            url: "${pageContext.request.contextPath}/goodsstock/update",
                            success: function (data) {
                                var s = JSON.parse(data);
                                $.messager.show({
                                    title: "提示",
                                    msg: s.msg,
                                    timeout: 5000,
                                    showType: 'slide'
                                })
                                $('#goodsstock_tt').datagrid("reload");
                                $("#goodsstock_ff1").form("clear");
                                $("#goodsstock_update").dialog({
                                    closed: true,
                                });
                            }
                        })
                    }
                }, {
                    text: '关闭',
                    handler: function () {
                        $("#goodsstock_ff1").form("clear");
                        $("#goodsstock_update").dialog({
                            closed: true,
                        })
                    }
                }]
            })
        },
    }
    $(function () {
        var goodsvalue;
        $('#goodsstock_tt').datagrid({
            width: '100%',
            height: '100%',
            toolbar: '#goodsstock_tb',
            title: "库存信息",
            pagination: "ture",
            remoteSort: false,
            nowrap: false,
            rownumbers: true,
            striped: true,
            url: '${pageContext.request.contextPath}/goodsstock/showAll',
            columns: [[
                {field: 'goodsstockid', title: 'id', width: '10%', checkbox: true,},
                {
                    field: 'goods', title: '商品名称', width: '10%',
                    formatter: function (value) {
                        goodsvalue = value;
                        return goodsvalue.goodsname;
                    }
                },
                {
                    field: 'goods2', title: '商品类型', width: '10%',
                    formatter: function (value) {
                        return goodsvalue.goodstype.goodsname;
                    }
                },
                {field: 'goodsnum', title: '商品数量', width: '10%'},
                {field: 'goodsinprice', title: '商品进价', width: '10%'},
                {field: 'goodsoutprice', title: '商品售价', width: '10%'},
            ]],
            onLoadSuccess: function () {
            }
        });

    })
</script>
</body>
</html>
