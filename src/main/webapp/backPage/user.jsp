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
<div id="user_tb">
    <a href="#" class="easyui-linkbutton" onclick="user.add()" title="添加员工"
       data-options="iconCls:'icon-add',plain:true"/>
    <a href="#" class="easyui-linkbutton" onclick="user.update1()" title="修改员工信息"
       data-options="iconCls:'icon-reload',plain:true"/>
    <a href="#" class="easyui-linkbutton" onclick="user.delete()" title="删除选中"
       data-options="iconCls:'icon-cancel',plain:true"/>
    <input id="ss" class="easyui-searchbox" style="width:150px ;height: 30px;"
           data-options="searcher:user.searcher,prompt:'请输入用户名'"/>
</div>
<div id="user_update" hidden>
    <form id="user_ff1" method="post" enctype="multipart/form-data">
        <table style="font-size:15px;font-family: 楷体">
            <tr style="height: 30px">
                <td>员工姓名<input type="hidden" class="easyui-textbox" style="display:none" name="userid"/></td>
                <td>
                    <input type="text" class="easyui-textbox" data-options="required:true"
                           style="width:100px;text-align: left" name="realname"/></td>
            </tr>
            <tr style="height: 30px">
                <td>年龄</td>
                <td><input type="text" class="easyui-numberspinner" data-options="required:true,min:18,max:100"
                           align="left" style="width:100px;text-align: left" name="age"/></td>
            </tr>
            <tr style="height: 30px">
                <td>性别</td>
                <td><select class="easyui-combobox" name="sex" style="width:150px;">
                    <option value="1">男</option>
                    <option value="0">女</option>
                </select>
            </tr>
            <tr style="height: 30px">
                <td>薪资</td>
                <td><input type="text" class="easyui-numberspinner" data-options="required:true,min:1000"
                           style="width:200px;" name="salary"></td>
            </tr>
            <tr style="height: 30px">
                <td>手机号码</td>
                <td><input type="text" class="easyui-textbox" data-options="required:true" style="width:200px"
                           name="telephone"/></td>
            </tr>
            <tr style="height: 30px">
                <td>地址</td>
                <td><input type="text" class="easyui-textbox" data-options="required:true" style="width:300px"
                           name="address"/></td>
            </tr>
        </table>
    </form>
</div>
<div id="user_add" hidden>
    <form id="user_ff2" method="post" enctype="multipart/form-data">
        <table style="font-size:15px;font-family: 楷体">
            <tr style="height: 30px">
                <td>员工姓名<input type="hidden" class="easyui-textbox" style="display:none" name="userid"/></td>
                <td>
                    <input type="text" class="easyui-textbox" data-options="required:true"
                           style="width:100px;text-align: left" name="realname"/></td>
            </tr>
            <tr style="height: 30px">
                <td>年龄</td>
                <td><input type="text" class="easyui-numberspinner" data-options="required:true,min:18,max:100"
                           align="left" style="width:100px;text-align: left" name="age"/></td>
            </tr>
            <tr style="height: 30px">
                <td>性别</td>
                <td><select class="easyui-combobox" name="sex" style="width:150px;">
                    <option value="1">男</option>
                    <option value="0">女</option>
                </select>
            </tr>
            <tr style="height: 30px">
                <td>薪资</td>
                <td><input type="text" class="easyui-numberspinner" data-options="required:true,min:1000"
                           style="width:200px;" name="salary"></td>
            </tr>
            <tr style="height: 30px">
                <td>手机号码</td>
                <td><input type="text" class="easyui-textbox" data-options="required:true" style="width:200px"
                           name="telephone"/></td>
            </tr>
            <tr style="height: 30px">
                <td>地址</td>
                <td><input type="text" class="easyui-textbox" data-options="required:true" style="width:300px"
                           name="address"/></td>
            </tr>
        </table>
    </form>
</div>
<div id="user_selects" hidden>
    <input id="user_select"/>
</div>
<table id="user_tt"></table>
<script type="text/javascript">
    user = {
        delete: function () {
            var as = $("#user_tt").datagrid('getChecked');
            if (as[0] == null) {
                $.messager.show({
                    title: '提示',
                    msg: '请选择一名员工'
                })
            } else {
                var param = "";
                for (var i = 0; i < as.length; i++) {
                    var id = as[i].userid;
                    if (i == 0) {
                        param = param + "ids=" + id;
                    } else {
                        param = param + "&ids=" + id;
                    }
                }
                $.messager.confirm('确认对话框', '您确定要删除吗？', function (r) {
                    if (r) {
                        $.ajax({
                            url: "${pageContext.request.contextPath}/user/removes",
                            type: "post",
                            data: param,
                            dataType: "json",
                            success: function (json) {
                                //1. 重新加载当前页面的信息。
                                $("#user_tt").datagrid('reload');
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
            $("#user_selects").dialog({
                closed: false,
                modal: true,
                title: '请选择需要修改的用户',
                onOpen: function () {
                    $("#user_select").combobox({
                        url: '${pageContext.request.contextPath}/user/showAll',
                        value: '胡霖康',
                        valueField: 'userid',
                        textField: 'realname',
                        editable: false,
                        onSelect: function (rec) {
                            user.update(rec.userid)
                            $("#user_selects").dialog({
                                closed: true
                            })
                            $("#user_select").combobox('clear')
                        }
                    })
                }
            })
        },
        update: function (id) {
            $("#user_ff1").form('load', "${pageContext.request.contextPath}/user/selectById?userid=" + id);
            $("#user_update").dialog({
                title: '修改前台用户',
                width: 500,
                height: 350,
                cache: false,
                modal: true,
                closed: false,
                shadow: true,
                buttons: [{
                    text: '修改',
                    handler: function () {
                        $('#user_ff1').form('submit', {
                            url: "${pageContext.request.contextPath}/user/update",
                            success: function (data) {
                                $.messager.show({
                                    title: "提示",
                                    msg: '修改成功',
                                    timeout: 5000,
                                    showType: 'slide'
                                })
                                $('#user_tt').datagrid("reload");
                                $("#user_ff1").form("clear");
                                $("#user_update").dialog({
                                    closed: true,
                                });
                            }
                        })
                    }
                }, {
                    text: '关闭',
                    handler: function () {
                        $("#user_ff1").form("clear");
                        $("#user_update").dialog({
                            closed: true,
                        })
                    }
                }]
            })
        },
        add: function (id) {
            $("#user_add").dialog({
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
                        $('#user_ff2').form('submit', {
                            url: "${pageContext.request.contextPath}/user/insert",
                            success: function (data) {
                                $.messager.show({
                                    title: "提示",
                                    msg: '添加成功',
                                    timeout: 5000,
                                    showType: 'slide'
                                })
                                $('#user_tt').datagrid("reload");
                                $("#user_ff2").form("clear");
                                $("#user_add").dialog({
                                    closed: true,
                                });
                            }
                        })
                    }
                }, {
                    text: '关闭',
                    handler: function () {
                        $("#user_ff2").form("clear");
                        $("#user_add").dialog({
                            closed: true,
                        })
                    }
                }]
            })
        },
        searcher: function (value) {
            $("#user_tt").datagrid('load', {
                realname: value
            });
        }
    }
    $(function () {

        $('#user_tt').datagrid({
            width: '100%',
            height: '100%',
            toolbar: '#user_tb',
            title: "前台用户信息",
            pagination: "ture",
            remoteSort: false,
            nowrap: false,
            rownumbers: true,
            striped: true,
            url: '${pageContext.request.contextPath}/user/showAll',
            columns: [[
                {field: 'userid', title: 'id', width: '10%', checkbox: true,},
                {field: 'username', title: '用户名', width: '10%'},
                {field: 'realname', title: '真实姓名', width: '10%'},
                {
                    field: 'sex', title: '性别', width: '10%',
                    formatter: function (value) {
                        if (value = 1) {
                            return '男'
                        }
                        return '女'
                    }
                },
                {field: 'age', title: '年龄', width: '10%', sortable: true, order: 'asc'},
                {field: 'telephone', title: '手机号码', width: '10%'},
                {field: 'address', title: '家庭住址', width: '15%'},
                {field: 'entryData', title: '入职日期', width: '10%'},
                {field: 'salary', title: '薪资', width: '10%'},
                {
                    field: 'status', title: '当前状态', width: '10%',
                    formatter: function (value) {
                        if (value == "1") {
                            return "<input class=\"usereasyui\" style='background-color: blue' checked>";
                        } else {
                            return "<input class=\"usereasyui\">";
                        }
                    }
                },
            ]],
            onLoadSuccess: function () {
                $('.usereasyui').switchbutton({
                    onText: "在职",
                    offText: "停职",
                    width: '100%',
                    onChange: function (s) {
                        var id = this.parentNode.parentNode.previousSibling.previousSibling.previousSibling.previousSibling.previousSibling.previousSibling.previousSibling.previousSibling.previousSibling.firstChild.firstChild.value;
                        $.messager.confirm('确认', '您确定修改员工状态??', function (r) {
                            if (r) {
                                if (s) {
                                    status = 1;
                                    $.ajax({
                                        url: "${pageContext.request.contextPath}/user/modify",
                                        dataType: "json",
                                        data: "userid=" + id + "&status=" + status,
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
                                        url: "${pageContext.request.contextPath}/user/modify",
                                        dataType: "json",
                                        data: "userid=" + id + "&status=" + status,
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
                                $('#user_tt').datagrid("reload");
                            } else {
                                $('#user_tt').datagrid("reload");
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
