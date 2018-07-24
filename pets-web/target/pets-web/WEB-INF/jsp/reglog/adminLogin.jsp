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
	    top: 50px;
	    left: 50px;
	    margin: 14px;
	    padding: 25px;
	    padding-top: 10px;
	    background-color: white;
	    border-radius: 5px;
	}
	.error {
	    height: 29px;
	    font-size: 14px;
	    border-radius: 3px;
	    /* position: absolute;
	    top: 14px;
	    left: 0px; */
	    background: #f15f6a;
	    color: #fff;
	    text-align: center;
	    width: 100%;
	    line-height: 30px;
	    margin-bottom: 10px;
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

	<div class= "login-main-div">
		<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
			<ul class="layui-tab-title ul-title">
				<li class="li-child layui-this" lay-id="login">管理员登录</li>
			</ul>
			
			<div class="layui-tab-content">
				<div class="layui-tab-item layui-show">
					<form class="layui-form" lay-filter= "loginForm" action="${pageContext.request.contextPath}/admin/login" method="post">
						<p class="error" id="logErr" style="display: none;"></p>
						<div class="layui-form-item">
							<label class="layui-form-label">账号</label>
							<div class="layui-input-block">
						    	<input type="text" name="username" id="username" placeholder="请输入账号.." autocomplete="off" class="layui-input">
						   	</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">密码</label>
							<div class="layui-input-block">
								<input type="password" name="password" id="password" placeholder="请输入密码" autocomplete="off" class="layui-input">
							</div>
						</div>
						<div class="layui-form-item">
							<div class="layui-input-block">
								<button class="layui-btn" lay-submit lay-filter="loginFormSubmit">立即提交</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>  
	</div>
</body>

<script type="text/javascript">
	layui.use(['form','element'],function(){
		var form = layui.form;
		var element = layui.element;
		
		form.on('submit(loginFormSubmit)', function(data){
			if(data.field.username == ""){
				layer.alert("账号不能为空!");
				return false;
			}
			if(data.field.password == ""){
				layer.alert("密码不能为空!");
				return false;
			}
			console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}

			$.ajax({
				url : "${pageContext.request.contextPath}/admin/login"
				,data : data.field
				,type : 'POST'
				,success : function(result){
					console.log(result);
					var result = JSON.parse(result);
					if(result.code == 0){
						window.location.href = "${pageContext.request.contextPath}/admin/index";
					}else{
						$("p#logErr").text(result.msg);
						$("p#logErr").css("display","block");
					}
				}
				,error : function(){
					console.log("error");
				}
			});
			return false;
		});
	});
	


</script>

</html>