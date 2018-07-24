<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	th.order-pay-face-th{
		border: 1px solid #CCC;
	    text-align: center;
	    padding: 15px 0;
	    font-weight: bold;
	}
	td.order-pay-face-td{
		border: 1px solid #CCC;
	    text-align: center;
	    padding: 15px 0;
	}
</style>
</head>
<body style="overflow-y: auto; background-color: #f1ecec;">

	<%@ include file="/WEB-INF/jsp/headBar.jsp" %>

	<div style="margin: 25px 50px;">
		<div id="haveData" style="">
			<div class="head-title-div">
				<p class="head-title-p">${status eq 7 ? '订单取消' : '订单提交成功' }</p>
			</div>
			<div class="order-address-body">
				<div style="background: #ffffff; height: 30px;"></div>
				<div class="order-pay-face-div">
					<p class="order-pay-face-p">
						${status eq 7 ? '您的订单已经取消，感谢您的光临!' : '您的订单已提交成功,我们将尽快为你安排发货!' }
					</p>
					<table class="layui-table">
					  <colgroup>
					    <col width="340">
					    <col width="340">
					    <col>
					  </colgroup>
					  <thead>
					    <tr>
					      <th class="order-pay-face-th">订单号</th>
					      <th class="order-pay-face-th">应付金额</th>
					      <th class="order-pay-face-th">支付方式</th>
					    </tr> 
					  </thead>
					  <tbody>
					    <tr>
					      <td class="order-pay-face-td">${orderId }</td>
					      <td class="order-pay-face-td">${payment }</td>
					      <td class="order-pay-face-td">${paymentType eq 1 ? '在线支付' : '货到付款' }</td>
					    </tr>
					  </tbody>
					</table>
					<div style="margin-top:10px;">
						<button id="orderDetail" class="layui-btn layui-btn-danger layui-btn-sm" style="margin-left: 400px;margin-top: 30px;">查看订单详情</button>
					</div>
				</div>
				<div style="background: #ffffff; height: 30px;"></div>
			</div>
		</div>
		<div id="noData" style="display: none;">
			<blockquote style="background-color: white; height: 250px;" class="layui-elem-quote layui-quote-nm">
				<div style="text-align: center;margin-top: 100px;">
					数据为空!
				</div>
			</blockquote>
		</div>
	</div>

<script>
	layui.use(['element','form','table'], function(){
		var element = layui.element;
		var form = layui.form;
		var table = layui.table;
		
		$("button#orderDetail").click(function(){
			var orderId = '${orderId}';
			window.location.href = '${pageContext.request.contextPath}/order/orderDetail?orderId=' + orderId;
		});
		
	});
</script>

</body>
</html>