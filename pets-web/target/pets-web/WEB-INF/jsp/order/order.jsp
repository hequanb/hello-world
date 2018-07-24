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
		<div id="haveData" style="display: none;">
			<div class="head-title-div">
				<p class="head-title-p">核对订单信息</p>
			</div>
			<div class="order-address-body">
				<div style="background: #ffffff; height: 30px;"></div>
				<form class="layui-form" action="">
				<fieldset class="layui-elem-field margin-20">
					<legend>收货人信息</legend>
					<div class="layui-field-box">
						<div class="layui-form-item">
							<div class="layui-inline">
								<label class="layui-form-label">收件人姓名</label>
								<div class="layui-input-block">
									<input type="text" name="receiverName" required  lay-verify="required" placeholder="请输入收件人姓名.." autocomplete="off" class="layui-input">
								</div>
							</div>
							<div class="layui-inline">
								<label class="layui-form-label">联系电话</label>
								<div class="layui-input-block">
									<input type="text" name="receiverPhone" required  lay-verify="required|phone" placeholder="请输入联系电话.." autocomplete="off" class="layui-input">
								</div>
							</div>
							<div class="layui-inline">
								<label class="layui-form-label">邮政编码</label>
								<div class="layui-input-block">
									<input type="text" name="receiverZip" placeholder="请输入联系邮编.." autocomplete="off" class="layui-input">
								</div>
							</div>
						</div>
						<div class="layui-form-item layui-form-text">
							<label class="layui-form-label">收货地址</label>
							<div class="layui-input-inline">
								<textarea name="receiverAddress" lay-verify="required" style="width: 794px;" placeholder="请输入收货地址.." maxlength="200" class="layui-textarea"></textarea>
							</div>
							<div class="layui-form-mid layui-word-aux">* 最多输入200字</div>
						</div>
					</div>
				</fieldset>
				<fieldset class="layui-elem-field margin-20">
					<legend>支付方式</legend>
					<div class="layui-field-box">
						<div class="layui-form-item">
							<label class="layui-form-label">支付方式</label>
							<div class="layui-input-block">
								<input type="radio" name="paymentType" value="1" title="在线支付" checked>
								<input type="radio" name="paymentType" value="2" title="货到付款">
							</div>
						</div>
					</div>
				</fieldset>
				<fieldset class="layui-elem-field margin-20">
					<legend>商品清单 <span><a class="order-detail-a" href="${pageContext.request.contextPath }/shopcart/toMyShopcart">返回购物车修改</a></span></legend>
					<div class="layui-field-box">
						<table id="orderDetail" lay-filter="orderDetail"></table>
						<blockquote class="layui-elem-quote layui-quote-nm" style="background-color: white">
							<div class="layui-row">
								<div class="layui-col-md6">
									<div class="layui-form-item layui-form-text">
										<label class="layui-form-label">订单备注</label>
										<div class="layui-input-inline">
											<textarea id="buyerMessage" name="buyerMessage" style="width: 300px;" placeholder="请输入订单备注.." maxlength="100" class="layui-textarea"></textarea>
										</div>
										<div class="layui-form-mid layui-word-aux">* 最多输入100字</div>
									</div>
								</div>
								<div class= "layui-col-md3 layui-col-md-offset1">
									<div class="layui-row">已选择<span class="shopcart-span-totalcount" id="totalCount"></span>件商品，总价：<span class="shopcart-span-totalprice">¥</span><span class="shopcart-span-totalprice" id="totalPrice">2721.60</span></div>
								</div>
								<div class="layui-col-md2">
									<div>
										<button id="toOrder" class="layui-btn layui-btn-danger" lay-submit lay-filter="orderSubmit">提交订单</button>
									</div>
								</div>
							</div>
						</blockquote>
					</div>
				</fieldset>
				</form>
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
		
		var tableIns = table.render({
			elem: '#orderDetail'
			,url: '${pageContext.request.contextPath}/shopcart/getShopcartData' //数据接口 
			,skin: 'nob'
			,even: 'true'
			,method: 'get'
			,size: 'lg'
			,id: 'orderDetail'
			,cols: [[ //表头
				{field: 'sciId', title: '', align: 'center', style: 'display:none'}
				,{field: 'itemId', title: '', align: 'center', style: 'display:none'}
				,{field: 'image', title: '', align: 'center', templet: '#imgTpl', style: 'height:70px'}
				,{field: 'title', title: '商品名', align: 'center'}
				,{field: 'standard', title: '规格', align: 'center'}
				,{field: 'price', title: '单价(元)', align: 'center'} 
				,{field: 'count', title: '数量', align: 'center'}
				,{field: 'subTotal', title: '小计(元)', align: 'center'}
			]]
			,done: function(res, curr, count){
				//如果是异步请求数据方式，res即为你接口返回的信息。
				$("th[data-field=sciId]").css("display","none");
				$("th[data-field=itemId]").css("display","none");
				if(res.count == 0){
					$("div#noData").css('display','block');
					$("div#haveData").css('display','none');
				}else{
					var tds = $("td[data-field=count]");
					var priceTds = $("td[data-field=subTotal]");
					var totalCount = 0;
					var totalPrice = 0;
					$.each(tds, function(index,value){
						var count = parseInt($(value).text());
						totalCount += count;
					})
					$.each(priceTds, function(index,value){
						var subTotal = parseFloat($(value).text());
						totalPrice += subTotal;
					})
					$("th[data-field=sciId]").css("display","none");
					$("span#totalCount").text(totalCount);
					$("span#totalPrice").text(totalPrice.toFixed(2));
					$("div#noData").css('display','none');
					$("div#haveData").css('display','block');
				}
			}
		});
		
		form.on('submit(orderSubmit)',function(data){

			$.ajax({
				url: "${pageContext.request.contextPath}/order/addOrder"
				,data: JSON.stringify(data.field)
				,method: "POST"
				,contentType: "application/json"
				,dataType: "JSON"
				,success: function(result){
					console.log(result);
					if(result.code == 0){
						var orderId = result.data;
						//httpPost("${pageContext.request.contextPath}/order/orderPay", orderId);
						window.location.href = "${pageContext.request.contextPath}/order/orderPay?orderId="+orderId;
					}else if(result.code == 2){
						var orderId = result.data;
						//httpPost("${pageContext.request.contextPath}/order/orderPayInFace", orderId);
						window.location.href = "${pageContext.request.contextPath}/order/orderPayInFace?orderId="+ orderId;
					}else{
						layer.alert(result.msg);
					}
				}
			})
			
			return false;
		})
		
		function httpPost(URL, orderId) {
			var temp = document.createElement("form");
			temp.action = URL;
			temp.method = "post";
			temp.style.display = "none";
			var opt = document.createElement("input");
			opt.name = "orderId";
			opt.value = orderId;
			temp.appendChild(opt);
			document.body.appendChild(temp);
			temp.submit();
			return temp;
		}
		
	});
</script>
<script type="text/html" id="imgTpl">
	<img class="shopcart-table-img" src="${pageContext.request.contextPath}/images{{d.image}}" />
</script>
</body>
</html>