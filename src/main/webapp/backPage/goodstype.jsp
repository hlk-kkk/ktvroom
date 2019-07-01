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
<div id="goodstype_tb">
    <a href="#" class="easyui-linkbutton" onclick="goodstype.add()" title="添加商品"
       data-options="iconCls:'icon-add',plain:true"/>
    <a href="#" class="easyui-linkbutton" onclick="goodstype.update1()" title="修改商品信息"
       data-options="iconCls:'icon-reload',plain:true"/>
    <a href="#" class="easyui-linkbutton" onclick="goodstype.delete()" title="删除选中"
       data-options="iconCls:'icon-cancel',plain:true"/>
</div>
<div id="goodstype_update" hidden>
    <form id="goodstype_ff1" method="post" enctype="multipart/form-data">
        <table style="font-size:15px;font-family: 楷体">
            <tr style="height: 30px">
                <td>商品类型<input type="hidden" class="easyui-textbox" style="display:none" name="goodstypeid"/></td>
                <td>
                    <input type="text" class="easyui-textbox" data-options="required:true"
                           style="width:100px;text-align: left" name="goodsname"/></td>
            </tr>
        </table>
    </form>
</div>
<div id="goodstype_add" hidden>
    <form id="goodstype_ff2" method="post" enctype="multipart/form-data">
        <table style="font-size:15px;font-family: 楷体">
            <tr style="height: 30px">
                <td>商品类型</td>
                <td>
                    <input type="text" class="easyui-textbox" data-options="required:true"
                           style="width:100px;text-align: left" name="goodsname"/></td>
            </tr>
        </table>
    </form>
</div>
<div id="goodstype_selects" hidden>
    <input id="goodstype_select"/>
</div>
<table id="goodstype_tt"></table>
<script type="text/javascript">
    goodstype = {
        delete: function () {
            var as = $("#goodstype_tt").datagrid('getChecked');
            if (as[0] == null) {
                $.messager.show({
                    title: '提示',
                    msg: '请选择一个商品'
                })
            } else {
                var param = "";
                for (var i = 0; i < as.length; i++) {
                    var id = as[i].goodstypeid;
                    if (i == 0) {
                        param = param + "ids=" + id;
                    } else {
                        param = param + "&ids=" + id;
                    }
                }
                $.messager.confirm('确认对话框', '您确定要删除吗？', function (r) {
                    if (r) {
                        $.ajax({
                            url: "${pageContext.request.contextPath}/goodstype/removes",
                            type: "post",
                            data: param,
                            dataType: "json",
                            success: function (json) {
                                //1. 重新加载当前页面的信息。
                                $("#goodstype_tt").datagrid('reload');
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
        update1: function () {
            $("#goodstype_selects").dialog({
                closed: false,
                modal: true,
                title: '请选择需要修改的商品',
                onOpen: function () {
                    $("#goodstype_select").combobox({
                        url: '${pageContext.request.contextPath}/goodstype/showAll',
                        valueField: 'goodstypeid',
                        textField: 'goodsname',
                        editable: false,
                        onSelect: function (rec) {
                            goodstype.update(rec.goodstypeid)
                            $("#goodstype_selects").dialog({
                                closed: true
                            })
                            $("#goodstype_select").combobox('clear')
                        }
                    })
                },
            })
        },
        update: function (id) {
            $("#goodstype_ff1").form('load', "${pageContext.request.contextPath}/goodstype/selectById?goodstypeid=" + id);
            $("#goodstype_update").dialog({
                title: '修改商品信息',
                width: 500,
                height: 350,
                cache: false,
                modal: true,
                closed: false,
                shadow: true,
                buttons: [{
                    text: '修改',
                    handler: function () {
                        $('#goodstype_ff1').form('submit', {
                            url: "${pageContext.request.contextPath}/goodstype/update",
                            success: function (data) {
                                $.messager.show({
                                    title: "提示",
                                    msg: '修改成功',
                                    timeout: 5000,
                                    showType: 'slide'
                                })
                                $("#goodstype_ff1").form("clear");
                                $("#goodstype_update").dialog({
                                    closed: true,
                                });
                                $('#goodstype_tt').datagrid("reload");
                            }
                        })
                    }
                }, {
                    text: '关闭',
                    handler: function () {
                        $("#goodstype_ff1").form("clear");
                        $("#goodstype_update").dialog({
                            closed: true,
                        })
                    }
                }]
            })
        },
        add: function (id) {
            $("#goodstype_add").dialog({
                title: '添加商品类型',
                width: 500,
                height: 350,
                cache: false,
                modal: true,
                closed: false,
                shadow: true,
                buttons: [{
                    text: '添加',
                    handler: function () {
                        $('#goodstype_ff2').form('submit', {
                            url: "${pageContext.request.contextPath}/goodstype/insert",
                            success: function (data) {
                                $.messager.show({
                                    title: "提示",
                                    msg: '添加成功',
                                    timeout: 5000,
                                    showType: 'slide'
                                })
                                $('#goodstype_tt').datagrid("reload");
                                $("#goodstype_ff2").form("clear");
                                $("#goodstype_add").dialog({
                                    closed: true,
                                });
                            }
                        })
                    }
                }, {
                    text: '关闭',
                    handler: function () {
                        $("#goodstype_ff2").form("clear");
                        $("#goodstype_add").dialog({
                            closed: true,
                        })
                    }
                }]
            })
        },
    }
    $(function () {
        $('#goodstype_tt').datagrid({
            width: '100%',
            height: '100%',
            toolbar: '#goodstype_tb',
            title: "商品类型信息",
            pagination: "ture",
            remoteSort: false,
            nowrap: false,
            rownumbers: true,
            striped: true,
            url: '${pageContext.request.contextPath}/goodstype/showAll',
            columns: [[
                {field: 'goodstypeid', title: 'id', width: '10%', checkbox: true,},
                {field: 'goodsname', title: '商品类型', width: '10%'},
            ]],
            onLoadSuccess: function () {
            }
        });

    })
</script>
</body>
</html>
