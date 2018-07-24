<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
	.laytable-cell-1-title:hover{
		color: red;
	}
</style>
</head>
<body style="overflow-y: auto; background-color: #f1ecec;">

	<%@ include file="/WEB-INF/jsp/headBar.jsp" %>

	<div style="margin: 25px 50px;">
		<c:if test="${not empty order }">
			<div id="haveData" style="">
				<div class="head-title-div">
					<p class="head-title-p">订单详情</p>
				</div>
				<div class="order-address-body">
					<div style="background: #ffffff; height: 30px;"></div>
					<fieldset class="layui-elem-field margin-20">
						<legend>订单状态</legend>
						<div class="layui-field-box">
							<div class="layui-form-item">
								<div class="layui-inline">
									<label class="layui-form-label">订单状态</label>
									<div class="layui-input-block">
										<div class="order-detail-content-text" style="color:orange">
										<c:if test="${not empty order }">
											<c:choose>
												<c:when test="${order.status eq 7 }">
													交易取消
												</c:when>
												<c:when test="${order.status eq 1 }">
													未付款
												</c:when>
												<c:when test="${order.status eq 2 || order.status eq 3 }">
													未发货
												</c:when>
												<c:when test="${order.status eq 4 }">
													已发货
												</c:when>
												<c:when test="${order.status eq 5 }">
													交易成功
												</c:when>
												<c:when test="${order.status eq 6 }">
													交易关闭
												</c:when>
											</c:choose>
											</c:if>
										</div>
									</div>
								</div>
								<div class="layui-inline">
									<label class="layui-form-label">支付方式</label>
									<div class="layui-input-block">
										<div class="order-detail-content-text">
											<c:choose>
												<c:when test="${order.paymentType eq 1}">
													在线支付
												</c:when>
												<c:when test="${order.paymentType eq 2}">
													货到付款
												</c:when>
											</c:choose>
										</div>
									</div>
								</div>
							</div>
							<div class="layui-form-item">
								<div class="layui-inline">
									<label class="layui-form-label">订单编号</label>
									<div class="layui-input-block">
										<div class="order-detail-content-text">
											${order.orderId }
										</div>
									</div>
								</div>
							</div>
						</div>
					</fieldset>
					<fieldset class="layui-elem-field margin-20">
						<legend>收货信息</legend>
						<div class="layui-field-box">
							<div class="layui-form-item">
								<label class="layui-form-label">发件人</label>
								<div class="layui-input-block">
									<div class="order-detail-content-text">
										${order.buyerNick }
									</div>
								</div>
							</div>
							<div class="layui-form-item">
								<label class="layui-form-label">收货人</label>
								<div class="layui-input-block">
									<div class="order-detail-content-text">
										${order.receiverName }
									</div>
								</div>
							</div>
							<div class="layui-form-item">
								<label class="layui-form-label">收货地址</label>
								<div class="layui-input-block">
									<div class="order-detail-content-text">
										${order.receiverAddress }
									</div>
								</div>
							</div>
							<div class="layui-form-item">
								<label class="layui-form-label">联系电话</label>
								<div class="layui-input-block">
									<div class="order-detail-content-text">
										${order.receiverPhone }
									</div>
								</div>
							</div>
						</div>
					</fieldset>
					<fieldset class="layui-elem-field margin-20">
						<legend>商品清单</legend>
						<div class="layui-field-box">
							<table id="orderDetail" lay-filter="orderDetail"></table>
							<blockquote class="layui-elem-quote layui-quote-nm" style="background-color: white">
								<div class="layui-row">
									<div class="layui-col-md6">
										<div class="layui-form-item layui-form-text">
											<label class="layui-form-label">订单备注</label>
											<div class="layui-input-inline">
												<div class="order-detail-content-text">
													${not empty order.buyerMessage ? order.buyerMessage : '无'}
												</div>
											</div>
										</div>
									</div>
									<div class= "layui-col-md3 layui-col-md-offset1">
										总价：<span class="shopcart-span-totalprice">¥</span><span class="shopcart-span-totalprice" id="totalPrice">${order.payment }</span>
									</div>
								</div>
							</blockquote>
						</div>
					</fieldset>
				</div>
			</div>
		</c:if>
		<c:if test="${empty order }">
			<div id="noData" style="">
				<blockquote style="background-color: white; height: 250px;" class="layui-elem-quote layui-quote-nm">
					<div style="text-align: center;margin-top: 100px;">
						${data.msg }
					</div>
				</blockquote>
			</div>
		</c:if>
	</div>

<script>
	layui.use(['element','form','table'], function(){
		var element = layui.element;
		var form = layui.form;
		var table = layui.table;
		
		var data = JSON.parse('${data.msg}');
		
		var tableIns = table.render({
			elem: '#orderDetail'
			,data: data
			,skin: 'nob'
			,even: 'true'
			,method: 'get'
			,size: 'lg'
			,id: 'orderDetail'
			,cols: [[ //表头
				{field: 'itemId', title: '', align: 'center', style: 'display:none'}
				,{field: 'image', title: '', align: 'center', templet: '#imgTpl', style: 'height:70px'}
				,{field: 'title', title: '商品名', style:'cursor: pointer', align: 'center', event: 'showItem'}
				,{field: 'price', title: '单价(元)', align: 'center'} 
				,{field: 'count', title: '数量', align: 'center'}
				,{field: 'subTotal', title: '小计(元)', align: 'center'}
			]]
			,done: function(){
				$("th[data-field=itemId]").css("display","none");
			}
		});
		
		table.on('tool(orderDetail)', function(obj){
			var data = obj.data;
			if(obj.event === 'showItem'){
				window.location.href = '${pageContext.request.contextPath }/item/showItemDetail?id='+data.itemId;
			}
		});
		
	});
</script>
<script type="text/html" id="imgTpl">
	<img class="shopcart-table-img" src="${pageContext.request.contextPath}/images{{d.image}}" />
</script>
</body>
</html>