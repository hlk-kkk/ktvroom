<%@page isELIgnored="false" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<!DOCTYPE html >
<head>
    <%@include file="link.jsp" %>
    <script>
        <!--菜单处理-->
        $(function () {
            $.ajax({
                url: "${pageContext.request.contextPath}/menu/showAll.do",
                dataType: "json",
                success: function (obj) {
                    $.each(obj, function (index, first) {
                        var title = "";
                        $.each(first.children, function (index1, second) {
                            title += "<p style=\"text-align:center;\"><a onclick=addTab('" + second.title + "','" + second.iconCls + "','" + second.href + "') style=\"font-size:15px;font-family: 楷体\" href=\"#\" class=\"easyui-linkbutton\" data-options=\"iconCls:'" + second.iconCls + "'\">" + second.title + "</a></p>";
                        });
                        $('#menu_aa').accordion('add', {
                            title: first.title,
                            content: title,
                            selected: false,
                            iconCls: first.iconCls
                        });
                    });
                }
            });
        });

        function addTab(title, iconCls, href) {
            var isOk = $("#menu_tt").tabs('exists', title);
            if (isOk) {
                $("#menu_tt").tabs('select', title);
            } else {
                $('#menu_tt').tabs('add', {
                    title: title,
                    href: "${pageContext.request.contextPath}/" + "backPage/" + href,
                    closable: true,
                    pill: true,
                });
            }
        }
    </script>
</head>
<body class="easyui-layout">
<div data-options="region:'north',split:true" style="height:10%;background-color:  #5C160C">
    <div style="font-size: 24px;color: #FAF7F7;font-family: 楷体;font-weight: 900;width: 70%;float:left;padding-left: 20px;padding-top: 10px">
        KTV后台管理系统
    </div>
    <div style="font-size: 16px;color: #FAF7F7;font-family: 楷体;width:  30%;float:right;padding-top:15px">欢迎您:xxxxx
        &nbsp;
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">修改密码</a>
        &nbsp;&nbsp;<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-back'">退出系统</a></div>
</div>
<div data-options="region:'south',split:true" style="height: 40px;background: #5C160C">
</div>
<div data-options="region:'west',title:'导航菜单',split:true" style="width:15%">
    <div id="menu_aa" class="easyui-accordion"></div>
    <div id="cc" class="easyui-calendar" style="width:100%;height:30%;"></div>

</div>
<div data-options="region:'center'">
    <div id="menu_tt" class="easyui-tabs" data-options="fit:true,narrow:true,pill:true">
    </div>
</div>
</body>
</html>
