<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="layui-layout layui-layout-admin">
	<div class="layui-header">
    	<div class="layui-logo">PetStore--Pet's Home</div>
   		<!-- 头部区域（可配合layui已有的水平导航） -->
		<ul class="layui-nav layui-layout-left">
			<li class="layui-nav-item"><a href="${pageContext.request.contextPath }">商城</a></li>
			<li class="layui-nav-item"><a href="${pageContext.request.contextPath }/baike/toBaikeIndex">百科</a></li>
	    </ul>
		<ul class="layui-nav layui-layout-right">
			<c:choose>
				<c:when test="${sessionScope.user != null }">
					<li class="layui-nav-item">
						<a href="javascript:;">
							${sessionScope.user.nickName}
						</a>
						<dl class="layui-nav-child">
							<dd><a href="">基本资料</a></dd>
							<dd><a href="${pageContext.request.contextPath }/shopcart/toMyShopcart">我的购物车</a></dd>
							<dd><a href="${pageContext.request.contextPath }/order/myOrder">我的订单</a></dd>
							<dd><a href="${pageContext.request.contextPath }/user/myInfo">个人资料</a></dd>
						</dl>
					</li>
					<li class="layui-nav-item"><a href="${pageContext.request.contextPath }/user/logout">退出</a></li>
				</c:when>
				<c:otherwise>
					<li class="layui-nav-item"><a href="${pageContext.request.contextPath}/user/toLoginAndRegist?hash=login">登录</a></li>
				</c:otherwise>
			</c:choose>
		</ul>
	</div>
</div>
