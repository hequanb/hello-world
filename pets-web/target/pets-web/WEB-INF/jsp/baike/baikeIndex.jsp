<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> -->
<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Pets</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layui/css/layui.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
<script src="${pageContext.request.contextPath}/css/layui/layui.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery/jquery-3.2.1.min.js"></script>
<style>
	.layui-table-view .layui-table[lay-size=lg] .layui-table-cell {
	    height: 70px;
	    line-height: 70px;
	}
</style>
</head>
<body style="overflow-y: auto; background-color: #ffffff;">

	<%@ include file="/WEB-INF/jsp/headBar.jsp" %>

	<div style="margin: 25px 50px;">
		<div id="haveData" style="">
			
			<div class="layui-tab" lay-filter="demo">
				<ul class="layui-tab-title">
					<li class="layui-this">全部</li>
					<li>狗狗</li>
					<li>猫猫</li>
					<li>其他</li>
				</ul>
			</div>
			
			<div class="head-title-div" id="dogList" style="display: none;">
				<fieldset class="layui-elem-field margin-20" >
					<legend>狗狗百科</legend>
					<div class="layui-field-box">
						<div class="layui-row  layui-col-space20" id="dogNail">

						</div>
					</div>
				</fieldset>
			</div>
			
			<div class="head-title-div" id="catList" style="display: none;">
				<fieldset class="layui-elem-field margin-20" >
					<legend>猫猫百科</legend>
					<div class="layui-field-box">
						<div class="layui-row  layui-col-space20" id="catNail">
						
						</div>
					</div>
				</fieldset>
			</div>
			
			<div class="head-title-div" id="otherList" style="display: none;">
				<fieldset class="layui-elem-field margin-20" >
					<legend>其他动物百科</legend>
					<div class="layui-field-box">
						<div class="layui-row  layui-col-space20" id="otherNail">
						
						</div>
					</div>
				</fieldset>
			</div>
			
		</div>
	</div>

<script>
	layui.use(['element','form','table'], function(){
		var element = layui.element;
		var form = layui.form;
		var table = layui.table;
		
		$(function(){
			$.ajax({
				url : "${pageContext.request.contextPath}/baike/getAllBaike"
				,contentType : 'application/json'
				,success : function(data){
					var data = JSON.parse(data);
					console.log(data);
					if(data.dogList != null){
						var html = '';
						$("#dogList").css("display","block");
						$.each(data.dogList, function(index,item){
							html += '<div class="layui-col-md2 up-23 down-30">';
							html += '<div class="layui-row" style="border: solid 2px #efefef;">';
							html += '<div>';
							html += '<a class="nail-a2" target="_blank" href="${pageContext.request.contextPath }/baike/getBaikeDetail?id='+item.id+'">';
							html += '<img class="nail-img2" src="${pageContext.request.contextPath }/images'+item.image+'" />';
							html += '</a>';
							html += '</div>';
							html += '</div>';
							html += '<div class="layui-row nail-text-div">';
							html += '<a class="nail-a2 nail-title2" target="_blank" title="'+item.name+'" href="${pageContext.request.contextPath }/baike/getBaikeDetail?id='+item.id+'">';
							html += item.name;
							html += '</a>';
							html += '</div>';	
							html += '</div>';	
						});
						$("div#dogNail").html(html);
					}
					
					if(data.catList != null){
						var html = '';
						$("#catList").css("display","block");
						$.each(data.catList, function(index,item){
							html += '<div class="layui-col-md2 up-23 down-30">';
							html += '<div class="layui-row" style="border: solid 2px #efefef;">';
							html += '<div>';
							html += '<a class="nail-a2" target="_blank" href="${pageContext.request.contextPath }/baike/getBaikeDetail?id='+item.id+'">';
							html += '<img class="nail-img2" src="${pageContext.request.contextPath }/images'+item.image+'" />';
							html += '</a>';
							html += '</div>';
							html += '</div>';
							html += '<div class="layui-row nail-text-div">';
							html += '<a class="nail-a2 nail-title2" target="_blank" title="'+item.name+'" href="${pageContext.request.contextPath }/baike/getBaikeDetail?id='+item.id+'">';
							html += item.name;
							html += '</a>';
							html += '</div>';	
							html += '</div>';	
						});
						$("div#catNail").html(html);
					}
					
					if(data.otherList != null){
						var html = '';
						$("#otherList").css("display","block");
						$.each(data.otherList, function(index,item){
							html += '<div class="layui-col-md2 up-23 down-30">';
							html += '<div class="layui-row" style="border: solid 2px #efefef;">';
							html += '<div>';
							html += '<a class="nail-a2" target="_blank" href="${pageContext.request.contextPath }/baike/getBaikeDetail?id='+item.id+'">';
							html += '<img class="nail-img2" src="${pageContext.request.contextPath }/images'+item.image+'" />';
							html += '</a>';
							html += '</div>';
							html += '</div>';
							html += '<div class="layui-row nail-text-div">';
							html += '<a class="nail-a2 nail-title2" target="_blank" title="'+item.name+'" href="${pageContext.request.contextPath }/item/showItemDetail?id='+item.id+'">';
							html += item.name;
							html += '</a>';
							html += '</div>';	
							html += '</div>';	
						});
						$("div#otherNail").html(html);
					}
				}
				,error : function(){
					console.log("error");
				}
			})
		});
		
		//一些事件监听
		element.on('tab(demo)', function(data){
			console.log(data.index);
			if(data.index == 1){
				window.location.href = "${pageContext.request.contextPath}/baike/allDog"
			}
			if(data.index == 2){
				window.location.href = "${pageContext.request.contextPath}/baike/allCat"
			}
			if(data.index == 3){
				window.location.href = "${pageContext.request.contextPath}/baike/allOther"
			}
		});
		
	});
	
</script>

<script type="text/html" id="barDemo">
	<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>

<script type="text/html" id="imgTpl">
	<img class="shopcart-table-img" src="${pageContext.request.contextPath}/images{{d.image}}" />
</script>

</body>
</html>