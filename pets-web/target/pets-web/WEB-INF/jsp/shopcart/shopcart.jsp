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
<body style="overflow-y: auto; background-color: #f1ecec;">

	<%@ include file="/WEB-INF/jsp/headBar.jsp" %>

	<div style="margin: 25px 50px;">
		<div id="haveData" style="display:none; ">
			<div class="head-title-div">
				<p class="head-title-p">我的购物车</p>
			</div>
			<table id="shopcart" lay-filter="shopcart"></table>
			<blockquote class="layui-elem-quote layui-quote-nm" style="background-color: white">
				<div class="layui-row">
					<div class="layui-col-md3">
						<div class="layui-btn-container">
								<button class="layui-btn layui-btn-sm" id="deleteSelectedItem">
									<i class="layui-icon">&#x1006; 删除所选物品</i>
								</button>
								<button class="layui-btn layui-btn-sm" id="deleteAllItem" style="width: 140px">
									<i class="layui-icon">&#xe640; 清空购物车   </i>
								</button>
						</div>
					</div>
					<div class= "layui-col-md3 layui-col-md-offset4">
						<div class="layui-row">已选择<span class="shopcart-span-totalcount" id="totalCount"></span>件商品，总价：<span class="shopcart-span-totalprice">¥</span><span class="shopcart-span-totalprice" id="totalPrice"></span></div>
					</div>
					<div class="layui-col-md2">
						<div>
							<button id="toOrder" class="layui-btn layui-btn-danger">立即购买</button>
						</div>
					</div>
				</div>
			</blockquote>
		</div>
		<div id="noData" style="display: none;">
			<blockquote style="background-color: white; height: 250px;" class="layui-elem-quote layui-quote-nm">
				<div style="text-align: center;margin-top: 100px;">
					购物车是空的,<a href="${pageContext.request.contextPath }" style="color: #0088dd; ">去购物~</a>
				</div>
			</blockquote>
		</div>
	</div>

<script>
	layui.use(['element','form','table'], function(){
		var element = layui.element;
		var form = layui.form;
		var table = layui.table;
		
		function checkTr(){
			var tds = $("td[data-field=count]");
			var priceTds = $("td[data-field=subTotal]");
			if(tds.length == 0){
				$("div#noData").css('display','block');
				$("div#haveData").css('display','none');
				$("span#totalCount").text(0);
				$("span#totalPrice").text(0);
				return;
			}
			var totalCount = 0;
			var totalPrice = 0;
			$.each(tds, function(index,value){
				var count = parseInt($(value).text());
				totalCount += count;
			})
			$.each(priceTds, function(index,value){
				var subTotal = parseFloat($(value).text());
				totalPrice += subTotal;
			})
			$("th[data-field=sciId]").css("display","none");
			$("span#totalCount").text(totalCount);
			$("span#totalPrice").text(totalPrice.toFixed(2));
			$("div#noData").css('display','none');
			$("div#haveData").css('display','block');
		}
		
		function deleteBatch(ids){
			$.ajax({
				url: '${pageContext.request.contextPath }/shopcart/deleteShopcartItemBatch'
				,data: 'ids='+ids
				,type: 'POST'
				,success: function(data){
					layer.alert(JSON.parse(data).msg);
					checkTr();
					tableIns.reload();
				}
				,error: function(){
					console.log("error");
				}
			});
		}
		
		var tableIns = table.render({
			elem: '#shopcart'
			,url: '${pageContext.request.contextPath}/shopcart/getShopcartData' //数据接口 
			,skin: 'nob'
			,even: 'true'
			,method: 'get'
			,size: 'lg'
			,id: 'shopcart'
			,cols: [[ //表头
				{type: 'checkbox'}
				,{field: 'sciId', title: '', align: 'center', style: 'display:none'}
				,{field: 'image', title: '', align: 'center', templet: '#imgTpl', style: 'height:70px'}
				,{field: 'title', title: '商品名', align: 'center'}
				,{field: 'standard', title: '规格', align: 'center'}
				,{field: 'price', title: '单价(元)', align: 'center'} 
				,{field: 'count', title: '数量', align: 'center'}
				,{field: 'subTotal', title: '小计(元)', align: 'center'}
				,{title: '操作', align: 'center', toolbar: '#barDemo'}
			]]
			,done: function(res, curr, count){
				//如果是异步请求数据方式，res即为你接口返回的信息。
				if(res.count == 0){
					$("div#noData").css('display','block');
					$("div#haveData").css('display','none');
				}else{
					var tds = $("td[data-field=count]");
					var priceTds = $("td[data-field=subTotal]");
					var totalCount = 0;
					var totalPrice = 0;
					$.each(tds, function(index,value){
						var count = parseInt($(value).text());
						totalCount += count;
					})
					$.each(priceTds, function(index,value){
						var subTotal = parseFloat($(value).text());
						totalPrice += subTotal;
					})
					$("th[data-field=sciId]").css("display","none");
					$("span#totalCount").text(totalCount);
					$("span#totalPrice").text(totalPrice.toFixed(2));
					$("div#noData").css('display','none');
					$("div#haveData").css('display','block');
				}
			}
		});

		//监听工具条
		table.on('tool(shopcart)', function(obj){
			var data = obj.data;
			var id = data.sciId;

			if(obj.event === 'del'){
				layer.confirm('真的删除么', function(index){
					$.ajax({
						url: '${pageContext.request.contextPath }/shopcart/deleteShopcartItem'
						,data: 'id='+id
						,type: 'POST'
						,success: function(data){
							layer.alert(JSON.parse(data).msg);
							checkTr();
						}
						,error: function(){
							console.log("error");
						}
					});
					obj.del();
					layer.close(index);
				});
			}
		});
		
		$("button#deleteSelectedItem").click(function(){
			var checkStatus = table.checkStatus('shopcart');
			var data = checkStatus.data;
			var ids = '';
			layer.confirm('真的删除么', function(index){
				$.each(data, function(index, value){
					ids += value.sciId;
					ids += ','; 
				});
				ids = ids.substring(0, ids.length-1);
				deleteBatch(ids);
				layer.close(index);
			});
		});
		
		$("button#deleteAllItem").click(function(){
			var tds = $("td[data-field=sciId]");
			if(tds.length == 0){
				layer.alert("没有条目");
				return;
			}
			var ids = '';
			layer.confirm('真的删除么', function(index){
				$.each(tds, function(index,value){
					var id = parseInt($(value).text());
					ids += id;
					ids += ','
				});
				ids = ids.substring(0,ids.length - 1);
				deleteBatch(ids);
				layer.close(index);
			});
		});
		
		$("button#toOrder").click(function(){
			window.location.href = '${pageContext.request.contextPath}/order/toOrder';
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