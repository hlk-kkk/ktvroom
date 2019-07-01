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
<div id="roomtype_tb">
    <a href="#" class="easyui-linkbutton" onclick="roomtype.add()" title="添加房间"
       data-options="iconCls:'icon-add',plain:true"/>
    <a href="#" class="easyui-linkbutton" onclick="roomtype.update1()" title="修改房间信息"
       data-options="iconCls:'icon-reload',plain:true"/>
    <a href="#" class="easyui-linkbutton" onclick="roomtype.delete()" title="删除选中"
       data-options="iconCls:'icon-cancel',plain:true"/>
    <input id="ss" class="easyui-searchbox" style="width:150px ;height: 30px;"
           data-options="searcher:roomtype.searcher,prompt:'请输入房间类型名称'"/>
</div>
<div id="roomtype_update" hidden>
    <form id="roomtype_ff1" method="post" enctype="multipart/form-data">
        <table style="font-size:15px;font-family: 楷体">
            <tr style="height: 30px">
                <td>房间类型<input type="hidden" class="easyui-textbox" style="display:none" name="roomtypeid"/></td>
                <td>
                    <input type="text" class="easyui-textbox" data-options="required:true"
                           style="width:100px;text-align: left" name="roomtype"/></td>
            </tr>
            <tr style="height: 30px">
                <td>房间消费等级</td>
                <td>
                    <input type="text" class="easyui-textbox" data-options="required:true"
                           style="width:100px;text-align: left" name="roommoney"/></td>
            </tr>
            <tr style="height: 30px">
                <td>房间信息</td>
                <td>
                    <input type="text" class="easyui-textbox" data-options="required:true"
                           style="width:100px;text-align: left" name="roomremark"/></td>
            </tr>
            <tr style="height: 30px">
                <td>房间最低消费</td>
                <td>
                    <input type="text" class="easyui-textbox" data-options="required:true"
                           style="width:100px;text-align: left" name="roomminmoney"/></td>
            </tr>
        </table>
    </form>
</div>
<div id="roomtype_add" hidden>
    <form id="roomtype_ff2" method="post" enctype="multipart/form-data">
        <table style="font-size:15px;font-family: 楷体">
            <tr style="height: 30px">
                <td>房间类型</td>
                <td>
                    <input type="text" class="easyui-textbox" data-options="required:true"
                           style="width:100px;text-align: left" name="roomtype"/></td>
            </tr>
            <tr style="height: 30px">
                <td>房间消费等级</td>
                <td>
                    <input type="text" class="easyui-textbox" data-options="required:true"
                           style="width:100px;text-align: left" name="roommoney"/></td>
            </tr>
            <tr style="height: 30px">
                <td>房间信息</td>
                <td>
                    <input type="text" class="easyui-textbox" data-options="required:true"
                           style="width:100px;text-align: left" name="roomremark"/></td>
            </tr>
            <tr style="height: 30px">
                <td>房间最低消费</td>
                <td>
                    <input type="text" class="easyui-textbox" data-options="required:true"
                           style="width:100px;text-align: left" name="roomminmoney"/></td>
            </tr>
        </table>
    </form>
</div>
<div id="roomtype_selects" hidden>
    <input id="roomtype_select"/>
</div>
<table id="roomtype_tt"></table>
<script type="text/javascript">
    roomtype = {
        delete: function () {
            var as = $("#roomtype_tt").datagrid('getChecked');
            if (as[0] == null) {
                $.messager.show({
                    title: '提示',
                    msg: '请选择一个房间'
                })
            } else {
                var param = "";
                for (var i = 0; i < as.length; i++) {
                    var id = as[i].roomtypeid;
                    if (i == 0) {
                        param = param + "ids=" + id;
                    } else {
                        param = param + "&ids=" + id;
                    }
                }
                $.messager.confirm('确认对话框', '您确定要删除吗？', function (r) {
                    if (r) {
                        $.ajax({
                            url: "${pageContext.request.contextPath}/roomtype/removes",
                            type: "post",
                            data: param,
                            dataType: "json",
                            success: function (json) {
                                //1. 重新加载当前页面的信息。
                                $("#roomtype_tt").datagrid('reload');
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
            $("#roomtype_selects").dialog({
                closed: false,
                modal: true,
                title: '请选择需要修改的房间',
                onOpen: function () {
                    $("#roomtype_select").combobox({
                        url: '${pageContext.request.contextPath}/roomtype/showAll',
                        value: '小包',
                        valueField: 'roomtypeid',
                        textField: 'roomtype',
                        editable: false,
                        onSelect: function (rec) {
                            roomtype.update(rec.roomtypeid)
                            $("#roomtype_selects").dialog({
                                closed: true
                            })
                            $("#roomtype_select").combobox('clear')
                        }
                    })
                },
            })
        },
        update: function (id) {
            $("#roomtype_ff1").form('load', "${pageContext.request.contextPath}/roomtype/selectById?roomtypeid=" + id);
            $("#roomtype_update").dialog({
                title: '修改房间信息',
                width: 500,
                height: 350,
                cache: false,
                modal: true,
                closed: false,
                shadow: true,
                buttons: [{
                    text: '修改',
                    handler: function () {
                        $('#roomtype_ff1').form('submit', {
                            url: "${pageContext.request.contextPath}/roomtype/update",
                            success: function (data) {
                                $.messager.show({
                                    title: "提示",
                                    msg: '修改成功',
                                    timeout: 5000,
                                    showType: 'slide'
                                })
                                $("#roomtype_ff1").form("clear");
                                $("#roomtype_update").dialog({
                                    closed: true,
                                });
                                $('#roomtype_tt').datagrid("reload");
                            }
                        })
                    }
                }, {
                    text: '关闭',
                    handler: function () {
                        $("#roomtype_ff1").form("clear");
                        $("#roomtype_update").dialog({
                            closed: true,
                        })
                    }
                }]
            })
        },
        add: function (id) {
            $("#roomtype_add").dialog({
                title: '添加房间类型',
                width: 500,
                height: 350,
                cache: false,
                modal: true,
                closed: false,
                shadow: true,
                buttons: [{
                    text: '添加',
                    handler: function () {
                        $('#roomtype_ff2').form('submit', {
                            url: "${pageContext.request.contextPath}/roomtype/insert",
                            success: function (data) {
                                $.messager.show({
                                    title: "提示",
                                    msg: '添加成功',
                                    timeout: 5000,
                                    showType: 'slide'
                                })
                                $('#roomtype_tt').datagrid("reload");
                                $("#roomtype_ff2").form("clear");
                                $("#roomtype_add").dialog({
                                    closed: true,
                                });
                            }
                        })
                    }
                }, {
                    text: '关闭',
                    handler: function () {
                        $("#roomtype_ff2").form("clear");
                        $("#roomtype_add").dialog({
                            closed: true,
                        })
                    }
                }]
            })
        },
        searcher: function (value) {
            $("#roomtype_tt").datagrid('load', {
                roomtype: value
            });
        }
    }
    $(function () {

        $('#roomtype_tt').datagrid({
            width: '100%',
            height: '100%',
            toolbar: '#roomtype_tb',
            title: "房间类型信息",
            pagination: "ture",
            remoteSort: false,
            nowrap: false,
            rownumbers: true,
            striped: true,
            url: '${pageContext.request.contextPath}/roomtype/showAll',
            columns: [[
                {field: 'roomtypeid', title: 'id', width: '10%', checkbox: true,},
                {field: 'roomtype', title: '房间类型', width: '10%'},
                {field: 'roommoney', title: '房间消费等级', width: '10%',},
                {field: 'roomremark', title: '房间信息', width: '10%',},
                {field: 'roomminmoney', title: '房间最低消费', width: '10%',},
            ]],
            onLoadSuccess: function () {
            }
        });

    })
</script>
</body>
</html>
