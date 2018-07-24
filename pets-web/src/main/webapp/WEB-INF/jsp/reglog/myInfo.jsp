<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layui/css/layui.css">
<script src="${pageContext.request.contextPath}/css/layui/layui.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery/jquery-3.2.1.min.js"></script>
<style type="text/css">
	body{
		background:url("${pageContext.request.contextPath }/images/data/login_02.jpg") no-repeat;
  		background-size: 100%;
	}
	.login.back{
		background-color:white;
	}
	.login-main-div {
	    width: 400px;
	    position: absolute;
	    top: 200px;
	    left: 50px;
	    margin: 14px;
	    padding: 25px;
	    padding-top: 10px;
	    background-color: white;
	    border-radius: 5px;
	}
	.a-findpsw{
	    color: #3da8f5;
	   	vertical-align: middle;
    	line-height: 39px;
	}
	.checkbox-rempsw{
		width: 119px;
   		margin-left: 66px;
	}
	.ul-title{
		text-align:center;
	}
	li.li-child{
		width:42%;
		font-size: 20px;
	}
	.checkCode{
		width:60px;
		height:38px;
		cursor:pointer;
	}
	.icon-isNeed{
		color:red;
	}
</style>
<title>Pets</title>
</head>
<body class="layui-layout-body" style = "overflow-y: auto;">
	<%@ include file="/WEB-INF/jsp/headBar.jsp" %>
	<div class= "login-main-div">
		<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
			<ul class="layui-tab-title ul-title">
				<li class="li-child" lay-id="login">个人信息</li>
			</ul>
			
			<div class="layui-tab-content">
				<div class="layui-tab-item layui-show">
					<c:if test="${code eq 0 }">
					<form class="layui-form" lay-filter= "editForm" method="post">
						<div class="layui-form-item">
							<label class="layui-form-label">账号</label>
							<div class="layui-input-block">
						    	<input type="text" class="layui-input layui-disabled" name="username" id="username" value="${user.username }" autocomplete="off" class="layui-input" disabled>
						   	</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">昵称</label>
							<div class="layui-input-block">
								<input type="text" name="nickName" id="nickName" value="${user.nickName }" lay-verify="required" placeholder="请输入昵称.." autocomplete="off" class="layui-input">
							</div>
						</div>
						<div class="layui-form-item">
							<div class="layui-input-block">
								<button class="layui-btn" lay-submit lay-filter="editFormSubmit">立即提交</button>
							</div>
						</div>
					</form>
					</c:if>
					<c:if test="${code eq 100 }">
						${msg }
					</c:if>
				</div>
			</div>
			
		</div>  
	</div>
</body>

<script type="text/javascript">
	layui.use(['form','element'],function(){
		var form = layui.form;
		var element = layui.element;

		form.on('submit(editFormSubmit)', function(data){
			console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
			$.ajax({
				url : "${pageContext.request.contextPath}/user/editMyInfo"
				,data : data.field
				,type : 'POST'
				,success : function(result){
					var msg = JSON.parse(result).msg;
					layer.alert(msg)
				}
				,error : function(){
					console.log("error");
				}
			});
			return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
		});
	})
	
</script>

</html>