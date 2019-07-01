<%@page isELIgnored="false" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>AdminLTE 2 | Starter</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <%@include file="../../link.jsp" %>
    <script>
        test7 = function (data, data1) {
            $("#h33").text(data);
            $("#myModalLabe").text(data1);
            var orderid = $("#myModalLabe").text();
            $("#roomsorder").html(" <tr>\n" +
                "                      <th>房间名称</th>\n" +
                "                      <th>房间类型</th>\n" +
                "                      <th>每小时价钱</th>\n" +
                "                    </tr>");
            $("#goodsorder").html(" <tr>\n" +
                "                      <th>商品名称</th>\n" +
                "                      <th>商品数量</th>\n" +
                "                      <th>商品单价</th>\n" +
                "                    </tr>");
            $.ajax({
                type: "POST",
                cache: false,
                url: "${pageContext.request.contextPath}/roomorder/selectOrder",
                data: "orderid=" + orderid,
                async: true,
                success: function (data) {
                    $.each(data.rooms, function (i) {
                        $('#roomsorder').append("<tr><td>" + data.rooms[i].room.roomname + "</td><td>" + data.rooms[i].room.roomtype.roomtype + "</td><td>" + data.rooms[i].room.roomtype.roommoney + "</td></tr>");
                    });
                    $.each(data.goods, function (i) {
                        $('#goodsorder').append("<tr><td>" + data.goods[i].goods.goodsname + "</td><td>" + data.goods[i].goodsnum + "</td> <td>" + data.goods[i].goods.goodsprice + "</td></tr>");
                    });
                    $("#h44").text(data.rooms[0].order.ordermoney);
                },
            });
        }
        test8 = function (data) {
            console.log("dasdsa")
            $.ajax({
                type: "get",
                cache: false,
                url: "${pageContext.request.contextPath}/roomorder/ordering",
                data: "orderid=" + data,
                async: true,
            });
        }
        $(function () {
            $.ajax({
                type: "POST",
                cache: false,
                url: "${pageContext.request.contextPath}/room/showAllByStatic",
                async: true,
                success: function (data) {
                    $.each(data, function (i) {
                        $('#usertype').append("<option value=" + data[i].roomid + ">" + data[i].roomname + "</option>");
                    });
                    $('#usertype').selectpicker('refresh');
                },
            });
        });
    </script>
</head>
<body>
<section class="content">
    <div class="modal fade" id="modal-container-699976" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title" id="myModalLabel">
                        请选择入住的房间
                    </h4>
                </div>
                <form action="${pageContext.request.contextPath}/">
                    <div class="modal-body">
                        <select id="usertype" style="width: 257px;" name="usertype" class="selectpicker show-tick"
                                title="请选择">
                        </select>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="submit" class="btn btn-primary">保存</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="modal fade" id="modal-container-699975" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <div><i class="modal-title" id="myModalLabe"> </i>号订单的详细信息</div>
                </div>
                <div class="modal-body">
                    <div class="box">
                        <div class="box-header with-border">
                            房间号：<h3 class="box-title" id="h33"></h3>
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            <table class="table table-bordered" id="roomsorder">
                                <tr>
                                    <th>房间名称</th>
                                    <th>房间类型</th>
                                    <th>每小时价钱</th>
                                </tr>
                            </table>
                            <table class="table table-bordered" id="goodsorder">
                                <tr>
                                    <th>商品名称</th>
                                    <th>商品数量</th>
                                    <th>商品价钱</th>
                                </tr>
                            </table>

                        </div>
                        <!-- /.box-body -->
                    </div>
                </div>
                <div class="modal-footer">
                    订单总价：<span id="h44"></span>元
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="box-header">
            订单管理
        </div>
        <div class="box-body">
            <div class="dataTables_wrapper form-inline dt-bootstrap">
                <div class="row">
                    <div class="col-sm-12">
                        <div class="col-md-3">
                        </div>
                        <div class="col-md-5">
                            <form action="${pageContext.request.contextPath}/roomorder/showAll2"
                                  class="form form-inline input-group">
                                <input type="text" class="form-control" placeholder="请输入订单编号" name="order.orderid"/>
                                <span class="input-group-btn"><input type="submit" class="btn btn-success" value="搜索"/></span>
                            </form>
                        </div>
                        <div class="col-md-4">
                            <form action="${pageContext.request.contextPath}/roomorder/showAll2"
                                  class="form form-inline input-group">
                                <select name="order.delflag" class="form-control">
                                    <option value="1">已支付</option>
                                    <option value="0">未支付</option>
                                </select>
                                <span class="input-group-btn"><input type="submit" class="btn btn-success" value="搜索"/></span>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        <table class="table table-bordered table-hover dataTable" role="grid"
                               aria-describedby="example2_info">
                            <thead>
                            <tr role="row">
                                <th class="sorting" tabindex="0" rowspan="1" colspan="1">编号</th>
                                <th class="sorting" tabindex="0" rowspan="1" colspan="1">订单id</th>
                                <th class="sorting" tabindex="0" rowspan="1" colspan="1">房间编号</th>
                                <th class="sorting" tabindex="0" rowspan="1" colspan="1">开始时间</th>
                                <th class="sorting" tabindex="0" rowspan="1" colspan="1">结束时间</th>
                                <th class="sorting" tabindex="0" rowspan="1" colspan="1">价钱</th>
                                <th class="sorting" tabindex="0" rowspan="1" colspan="1">状态</th>
                                <th class="sorting" tabindex="0" rowspan="1" colspan="1">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${requestScope.rooms}" varStatus="vs" var="p">
                                <tr>
                                    <td>${vs.count}</td>
                                    <td>${p.order.orderid}</td>
                                    <td>${p.room.roomname}</td>
                                    <td><fmt:formatDate value='${p.order.begintime}'
                                                        pattern="yyyy-mm-dd HH:MM:SS"/></td>
                                    <td><fmt:formatDate value='${p.order.endtime}' pattern="yyyy-mm-dd HH:MM:SS"/></td>
                                    <td>${p.order.ordermoney}</td>
                                    <td>${p.order.delflag==1?"已支付":"未支付"}</td>
                                    <td><c:if test="${p.order.delflag==0}">
                                        <a href="${pageContext.request.contextPath}/pay/index.jsp?oid=${p.order.orderid}&totalprice=${p.order.ordermoney}"
                                           onclick="test8(${p.order.orderid})"><i class="fa fa-arrow-circle-o-down"></i>去支付</a>
                                    </c:if>
                                        <a id="modal-699975" href="#modal-container-699975"
                                           onclick="test7(${p.room.roomname},${p.order.orderid})" role="button"
                                           class="btn btn-sm btn-default" data-toggle="modal"><i
                                                class="fa fa-map-pin"></i>查看订单详情</a>
                                    </td>
                                </tr>
                            </c:forEach>

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-4"></div>
            <div class="col-md-4">
                <ul class="pager">
                    <c:choose>
                        <c:when test="${query.pageSum>1}">
                            <li class="previous"><a
                                    href="${pageContext.request.contextPath}/roomorder/showAll2?pageSum=${query.pageSum-1}&pageSize=6&resname=${query.order.orderid}&delflag=${query.order.delflag}"
                                    class="btn btn-default">上一页</a></li>
                        </c:when>
                        <c:otherwise>
                            <li class="previous"><a href="#" class="btn btn-default">上一页</a></li>
                        </c:otherwise>
                    </c:choose>
                    <li class="btn btn-default">当前页：${query.pageSum}</li>
                    <c:choose>
                        <c:when test="${query.pageSum<query.count}">
                            <li class="next"><a
                                    href="${pageContext.request.contextPath}/roomorder/showAll2?pageSum=${query.pageSum+1}&pageSize=6&resname=${query.order.orderid}&delflag=${query.order.delflag}"
                                    class="btn btn-default">下一页</a></li>
                        </c:when>
                        <c:otherwise>
                            <li class="next"><a href="#" class="btn btn-default">下一页</a></li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
            <div class="col-md-4"></div>
        </div>
    </div>

</section>
</body>
</html>
