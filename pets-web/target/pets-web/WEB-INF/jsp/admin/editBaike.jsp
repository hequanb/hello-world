<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layui/css/layui.css">
<script src="${pageContext.request.contextPath}/css/layui/layui.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery/jquery-3.2.1.min.js"></script>
<title>修改百科信息</title>
<style>
	.layui-upload-img{width: 300px; height: 300px; margin: 0 10px 10px 0;}
</style>
</head>
<body class="layui-layout-body" style="overflow: -webkit-paged-y;">
	<%@ include file="/WEB-INF/jsp/adminIndex.jsp" %>
		<div style="margin-top: 50px;">
		<form lay-filter="editBaikeForm" class="layui-form" method="post" enctype="multipart/form-data">
			<div class="layui-form-item">
				<label class="layui-form-label">宠物名:</label>
				<div class="layui-input-block">
					<input type="text" class="layui-input" name="name" value= "${baike.name }" required lay-verify="required" placeholder="请输入宠物名.."/>
				</div>
			</div>  
			<!-- 商品ID -->
			<input type="hidden" name="id" id="id" autocomplete="off" value= "${baike.id }" class="layui-input">
			<div class="layui-form-item layui-form-text">
				<label class="layui-form-label">性格:</label>
				<div class="layui-input-block">
					<input type="text" class="layui-input" name="temp" value= "${baike.temp }" required lay-verify="required" placeholder="请输入性格.."/>
				</div>
	  		</div>
	  		<div class="layui-form-item layui-form-text">
				<label class="layui-form-label">祖籍:</label>
				<div class="layui-input-block">
					<input type="text" class="layui-input" name="original" value= "${baike.original }" required lay-verify="required" placeholder="请输入祖籍.."/>
				</div>
	  		</div>
	  		<div class="layui-form-item">
				<label class="layui-form-label">易患病:</label>
				<div class="layui-input-block">
					<input type="text" class="layui-input" name="illness" value= "${baike.illness }" required lay-verify="required" placeholder="请输入易患病.."/>
				</div>
			</div> 
			<div class="layui-form-item">
				<label class="layui-form-label">寿命(岁):</label>
				<div class="layui-input-block">
					<input type="text" class="layui-input" name="lifetime" value= "${baike.lifetime }" required lay-verify="required" placeholder="请输入寿命.."/>
				</div>
			</div> 
			<div class="layui-form-item">
				<label class="layui-form-label">价格(元):</label>
				<div class="layui-input-block">
					<input type="text" class="layui-input" name="price" value= "${baike.price }" required lay-verify="required" placeholder="请输入价格.."/>
				</div>
			</div> 
			<div class="layui-form-item layui-form-text">
				<label class="layui-form-label">品种简介:</label>
				<div class="layui-input-block">
				  <textarea name="typeArticle" placeholder="请输入品种简介.." maxlength="500" class="layui-textarea">${baike.typeArticle }</textarea>
				</div>
	  		</div>
	  		<div class="layui-form-item layui-form-text">
				<label class="layui-form-label">性格特点:</label>
				<div class="layui-input-block">
				  <textarea name="tempArticle" placeholder="请输入性格特点.." maxlength="500" class="layui-textarea">${baike.tempArticle }</textarea>
				</div>
	  		</div>
			<div class="layui-form-item">
				<label class="layui-form-label">所属类目:</label>
			    <div class="layui-input-block" lay-filter="test2">
			      <select name="cid" lay-verify="required" lay-search>
			        <option value="">请选择一个类目</option>
			        <option value="0">狗狗</option>
			        <option value="1">猫猫</option>
			        <option value="2">其他</option>
			      </select>
			    </div>
			 </div>
			<div class="layui-upload">
			  <button type="button" class="layui-btn" id="image">上传图片</button>
			  <div class="layui-upload-list">
			    <img class="layui-upload-img" id="image1" src= "${pageContext.request.contextPath }/images${baike.image }"/>
			    <p id="demoText"></p>
			  </div>
			</div>   
			<!-- 接收回调的图片url -->
			<input type="hidden" class="layui-input" value= "${baike.image }" required lay-verify="image" name="image" id="image" autocomplete="off" class="layui-input">
			
			<div class="layui-form-item">
			    <div class="layui-input-block">
			      <button class="layui-btn" lay-submit lay-filter="editBaikeSubmit">立即提交</button>
			      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
			    </div>
	  		</div>			
		</form> 
	</div>
	<script>
		//Demo
		layui.use(['form','upload'], function(){
			var form = layui.form;
			var upload = layui.upload;
		  
			$(function(){
				var cid = '${baike.cid}';
				$("select[name=cid]").val(cid);
				form.render('select');
			});
		  //监听提交
			form.on('submit(editBaikeSubmit)', function(data){
				$.ajax({
					url : "${pageContext.request.contextPath}/admin/baike/editBaike"
					,data : JSON.stringify(data.field)
					,type : 'POST'
					,contentType : 'application/json'
					,success : function(result){
						var msg = JSON.parse(result).msg;
						layer.confirm(msg, {
							closeBtn: 0
							,btnAlign: 'c'
							,btn: ['确定'] //按钮
						}
						, function(){
							window.location.reload();
						})
					}
					,error : function(){
						console.log("error");
					}
				});
				return false;
			});
		  
			form.verify({
				image: function(value, item){
					if(value == ''){
						return '请上传图片';
					}
				}
			});   
			
			//普通图片上传
			  var uploadInst = upload.render({
			    elem: '#image'
			    ,url: '${pageContext.request.contextPath}/item/uploadImage'
			    ,accept: 'images'
			    ,before: function(obj){
			      //预读本地文件示例，不支持ie8
			      obj.preview(function(index, file, result){
			        $('#image1').attr('src', result); //图片链接（base64）
			        $('#demoText').text(file.name);
			      });
			    }
			    ,done: function(res){
			      //如果上传失败
			      if(res.code > 0){
			        return layer.msg('上传失败');
			      }
			      //上传成功
			      	console.log(res.url);
			        $('input#image').val(res.url);
			        return layer.msg('上传成功');
			    }
			    ,error: function(){
			      //演示失败状态，并实现重传
			      var demoText = $('#demoText');
			      demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-mini demo-reload">重试</a>');
			      demoText.find('.demo-reload').on('click', function(){
					uploadInst.upload();
			      });
			    }
			  });
			
		});
		
		  
			      
		</script> 
</body>
</html>