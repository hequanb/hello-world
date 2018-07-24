<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>百科信息列表</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layui/css/layui.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
	<script src="${pageContext.request.contextPath}/css/layui/layui.js"></script>
	<script src="${pageContext.request.contextPath}/js/jquery/jquery-3.2.1.min.js"></script>
	<style type="text/css">
		.layui-table-view .layui-table[lay-size=lg] .layui-table-cell {
		    height: 70px;
		    line-height: 70px;
		}
		.shopcart-table-img{
			height:60px;
			width:60px;
		}
	</style>
</head>
<body>  
<%@ include file="/WEB-INF/jsp/adminIndex.jsp" %>
<div style="margin-bottom: 5px;">
</div>
	<table class="layui-table" id="baikeList" lay-filter="baikeList"></table>
 
	<script type="text/html" id="barDemo">
  		<a class="layui-btn layui-btn-xs" lay-event="editBaike">编辑百科信息</a>
  		<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="deleteBaike">删除百科信息</a>
	</script>  
	
	<script type="text/html" id="cTpl">
  		{{# 
			if(d.cid == 0){ 
				return '狗狗'
			} else if(d.cid == 1) {
				return '猫猫'
			} else {
				return '其他'
			} 
		}}
	</script>   
          
<script type="text/javascript">
layui.use('table', function(){
	var table = layui.table;
  
	table.render({
		elem: '#baikeList'
		,id: 'baikeList'
		,page: true
		,url: '${pageContext.request.contextPath}/baike/getBaikeList' //数据接口
		,limits: [5, 10]
		,limit:5			
		,size: 'lg'
		,cols: [[ //表头
			{type:'numbers', align:'center'}
			,{field: 'image', title: '', align: 'center', width: 100, templet: '#imgTpl', style: 'height:70px;'}
			,{field: 'name',width: 200, title: '宠物名'}
			,{field: 'temp', width: 320, title: '性格'}
			,{field: 'cid', width: 320,title: '所属类目', templet: '#cTpl'}
			,{field: 'right', width: 360, align: 'center', toolbar: '#barDemo'}
		]]
		,done: function(res, curr, count){
		}
	});
  	
	  //监听工具条
	table.on('tool(baikeList)', function(obj){
		var data = obj.data;
		if(obj.event === 'editBaike'){
			window.location.href="${pageContext.request.contextPath}/admin/baike/toEditBaike?id="+data.id;
		}else if(obj.event === 'deleteBaike'){
			layer.confirm('确定删除百科信息么', function(index){
				var result = deleteBaike(data.id);
				if(result == 0){
					table.reload('baikeList', {
						page: {
							curr: 1 //重新从第 1 页开始
						}
					});
				}
				layer.close(index);
			}); 
		}
	});
	  
	 /*  var $ = layui.$, active = {
	    getCheckData: function(){ //获取选中数据
	      var checkStatus = table.checkStatus('itemList')
	      ,data = checkStatus.data;
	      layer.alert(JSON.stringify(data));
	    }
	    ,getCheckLength: function(){ //获取选中数目
	      var checkStatus = table.checkStatus('itemList')
	      ,data = checkStatus.data;
	      layer.msg('选中了：'+ data.length + ' 个');
	    }
	  };
	  
	  $('.demoTable .layui-btn').on('click', function(){
	    var type = $(this).data('type');
	    active[type] ? active[type].call(this) : '';
	  }); */
  
});
</script>

<script type="text/html" id="imgTpl">
	<img class="shopcart-table-img" src="${pageContext.request.contextPath}/images{{d.image}}" />
</script>

<script type="text/javascript">

	function deleteBaike(id){
		var code = 100;
		$.ajax({
			url: "${pageContext.request.contextPath}/admin/baike/deleteBaike"
			,data: {'id' : id}
			,type: 'post'
			,async: false
			,success: function(result){
				var result = JSON.parse(result);
				layer.alert(result.msg);
				code = result.code;
			}
			,error : function(){
				console.log("error");
			}
		});
		return code;
	}

</script>

</body>
</html>