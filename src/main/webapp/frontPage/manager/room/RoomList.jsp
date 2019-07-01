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
        function test1(dat) {
            var r = window.confirm("你确定要恢复房间状态吗？")
            if (r) {
                $.ajax({
                    type: "get",
                    cache: false,
                    url: "${pageContext.request.contextPath}/room/modify",
                    data: "roomid=" + dat + "&roomcondition=2",
                    async: true,
                    success: function (data) {
                        window.alert(data.msg);
                        history.go(0)
                    },
                });
            }
        }

        function test2(dat) {
            var r = window.confirm("你确定要将该房间状态设置成不可用状态吗？")
            if (r) {
                $.ajax({
                    type: "get",
                    cache: false,
                    url: "${pageContext.request.contextPath}/room/modify",
                    data: "roomid=" + dat + "&roomcondition=0",
                    async: true,
                    success: function (data) {
                        window.alert(data.msg);
                        history.go(0)
                    },
                });
            }
        }

        function test3(dat) {
            $("#roomid").val(dat)
        }

        function test4(dat) {
            var r = window.confirm("该订单完成支付后才可以手动退房，退房之后该房间为打扫房")
            if (r) {
                $.ajax({
                    type: "get",
                    cache: false,
                    url: "${pageContext.request.contextPath}/room/modify",
                    data: "roomid=" + dat + "&roomcondition=1",
                    async: true,
                    success: function (data) {
                        window.alert(data.msg);
                        history.go(0)
                    },
                });
            }
        }

        function test5(dat) {
            $("#roomids").val(dat)
        }

        function test6() {
            var roomids = $("#roomids").val();
            var goodsid = $("#goodstype").val();
            var goodsnum = $("#goodsnum").val();
            $.ajax({
                type: "get",
                url: "${pageContext.request.contextPath}/roomorder/shopgoods",
                data: "roomids=" + roomids + "&goodsid=" + goodsid + "&goodsnum=" + goodsnum,
                success: function (data) {
                    window.alert(data.msg);
                    history.go(0)
                }
            })
        }

        $(function () {
            $.ajax({
                type: "POST",
                cache: false,
                url: "${pageContext.request.contextPath}/goods/showAll1",
                async: true,
                success: function (data) {
                    $.each(data, function (i) {
                        $('#goodstype').append("<option value=" + data[i].goodsid + ">" + data[i].goodsname + "</option>");
                    });
                    $('#goodstype').select('refresh');
                },
            });
            $.ajax({
                type: "POST",
                cache: false,
                url: "${pageContext.request.contextPath}/membertype/showAll",
                async: true,
                success: function (data) {
                    $('#membertype4').append("<option value=0>" + "普通顾客" + "</option>");
                    $.each(data, function (i) {
                        $('#membertype4').append("<option value=" + data[i].membertypeid + ">" + data[i].memberlevel + "</option>");
                    });
                    $('#membertype4').selectpicker('refresh');
                },
            });
        })
    </script>

</head>
<body>
<div class="modal fade" id="modal-container-699976" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="myModalLabel">
                    请填写开房资料
                </h4>
            </div>
            <form action="${pageContext.request.contextPath}/roomorder/insert">
                <input type="number" hidden id="roomid" name="roomid"/>
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
                        <select id="membertype4" style="width: 257px;" name="discount" class="selectpicker show-tick">
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
<div class="modal fade" id="modal-container-699988" role="dialog" aria-labelledby="myModalLabe2" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="myModalLabe2">
                    请选择酒水
                </h4>
            </div>
            <!--  <form action="${pageContext.request.contextPath}/roomorder/shopgoods">-->
            <input type="number" hidden id="roomids" name="roomids"/>
            <div class="modal-body">
                <select id="goodstype" style="width: 257px;" name="goodsid" class="selectpicker show-tick" title="请选择">
                </select>
                请输入商品数量
                <input type="number" id="goodsnum" name="goodsnum"/>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <a href="#" onclick="test6()">购买</a>
            </div>
            <!--   </form>-->
        </div>
    </div>
</div>
<div class="dataTables_wrapper form-inline dt-bootstrap">
    <div class="row">
        <div class="col-sm-12">
            <div class="col-md-3">
            </div>
            <div class="col-md-5">
            </div>
            <div class="col-md-4">
                <form action="${pageContext.request.contextPath}/room/showAll1" class="form form-inline input-group">
                    <select name="roomcondition" class="form-control">
                        <option value="0">维修房</option>
                        <option value="1">打扫房</option>
                        <option value="2">干净房</option>
                        <option value="3">在用房</option>
                    </select>
                    <span class="input-group-btn"><input type="submit" class="btn btn-success" value="搜索"/></span>
                </form>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-sm-12">
        <table class="table table-bordered table-hover dataTable" role="grid" aria-describedby="example2_info">
            <thead>
            <tr role="row">
                <th class="sorting" tabindex="0" rowspan="1" colspan="1">编号</th>
                <th class="sorting" tabindex="0" rowspan="1" colspan="1">房间号码</th>
                <th class="sorting" tabindex="0" rowspan="1" colspan="1">房间类型</th>
                <th class="sorting" tabindex="0" rowspan="1" colspan="1">房间状态</th>
                <th class="sorting" tabindex="0" rowspan="1" colspan="1">操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${requestScope.rooms}" varStatus="vs" var="p">
                <tr>
                    <td>${vs.count}</td>
                    <td>${p.roomname}</td>
                    <td>${p.roomtype.roomtype}</td>
                    <c:if test="${p.roomcondition==0}">
                        <td>维修房</td>
                        <td id="modal-0"><a href="#" onclick="test1(${p.roomid})"><i
                                class="fa fa-arrow-circle-down"></i>恢复正常</a>
                        </td>
                    </c:if>
                    <c:if test="${p.roomcondition==1}">
                        <td>打扫房</td>
                        <td id="modal-0">
                            <a href="#" onclick="test2(${p.roomid})"><i class="fa fa-arrow-circle-down"></i>设置为维修房</a>&nbsp;&nbsp;
                            <a href="#" onclick="test1(${p.roomid})"><i class="fa fa-arrow-circle-down"></i>打扫完毕</a>
                        </td>
                    </c:if>
                    <c:if test="${p.roomcondition==2}">
                        <td>可用房</td>
                        <td id="modal-0">
                            <a href="#" onclick="test2(${p.roomid})"><i class="fa fa-arrow-circle-down"></i>设置为维修房</a>&nbsp;&nbsp;
                            <a id="modal-699976" href="#modal-container-699976" role="button"
                               onclick="test3(${p.roomid})" class="btn btn-xs btn-danger" data-toggle="modal"><i
                                    class="fa fa-arrow-circle-down"></i>开房</a>
                        </td>
                    </c:if>
                    <c:if test="${p.roomcondition==3}">
                        <td>在用房</td>
                        <td id="modal-0">
                            <a href="#" onclick="test4(${p.roomid})"><i class="fa fa-arrow-circle-down"></i>手动退房</a>
                            <a id="modal-699988" href="#modal-container-699988" role="button"
                               onclick="test5(${p.roomid})" class="btn btn-xs btn-danger" data-toggle="modal"><i
                                    class="fa fa-arrow-circle-down"></i>购买酒水</a>
                        </td>
                    </c:if>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

</div>
<script>
    $('.input_cxcalendar').each(function () {
        var a = new Calendar({
            targetCls: $(this),
            type: 'yyyy-mm-dd HH:MM:SS',
        }, function (val) {
            console.log(val);
        });
    });
    $(function () {

    })
</script>
</body>
</html>
