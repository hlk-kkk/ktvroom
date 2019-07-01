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
<div id="member_tb">
    <a href="#" class="easyui-linkbutton" onclick="member.add()" title="添加会员"
       data-options="iconCls:'icon-add',plain:true"/>
    <a href="#" class="easyui-linkbutton" onclick="member.update1()" title="修改会员信息"
       data-options="iconCls:'icon-reload',plain:true"/>
    <a href="#" class="easyui-linkbutton" onclick="member.delete()" title="删除选中"
       data-options="iconCls:'icon-cancel',plain:true"/>
    <input id="ss" class="easyui-searchbox" style="width:150px ;height: 30px;"
           data-options="searcher:member.searcher,prompt:'请输入会员名'"/>
</div>
<div id="member_update" hidden>
    <form id="member_ff1" method="post" enctype="multipart/form-data">
        <table style="font-size:15px;font-family: 楷体">
            <tr style="height: 30px">
                <td>会员姓名<input type="hidden" class="easyui-textbox" style="display:none" name="memberid"/></td>
                <td>
                    <input type="text" class="easyui-textbox" data-options="required:true"
                           style="width:100px;text-align: left" name="membername"/></td>
            </tr>
            <tr style="height: 30px">
                <td>性别</td>
                <td><select class="easyui-combobox" name="sex" style="width:150px;">
                    <option value="1">男</option>
                    <option value="0">女</option>
                </select>
            </tr>
            <tr style="height: 30px">
                <td>手机号码</td>
                <td><input type="text" class="easyui-textbox" data-options="required:true" style="width:200px;"
                           name="memberphone"></td>
            </tr>
        </table>
    </form>
</div>
<div id="member_add" hidden>
    <form id="member_ff2" method="post" enctype="multipart/form-data">
        <table style="font-size:15px;font-family: 楷体">
            <tr style="height: 30px">
                <td>会员姓名</td>
                <td>
                    <input type="text" class="easyui-textbox" data-options="required:true"
                           style="width:100px;text-align: left" name="membername"/></td>
            </tr>
            <tr style="height: 30px">
                <td>性别</td>
                <td><select class="easyui-combobox" name="sex" style="width:150px;">
                    <option value="1">男</option>
                    <option value="0">女</option>
                </select>
            </tr>
            <tr style="height: 30px">
                <td>手机号码</td>
                <td><input type="text" class="easyui-textbox" data-options="required:true" style="width:200px;"
                           name="memberphone"></td>
            </tr>
        </table>
    </form>
</div>
<div id="member_selects" hidden>
    <input id="member_select"/>
</div>
<table id="member_tt"></table>
<table id="member_Auditingmsg"></table>
<script type="text/javascript">
    member = {
        delete: function () {
            var as = $("#member_tt").datagrid('getChecked');
            if (as[0] == null) {
                $.messager.show({
                    title: '提示',
                    msg: '请选择一名会员'
                })
            } else {
                var param = "";
                for (var i = 0; i < as.length; i++) {
                    var id = as[i].memberid;
                    if (i == 0) {
                        param = param + "ids=" + id;
                    } else {
                        param = param + "&ids=" + id;
                    }
                }
                $.messager.confirm('确认对话框', '您确定要删除吗？', function (r) {
                    if (r) {
                        $.ajax({
                            url: "${pageContext.request.contextPath}/member/removes",
                            type: "post",
                            data: param,
                            dataType: "json",
                            success: function (json) {
                                //1. 重新加载当前页面的信息。
                                $("#member_tt").datagrid('reload');
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
            $("#member_selects").dialog({
                closed: false,
                modal: true,
                title: '请选择需要修改的用户',
                onOpen: function () {
                    $("#member_select").combobox({
                        url: '${pageContext.request.contextPath}/member/showAll',
                        value: '燕小六',
                        valueField: 'memberid',
                        textField: 'membername',
                        editable: false,
                        onSelect: function (rec) {
                            member.update(rec.memberid)
                            $("#member_selects").dialog({
                                modal: true,
                                closed: true
                            })
                            $("#member_select").combobox('clear')
                        }
                    })
                }
            })
        },
        update: function (id) {
            $("#member_ff1").form('load', "${pageContext.request.contextPath}/member/selectById?memberid=" + id);
            $("#member_update").dialog({
                title: '修改会员信息',
                width: 500,
                height: 350,
                cache: false,
                modal: true,
                closed: false,
                shadow: true,
                buttons: [{
                    text: '修改',
                    handler: function () {
                        $('#member_ff1').form('submit', {
                            url: "${pageContext.request.contextPath}/member/update",
                            success: function (data) {
                                var s = JSON.parse(data);
                                $.messager.show({
                                    title: "提示",
                                    msg: s.msg,
                                    timeout: 5000,
                                    showType: 'slide'
                                })
                                $('#member_tt').datagrid("reload");
                                $("#member_ff1").form("clear");
                                $("#member_update").dialog({
                                    closed: true,
                                });
                            }
                        })
                    }
                }, {
                    text: '关闭',
                    handler: function () {
                        $("#member_ff1").form("clear");
                        $("#member_update").dialog({
                            closed: true,
                        })
                    }
                }]
            })
        },
        add: function (id) {
            $("#member_add").dialog({
                title: '添加会员',
                width: 500,
                height: 350,
                cache: false,
                modal: true,
                closed: false,
                shadow: true,
                buttons: [{
                    text: '添加',
                    handler: function () {
                        $('#member_ff2').form('submit', {
                            url: "${pageContext.request.contextPath}/member/insert",
                            success: function (data) {
                                var s = JSON.parse(data);
                                $.messager.show({
                                    title: "提示",
                                    msg: s.msg,
                                    timeout: 5000,
                                    showType: 'slide'
                                })
                                $('#member_tt').datagrid("reload");
                                $("#member_ff2").form("clear");
                                $("#member_add").dialog({
                                    closed: true,
                                });
                            }
                        })
                    }
                }, {
                    text: '关闭',
                    handler: function () {
                        $("#member_ff2").form("clear");
                        $("#member_add").dialog({
                            closed: true,
                        })
                    }
                }]
            })
        },
        searcher: function (value) {
            $("#member_tt").datagrid('load', {
                realname: value
            });
        },
    }
    $(function () {

        $('#member_tt').datagrid({
            fit: true,
            toolbar: '#member_tb',
            title: "会员信息",
            pagination: "ture",
            remoteSort: false,
            nowrap: false,
            rownumbers: true,
            striped: true,
            url: '${pageContext.request.contextPath}/member/showAll',
            columns: [[
                {field: 'memberid', title: 'id', width: '10%', checkbox: true,},
                {field: 'membername', title: '会员名称', width: '10%'},
                {field: 'memberphone', title: '联系方式', width: '10%'},
                {
                    field: 'sex', title: '性别', width: '10%',
                    formatter: function (value) {
                        if (value == '1') {
                            return '男'
                        } else {
                            return '女'
                        }
                    }
                },
                {field: 'entryDate', title: '注册日期', width: '10%'},
                {field: 'membernum', title: '会员编号', width: '10%'},
                {
                    field: 'memberintegral', title: '当前积分', width: '10%',
                    formatter: function (value) {
                        return value + "<input class=\"membereasyuion\" value='提升会员等级'>";
                    }
                },
                {
                    field: 'membertype', title: '会员级别', width: '10%',
                    formatter: function (value) {
                        return value.memberlevel;
                    }
                },
                {
                    field: 'delfag', title: '当前状态', width: '27%',
                    formatter: function (value) {
                        if (value == "0") {
                            return "<input class=\"membereasyui1\" value='冻结'><input class=\"membereasyui3\" value='去解冻'>";
                        }
                        if (value == "1") {
                            return "<input class=\"membereasyui1\"value='待审核'><input class=\"membereasyui2\" value='去审核'>";
                        }
                        if (value == "2") {
                            return "<input class=\"membereasyui1\"value='正常'><input class=\"membereasyui4\" value='冻结该用户'>";
                        }
                    }
                },
            ]],

            onLoadSuccess: function () {
                $(".membereasyui1").linkbutton({})
                $(".membereasyui4").linkbutton({
                    width: '20%',
                    plain: true,
                    onClick: function () {
                        var id = this.parentNode.parentNode.previousSibling.previousSibling.previousSibling.previousSibling.previousSibling.previousSibling.previousSibling.previousSibling.firstChild.firstChild.value;
                        $.messager.confirm('确认', '您确定冻结该会员吗?', function (r) {
                            if (r) {
                                var status = 0;
                                $.ajax({
                                    url: "${pageContext.request.contextPath}/member/modify",
                                    data: "memberid=" + id + "&delfag=" + status,
                                    dataType: "json",
                                    success: function (json) {
                                        $.messager.show({
                                            title: '消息',
                                            msg: '修改成功',
                                            timeout: 5000,
                                            showType: 'slide'
                                        })
                                    }
                                })
                                $("#member_tt").datagrid('reload');
                            }
                        })

                    }
                })
                $(".membereasyui3").linkbutton({
                    width: '20%',
                    plain: true,
                    onClick: function () {
                        var id = this.parentNode.parentNode.previousSibling.previousSibling.previousSibling.previousSibling.previousSibling.previousSibling.previousSibling.previousSibling.firstChild.firstChild.value;
                        $.messager.confirm('确认', '您确定解冻该会员吗?' + id, function (r) {
                            if (r) {
                                var status = 2;
                                $.ajax({
                                    url: "${pageContext.request.contextPath}/member/modify",
                                    data: "memberid=" + id + "&delfag=" + status,
                                    dataType: "json",
                                    success: function (json) {
                                        $.messager.show({
                                            title: '消息',
                                            msg: '修改成功',
                                            timeout: 5000,
                                            showType: 'slide'
                                        })
                                    }
                                })
                                $("#member_tt").datagrid('reload');
                            }
                        })

                    }
                })
                $(".membereasyui2").linkbutton({
                    width: '20%',
                    plain: true,
                    onClick: function () {
                        var id = this.parentNode.parentNode.previousSibling.previousSibling.previousSibling.previousSibling.previousSibling.previousSibling.previousSibling.previousSibling.firstChild.firstChild.value;
                        $("#member_Auditingmsg").dialog({
                            closed: false,
                            title: '审核信息:',
                            modal: true,
                            width: '40%',
                            heght: '20%',
                            buttons: [{
                                text: '审核通过',
                                handler: function () {
                                    status = 0;
                                    $.ajax({
                                        url: "${pageContext.request.contextPath}/member/modify",
                                        type: "post",
                                        data: "memberid=" + id + "&delfag=" + status,
                                        dataType: "json",
                                        success: function (json) {
                                            $("#member_Auditingmsg").dialog({
                                                closed: true,
                                            })
                                            //1. 重新加载当前页面的信息。
                                            $("#member_tt").datagrid('reload');
                                            //2. 提示信息。
                                            $.messager.show({
                                                title: "提示",
                                                msg: json.msg,
                                            });
                                        }
                                    })
                                }
                            }, {
                                text: '审核不通过',
                                handler: function () {
                                    status = 2;
                                    $.ajax({
                                        url: "${pageContext.request.contextPath}/member/modify",
                                        type: "post",
                                        data: "memberid=" + id + "&delfag=" + status,
                                        dataType: "json",
                                        success: function (json) {
                                            $("#member_Auditingmsg").dialog({
                                                closed: true,
                                            })
                                            //1. 重新加载当前页面的信息。
                                            $("#member_tt").datagrid('reload');
                                            //2. 提示信息。
                                            $.messager.show({
                                                title: "提示",
                                                msg: json.msg,
                                            });
                                        }
                                    })
                                }
                            }, {
                                text: '关闭',
                                handler: function () {
                                    $("#member_Auditingmsg").dialog({
                                        closed: true,
                                    })
                                }
                            }]
                        })
                        $.ajax({
                            url: "${pageContext.request.contextPath}/member/selectById",
                            data: "memberid=" + id,
                            dataType: "json",
                            success: function (json) {
                                $("#member_Auditingmsg").dialog({
                                    title: '审核信息:',
                                    content: json.auditingmsg,
                                })
                            }
                        })
                    }
                })
                $(".membereasyuion").linkbutton({

                    onClick: function () {
                        var id = this.parentNode.parentNode.previousSibling.previousSibling.previousSibling.previousSibling.previousSibling.previousSibling.firstChild.firstChild.value;
                        console.log(id)
                        $.ajax({
                            url: "${pageContext.request.contextPath}/member/improve",
                            type: "post",
                            data: "memberid=" + id,
                            dataType: "json",
                            success: function (json) {
                                //1. 重新加载当前页面的信息。
                                $("#member_tt").datagrid('reload');
                                //2. 提示信息。
                                $.messager.show({
                                    title: "提示",
                                    msg: json.msg,
                                });
                            }
                        })
                    }
                });
            }
        });

    })
</script>
</body>
</html>
