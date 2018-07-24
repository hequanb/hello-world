<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>管理商品菜单</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layui/css/layui.css">
<script src="${pageContext.request.contextPath}/css/layui/layui.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery/jquery-3.2.1.min.js"></script>
<%-- <script src="${pageContext.request.contextPath}/js/xTree/layui-xtree.js"></script> --%>
<style type="text/css">
	#tabs-content{
		width:700px;
		height:500px;
	}
</style>
</head>
<body class="layui-layout-body">
	<%@ include file="/WEB-INF/jsp/adminIndex.jsp" %>
	<div class="layui-body" style="margin-top: 100px;">
		<div class= "layui-inline">
			<form class="layui-form">  
				<div id="xtree1" style="width:400px;padding: 10px 0 25px 5px;"></div>  
			</form> 
		</div>
		
		<div class= "layui-inline">
			<div class="layui-tab layui-tab-card">
				<ul class="layui-tab-title">
					<li class="layui-this">编辑类目</li>
					<li>增加类目</li>
					<li>删除类目</li>
				</ul>
				<div class="layui-tab-content" id="tabs-content">
					<div class="layui-tab-item layui-show">
						<form class="layui-form" id= "editCatForm" lay-filter= "editCatForm">  
							<div class="layui-form-item">
								<label class="layui-form-label" for= "name">目录名:</label>
								<div class="layui-input-inline">
									<input id="name" name="name" placeholder="目录名.." lay-verify="required" class="layui-input" />
									<input type="hidden" name="id" class="layui-input" />
								</div>
								<div class="layui-form-mid layui-word-aux" id="editTips"></div>
							</div>
							<div class="layui-form-item">
								<label class="layui-form-label" for= "sortOrder">同级顺序:</label>
								<div class="layui-input-inline">
									<input id="sortOrder" name="sortOrder" placeholder="同级顺序.." lay-verify="required|order" class="layui-input" />
								</div>
							</div>
							<div class="layui-form-item">
							    <div class="layui-input-block">
							      <button class="layui-btn" lay-submit lay-filter="editCatFormSubmit">立即提交</button>
							      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
							    </div>
					  		</div>
						</form> 
					</div>
					<div class="layui-tab-item">
						<form class="layui-form" id= "addCatForm" lay-filter= "addCatForm">
							<div class="layui-form-item">
								<label class="layui-form-label" for= "addName">目录名:</label>
								<div class="layui-input-inline">
									<input id="addName" name="name" placeholder="目录名.." lay-verify="required" class="layui-input" />
									<input type="hidden" name="id" class="layui-input" />
									<input type= "hidden" id="isParent" name="isParent"  lay-verify="required" class="layui-input" />
								</div>
								<div class="layui-form-mid layui-word-aux" id= "addTips"></div>
							</div>
							<div class="layui-form-item">
								<label class="layui-form-label" for= "sortOrder">同级顺序:</label>
								<div class="layui-input-inline">
									<input id="addSortOrder" name="sortOrder" placeholder="同级顺序.." lay-verify="required|order" class="layui-input" />
								</div>
							</div>
							<div class="layui-form-item">
							    <div class="layui-input-block">
							      <button class="layui-btn" lay-submit lay-filter="addCatFormSubmit">立即提交</button>
							      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
							    </div>
					  		</div>
						</form> 
					</div>
					<!-- 删除商品 -->
					<div class="layui-tab-item">
						<form class="layui-form" id= "deleteCatForm" lay-filter= "deleteCatForm">
							<div class="layui-form-item">
								<label class="layui-form-label" for= "delName">目录名:</label>
								<div class="layui-input-inline">
									<input id="delName" name="name" placeholder="要删除的目录名.." lay-verify="required" class="layui-input" />
									<input type="hidden" name="id" class="layui-input" />
									<input type="hidden" name="parentId" class="layui-input" />
									<input type= "hidden" id="isParent" name="isParent"  lay-verify="required" class="layui-input" />
								</div>
								<div class="layui-form-mid layui-word-aux" id= "delTips">温馨提示:父目录不能删除哦!</div>
							</div>
							<div class="layui-form-item">
							    <div class="layui-input-block">
							      <button class="layui-btn" lay-submit lay-filter="delCatFormSubmit">立即删除</button>
							      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
							    </div>
					  		</div>
						</form> 					
					</div>
				</div>
			</div>
		</div>
	</div>
</body>

<script type="text/javascript">

	function refreshTree(){
		$("#xtree1").html("");
		$.ajax({
			url: "${pageContext.request.contextPath}/itemCat/getAllCategories"
			,data: {'parentId' : 0}
			,success: function(data){
				layui.tree({
					elem: '#xtree1' 
					,nodes: JSON.parse(data)
					,click: function(data){
				    	$("input#name").val(data.name);
				    	$("input#delName").val(data.name);
				    	$("input[name=id]").val(data.id);
				    	$("input[name=parentId]").val(data.parentId);
				    	$("input#sortOrder").val(data.sortOrder);
				    	$("input[name=isParent]").val(data.isParent);
				    	$("#editTips").html("当前操作对象为:<span style=\"color:red\"> "+data.name+" </span>");
				    	$("#addTips").html("在<span style=\"color:red\"> "+data.name+" </span>下插入一个子类目")
					}
				});
			}
			,error: function(){
				console.log("error");
			}
		});
	}

</script>

<script type="text/javascript">

	layui.use(['form','element','tree'],function(){
		var form = layui.form;
		var element = layui.element;
		var tree = layui.tree;
		
		$(function(){
			refreshTree();
		});
		
		//监听提交
		form.on('submit(editCatFormSubmit)', function(data){
			var id = data.field.id;
			if(id == ""){
				layer.msg("还未选择任何菜单结点!");
				return false;
			}
			console.log(data.field);
			$.ajax({
				url : "${pageContext.request.contextPath}/itemCat/editItemCat"
				,data : JSON.stringify(data.field)
				,type : 'POST'
				,contentType : 'application/json'
				,success : function(result){
					var msg = JSON.parse(result).msg;
					var code = JSON.parse(result).code;
					console.log(code);
					layer.msg(msg)
					if(code == 0){
						refreshTree();
						$("#editCatForm")[0].reset();
						$("#editTips").text("");
					}
				}
				,error : function(){
					console.log("error");
				}
			});
			return false;
		});
		
		form.on('submit(addCatFormSubmit)', function(data){
			var id = data.field.id;
			if(id == ""){
				layer.msg("还未选择任何菜单结点!");
				return false;
			}
			console.log(data.field);
			$.ajax({
				url : "${pageContext.request.contextPath}/itemCat/addItemCat"
				,data : JSON.stringify(data.field)
				,type : 'POST'
				,contentType : 'application/json'
				,success : function(result){
					var msg = JSON.parse(result).msg;
					var code = JSON.parse(result).code;
					layer.msg(msg)
					if(code == 0){
						refreshTree();
						$("#addCatForm")[0].reset();
						$("#addTips").text("");
					}
				}
				,error : function(){
					console.log("error");
				}
			});
			return false;
		});
		
		form.on('submit(delCatFormSubmit)', function(data){
			var id = data.field.id;
			var isParent = data.field.isParent;
			console.log(data.field);
			if(id == ""){
				layer.msg("还未选择任何菜单结点!");
				return false;
			}
			if(isParent == 'true'){
				layer.alert("父目录不允许删除!");
				return false;
			}
			$.ajax({
				url : "${pageContext.request.contextPath}/itemCat/deleteItemCat"
				,data : JSON.stringify(data.field)
				,type : 'POST'
				,contentType : 'application/json'
				,success : function(result){
					var msg = JSON.parse(result).msg;
					var code = JSON.parse(result).code;
					layer.msg(msg)
					if(code == 0){
						refreshTree();
						$("#deleteCatForm")[0].reset();
					}
				}
				,error : function(){
					console.log("error");
				}
			});
			return false;
		});
		
		form.verify({
			order: function(value, item){ //value：表单的值、item：表单的DOM对象
				if(value > 9){
				  return '同级顺序最大值为9';
				}
				if(value<0){
					return '同级顺序最小值为0!';
				}
			}
		}); 
		
	});

</script>

</html>