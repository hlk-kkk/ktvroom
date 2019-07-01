<%@ page language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>KTVRoom管理系统</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

    <!-- Bootstrap 3.3.6 -->
    <link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../dist/css/font-awesome.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="../dist/css/ionicons.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="../dist/css/AdminLTE.min.css">
    <!-- AdminLTE Skins. Choose a skin from the css/skins
         folder instead of downloading all of them to reduce the load. -->
    <link rel="stylesheet" href="../dist/css/skins/all-skins.min.css">
    <!-- ./wrapper -->
    <!-- jQuery 2.2.3 -->
    <script src="../plugins/jQuery/jquery-2.2.3.min.js"></script>
    <!-- Bootstrap 3.3.6 -->
    <script src="../bootstrap/js/bootstrap.min.js"></script>
    <!-- Slimscroll -->
    <script src="../plugins/slimScroll/jquery.slimscroll.min.js"></script>
    <!-- FastClick -->
    <script src="../plugins/fastclick/fastclick.js"></script>
    <!-- AdminLTE App -->
    <script src="../dist/js/app.js"></script>
    <!-- AdminLTE for demo purposes -->
    <script src="../dist/js/demo.js"></script>
    <!--tabs-->
    <script src="../dist/js/app_iframe.js"></script>
    <!--http://aimodu.org:7777/admin/index_iframe.html?q=audio&search=#-->
    <style type="text/css">
        html {
            overflow: hidden;
        }
    </style>
</head>
<body class="hold-transition skin-blue sidebar-mini fixed">
<div class="wrapper">
    <header class="main-header">
        <!-- Logo -->
        <a href="index_iframe.jsp" class="logo">
            <span class="logo-lg"><b>KTVRoom管理</b></span>
        </a>
        <nav class="navbar navbar-static-top">
            <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </a>

            <div class="navbar-custom-menu">
                <ul class="nav navbar-nav">
                    <li class="dropdown user user-menu">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            <img src="../dist/img/user2-160x160.jpg" class="user-image" alt="User Image">
                            <span class="hidden-xs">${sessionScope.user.username}</span>
                        </a>
                        <ul class="dropdown-menu">
                            <li class="user-header">
                                <img src="../dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">

                                <p>
                                    ${sessionScope.user.address}
                                    <small>${sessionScope.user.realname}</small>
                                </p>
                            </li>
                            <!-- /.row -->
                            <!-- Menu Footer-->
                            <li class="user-footer">
                                <div class="pull-left">
                                    <a href="#" class="btn btn-default btn-flat">设置个人信息</a>
                                </div>
                                <div class="pull-right">
                                    <a href="#" class="btn btn-default btn-flat">退出登录</a>
                                </div>
                            </li>
                        </ul>
                    </li>

                </ul>
            </div>
        </nav>
    </header>
    <aside class="main-sidebar">
        <section class="sidebar">
            <div class="user-panel">
                <div class="pull-left image">
                    <img src="../dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
                </div>
                <div class="pull-left info">
                    <p>${sessionScope.user.username}</p>
                    <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
                </div>
            </div>
            <!-- 菜单栏-->
            <ul class="sidebar-menu">
            </ul>
        </section>
        <!-- /.sidebar -->
    </aside>

    <div class="content-wrapper" id="content-wrapper" style="min-height: 421px;">
        <div class="content-tabs">
            <button class="roll-nav roll-left tabLeft" onclick="scrollTabLeft()">
                <i class="fa fa-backward"></i>
            </button>
            <nav class="page-tabs menuTabs tab-ui-menu" id="tab-menu">
                <div class="page-tabs-content" style="margin-left: 0px;">

                </div>
            </nav>
            <button class="roll-nav roll-right tabRight" onclick="scrollTabRight()">
                <i class="fa fa-forward" style="margin-left: 3px;"></i>
            </button>
            <div class="btn-group roll-nav roll-right">
                <button class="dropdown tabClose" data-toggle="dropdown">
                    页签操作<i class="fa fa-caret-down" style="padding-left: 3px;"></i>
                </button>
                <ul class="dropdown-menu dropdown-menu-right" style="min-width: 128px;">
                    <li><a class="tabReload" href="javascript:refreshTab();">刷新当前</a></li>
                    <li><a class="tabCloseCurrent" href="javascript:closeCurrentTab();">关闭当前</a></li>
                    <li><a class="tabCloseAll" href="javascript:closeOtherTabs(true);">全部关闭</a></li>
                    <li><a class="tabCloseOther" href="javascript:closeOtherTabs();">除此之外全部关闭</a></li>
                </ul>
            </div>
            <button class="roll-nav roll-right fullscreen" onclick="App.handleFullScreen()"><i
                    class="fa fa-arrows-alt"></i></button>
        </div>
        <div class="content-iframe " style="background-color: #ffffff; ">
            <div class="tab-content " id="tab-content">
            </div>
        </div>
    </div>
    <footer class="main-footer">
        <div class="pull-right hidden-xs">
            Everything is possible
        </div>
        <strong>create &copy; 2018/01/22</strong>&nbsp; by hlk
    </footer>
    <div class="control-sidebar-bg"></div>
</div>

<script type="text/javascript">
    $(function () {
        App.setbasePath("../");
        App.setGlobalImgPath("dist/img/");
        addTabs({
            id: '10008',
            title: '欢迎页',
            close: false,
            url: 'welcome.jsp',
            urlType: "relative"
        });

        App.fixIframeCotent();


        var menus = [
            {
                id: "9000",
                text: "header",
                icon: "",
                isHeader: true
            },
            {
                id: "9001",
                text: "预定管理",
                icon: "fa fa-laptop",
                children: [
                    {
                        id: "90022",
                        text: "预定操作",
                        icon: "fa fa-circle-o",
                        url: "../reserve/showAll",
                        targetType: "iframe-tab"
                    },
                ]
            },
            {
                id: "9002",
                text: "房间服务管理",
                icon: "fa fa-edit",
                children: [
                    {
                        id: "90023",
                        text: "房间管理",
                        url: "../room/showAll1",
                        targetType: "iframe-tab",
                        icon: "fa fa-circle-o",
                    }
                ]
            },
            {
                id: "9003",
                text: "会员管理",
                icon: "fa fa-edit",
                children: [
                    {
                        id: "90025",
                        text: "会员列表",
                        url: "../member/showAll1",
                        targetType: "iframe-tab",
                        icon: "fa fa-circle-o",
                    }
                ]
            },
            {
                id: "9004",
                text: "结账收银",
                icon: "fa fa-edit",
                children: [
                    {
                        id: "90026",
                        text: "订单处理",
                        url: "../roomorder/showAll2",
                        targetType: "iframe-tab",
                        icon: "fa fa-circle-o",

                    }
                ]
            }
        ];
        $('.sidebar-menu').sidebarMenu({data: menus});

    });
</script>

</body>
</html>