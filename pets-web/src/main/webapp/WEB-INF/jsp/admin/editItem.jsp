<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layui/css/layui.css">
<script src="${pageContext.request.contextPath}/css/layui/layui.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery/jquery-3.2.1.min.js"></script>
<title>修改商品</title>
<style>
	.layui-upload-img{width: 300px; height: 300px; margin: 0 10px 10px 0;}
</style>
</head>
<body class="layui-layout-body" style="overflow: -webkit-paged-y;">
	<%@ include file="/WEB-INF/jsp/adminIndex.jsp" %>
	<div style="margin-top: 50px;">
		<form lay-filter="addItemForm" class="layui-form" method="post" enctype="multipart/form-data">
			<div class="layui-form-item">
				<label class="layui-form-label">商品标题:</label>
				<div class="layui-input-block">
					<input type="text" class="layui-input" name="title" value= "${item.title }" required lay-verify="required" placeholder="请输入商品标题.."/>
				</div>
			</div>  
			<!-- 商品ID -->
			<input type="hidden" name="id" id="id" autocomplete="off" value= "${item.id }" class="layui-input">
			
			<div class="layui-form-item layui-form-text">
				<label class="layui-form-label">商品卖点:</label>
				<div class="layui-input-block">
				  <textarea name="sellPoint" placeholder="请输入商品卖点.." maxlength="500"  class="layui-textarea">${item.sellPoint }</textarea>
				</div>
	  		</div>
	  		<div class="layui-form-item">
				<label class="layui-form-label">商品价钱:</label>
				<div class="layui-input-inline">
					<input type="number" name="price" lay-verify="price|required|number" value= "${item.price }" required placeholder="请输入商品价钱.." step="0.01" autocomplete="off" class="layui-input">
				</div>
				<div class="layui-form-mid layui-word-aux">最少单位为:分</div>
			</div>
			
	  		<div class="layui-form-item">
				<label class="layui-form-label">商标:</label>
				<div class="layui-input-block">
					<input type="text" class="layui-input" name="brand" value= "${item.brand }" required lay-verify="required" placeholder="请输入商标.."/>
				</div>
			</div> 
			<div class="layui-form-item">
				<label class="layui-form-label">规格:</label>
				<div class="layui-input-inline">
					<input type="text" class="layui-input" name="standard" value= "${item.standard }" required lay-verify="required" placeholder="请输入商品规格.."/>
				</div>
				<div class="layui-form-mid layui-word-aux">例子: 20Kg</div>
			</div> 
			<div class="layui-form-item">
				<label class="layui-form-label">适用对象:</label>
				<div class="layui-input-block">
					<input type="text" class="layui-input" name="target" value= "${item.target }" required lay-verify="required" placeholder="请输入适用对象.."/>
				</div>
			</div> 
			<div class="layui-form-item">
				<label class="layui-form-label">所属类目:</label>
			    <div class="layui-input-block" lay-filter="test2">
			      <select name="cid" lay-verify="required" lay-search>
			        <option value="">请选择一个类目</option>
			      </select>
			    </div>
			 </div>
			 
			 <div class="layui-form-item">
				<label class="layui-form-label">商品状态:</label>
			    <div class="layui-input-block" lay-filter="test2">
			      <select name="status" lay-verify="required" lay-search>
			        <option value="">请选择一个状态</option>
			        <option value="1">正常</option>
			        <option value="2">下架</option>
			      </select>
			    </div>
			 </div>
			 
			<div class="layui-form-item">
				<label class="layui-form-label">库存量:</label>
				<div class="layui-input-inline">
					<input type="number" name="num" lay-verify="required|number|num" value= "${item.num }" required placeholder="请输入库存量.." step="1" autocomplete="off" class="layui-input">
				</div>
				<div class="layui-form-mid layui-word-aux">最多9999个</div>
			</div>
			
			<div class="layui-upload">
			  <button type="button" class="layui-btn" id="image">上传图片</button>
			  <div class="layui-upload-list">
			    <img class="layui-upload-img" id="image1" src= "${pageContext.request.contextPath }/images${item.image }"/>
			    <p id="demoText"></p>
			  </div>
			</div>   
			<!-- 接收回调的图片url -->
			<input type="hidden" name="image" value= "${item.image }" id="image" autocomplete="off" class="layui-input">
			
			<div class="layui-form-item">
			    <div class="layui-input-block">
			      <button class="layui-btn" lay-submit lay-filter="editItemFormSubmit">立即提交</button>
			      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
			    </div>
	  		</div>
	  		<!-- <input type="submit"/> -->
			
		</form> 
	</div>
	<script>
		//Demo
		layui.use(['form','upload'], function(){
			var form = layui.form;
			var upload = layui.upload;
		  
			$(function(){
				var status = '${item.status}';
				$("select[name=status]").val(status);
				$.ajax({
					url : "${pageContext.request.contextPath}/item/selectLeafCat"
					,success : function(data){
						var data = JSON.parse(data);
						console.log(data);
						var html = '';
						$.each(data, function(index, value){
							html+="<option value='"+value.id+"'>"+value.name+"</option> ";
						});
						$("select[name=cid]").append(html);
						var val = '${item.cid }';
						$("select[name=cid]").val(val);
						form.render('select');
					}
					,error : function(){
						console.log("error");
					}
				});
			});
			
		  //监听提交
			form.on('submit(editItemFormSubmit)', function(data){
				$.ajax({
					url : "${pageContext.request.contextPath}/item/editItem"
					,data : JSON.stringify(data.field)
					,type : 'POST'
					,contentType : 'application/json'
					,success : function(result){
						var msg = JSON.parse(result).msg;
						layer.msg(msg)
					}
					,error : function(){
						console.log("error");
					}
				});
				return false;
			});
		  
			form.verify({
				price: [
				        /^\d+(\.\d{1,2})?$/
				        ,'价钱的最少单位为:分'
				      ],
				num: function(value, item){ //value：表单的值、item：表单的DOM对象
				    if(value > 9999){
				      return '库存量最多9999';
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