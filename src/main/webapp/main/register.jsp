<%@ page language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>KTVRoomStart</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <%@include file="../frontPage/link.jsp" %>
</head>
<body>
<div class="register-box">
    <div class="register-logo">
        <a href=""><b>KTV包房</b>管理系统</a>
    </div>

    <div class="register-box-body">
        <p class="login-box-msg">注册一个管理员账号</p>

        <form action="${pageContext.request.contextPath }/user/register" method="post">
            <div class="form-group has-feedback">
                <input type="text" class="form-control" name="username" placeholder="用户名">
                <span class="glyphicon glyphicon-user form-control-feedback"></span>
            </div>
            <div class="form-group has-feedback">
                <input type="password" class="form-control" name="password" placeholder="密码">
                <span class="glyphicon glyphicon-lock form-control-feedback"></span>
            </div>
            <div class="form-group has-feedback">
                <input type="password" class="form-control" name="password" placeholder="确认密码">
                <span class="glyphicon glyphicon-log-in form-control-feedback"></span>
            </div>
            <div class="form-group has-feedback">
                <input type="text" class="form-control" name="sysword" placeholder="邀请码">
                <span class="glyphicon glyphicon-log-in form-control-feedback"></span>
            </div>
            <div class="form-group has-feedback">
                <input type="text" class="form-control" id="enCode" name="code" placeholder="请输入验证码"/>
                <img id="captchaImage" src="${pageContext.request.contextPath }/util/captcha"/>
            </div>
            <div class="row">
                <div class="col-xs-8">
                </div>
                <!-- /.col -->
                <div class="col-xs-4">
                    <span style="color: red">${requestScope.msg}</span>
                    <button type="submit" class="btn btn-primary btn-block btn-flat">注册</button>
                </div>
                <!-- /.col -->
            </div>
        </form>

        <a href="${pageContext.request.contextPath }/main/login.jsp" class="text-center">我已经有一个账号 去登陆</a>
    </div>
    <!-- /.form-box -->
</div>
<!-- /.register-box -->

<!-- jQuery 2.2.3 -->
<script src="../../plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="../../bootstrap/js/bootstrap.min.js"></script>
<!-- iCheck -->
<script src="../../plugins/iCheck/icheck.min.js"></script>
<script>
    $(function () {
        $("#captchaImage").on("click", function () {
            $("#captchaImage").prop("src", "${pageContext.request.contextPath }/util/captcha?time=" + new Date().getTime());
        });
    });
</script>
</body>
</html>
