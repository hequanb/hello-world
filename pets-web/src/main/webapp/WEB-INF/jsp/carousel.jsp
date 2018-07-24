<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layui/css/layui.css">
<script src="${pageContext.request.contextPath}/css/layui/layui.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery/jquery-3.2.1.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">

<style>
	.bgStyle{
		-moz-background-size:100% 100%;
		background-size:100% 100%;
	}
</style>
	<div >
		<div id="main" >
			<div class="layui-carousel" id="test1">
				<div carousel-item>
					<div class="bgStyle" style="background:url('${pageContext.request.contextPath }/images/data/slide1.jpg') no-repeat; background-size:100% 100%;"></div>
					<div style="background:url('${pageContext.request.contextPath }/images/data/slide2.jpg') no-repeat; background-size:100% 100%;"></div>
					<div style="background:url('${pageContext.request.contextPath }/images/data/slide.jpg') no-repeat; background-size:100% 100%;">条目3</div>
				</div>
			</div>
		</div>
	</div>
	
	<ul class="layui-nav layui-bg-red" id="firstCatNav" lay-filter="firstCatNav">
		
	</ul>
	
	<script>
	layui.use(['element','carousel'], function(){
		var element = layui.element;
		var carousel = layui.carousel;
		
		$(function(){
			$.ajax({
				url : "${pageContext.request.contextPath}/itemCat/getAllCategoriesNew"
				,type : 'POST'
				,contentType : 'application/json'
				,success : function(data){
					var data = JSON.parse(data);
					console.log(data);
					var html = '';
					html += '<li class="layui-nav-item" style="font-size: 25px;">商品类目<i class="layui-icon" style="font-size: 21px;">&#xe649;</i></li>';
					html += data;
					$("ul#firstCarNav").find("span.layui-nav-bar").remove();
					$("ul#firstCatNav").html(html);
					element.render('nav'); 
				}
				,error : function(){
					console.log("error");
				}
			})
		});
		
		//建造实例
		carousel.render({
			elem: '#test1'
			,width: '100%' //设置容器宽度
			,arrow: 'always' //始终显示箭头
			,anim: 'fade' //切换动画方式
			,height: 700
		});
	});
	</script>