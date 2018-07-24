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
</head>

<body class="layui-layout-body">
	<%@ include file="/WEB-INF/jsp/adminIndex.jsp" %>
	<div class="layui-body admin-body">
		<form class="layui-form" action="" style="width: 500px;">
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
					<button type="button" class="layui-btn" onclick="getData()">搜索</button>
				</div>
			</div>
		</form>
			<table class="layui-table" style="width: 500px;">
			  <colgroup>
			    <col width="150">
			  </colgroup>
			  <thead>
			    <tr>
			      <th id="typeTitle">支付类型</th>
			      <th id="timeTitle" style="width: 150px"></th>
			    </tr> 
			  </thead>
			  <tbody>
			    <tr>
			      <td id="typeData"></td>
			      <td id="data"></td>
			    </tr>
			  </tbody>
			</table>		
	</div>
	<script>
	function getData(){
		var paymentType = $("select[name='paymentType']").val();
		var timeType = $("select[name='timeType']").val();
		$.ajax({
			url: '${pageContext.request.contextPath}/admin/benefit/getBenefit?paymentType='+paymentType+'&timeType='+timeType+'',
			success: function(data){
				if(paymentType == 0){
					$("td#typeData").text("全部");
				}else if(paymentType == 1){
					$("td#typeData").text("在线支付");
				}else{
					$("td#typeData").text("货到付款");
				}
				if(timeType == 1){
					$("th#timeTitle").text("一周内");
				}else if(timeType == 2){
					$("th#timeTitle").text("一月内");
				}else{
					$("th#timeTitle").text("三月内");
				}
				if(data == "null"){
					data = "无数据";
				}
				$("td#data").text(data);
			}
		});
	}
	
	layui.use(['form'], function(){
		var form = layui.form;
	
		$(function(){
			$.ajax({
				url: '${pageContext.request.contextPath}/admin/benefit/getBenefit?paymentType=0&timeType=1',
				success: function(data){
					if(data == "null"){
						data =  "无数据";
					}
					$("td#typeData").text("全部");
					$("th#timeTitle").text("一周内");
					$("td#data").text(data);
				}
			});
		});

	});
	</script> 
</body>
</html>