<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> -->
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
<body style="overflow-y: auto; background-color: #ffffff;">

	<%@ include file="/WEB-INF/jsp/headBar.jsp" %>

	<div style="margin: 25px 50px;">
		<div id="haveData" style="">
			
			<div class="layui-tab" lay-filter="demo">
				<ul class="layui-tab-title">
					<li class="layui-this">全部</li>
					<li>狗狗</li>
					<li>猫猫</li>
					<li>其他</li>
				</ul>
			</div>
			
			<div>
				<div class="up-23 down-30">
					<h2 class="baike-detail-h2">${baike.name }</h2>
				</div>
			</div>
			
			<div style="border: 1px solid #ddd;">
				<div style="background: #efefef; border-bottom: 1px solid #ddd; padding: 20px 30px;position: relative;">
					<dl class="baike-detail-dl">
						<dt style="font: 24px/24px 'Microsoft YaHei' ;padding-bottom: 5px;">基本信息栏</dt>
						<dd><span>性格 : </span><em>${baike.temp }</em></dd>
						<dd><span>祖籍 : </span><em>${baike.original }</em></dd>
						<dd><span>易患病 : </span><em>${baike.illness }</em></dd>
						<dd><span>寿命 : </span><em>${baike.lifetime }</em></dd>
						<dd><span>价格 : </span><em>${baike.price }</em></dd>
					</dl>
				</div>
				<div style="padding: 0 50px 30px;">
					<div class="baike-detail-art">
						<div style="padding: 25px 0 10px; overflow: hidden;">
							<span style="height: 22px;" class="layui-badge layui-bg-green layui-inline">1</span>
							<h2 class="layui-inline" style="font: 24px/24px 'Microsoft YaHei';">${baike.name }品种简介</h2>
						</div>
						<div>
							<p style="text-align: center;">
								<img class="baike-detai-img" title="${baike.name }" src="${pageContext.request.contextPath }/images/${baike.image }"/>
							</p>
						</div>
						<p class="baike-detail-p" style="text-indent: 28px;">
							${baike.typeArticle }
						</p>
					</div>
					<div class="baike-detail-art">
						<div style="padding: 25px 0 10px; overflow: hidden;">
							<span style="height: 22px;" class="layui-badge layui-bg-green layui-inline">2</span>
							<h2 class="layui-inline" style="font: 24px/24px 'Microsoft YaHei';">${baike.name }性格特点</h2>
						</div>
						<p class="baike-detail-p" style="text-indent: 28px;">
							${baike.tempArticle }
						</p>
					</div>
				</div>
				
			</div>
			
		</div>
	</div>

<script>
	layui.use(['element','form','table'], function(){
		var element = layui.element;
		var form = layui.form;
		var table = layui.table;
		
		//一些事件监听
		element.on('tab(demo)', function(data){
			console.log(data.index);
			if(data.index == 1){
				window.location.href = "${pageContext.request.contextPath}/baike/allDog"
			}
		});
		
	});
	
</script>

<script type="text/html" id="barDemo">
	<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>

<script type="text/html" id="imgTpl">
	<img class="shopcart-table-img" src="${pageContext.request.contextPath}/images{{d.image}}" />
</script>

</body>
</html>