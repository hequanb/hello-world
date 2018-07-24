<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>订单管理</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layui/css/layui.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
	<script src="${pageContext.request.contextPath}/css/layui/layui.js"></script>
	<script src="${pageContext.request.contextPath}/js/jquery/jquery-3.2.1.min.js"></script>
	<style>
		#a-hover:hover{
			color: orange;
		}
		.shopcart-table-img{
			height:60px;
			width:60px;
		}
	</style>
</head>

<body> 
	<%@ include file="/WEB-INF/jsp/adminIndex.jsp" %>
	<div style="margin-bottom: 5px;"></div>
	<div class="demoTable" style="margin-left: 10px;">
		<form class="layui-form">
		<span class="layui-inline">订单编号：</span>
		<div class="layui-inline">
			<input class="layui-input" name="orderId" id="orderId" autocomplete="off">
		</div>
		
		<span class="layui-inline" style="margin-left: 20px">订单状态：</span>
		<div class="layui-inline">
			<select name="status" id="status" class="layui-input" lay-verify="status" lay-search>
				<option value="">全部</option>
				<option value="1">未付款(在线支付)</option>
				<option value="2">已付款(在线支付)</option>
				<option value="3">未发货(在线支付)</option>
				<option value="4">未发货(货到付款)</option>
				<option value="5">已发货</option>
				<option value="6">交易成功</option>
				<option value="7">完成的交易</option>
				<option value="8">取消的交易</option>
			</select>  
		</div>
		<button id="searchOID" class="layui-btn" data-type="searchOID" type="button">搜索</button>
		</form>
	</div>
	
	<table class="layui-table" id="orderList" lay-filter="orderList"></table>
 
	<script type="text/html" id="barDemo">
  		<a class="layui-btn layui-btn-xs" lay-event="editItem">编辑商品</a>
  		<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="deleteItem">删除商品</a>
	</script>
	
	<script type="text/html" id="statusDemo">
  		{{#
			if(d.status == 1 && d.paymentType == 2){
				return '<button id="consignBtn" lay-event="consignBtn" class="layui-btn layui-btn-warm layui-btn-xs">发货(货到付款)</button>'
			} else if(d.status == 1 && d.paymentType == 1){
				return '未付款'
			} else if(d.status == 2 && d.paymentType == 1) {
				return '<button lay-event="consignBtn" class="layui-btn layui-btn-warm layui-btn-xs">发货</button>'
			} else if(d.status == 3) {
				return '<button lay-event="consignBtn" class="layui-btn layui-btn-warm layui-btn-xs">发货</button>'
			} else if(d.status == 4) {
				return '已发货'
			} else if(d.status == 5) {
				return '<button lay-event="endBtn" class="layui-btn layui-btn-xs">完成交易</button>'
			} else if(d.status == 6) {
				return '交易关闭'
			} else {
				return '交易已被取消'
			} 
		}}
	</script>   
    
    <script type="text/html" id="paymentTypeDemo">
  		{{# if(d.paymentType == 1){ return '在线支付'} else if(d.paymentType == 2) {return '货到付款'} }}
	</script>
	
	<script type="text/html" id="detailDemo">
  		<a class="layui-btn layui-btn-xs" lay-event="orderDetail">订单详情</a>
	</script>
	  		    
	<script type="text/javascript">
	layui.use(['table','form'], function(){
		var table = layui.table;

		table.render({
			elem: '#orderList'
			,id: 'orderList'
			,page: true
			,url: '${pageContext.request.contextPath}/admin/order/getOrderList' //数据接口
			,limits: [5, 10, 20]
			,limit:5
			,cols: [[ //表头
				{type:'numbers', align:'center'}
				,{field: 'orderId', title: '订单编号' }
				,{field: 'payment', title: '总金额' }
				,{field: 'paymentType', title: '支付方式', templet: '#paymentTypeDemo' } 
				,{field: 'status', title: '订单状态', templet: '#statusDemo' }
				,{title:'订单详情', align: 'center', templet: '#detailDemo' }
			]]
			,done: function(res, curr, count){

			}
		});
	  	
		//监听工具条
		table.on('tool(orderList)', function(obj){
			var data = obj.data;
			if(obj.event === 'consignBtn'){
				$.post('${pageContext.request.contextPath}/admin/order/consign'
					,{"orderId": data.orderId}
					,function(data){
						var msg = JSON.parse(data).msg;
						layer.alert(msg);
						$(".layui-laypage-btn").click();
					}
				)
			}else if(obj.event === 'endBtn'){
				$.post('${pageContext.request.contextPath}/admin/order/end'
					,{"orderId": data.orderId}
					,function(data){
						var msg = JSON.parse(data).msg;
						layer.alert(msg);
						$(".layui-laypage-btn").click();
					}
				)
			}else if(obj.event === 'orderDetail'){
				layer.open({
					type: 2,
					title: '订单详情',
					shadeClose: true,
					shade: [0.6],
					maxmin: true, //开启最大化最小化按钮
					area: ['1080px', '600px'],
					content: '${pageContext.request.contextPath}/admin/order/toOrderDetail?orderId='+data.orderId
				});
			}
		});
		  
		var $ = layui.$, active = {
			searchOID: function(){
				var orderId = $('#orderId');
				var status = $('#status').val();
				var tempStatus = '';
				var tempPaymentType = '';

				if(status == 1){
					tempStatus = 1;
					tempPaymentType = 1;
				}else if(status == 2){
					tempStatus = 2;
					tempPaymentType = 1;
				}else if(status == 3){
					tempStatus = 2;
					tempPaymentType = 1;
				}else if(status == 4){
					tempStatus = 1;
					tempPaymentType = 2;
				}else if(status == 5){
					tempStatus = 4;
				}else if(status == 6){
					tempStatus = 5;
				}else if(status == 7){
					tempStatus = 6;
				}else if(status == 8){
					tempStatus = 7;
				}
				//执行重载
				table.reload('orderList', {
					page: {
						curr: 1 //重新从第 1 页开始
					}
					,where: {
						orderId: orderId.val()
						,status: tempStatus
						,paymentType: tempPaymentType
					}
				});
			}
		};
		$('.demoTable #searchOID').on('click', function(){
			var type = $(this).data('type');
			active[type] ? active[type].call(this) : '';
		});
		
	});
	
	</script>

<script type="text/javascript">

	function deleteItem(id){
		var code = 100;
		$.ajax({
			url: "${pageContext.request.contextPath}/item/deleteItem"
			,data: {'id' : id}
			,type: 'post'
			,async: false
			,success: function(result){
				var result = JSON.parse(result);
				layer.msg(result.msg);
				code = result.code;
			}
			,error : function(){
				console.log("error");
			}
		});
		return code;
	}
</script>

</body>
</html>