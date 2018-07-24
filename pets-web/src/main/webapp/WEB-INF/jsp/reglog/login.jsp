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
				<li class="li-child layui-this" lay-id="login">登录</li>
				<li class="li-child" lay-id="regist">注册</li>
			</ul>
			
			<div class="layui-tab-content">
				<div class="layui-tab-item layui-show">
					<form class="layui-form" lay-filter= "loginForm" action="${pageContext.request.contextPath}/user/login" method="post">
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
							<div class="layui-inline">
								<div class="layui-input-inline checkbox-rempsw" style="width: 180px;">
									<input type="checkbox"  name="remFlag" id="remFlag" title="记住密码" lay-skin="primary" checked>
								</div>
							</div>
						</div>
						<div class="layui-form-item">
							<div class="layui-input-block">
								<button class="layui-btn" lay-submit lay-filter="loginFormSubmit">立即提交</button>
								<button type="reset" class="layui-btn layui-btn-primary">重置</button>
							</div>
						</div>
					</form>
				</div>
				
				<div class="layui-tab-item">
					<div class="layui-tab-item layui-show">
						<form class="layui-form" lay-filter= "registerForm" action="">
							<p class="error" id= "regError" style="display: none;"></p>
							<div class="layui-form-item">
								<div class="layui-inline">
									<label class="layui-form-label" for= "regUsername"><i class="layui-icon icon-isNeed">*</i> 账号</label>
									<div class="layui-input-block">
								    	<input type="text" id= "regUsername" name="username" onblur= "checkAll()" lay-verify="required|checkUserName" placeholder="请输入长度4-12的账号.." autocomplete="off" class="layui-input">
								   	</div>
								</div>
								<div class="layui-inline"><i class="layui-icon" title="成功" id="usernameTick" style="color:green; display:none;">&#xe605;</i></div>
							</div>
							<div class="layui-form-item">
								<div class="layui-inline">
									<label class="layui-form-label" for= "regPsw"><i class="layui-icon icon-isNeed">*</i> 密码</label>
									<div class="layui-input-block">
										<input type="password" id= "regPsw" name="password" onblur= "checkAll()" required lay-verify="required" placeholder="请输入6-12位的密码.." autocomplete="off" class="layui-input">
									</div>
								</div>
								<div class="layui-inline"><i class="layui-icon" title="成功" id="passwordTick" style="color:green; display:none;">&#xe605;</i></div>
							</div>
							<div class="layui-form-item">
								<div class="layui-inline">
									<label class="layui-form-label"><i class="layui-icon icon-isNeed">*</i> 确认密码</label>
									<div class="layui-input-block">
										<input type="password" id= "regEnsurePsw" name="ensurePassword" onblur= "checkAll()" required lay-verify="required" placeholder="请再次输入密码.." autocomplete="off" class="layui-input">
									</div>
								</div>
								<div class="layui-inline"><i class="layui-icon" title="成功" id= "ensureTick" style="color:green; display: none;">&#xe605;</i></div>
							</div>
							<div class="layui-form-item">
								<div class="layui-inline">
									<label class="layui-form-label"><i class="layui-icon icon-isNeed">*</i> 昵称</label>
									<div class="layui-input-block">
										<input type="text" id= "regNickName" name="nickName" onblur= "checkAll()" required lay-verify="required" placeholder="请输入3-12位昵称.." autocomplete="off" class="layui-input">
									</div>
								</div>
								<div class="layui-inline"><i class="layui-icon" title="成功" id= "nickNameTick" style="color:green; display: none;">&#xe605;</i></div>
							</div>
							<div class="layui-form-item">
								<div class="layui-inline">
									<label class="layui-form-label"><i class="layui-icon icon-isNeed">*</i> 电子邮箱</label>
									<div class="layui-input-block">
										<input type="text" id= "regEmail" name="email" onblur= "checkAll()" required lay-verify="email|required" placeholder="请输入邮箱.." autocomplete="off" class="layui-input">
									</div>
								</div>
								<div class="layui-inline"><i class="layui-icon" title="成功" id= "emailTick" style="color:green; display:none;">&#xe605;</i></div>
							</div>
							<div class="layui-form-item">
								<label class="layui-form-label">性别</label>
								<div class="layui-input-block">
									<input type="radio" name="sex" value="M" title="男" checked>
									<input type="radio" name="sex" value="F" title="女">
								</div>
							</div>
							<div class="layui-form-item">
								<div class="layui-inline">
									<label class="layui-form-label"><i class="layui-icon icon-isNeed">*</i> 电话</label>
									<div class="layui-input-block">
										<input type="text" id="regPhone" name="phone" onblur= "checkAll()" required lay-verify="phone" placeholder="请输入电话号码.." autocomplete="off" class="layui-input">
									</div>
								</div>
								<div class="layui-inline"><i class="layui-icon" title="成功" id= "phoneTick" style="color:green; display: none;">&#xe605;</i></div>
							</div>
							<div class="layui-form-item">
								<div class="layui-input-block">
									<button class="layui-btn" id="registerFormSubmit" lay-submit lay-filter="registerFormSubmit">注册</button>
									<button type="reset" id="regReset" class="layui-btn layui-btn-primary">重置</button>
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
	layui.use(['form','element'],function(){
		var form = layui.form;
		var element = layui.element;
		
		//获取hash来切换选项卡，假设当前地址的hash为lay-id对应的值
		var layid = location.hash.replace(/^#docDemoTabBrief=/, '');
		element.tabChange('docDemoTabBrief', layid); //假设当前地址为：http://a.com#test1=222，那么选项卡会自动切换到“发送消息”这一项
		
		//监听Tab切换，以改变地址hash值
		element.on('tab(docDemoTabBrief)', function(){
			location.hash = 'docDemoTabBrief='+ this.getAttribute('lay-id');
		});
		  
		$(document).ready(function(){
	        //记住密码功能
	        var str = getCookie("loginInfo");
	        str = str.substring(1,str.length-1);
	        var username = str.split(",")[0];
	        var password = str.split(",")[1];
	        //自动填充用户名和密码
	        /* $("#userName").val(username);
	        $("#pwd").val(password); */
	        $("#username").val(username);
	        $("#password").val(password);
		});
		
		//获取cookie
		function getCookie(cname) {
		    var name = cname + "=";
		    var ca = document.cookie.split(';');
		    for(var i=0; i<ca.length; i++) {
		        var c = ca[i];
		        while (c.charAt(0)==' ') c = c.substring(1);
		        if (c.indexOf(name) != -1) return c.substring(name.length, c.length);
		    }
		    return "";
		} 

		/* //记住密码功能
		function remember(){
		    var remFlag = $("input[type='checkbox']").is(':checked');
		    if(remFlag==true){ //如果选中设置remFlag为1
		        //cookie存用户名和密码,回显的是真实的用户名和密码,存在安全问题.
				$("#remFlag").val("1");
		    }else{ //如果没选中设置remFlag为""
		        $("#remFlag").val("");
		    }
		} */
		
		form.on('submit(loginFormSubmit)', function(data){
			if(data.field.username == ""){
				layer.alert("账号不能为空!");
				return false;
			}
			if(data.field.password == ""){
				layer.alert("密码不能为空!");
				return false;
			}
			if(data.field.remFlag == undefined){
				data.field.remFlag = false;
			}else{
				data.field.remFlag = true;
			}
			console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}

			$.ajax({
				url : "${pageContext.request.contextPath}/user/login"
				,data : JSON.stringify(data.field)
				,type : 'POST'
				,contentType : 'application/json'
				,success : function(result){
					console.log(result);
					var result = JSON.parse(result);
					if(result.code == 0){
						window.location.href = "${pageContext.request.contextPath}";
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
		
		form.on('submit(registerFormSubmit)', function(data){
			console.log(data.elem) //被执行事件的元素DOM对象，一般为button对象
			console.log(data.form) //被执行提交的form对象，一般在存在form标签时才会返回
			console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
			$.ajax({
				url : "${pageContext.request.contextPath}/user/regist"
				,data : JSON.stringify(data.field)
				,type : 'POST'
				,contentType : 'application/json'
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
	
	$("button#regReset").click(function(){
		$("i[title='成功']").css('display','none');
	})
	
	function checkAll(){
		$("button#registerFormSubmit").addClass("layui-btn-disabled");
		$("button#registerFormSubmit").attr("disabled",true);
		var flag = false;
		var username = $.trim($("input#regUsername").val());
		var usernameLength = username.length;
		if(usernameLength > 12 || usernameLength < 4){
			$("p#regError").text("账号长度为4-12位");
			$("p#regError").css("display","block")
			$("i#usernameTick").css("display","none");
			return false;
		}
		
		var patrn=/^[a-zA-Z]{1}([a-zA-Z0-9]|[_]){3,14}$/;//以字母开头,可使用数字,字母以及"_"的
		if(!patrn.test(username)){
			$("p#regError").text('账号只能以字母开头,且只可使用数字,字母以及"_"');
			$("p#regError").css("display","block");
			$("i#usernameTick").css("display","none");
			return false;
		}
		//后续ajax请求查是否已经使用
		$.ajax({
			url: "${pageContext.request.contextPath}/user/checkUserNameForAjax"
			,data: {'username' : username}
			,async: false
			,success: function(data){
				var data = JSON.parse(data);
				if(data.code == 100){
					$("p#regError").text(data.msg);
					$("p#regError").css("display","block");
					$("i#usernameTick").css("display","none");
					flag = false;
					return false;
				}
				flag = true;
				$("i#usernameTick").css("display","block");
			}
		});
				
		if(!flag){
			return false;
		}
				
		//密码校验
		var password = $.trim($("input#regPsw").val());
		var passwordLength = password.length;
		if(passwordLength > 12 || passwordLength < 6){
			$("p#regError").text("密码长度为6-12位");
			$("p#regError").css("display","block");
			$("i#passwordTick").css("display","none");
			return false;
		}	
		$("i#passwordTick").css("display","block");
		
		//确认密码校验
		var ensurePassword = $.trim($("input#regEnsurePsw").val());
		var ensurePasswordLength = ensurePassword.length;
		if(ensurePassword != password){
			$("p#regError").text("两次密码不一样,请重新输入");
			$("p#regError").css("display","block");
			$("i#ensureTick").css("display","none");
			return false;
		}	
		$("i#ensureTick").css("display","block");
		
		//昵称验证
		var nickName = $.trim($("input#regNickName").val());
		var nickNameLength = nickName.length;
		if(nickNameLength > 12 || nickNameLength < 3){
			$("p#regError").text("昵称长度为3-12位");
			$("p#regError").css("display","block");
			$("i#nickNameTick").css("display","none");
			return false;
		}
		$("i#nickNameTick").css("display","block");
		
		//邮箱验证
		var reg = new RegExp("^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$");
		var email = $.trim($("input#regEmail").val());
		if(email == '' || email.length == 0){
			$("p#regError").text("邮箱不能为空!");
			$("p#regError").css("display","block");
			$("i#emailTick").css("display","none");
			return false;
		}
		if(!reg.test(email)){
			$("p#regError").text("邮箱格式不正确!");
			$("p#regError").css("display","block");
			$("i#emailTick").css("display","none");
			return false;
		}
		//邮箱异步验证
		$.ajax({
			url: "${pageContext.request.contextPath}/user/checkEmailForAjax"
			,data: {'email' : email}
			,async: false
			,success: function(data){
				var data = JSON.parse(data);
				if(data.code == 100){
					$("p#regError").text(data.msg);
					$("p#regError").css("display","block");
					$("i#emailTick").css("display","none");
					flag = false;
					return false;
				}
				flag = true;
				$("i#emailTick").css("display","block");
			}
		});
		
		if(!flag){
			return false;
		}
		
		//电话验证
		var reg = new RegExp("^[1][3,4,5,7,8][0-9]{9}$");
		var phone = $.trim($("input#regPhone").val());
		if(!reg.test(phone)){
			$("p#regError").text("请输入正确的手机号码!");
			$("p#regError").css("display","block");
			$("i#phoneTick").css("display","none");
			return false;
		}
		//电话异步验证
		$.ajax({
			url: "${pageContext.request.contextPath}/user/checkPhoneForAjax"
			,data: {'phone' : phone}
			,async: false
			,success: function(data){
				var data = JSON.parse(data);
				console.log(data);
				if(data.code == 100){
					$("p#regError").text(data.msg);
					$("p#regError").css("display","block");
					$("i#phoneTick").css("display","none");
					flag = false;
					return false;
				}
				flag = true;
				$("i#phoneTick").css("display","block");
			}
		});
		if(!flag){
			return false;
		}
		$("p.error").text("");
		$("p.error").css("display","none");
		$("button#registerFormSubmit").removeClass("layui-btn-disabled");
		$("button#registerFormSubmit").removeAttr("disabled");
	}

</script>

</html>