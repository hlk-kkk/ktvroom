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
        function member1(dat) {
            $("#membermsgid").val(dat);
        }

        $(function () {
            $.ajax({
                type: "POST",
                cache: false,
                url: "${pageContext.request.contextPath}/membertype/showAll",
                async: true,
                success: function (data) {
                    $.each(data, function (i) {
                        $('#membertype4').append("<option value=" + data[i].membertypeid + ">" + data[i].memberlevel + "</option>");
                    });
                    $('#membertype4').selectpicker('refresh');
                },
            });
        });
    </script>
</head>
<body>
<section class="content">
    <div class="modal fade" id="modal-container-688888" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title" id="myModalLabel">
                        请填写会员信息
                    </h4>
                </div>
                <form action="${pageContext.request.contextPath}/member/insert1">
                    <div class="modal-body">
                        <table>
                            <tr>
                                <td>会员姓名：</td>
                                <td><input type="text" name="membername"/></td>
                            </tr>
                            <tr>
                                <td>会员手机号码：</td>
                                <td><input type="text" name="memberphone"/></td>
                            </tr>
                            <tr>
                                <td>性别：</td>
                                <td><select name="sex">
                                    <option value="1">男</option>
                                    <option value="0">女</option>
                                </select>
                                </td>
                            </tr>
                            <tr>
                                <td>请选择会员类型：</td>
                                <td><select id="membertype4" style="width: 257px;" name="membertype.membertypeid"
                                            class="selectpicker show-tick" title="请选择"></select>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="submit" class="btn btn-primary">保存</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="modal fade" id="modal-container-688889" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title" id="myModalLabe5">
                        冻结会员
                    </h4>
                </div>
                <form action="${pageContext.request.contextPath}/member/modify">
                    <div class="modal-body">
                        <table>
                            <tr>
                                <td><input type="text" hidden id="membermsgid" name="memberid"></td>
                            </tr>
                            <tr>
                                <td>冻结该会员原因：</td>
                                <td><input type="text" name="auditingmsg"/></td>
                            </tr>
                        </table>
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
            会员信息管理 <br>
            <a id="modal-688888" href="#modal-container-688888" role="button" class="btn btn-xs btn-danger"
               data-toggle="modal"><i class="fa fa-plus-square"></i>添加会员</a>
        </div>
        <div class="box-body">
            <div class="dataTables_wrapper form-inline dt-bootstrap">
                <div class="row">
                    <div class="col-sm-12">
                        <div class="col-md-3">
                        </div>
                        <div class="col-md-5">
                            <form action="${pageContext.request.contextPath}/member/showAll1"
                                  class="form form-inline input-group">
                                <input type="text" class="form-control" placeholder="请输入会员姓名" name="membername"/>
                                <span class="input-group-btn"><input type="submit" class="btn btn-success" value="搜索"/></span>
                            </form>
                        </div>
                        <div class="col-md-4">
                            <form action="${pageContext.request.contextPath}/member/showAll1"
                                  class="form form-inline input-group">
                                <select name="delfag" class="form-control">
                                    <option value="0">已冻结</option>
                                    <option value="2">未冻结</option>
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
                                <th class="sorting" tabindex="0" rowspan="1" colspan="1">会员姓名</th>
                                <th class="sorting" tabindex="0" rowspan="1" colspan="1">会员类型</th>
                                <th class="sorting" tabindex="0" rowspan="1" colspan="1">会员性别</th>
                                <th class="sorting" tabindex="0" rowspan="1" colspan="1">手机号码</th>
                                <th class="sorting" tabindex="0" rowspan="1" colspan="1">注册时间</th>
                                <th class="sorting" tabindex="0" rowspan="1" colspan="1">会员编号</th>
                                <th class="sorting" tabindex="0" rowspan="1" colspan="1">会员积分</th>
                                <th class="sorting" tabindex="0" rowspan="1" colspan="1">会员冻结</th>
                                <th class="sorting" tabindex="0" rowspan="1" colspan="1">冻结信息</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${requestScope.members}" varStatus="vs" var="p">
                            <tr>
                                <td>${vs.count}</td>
                                <td>${p.membername}</td>
                                <td>${p.membertype.memberlevel}</td>
                                <td>${p.sex==1?"男":"女"}</td>
                                <td>${p.memberphone}</td>
                                <td><fmt:formatDate value='${p.entryDate}' pattern="yyyy/MM/dd"/></td>
                                <td>${p.membernum}</td>
                                <td>${p.memberintegral}</td>
                                <td>
                                    <c:if test="${p.delfag==0}">
                                        已冻结
                                    </c:if>
                                    <c:if test="${p.delfag==2}">
                                        未冻结
                                        <a id="modal-688889" href="#modal-container-688889" role="button"
                                           onclick="member1(${p.memberid})" data-toggle="modal">冻结该会员</a>
                                    </c:if>
                                </td>
                                <td><c:if test="${p.delfag==0}">
                                    ${p.auditingmsg}
                                </c:if></td>
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
                                    href="${pageContext.request.contextPath}/member/showAll1.do?pageSum=${query.pageSum-1}&pageSize=3&membername=${query.membername}&delfag=${query.delfag}"
                                    class="btn btn-default">上一页</a></li>
                        </c:when>
                        <c:otherwise>
                            <li class="previous"><a href="#" class="btn btn-default">上一页</a></li>
                        </c:otherwise>
                    </c:choose>
                    <li class="btn btn-default">当前页：1${query.pageSum}</li>
                    <c:choose>
                        <c:when test="${query.pageSum<query.count}">
                            <li class="next"><a
                                    href="${pageContext.request.contextPath}/member/showAll1.do?pageSum=${query.pageSum+1}&pageSize=3&membername=${query.membername}&delfag=${query.delfag}"
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
