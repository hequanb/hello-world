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
</style>
</head>
<body style="overflow-y: auto; background-color: #f1ecec;">

	<%@ include file="/WEB-INF/jsp/headBar.jsp" %>

	<div style="margin: 25px 50px;">
	<c:if test="${code eq 0 }">
		<div id="haveData" style="">
			<div class="head-title-div">
				<p class="head-title-p">在线支付</p>
			</div>
			<div class="order-address-body">
				<div style="background: #ffffff; height: 60px; border-bottom: 2px solid #ddd;">
					<p class="order-pay-p">订单提交成功，请您尽快付款！</p>
					<p class="order-pay-p2">
						<span>应付总金额:
							<strong>¥${order.payment }</strong>
						</span>
					</p>
				</div>
				<div style="height:300px">
				<form class="layui-form" action="${pageContext.request.contextPath }order/pay">
				<fieldset class="layui-elem-field margin-20">
					<legend>选择支付平台</legend>
					<div class="layui-field-box">
						<div class="layui-form-item">
							<label class="layui-form-label">单选框</label>
							<div class="layui-input-block">
								<input type="radio" name="platform" value="1" title="支付宝">
								<input type="radio" name="platform" value="2" title="微信" checked>
							</div>
						</div>
					</div>
				</fieldset>
				<button lay-filter="paySubmit" lay-submit class="layui-btn layui-btn-danger" style="text-align: center; margin-left: 40%; width: 101px;">支付</button>
				</form>
				</div>
			</div>
		</div>
	</c:if>
	<c:if test="${code eq 100 }">
		<div id="noData" style="">
			<blockquote style="background-color: white; height: 250px;" class="layui-elem-quote layui-quote-nm">
				<div style="text-align: center;margin-top: 100px;">
					${msg }
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
		
		form.on('submit(paySubmit)', function(data){
			
			var orderId = '${order.orderId}'
			var pf = $("input[name=platform]:checked").val();
			
			$.post('${pageContext.request.contextPath}/order/pay'
				,{'orderId' : orderId, 'platform' : pf}	
				,function(result){
					var msg = JSON.parse(result).msg;
					layer.confirm(msg, {
						closeBtn: 0
						,btnAlign: 'c'
						,btn: ['前往购物'] //按钮
					}
					, function(){
						window.location.href = "${pageContext.request.contextPath}/"
					})
				}
			)

			return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
		});
		
	});
</script>

</body>
</html>