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
<div id="room_tb">
    <a href="#" class="easyui-linkbutton" onclick="room.add()" title="添加房间"
       data-options="iconCls:'icon-add',plain:true"/>
    <a href="#" class="easyui-linkbutton" onclick="room.delete()" title="删除选中"
       data-options="iconCls:'icon-cancel',plain:true"/>
    <input id="ss" class="easyui-searchbox" style="width:150px ;height: 30px;"
           data-options="searcher:room.searcher,prompt:'请输入房间号码'"/>
</div>
<div id="room_add" hidden>
    <form id="room_ff2" method="post" enctype="multipart/form-data">
        <table style="font-size:15px;font-family: 楷体">
            <tr style="height: 30px">
                <td>房间号码<input type="hidden" class="easyui-textbox" style="display:none" name="roomid"/></td>
                <td>
                    <input type="text" class="easyui-textbox" data-options="required:true"
                           style="width:100px;text-align: left" name="roomname"/></td>
            </tr>
            <tr style="height: 30px">
                <td>房间类型</td>
                <td>
                    <input id="cc" class="easyui-combobox" name="roomtype.roomtypeid"
                           data-options="valueField:'roomtypeid',textField:'roomtype',url:'${pageContext.request.contextPath}/roomtype/showAll'"/>
            </tr>
        </table>
    </form>
</div>
<div id="room_selects" hidden>
    <input id="room_select"/>
</div>
<table id="room_tt"></table>
<script type="text/javascript">
    room = {
        delete: function () {
            var as = $("#room_tt").datagrid('getChecked');
            if (as[0] == null) {
                $.messager.show({
                    title: '提示',
                    msg: '请选择一名员工'
                })
            } else {
                var param = "";
                for (var i = 0; i < as.length; i++) {
                    var id = as[i].roomid;
                    if (i == 0) {
                        param = param + "ids=" + id;
                    } else {
                        param = param + "&ids=" + id;
                    }
                }
                $.messager.confirm('确认对话框', '您确定要删除吗？', function (r) {
                    if (r) {
                        $.ajax({
                            url: "${pageContext.request.contextPath}/room/removes",
                            type: "post",
                            data: param,
                            dataType: "json",
                            success: function (json) {
                                //1. 重新加载当前页面的信息。
                                $("#room_tt").datagrid('reload');
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
            $("#room_add").dialog({
                title: '添加前台用户',
                width: 500,
                height: 350,
                cache: false,
                modal: true,
                closed: false,
                shadow: true,
                buttons: [{
                    text: '添加',
                    handler: function () {
                        $('#room_ff2').form('submit', {
                            url: "${pageContext.request.contextPath}/room/insert",
                            success: function (data) {
                                $.messager.show({
                                    title: "提示",
                                    msg: '添加成功',
                                    timeout: 5000,
                                    showType: 'slide'
                                })
                                $('#room_tt').datagrid("reload");
                                $("#room_ff2").form("clear");
                                $("#room_add").dialog({
                                    closed: true,
                                });
                            }
                        })
                    }
                }, {
                    text: '关闭',
                    handler: function () {
                        $("#room_ff2").form("clear");
                        $("#room_add").dialog({
                            closed: true,
                        })
                    }
                }]
            })
        },
        searcher: function (value) {
            $("#room_tt").datagrid('load', {
                roomname: value
            });
        }
    }
    $(function () {
        $("#room_select").combobox({
            url: '${pageContext.request.contextPath}/room/showAll',
            value: '101',
            valueField: 'roomid',
            textField: 'roomname',
            editable: false,
            onSelect: function (rec) {
                room.update(rec.roomid)
                $("#room_selects").dialog({
                    closed: true
                })
                $("#room_select").combobox('clear')
            }
        })
        $('#room_tt').datagrid({
            width: '100%',
            height: '100%',
            toolbar: '#room_tb',
            title: "前台用户信息",
            pagination: "ture",
            remoteSort: false,
            nowrap: false,
            rownumbers: true,
            striped: true,
            url: '${pageContext.request.contextPath}/room/showAll',
            columns: [[
                {field: 'roomid', title: 'id', width: '10%', checkbox: true,},
                {field: 'roomname', title: '房间号码', width: '10%'},
                {
                    field: 'roomtype', title: '房间类型', width: '10%',
                    formatter: function (value) {
                        return value.roomtype;
                    }
                },
                {
                    field: 'roomcondition', title: '当前状态', width: '10%',
                    formatter: function (value) {
                        if (value == "1" || value == "2" || value == "3") {
                            return "<input class=\"roomeasyui\" style='background-color: blue' checked>";
                        } else {
                            return "<input class=\"roomeasyui\">";
                        }
                    }
                },
            ]],
            onLoadSuccess: function () {
                $('.roomeasyui').switchbutton({
                    onText: "可用房",
                    offText: "维护房",
                    width: '100%',
                    onChange: function (s) {
                        var id = this.parentNode.parentNode.previousSibling.previousSibling.previousSibling.firstChild.firstChild.value;
                        $.messager.confirm('确认', '您确定修改房间状态??', function (r) {
                            if (r) {
                                if (s) {
                                    status = 1;
                                    $.ajax({
                                        url: "${pageContext.request.contextPath}/room/modify",
                                        dataType: "json",
                                        data: "roomid=" + id + "&roomcondition=" + status,
                                        success: function (obj) {
                                            $.messager.show({
                                                title: "提示",
                                                msg: obj.msg,
                                                timeout: 5000,
                                                showType: 'slide'
                                            })
                                        }
                                    });
                                } else {
                                    status = 0;
                                    $.ajax({
                                        url: "${pageContext.request.contextPath}/room/modify",
                                        dataType: "json",
                                        data: "roomid=" + id + "&roomcondition=" + status,
                                        success: function (obj) {
                                            $.messager.show({
                                                title: "提示",
                                                msg: obj.msg,
                                                timeout: 5000,
                                                showType: 'slide'
                                            })
                                        }
                                    });
                                }
                                $('#room_tt').datagrid("reload");
                            } else {
                                $('#room_tt').datagrid("reload");
                            }
                        });

                    }
                });
            }
        });

    })
</script>
</body>
</html>
