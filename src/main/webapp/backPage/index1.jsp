<%@ page language="java" pageEncoding="UTF-8" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <script type="text/javascript" src="http://cdn-hangzhou.goeasy.io/goeasy.js"></script>
    <script>
    </script>
</head>
<body>
<div id="main" style="width: 600px;height:400px;">
    <form action="${pageContext.request.contextPath}/import/out">
        <table>
            <tr>
                <td>请选择开始时间</td>
                <td><input type="date" name="beginTime"></td>
            </tr>
            <tr>
                <td>请导出结束时间</td>
                <td><input type="date" name="endTime"></td>
            </tr>
        </table>
        <input type="submit" style="text-align: center" value="导出"/>
    </form>
</div>
</body>
<script type="text/javascript">
    var goEasy = new GoEasy({
        appkey: 'BC-f4ff56b0748546268594dd8d6f91e416'
    });
    //推送消息
    goEasy.publish({
        channel: 'demo_channel2',
        message: 'Hello world!'
    });
    //接收消息
    goEasy.subscribe({
        channel: 'demo_channel1',
        onMessage: function (message) {
            alert('收到：' + message.content);
        }
    });
    //GoEasy-OTP可以对appkey进行有效保护，详情请参考：GoEasy-Reference
</script>
</html>
