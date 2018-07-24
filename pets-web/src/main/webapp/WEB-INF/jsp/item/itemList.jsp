<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Pets</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layui/css/layui.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/css/bootstrap.min.css">--%>
<script src="${pageContext.request.contextPath}/css/layui/layui.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery/jquery-3.2.1.min.js"></script>
<style type="text/css">

	.side-nav{
		width: 100%;
    	height: 500px;
    	background-color: #f2f2f2;
    }
    #brandA{
    	pointer: cursor;
    	color: #0088dd;
    }

</style>
</head>
<body class="layui-layout-body" style="overflow-y: auto">
<div class="layui-layout layui-layout-admin">

	<%@ include file="/WEB-INF/jsp/headBar.jsp" %>
  	<%@ include file="/WEB-INF/jsp/carousel.jsp" %>
	
	<div class="updown-35"></div>
	
	<%-- <fieldset class="layui-elem-field margin-20" >
		<legend>${cName }</legend>
		<div class="layui-field-box">
			 <div class="layui-row" id="nail">
			 	<c:choose>
			 		<c:when test="${list != null }">
			 			<c:forEach var="item" items="${ list}">
				 			<div class="layui-col-md3 up-23 down-30">
								<div class="layui-row">
									<div>
										<a class="nail-a" target="_blank" href="${pageContext.request.contextPath }/item/showItemDetail?id=${item.id}">
											<img class="nail-img" src="${pageContext.request.contextPath }/images${item.image}" />
										</a>
									</div>
								</div>
								<div class="layui-row up-23">
									<a class="nail-a nail-title" target="_blank" title="${item.title }" href="${pageContext.request.contextPath }/item/showItemDetail?id=${item.id}">
										${ item.title};
									</a>
								</div>
							</div>
						</c:forEach>
			 		</c:when>
			 		<c:otherwise>
			 			没有商品!
			 		</c:otherwise>
			 	</c:choose>
			</div>
		</div>
	</fieldset> --%>
	<div >
		<div style="margin-left: 40px;" class="layui-inline">品牌</div>
		<div style="margin-left: 40px; margin-top: 10px;">
			<div id="brandDiv" class="layui-row">
				
			</div>
		</div>
		<fieldset class="layui-elem-field margin-20" >
			<legend id="cName"></legend>
			<div class="layui-field-box">
				 <div class="layui-row" id="nail">
				</div>
			</div>
		</fieldset>
	</div>

<script>

	function reload(brand){
		var cid = '${cid }';
		var html = '';
		$.ajax({
			url : "${pageContext.request.contextPath}/item/loadItemListByCat"
			,data: JSON.stringify({cid: cid, brand: brand})
			,type: 'POST'
			,contentType : 'application/json'
			,success : function(result){
				var data = JSON.parse(result).list;
				$.each(data,function(index,item){
					html += '<div class="layui-col-md3 up-23 down-30">';
					html += '<div class="layui-row">';
					html += '<div>';
					html += '<a class="nail-a" target="_blank" href="${pageContext.request.contextPath }/item/showItemDetail?id='+item.id+'">';
					html += '<img class="nail-img" src="${pageContext.request.contextPath }/images'+item.image+'" />';
					html += '</a>';
					html += '</div>';
					html += '</div>';
					html += '<div class="layui-row up-23">';
					html += '<a class="nail-a nail-title" target="_blank" title="'+item.title+'" href="${pageContext.request.contextPath }/item/showItemDetail?id='+item.id+'">';
					html += item.title;
					html += '</a>';
					html += '</div>';	
					html += '</div>';	
				});
				$("div#nail").html(html);
			}
			,error : function(){
				console.log("error");
			}
		});
	}

	layui.use(['element'], function(){
		var element = layui.element;
		var html = '';
		var brandHtml = '';
		var cid = '${cid }';
		$(function(){
			$.ajax({
				url : "${pageContext.request.contextPath}/item/loadItemListByCat"
				,contentType : 'application/json'
				,data: JSON.stringify({cid: cid})
				,type: 'POST'
				,success : function(result){
					var data = JSON.parse(result).list;
					var cName = JSON.parse(result).cName;
					var brandList = JSON.parse(result).brandList;
					brandHtml += '<div class="layui-col-md2">';
					brandHtml += '<a id="brandA" href="javascript:;" onclick="reload(\'\')">';
					brandHtml += '全部';
					brandHtml += '</a>';
					brandHtml += '</div>';
					$.each(brandList, function(index, item){
						brandHtml += '<div class="layui-col-md2">';
						brandHtml += '<a id="brandA" href="javascript:;" onclick="reload(\''+item+'\')">';
						brandHtml += item;
						brandHtml += '</a>';
						brandHtml += '</div>';
					});
					$("div#brandDiv").html(brandHtml);
					$("#cName").text(cName);
					$.each(data,function(index,item){
						html += '<div class="layui-col-md3 up-23 down-30">';
						html += '<div class="layui-row">';
						html += '<div>';
						html += '<a class="nail-a" target="_blank" href="${pageContext.request.contextPath }/item/showItemDetail?id='+item.id+'">';
						html += '<img class="nail-img" src="${pageContext.request.contextPath }/images'+item.image+'" />';
						html += '</a>';
						html += '</div>';
						html += '</div>';
						html += '<div class="layui-row up-23">';
						html += '<a class="nail-a nail-title" target="_blank" title="'+item.title+'" href="${pageContext.request.contextPath }/item/showItemDetail?id='+item.id+'">';
						html += item.title;
						html += '</a>';
						html += '</div>';	
						html += '</div>';	
					});
					$("div#nail").html(html);
				}
				,error : function(){
					console.log("error");
				}
			});
		});
		
	}); 
</script>

</body>
</html>