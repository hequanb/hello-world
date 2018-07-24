<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>后台</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layui/css/layui.css">
<style>
	.layui-table-view .layui-table[lay-size=lg] .layui-table-cell {
	    height: 70px;
	    line-height: 70px;
	}
</style>
</head>
<div class="layui-layout layui-layout-admin">
  <div class="layui-header">
    <div class="layui-logo">layui 后台布局</div>
    <!-- 头部区域（可配合layui已有的水平导航） -->
    <ul class="layui-nav layui-layout-left">
      <li class="layui-nav-item">
        <a href="javascript:;">商品管理</a>
        <dl class="layui-nav-child">
          <dd><a href="${pageContext.request.contextPath }/admin/toGetItemList">商品列表</a></dd>
          <dd><a href="${pageContext.request.contextPath }/admin/toAddItem">添加商品</a></dd>
          <dd><a href="${pageContext.request.contextPath }/admin/toSetItemCat">管理商品类目</a></dd>
        </dl>
      </li>
     <li class="layui-nav-item">
        <a href="javascript:;">订单管理</a>
        <dl class="layui-nav-child">
          <dd><a href="${pageContext.request.contextPath }/admin/order/toOrderManage">订单管理</a></dd>
        </dl>
      </li>
      <li class="layui-nav-item">
        <a href="javascript:;">百科管理</a>
        <dl class="layui-nav-child">
			<dd><a href="${pageContext.request.contextPath }/admin/baike/toGetBaikeList">百科信息列表</a></dd>
			<dd><a href="${pageContext.request.contextPath }/admin/baike/toAddBaike">添加百科信息</a></dd>
        </dl>
      </li>
      <li class="layui-nav-item">
        <a href="javascript:;">销售管理</a>
        <dl class="layui-nav-child">
			<dd><a href="${pageContext.request.contextPath }/admin/benefit/benefitInTime">查看营业额</a></dd>
			<dd><a href="${pageContext.request.contextPath }/admin/benefit/toDetailBenefit">具体商品销量</a></dd>
        </dl>
      </li>
    </ul>
    <ul class="layui-nav layui-layout-right">
      <c:choose>
		<c:when test="${sessionScope.admin != null }">
			<li class="layui-nav-item">
				<a href="javascript:;">
					${sessionScope.admin.nickName}
				</a>
			</li>
			<li class="layui-nav-item"><a href="${pageContext.request.contextPath }/admin/logout">退出</a></li>
		</c:when>
	  </c:choose>
    </ul>
  </div>
</div>
<script src="${pageContext.request.contextPath}/css/layui/layui.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery/jquery-3.2.1.min.js"></script>

<script>
	layui.use('element', function(){
	  var element = layui.element;
	  
	});
</script>
</html>