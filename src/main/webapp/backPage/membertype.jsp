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
<div id="membertype_tb">
    <a href="#" class="easyui-linkbutton" onclick="membertype.add()" title="添加会员等级"
       data-options="iconCls:'icon-add',plain:true"/>
    <a href="#" class="easyui-linkbutton" onclick="membertype.update()" title="修改会员等级信息"
       data-options="iconCls:'icon-reload',plain:true"/>
    <a href="#" class="easyui-linkbutton" onclick="membertype.delete()" title="删除选中"
       data-options="iconCls:'icon-cancel',plain:true"/>
</div>
<div id="membertype_update" hidden>
    <form id="membertype_ff1" method="post" enctype="multipart/form-data">
        <table style="font-size:15px;font-family: 楷体">
            <tr style="height: 30px">
                <td>会员等级名称<input type="hidden" class="easyui-textbox" style="display:none" name="membertypeid"/></td>
                <td>
                    <input type="text" class="easyui-textbox" data-options="required:true"
                           style="width:100px;text-align: left" name="memberlevel"/></td>
            </tr>
            <tr style="height: 30px">
                <td>该等级折扣</td>
                <td>
                    <input type="text" class="easyui-numberbox" data-options="required:true,min:0,max:10,precision:1"
                           style="width:100px;text-align: left" name="memberdiscount"/></td>
            </tr>
            <tr style="height: 30px">
                <td>提升到该等级所需积分</td>
                <td><input type="text" class="easyui-numberspinner" data-options="required:true,min:0,max:100000,"
                           style="width:200px;" name="memberintegral"></td>
            </tr>
        </table>
    </form>
</div>
<div id="membertype_add" hidden>
    <form id="membertype_ff2" method="post" enctype="multipart/form-data">
        <table style="font-size:15px;font-family: 楷体">
            <tr style="height: 30px">
                <td>会员等级名称</td>
                <td>
                    <input type="text" class="easyui-textbox" data-options="required:true"
                           style="width:100px;text-align: left" name="memberlevel"/></td>
            </tr>
            <tr style="height: 30px">
                <td>该等级折扣</td>
                <td>
                    <input type="text" class="easyui-numberbox" data-options="required:true,min:0,max:10,precision:2"
                           style="width:100px;text-align: left" name="memberdiscount"/></td>
            </tr>
            <tr style="height: 30px">
                <td>提升到该等级所需积分</td>
                <td><input type="text" class="easyui-numberspinner" data-options="required:true,min:0,max:100000,"
                           style="width:200px;" name="memberintegral"></td>
            </tr>
        </table>
    </form>
</div>
<table id="membertype_tt"></table>
<script type="text/javascript">
    membertype = {
        delete: function () {
            var as = $("#membertype_tt").datagrid('getChecked');
            if (as[0] == null) {
                $.messager.show({
                    title: '提示',
                    msg: '请选择一行数据'
                })
            } else {
                var param = "";
                var num = 0;
                for (var i = 0; i < as.length; i++) {
                    var id = as[i].membertypeid;
                    if (id <= 3) {
                        num += 1;
                    }
                    if (i == 0) {
                        param = param + "ids=" + id;
                    } else {
                        param = param + "&ids=" + id;
                    }
                }
                if (num == 0) {
                    $.messager.confirm('确认对话框', '您确定要删除吗？', function (r) {
                        if (r) {
                            $.ajax({
                                url: "${pageContext.request.contextPath}/membertype/removes",
                                type: "post",
                                data: param,
                                dataType: "json",
                                success: function (json) {
                                    //1. 重新加载当前页面的信息。
                                    $("#membertype_tt").datagrid('reload');
                                    //2. 提示信息。
                                    $.messager.show({
                                        title: "提示",
                                        msg: json.msg,
                                    });
                                }
                            });
                        }
                    });
                } else {
                    $.messager.alert('警告', '初始等级不允许删除', 'info');
                }
            }
        },
        update: function (id) {
            var as = $("#membertype_tt").datagrid('getSelected');
            var id = as.membertypeid;
            $("#membertype_ff1").form('load', "${pageContext.request.contextPath}/membertype/selectById?membertypeid=" + id);
            $("#membertype_update").dialog({
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
                        $('#membertype_ff1').form('submit', {
                            url: "${pageContext.request.contextPath}/membertype/update",
                            success: function (data) {
                                var s = JSON.parse(data);
                                $.messager.show({
                                    title: "提示",
                                    msg: s.msg,
                                    timeout: 5000,
                                    showType: 'slide'
                                })
                                $('#membertype_tt').datagrid("reload");
                                $("#membertype_ff1").form("clear");
                                $("#membertype_update").dialog({
                                    closed: true,
                                });
                            }
                        })
                    }
                }, {
                    text: '关闭',
                    handler: function () {
                        $("#membertype_ff1").form("clear");
                        $("#membertype_update").dialog({
                            closed: true,
                        })
                    }
                }]
            })
        },
        add: function () {
            $("#membertype_add").dialog({
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
                        $('#membertype_ff2').form('submit', {
                            url: "${pageContext.request.contextPath}/membertype/insert",
                            success: function (json) {
                                var s = JSON.parse(json);
                                $.messager.show({
                                    title: "提示",
                                    msg: s.msg,
                                    timeout: 5000,
                                    showType: 'slide'
                                })
                                $('#membertype_tt').datagrid("reload");
                                $("#membertype_ff2").form("clear");
                                $("#membertype_add").dialog({
                                    closed: true,
                                });
                            }
                        })
                    }
                }, {
                    text: '关闭',
                    handler: function () {
                        $("#membertype_ff2").form("clear");
                        $("#membertype_add").dialog({
                            closed: true,
                        })
                    }
                }]
            })
        },

    }
    $(function () {
        $('#membertype_tt').datagrid({
            fit: true,
            toolbar: '#membertype_tb',
            title: "会员等级信息",
            pagination: "ture",
            remoteSort: false,
            nowrap: false,
            rownumbers: true,
            striped: true,
            url: '${pageContext.request.contextPath}/membertype/showAll',
            columns: [[
                {field: 'membertypeid', title: 'id', width: '10%', checkbox: true,},
                {field: 'memberlevel', title: '会员等级名称', width: '15%'},
                {field: 'memberintegral', title: '提升到该等级所需积分', width: '20%'},
                {field: 'memberdiscount', title: '该等级折扣', width: '20%'},
            ]],
            onLoadSuccess: function () {

            },
        })
    })
</script>
</body>
</html>
