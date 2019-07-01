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
        setTimeout("location=location;", 60000);
        //设置表单中的初始时间，比当前时间多一小时
        var now = new Date();
        now.setHours(now.getHours() + 1);
        var str = now.getFullYear() + "-" + fix((now.getMonth() + 1), 2) + "-" + fix(now.getDate(), 2) + "T" + fix(now.getHours(), 2) + ":" + fix(now.getMinutes(), 2);
        $("#startDate").val(str);

        //将日期格式化为两位，不足补零
        function fix(num, length) {
            return ('' + num).length < length ? ((new Array(length + 1)).join('0') + num).slice(-length) : '' + num;
        }

        //发送订单
        function sendOrder() {
            //将datetime-local转换为Date
            x = $("#startDate").val();
            now.setFullYear(parseInt(x.substring(0, 4)));
            now.setMonth(parseInt(x.substring(5, 7)) - 1);
            now.setDate(parseInt(x.substring(8, 10)));
            now.setHours(parseInt(x.substring(11, 13)));
            now.setMinutes(parseInt(x.substring(14, 16)));

            //获取表单数据，并序列化
            var formData = $("#order").serializeArray();

            //将序列化数据转为对象
            var formObject = {};
            for (var item in formData) {
                formObject[formData[item].name] = formData[item].value;
            }
            formObject.resarrtime = now;
            var formJSON = JSON.stringify(formObject);

            //发送JSON到服务器
            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/reserve/insert",
                contentType: "application/json",  //一定要设置这一行，很关键
                data: formJSON,
                datatype: "json",
                success: function (data) {
                    alert(data.msg);
                    history.go(0);
                }
            });
        }

        test9 = function () {
            var v1 = $("#usertype1").val()
            $("#roomid1").val(v1);
            //  window.location.href ="#modal-container-699977"
        },
            test10 = function (data) {
                $("#resid").val(data);
            },
            $(function () {
                $.ajax({
                    type: "POST",
                    cache: false,
                    url: "${pageContext.request.contextPath}/room/showAllByStatic",
                    async: true,
                    success: function (data) {
                        $.each(data, function (i) {
                            $('#usertype1').append("<option value=" + data[i].roomid + ">" + data[i].roomname + "</option>");
                        });
                        $('#usertype1').selectpicker('refresh');
                    },
                });
                $.ajax({
                    type: "POST",
                    cache: false,
                    url: "${pageContext.request.contextPath}/roomtype/showAll",
                    async: true,
                    success: function (data) {
                        $.each(data, function (i) {
                            $('#roomtype2').append("<option value=" + data[i].roomtypeid + ">" + data[i].roomtype + "</option>");
                        });
                        $('#roomtype2').selectpicker('refresh');
                    },
                });
                $.ajax({
                    type: "POST",
                    cache: false,
                    url: "${pageContext.request.contextPath}/membertype/showAll",
                    async: true,
                    success: function (data) {
                        $('#membertype3').append("<option value=0>" + "普通顾客" + "</option>");
                        $.each(data, function (i) {
                            $('#membertype3').append("<option value=" + data[i].membertypeid + ">" + data[i].memberlevel + "</option>");
                        });
                        $('#membertype3').selectpicker('refresh');
                    },
                });
            });
    </script>
</head>
<body>
<section class="content">
    <div class="modal fade" id="modal-container-699989" role="dialog" aria-labelledby="myModalLabe2" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    请填写预定人员信息
                    </h4>
                </div>
                <form id="order">
                    <div class="modal-body">
                        <table>
                            <tr>
                                <td>预定人姓名：</td>
                                <td><input type="text" name="resname"/></td>
                            </tr>
                            <tr>
                                <td>预定人手机号码：</td>
                                <td><input type="text" name="resphone"/></td>
                            </tr>
                            <tr>
                                <td> 预定房间类型：</td>
                                <td><select id="roomtype2" style="width: 257px;" name="delflag"
                                            class="selectpicker show-tick">

                                </select></td>
                            </tr>
                            <tr>
                                <td> 预定到达时间：</td>
                                <td><input type="datetime-local" id="startDate" name="resarrtime"/></td>
                            </tr>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="button" onclick="sendOrder()" class="btn btn-primary">添加</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="modal fade" id="modal-container-699976" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title" id="myModalLabel">
                        请选择入住的房间
                    </h4>
                </div>
                <div class="modal-body">
                    <select id="usertype1" style="width: 257px;" name="usertype" class="selectpicker show-tick">
                    </select>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <a id="modal-699977" href="#modal-container-699977" role="button" data-toggle="modal"
                       onclick="test9()" class="btn btn-primary">确定</a>
                </div>
                </form>
            </div>
        </div>
    </div>
    <div class="modal fade" id="modal-container-699977" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title" id="myModalLabe3">
                        请填写开房资料
                    </h4>
                </div>
                <form action="${pageContext.request.contextPath}/roomorder/insert1">
                    <input type="number" hidden id="roomid1" name="roomid"/>
                    <input type="number" hidden id="resid" name="resid"/>
                    <!-- Date and time range -->
                    <div class="form-group">
                        <label>请输入开房时间</label>
                        <div class="input-group">
                            <div class="input-group-addon">
                                <i class="fa fa-clock-o"></i>
                            </div>
                            <input type="number" name="roomdate">
                        </div>
                        <!-- /.input group -->
                        <label>如果该顾客是会员，请选择会员类型</label>
                        <div class="input-group">
                            <div class="input-group-addon">
                                <i class="fa fa-clock-o"></i>
                            </div>
                            <select id="membertype3" style="width: 257px;" name="discount"
                                    class="selectpicker show-tick">
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="submit" class="btn btn-primary">保存</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="box-header">
            预定信息管理
            <div>
                <a id="modal-699989" href="#modal-container-699989" role="button" class="btn btn-xs btn-danger"
                   data-toggle="modal"><i class="fa fa-plus-square"></i>添加预定信息</a>
            </div>
        </div>

        <div class="box-body">
            <div class="dataTables_wrapper form-inline dt-bootstrap">
                <div class="row">
                    <div class="col-sm-12">
                        <div class="col-md-3">
                        </div>
                        <div class="col-md-5">
                            <form action="${pageContext.request.contextPath}/reserve/showAll"
                                  class="form form-inline input-group">
                                <input type="text" class="form-control" placeholder="请输入预定人姓名" name="resname"/>
                                <span class="input-group-btn"><input type="submit" class="btn btn-success" value="搜索"/></span>
                            </form>
                        </div>
                        <div class="col-md-4">
                            <form action="${pageContext.request.contextPath}/reserve/showAll"
                                  class="form form-inline input-group">
                                <select name="delflag" class="form-control">
                                    <option value="1">已入住</option>
                                    <option value="0">未入住</option>
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
                                <th class="sorting" tabindex="0" rowspan="1" colspan="1">预定人姓名</th>
                                <th class="sorting" tabindex="0" rowspan="1" colspan="1">预定手机号码</th>
                                <th class="sorting" tabindex="0" rowspan="1" colspan="1">预定房间类型</th>
                                <th class="sorting" tabindex="0" rowspan="1" colspan="1">到达时间</th>
                                <th class="sorting" tabindex="0" rowspan="1" colspan="1">是否完成预定</th>
                                <th class="sorting" tabindex="0" rowspan="1" colspan="1">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${requestScope.reserves}" varStatus="vs" var="p">
                                <tr>
                                    <td>${vs.count}</td>
                                    <td>${p.resname}</td>
                                    <td>${p.resphone}</td>
                                    <td>${p.roomtype.roomtype}</td>
                                    <td><fmt:formatDate value='${p.resarrtime}' pattern="yyyy/MM/dd HH:MM:SS"/></td>
                                    <td>${p.delflag==1?"已入住":"未入住"}</td>
                                    <td><c:if test="${p.delflag==0}">
                                        <a id="modal-699976" onclick="test10(${p.resid})" href="#modal-container-699976"
                                           role="button" class="btn btn-xs btn-danger" data-toggle="modal"><i
                                                class="fa fa-arrow-circle-down"></i>入住</a>
                                    </c:if></td>
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
                                    href="${pageContext.request.contextPath}/reserve/showAll.do?pageSum=${query.pageSum-1}&pageSize=6&resname=${query.resname}&delflag=${query.delflag}"
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
                                    href="${pageContext.request.contextPath}/reserve/showAll.do?pageSum=${query.pageSum+1}&pageSize=6&resname=${query.resname}&delflag=${query.delflag}"
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
