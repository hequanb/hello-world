<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	  <meta charset="utf-8">
	  <title>商品列表</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layui/css/layui.css">
	<script src="${pageContext.request.contextPath}/css/layui/layui.js"></script>
	<script src="${pageContext.request.contextPath}/js/jquery/jquery-3.2.1.min.js"></script>
</head>
<body>  
<%@ include file="/WEB-INF/jsp/adminIndex.jsp" %>
<div style="margin-bottom: 5px;">          
</div>
 
	<table class="layui-table" id="itemList" lay-filter="itemList">
	  
	</table>
 
	<script type="text/html" id="barDemo">
  		<a class="layui-btn layui-btn-xs" lay-event="editItem">编辑商品</a>
  		<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="deleteItem">删除商品</a>
	</script>  
	
	<script type="text/html" id="statusDemo">
  		{{# if(d.status == 1){ return '正常'} else if(d.status == 2) {return '下架'} else {return '删除'} }}
	</script>   
          
<script type="text/javascript">
layui.use('table', function(){
	var table = layui.table;
  
	table.render({
		elem: '#itemList'
		,id: 'itemList'
		,page: true
		,url: '${pageContext.request.contextPath}/item/getItemList' //数据接口
		,limits: [3, 5]
		,limit:5
		,cols: [[ //表头
			{type:'checkbox', fixed: 'left'}
			,{type:'numbers', align:'center'}
			,{field: 'title', title: '商品标题', width:330 }
			,{field: 'price', title: '价格', width:120 }
			,{field: 'brand', title: '品牌', width:120} 
			,{field: 'standard', title: '规格', width: 70}
			,{field: 'target', title: '适用对象', width: 150}
			,{field: 'cid', title: '所属类目', width: 100}
			,{field: 'cName', title: '所属类目', width: 100}
			,{field: 'status', title: '商品状态', templet: '#statusDemo', width: 110}
			,{fixed: 'right', width: 250,align: 'center', toolbar: '#barDemo'}
		]]
		,done: function(res, curr, count){
			$("[data-field='cid']").css('display','none');
		}
	});
  
  	table.on('checkbox(itemList)', function(obj){
	    /* console.log(obj) */
	});
  	
	  //监听工具条
	table.on('tool(itemList)', function(obj){
		var data = obj.data;
		if(obj.event === 'editItem'){
			window.location.href="${pageContext.request.contextPath}/admin/toEditItem/"+data.id;
		}else if(obj.event === 'deleteItem'){
			layer.confirm('确定删除商品么', function(index){
				var result = deleteItem(data.id);
				if(result == 0){
					table.reload('itemList', {
						page: {
							curr: 1 //重新从第 1 页开始
						}
					});
				}
				layer.close(index);
			});
		}
	});
	  
	  var $ = layui.$, active = {
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
	    ,isAll: function(){ //验证是否全选
	      var checkStatus = table.checkStatus('idTest');
	      layer.msg(checkStatus.isAll ? '全选': '未全选')
	    }
	  };
	  
	  $('.demoTable .layui-btn').on('click', function(){
	    var type = $(this).data('type');
	    active[type] ? active[type].call(this) : '';
	  });
  
});

</script>

<script type="text/javascript">

	function deleteItem(id){
		var code = 100;
		$.ajax({
			url: "${pageContext.request.contextPath}/item/deleteItem"
			,data: {'id' : id}
			,type: 'post'
			,async: false
			,success: function(result){
				var result = JSON.parse(result);
				layer.msg(result.msg);
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