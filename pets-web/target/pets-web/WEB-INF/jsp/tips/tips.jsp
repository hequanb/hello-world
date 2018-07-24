<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layui/css/layui.css">
<script src="${pageContext.request.contextPath}/css/layui/layui.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery/jquery-3.2.1.min.js"></script>
<title>提示页</title>
<style>
	.tips-image{
		width: 400px; 
		height: 400px; 
		margin: 0 10px 10px 0;
		margin-top: 120px;
	}
	.tick{
		margin-top: 240px;
		width: 50px;
	}
	.tips-p{
		color:red;
		margin-top: 240px;
		font-size: 20px;
		font-weight: bold;
	}
</style>
</head>
<body class="layui-layout-body">
	<div class="layui-body">
		<div class="layui-container">
			<div class="layui-row">
				<div class="layui-col-md4">
					<img class="tips-image" alt="" src="${pageContext.request.contextPath }/images/data/tips.png">
				</div>
				<div class="layui-col-md5">
					<div class="layui-row">
						<div class="layui-inline">
							<p class= "tips-p">${result.msg }</p>
						</div>
						<div class="layui-inline">
							<img id="tick" class="tick" alt="" >
						</div>
					</div>
					<div class="layui-row"></div>
					<div class="layui-row">
						<div class="layui-block">
							<button id="index" class="layui-btn layui-btn-normal layui-btn-sm">首页</button>
							<button id="login" class="layui-btn layui-btn-normal layui-btn-sm">登录</button>
							<button id="regist" class="layui-btn layui-btn-normal layui-btn-sm">注册</button>
						</div>
					</div>
				</div>
				
			</div>
		</div>
		
	</div>
	<script>
		$(function(){
			var code = '${result.code}';
			code == 0 ? $("img#tick").attr("src","${pageContext.request.contextPath}/images/data/tick.jpg")
					  : $("img#tick").attr("src","${pageContext.request.contextPath}/images/data/error.jpg")
		
			$("button#index").click(function(){
				window.location.href="${pageContext.request.contextPath}";
			});
			$("button#login").click(function(){
				console.log(1);
				window.location.href="${pageContext.request.contextPath}/user/toLoginAndRegist?hash=login";
			});
			$("button#regist").click(function(){
				window.location.href="${pageContext.request.contextPath}/user/toLoginAndRegist?hash=regist";
			});
		})
	</script> 
</body>
</html>