<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layui/css/layui.css">
<script src="${pageContext.request.contextPath}/css/layui/layui.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery/jquery-3.2.1.min.js"></script>
<title>添加商品</title>
<style>
	.layui-table-view .layui-table[lay-size=lg] .layui-table-cell {
	    height: 70px;
	    line-height: 70px;
	}
</style>
</head>
<body>
	<table class="layui-table" id="orderItemList" lay-filter="orderItemList"></table>
	<script>
		layui.use(['table'], function(){
			var table = layui.table;
		  	var orderId = '${orderId}';
			table.render({
				elem: '#orderItemList'
				,id: 'orderItemList'
				,size: 'lg'
				,url: '${pageContext.request.contextPath}/admin/order/orderDetail?orderId='+orderId //数据接口
				,cols: [[ //表头
				    {field: 'image', title: '', align: 'center', templet: '#imgTpl' }
					,{field: 'title', title: '商品名' }
					,{field: 'count', title: '数量' }
					,{field: 'price', title: '商品单价' } 
					,{field: 'subTotal', title: '小计' }
				]]
				,done: function(res, curr, count){

				}
			});
			
		});	      
	</script>
	
	<script type="text/html" id="imgTpl">
		<img class="shopcart-table-img" src="${pageContext.request.contextPath}/images{{d.image}}" />
	</script>
</body>
</html>