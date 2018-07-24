<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Pets</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layui/css/layui.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
<script src="${pageContext.request.contextPath}/css/layui/layui.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery/jquery-3.2.1.min.js"></script>
<style>
	.layui-table-view .layui-table[lay-size=lg] .layui-table-cell {
	    height: 70px;
	    line-height: 70px;
	}
	.itemTd:hover{
		color: orange;
	}
</style>
</head>
<body style="overflow-y: auto; background-color: #f1ecec;">

	<%@ include file="/WEB-INF/jsp/headBar.jsp" %>

	<div style="margin: 25px 50px;">
		<c:if test="${not empty order }">
			<div id="haveData" style="">
				<div class="head-title-div">
					<p class="head-title-p">核对订单信息</p>
				</div>
				<div class="order-address-body">
					<div style="background: #ffffff; height: 30px;"></div>
					<table class="order-table" align="center" style="text-align: center;" >
						<colgroup>
							<col width="70">
							<col width="350">
							<col width="100">
							<col width="100">
							<col width="200">
							<col width="200">
							<col width="200">
						</colgroup>
						<thead>
							<tr>
								<th></th>
								<th>商品</th>
								<th>单价</th>
								<th>数量</th>
								<th>订单金额</th>
								<th>订单状态</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody >
							<c:forEach var="order" items="${order }">
								<tr class="">
									<td align="left" colspan="8" class="order-table-tr1">
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;订单号:${order.orderId }
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<fmt:formatDate value="${order.created }" type="both" />
									</td>
								</tr>
								<c:forEach var="item" items="${order.itemList }" varStatus="status">
									<tr style="height: 100px">
										<td><a href="${pageContext.request.contextPath }/item/showItemDetail?id=${item.itemId}">
											<image class="shopcart-table-img" src="${pageContext.request.contextPath}/images/${item.image }"/>
										</a></td>
										<td><a class="itemTd" href="${pageContext.request.contextPath }/item/showItemDetail?id=${item.itemId}">${item.title }</a></td>
										<td>${item.price }</td>
										<td>${item.count }</td>
										<c:if test="${status.index == 0 }">
											<td rowspan="${fn:length(order.itemList) }">${order.payment }</td>
											<td rowspan="${fn:length(order.itemList) }">
												<c:if test="${order.status eq 1 and order.paymentType eq 1}">
													未付款
												</c:if>
												<c:if test="${order.status eq 1 and order.paymentType eq 2}">
													货到付款
												</c:if>
												<c:if test="${order.status eq 2}">
													已付款,待发货
												</c:if>
												<c:if test="${order.status eq 3}">
													待发货
												</c:if>
												<c:if test="${order.status eq 4}">
													已发货,待收货
												</c:if>
												<c:if test="${order.status eq 5}">
													交易成功,待结束
												</c:if>
												<c:if test="${order.status eq 6}">
													交易已完成
												</c:if>
												<c:if test="${order.status eq 7}">
													交易取消
												</c:if>
											</td>
											<td rowspan="${fn:length(order.itemList) }">
												<a class="itemTd" href="${pageContext.request.contextPath}/order/orderDetail?orderId=${order.orderId}">查看订单详情</a>
												<br/>
												<br/>
												<c:if test="${order.status eq 1 and order.paymentType eq 1}">
													<a id="goPay" class="layui-btn layui-btn-danger layui-btn-sm" href="${pageContext.request.contextPath}/order/orderPay?orderId=${order.orderId }">去付款</a>
												</c:if>
												<c:if test="${order.status eq 4}">
													<button id="orderAccept" class="layui-btn layui-btn-danger layui-btn-sm" onclick="accept('${order.orderId}')">确认收货</button	>
												</c:if>
											</td>
										</c:if>
									</tr>
								</c:forEach>
							</c:forEach>
						</tbody>
					</table>
					<div>
						
					</div>
				</div>
			</div>
		</c:if>
		<c:if test="${empty order }">
			<div id="noData">
				<blockquote style="background-color: white; height: 250px;" class="layui-elem-quote layui-quote-nm">
					<div style="text-align: center;margin-top: 100px;">
						数据为空!
					</div>
				</blockquote>
			</div>
		</c:if>
	</div>

<script type="text/javascript">

	function accept(orderId){
		if(orderId == ''){
			return;
		}
		$.ajax({
			url: "${pageContext.request.contextPath}/order/orderAccept"
			,data: {orderId: orderId}
			,type: "POST"
			,success: function(data){
				var msg = JSON.parse(data).msg;
				layer.confirm(msg, {
					closeBtn: 0
					,btnAlign: 'c'
					,btn: ['确定'] //按钮
				}
				, function(){
					window.location.reload();
				})
			}
		});
	}

</script>

<script>
	layui.use(['element','form','table'], function(){
		var element = layui.element;
		var form = layui.form;
		var table = layui.table;
		
		
		
	});
</script>
<script type="text/html" id="imgTpl">
	<img class="shopcart-table-img" src="${pageContext.request.contextPath}/images{{d.image}}" />
</script>
</body>
</html>