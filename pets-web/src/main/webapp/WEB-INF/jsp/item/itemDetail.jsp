<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Pets</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layui/css/layui.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/css/bootstrap.min.css">--%>
<script src="${pageContext.request.contextPath}/css/layui/layui.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery/jquery-3.2.1.min.js"></script>
<style type="text/css">

	.side-nav{
		width: 100%;
    	height: 500px;
    	background-color: #f2f2f2;
    }

</style>
</head>
<body class="layui-layout-body" style="overflow-y: auto">
<div class="layui-layout layui-layout-admin">

	<%@ include file="/WEB-INF/jsp/headBar.jsp" %>
	
	<div class="layui-container">
		<div class="layui-row up-70 layui-col-space30">
			<div class="layui-col-md4">
				<div class="itemdetail-img-div">
					<img class="itemdetail-img" alt="${item.title }" title="${item.title }" src="${pageContext.request.contextPath }/images${item.image }"/>
				</div>
			</div>
			<div class="layui-col-md7 layui-col-md-offset1">
				<form action="" class="layui-form" method="post">
					<input name="id" id="id" type="hidden" value="${item.id }"/>
					<h2 class="itemdetail-title">${item.title }</h2>
					<blockquote class="layui-elem-quote layui-quote-nm updown-35" style="height: 305px;">
						<dl class="down-10">
							<dt class="itemdetail-param-title">规格:</dt>
							<dd class="itemdetail-standard-value">${item.standard }</dd>
						</dl>
						<dl class="down-10">
							<dt class="itemdetail-param-title">价格:</dt>
							<dd class="itemdetail-price-value"><span class="itemdetail-param-em">¥</span>${item.price }</dd>
						</dl>
						<c:choose>
							<c:when test="${item.num eq 0 }">
								<dl class="down-10">
									<dt class="itemdetail-param-title">剩余数量(件):</dt>
									<dd class="itemdetail-standard-value">无剩余库存</dd>
								</dl>
							</c:when>
							<c:otherwise>
								<dl class="down-10">
									<dt class="itemdetail-param-title">剩余数量(件):</dt>
									<dd class="itemdetail-standard-value">${item.num }</dd>
								</dl>
								<div class="layui-row">
									<div class="layui-col-md2">
										<dl class="down-10">
											<dt class="itemdetail-param-title" style="margin-top: 8px;">数量:</dt>
										</dl>
									</div>
									<div class="layui-col-md3">
										<input type="number" name="count" max="${item.num }" placeholder="最多购买10件" lay-verify="numberVal|number" autocomplete="off" class="layui-input"> 
									</div>
								</div>
								<div class="layui-row itemdetail-btn-position">
									<div class="layui-col-md2 layui-col-md-offset1">
										<button id="buyNow" class="layui-btn layui-btn-danger itemdetail-btn-word" lay-submit lay-filter="buyNow">立即购买</button>
									</div>
									<div class="layui-col-md3 layui-col-md-offset1">
										<button class="layui-btn layui-btn-primary itemdetail-btn-buycart-word" lay-submit lay-filter="addToShopcart">加入购物车</button>
									</div>
								</div>
							</c:otherwise>
						</c:choose>
					</blockquote>
				</form>
			</div>
		</div>
		<div class="layui-row">
			<fieldset class="layui-elem-field">
				<legend>产品信息</legend>
				<div class="layui-field-box">
					<p class="itemdetail-product-info-text">${item.title }</p>
					<div class="itemdetail-product-info">
						<p class="itemdetail-product-p">
							<span class="itemdetail-product-title">所属品牌:</span>
							<span class="itemdetail-product-value">${item.brand }</span>
						</p>
						<p class="itemdetail-product-p">
							<span class="itemdetail-product-title">产品规格:</span>
							<span class="itemdetail-product-value">${item.standard }</span>
						</p>
						<p class="itemdetail-product-p">
							<span class="itemdetail-product-title">适用对象:</span>
							<span class="itemdetail-product-value">${item.target }</span>
						</p>
					</div>
					<p class="itemdetail-product-sellPoint">${item.sellPoint }</p>
				</div>
			</fieldset>
		</div>
	</div>
	
	
	
</div>

<script>
	layui.use(['element','form'], function(){
		var element = layui.element;
		var form = layui.form;
		var num = '${item.num}';
		
		form.verify({
			numberVal: function(value, item){ //value：表单的值、item：表单的DOM对象
				if(value == '' || value == 0){
					return '请输入购买数量';
				}
				if(value > 10){
					return '最多购买10件';
				}
				if(value < 0){
					return '请输入正确的购买数量';
				}
				if(value > num){
					return '库存不够';
				}
			}
		}); 
		
		form.on('submit(buyNow)',function(data){
			if(data.field.number == 0 || data.field.number == ''){
				layer.alert("请输入购买数量.");
				return false;
			}
			$.ajax({
				url: '${pageContext.request.contextPath}/shopcart/buyNow'
				,data: data.field
				,type: 'POST'
				,success: function(data){
					var result = JSON.parse(data);
					if(result.code > 0){
						layer.alert(result.msg);
					}else{
						window.location.href = '${pageContext.request.contextPath }/shopcart/toMyShopcart';
					}
				}
				,error: function(){
					console.log("error")
				}
			});
			return false;
		});
		
		form.on('submit(addToShopcart)',function(data){
			console.log(data.field);
			console.log(JSON.stringify(data.field));
			$.ajax({
				url: '${pageContext.request.contextPath}/shopcart/buyNow'
				,data: data.field
				,type: 'POST'
				,success: function(data){
					var result = JSON.parse(data);
					layer.alert(result.msg);
				}
				,error: function(){
					console.log("error")
				}
			});
			return false;
		});
		
	});
	
	
	/* $("button#buyNow").click(function(){
		$.ajax({
			url: '${pageContext.request.contextPath}/shopcart/buyNow'
			,contextType: 'application/json'
			,success: function(data){
				console.log(data);
			}
			,error: function(){
				console.log("error")
			}
		});
	}); */
	
</script>

</body>
</html>