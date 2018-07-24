<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layui/css/layui.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
<script src="${pageContext.request.contextPath}/css/layui/layui.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery/jquery-3.2.1.min.js"></script>
<title>查看营业额</title>
<style>
	.layui-table-view .layui-table[lay-size=lg] .layui-table-cell {
	    height: 70px;
	    line-height: 70px;
	}
</style>
</head>

<body style="overflow-y: auto;">
	<%@ include file="/WEB-INF/jsp/adminIndex.jsp" %>
		<form class="layui-form" action="" style="width: 500px; margin-top: 40px">
			<div class="layui-form-item">
				<label class="layui-form-label">付款类型</label>
				<div class="layui-input-block">
					<select name="paymentType" class="layui-input">
					  <option value="0">全部</option>
					  <option value="1">在线支付</option>
					  <option value="2">货到付款</option>
					</select>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">商品名</label>
				<div class="layui-input-block">
					<select name="itemId" class="layui-input">
					  <option value="">请选择商品</option>
					</select>
				</div>
			</div>
			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">时间范围</label>
					<div class="layui-input-inline">
						<select name="timeType" class="layui-input">
						  <option value="1">一周内</option>
						  <option value="2">一月内</option>
						  <option value="3">三月内</option>
						</select>
					</div>
				</div>
				<div class="layui-inline">
					<button type="button" class="layui-btn" id="getData" data-type="getData">搜索</button>
				</div>
			</div>
		</form>
		<table id="detail" lay-filter="detail"></table>
		<script>
		$(function(){
			$.ajax({
				url: '${pageContext.request.contextPath}/item/getItemListNew'
				,success: function(result){
					var data = JSON.parse(result);
					var html = '';
					$.each(data,function(index, item){
						html += "<option value="+item.id+">"+item.title+"</option>";
					});
					$("select[name=itemId]").append(html);
				}
			})
		})
		
		layui.use(['form','table'], function(){
			var form = layui.form;
			var table = layui.table;
			
			table.render({
				elem: '#detail'
				,id: 'detail'
				,url: '${pageContext.request.contextPath}/admin/benefit/getDetailBenefit' //数据接口 
				,skin: 'nob'
				,even: 'true'
				,method: 'get'
				,size: 'lg'
				,where: {
					paymentType: '0'
					,timeType: '1'
				}
				,cols: [[ //表头
					{field: 'image', title: '', align: 'center', templet: '#imgTpl', style: 'height:70px', width:300}
					,{field: 'title', title: '商品名', align: 'center', width:400}
					,{field: 'price', title: '单价(元)', align: 'center', width:240} 
					,{field: 'count', title: '售出数量', align: 'center', width:250}
					,{field: 'subTotal', title: '小计(元)', align: 'center', width:300}
				]]
				,done: function(res, curr, count){
					
				}
			});
		
			 var $ = layui.$, active = {
				getData: function(){
					var paymentType = $("select[name=paymentType]").val();
					var timeType = $("select[name=timeType]").val();
					var itemId = $("select[name=itemId]").val();
					console.log(paymentType);
					console.log(timeType);
					console.log(itemId);
				
					//执行重载
					table.reload('detail', {
						where: {	
							paymentType: paymentType
							,timeType: timeType
							,itemId: itemId
						}
					});
				}
			};
	
			$('button#getData').on('click', function(){
			  var type = $(this).data('type');
			  active[type] ? active[type].call(this) : '';
			});
			
		});
		</script> 
	
	<script type="text/html" id="imgTpl">
		<img class="shopcart-table-img" src="${pageContext.request.contextPath}/images{{d.image}}" />
	</script>
</body>
</html>