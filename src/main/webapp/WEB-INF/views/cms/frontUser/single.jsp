<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/fn.tld" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/fmt.tld" prefix="fmt"%>
<%@ taglib uri="/WEB-INF/tlds/shiro.tld" prefix="shiro"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<title>Hi,Danmaku!-CMS</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="format-detection" content="telephone=no">
<link rel="stylesheet" href="<%=basePath%>assets/css/x-admin.css" media="all">
</head>
<body>
	<div class="x-body">
		<div class="pd-20">
			<c:if test="${not empty errMsg}">
				<blockquote class="layui-elem-quote">${errMsg}</blockquote>
			</c:if>
			<c:choose>
				<c:when test="${(empty one)}">
					<blockquote class="layui-elem-quote">信息传递失败!</blockquote>
				</c:when>
				<c:otherwise>
					<table class="layui-table">
						<tbody>
							<tr>
								<th>用户ID</th>
								<td>${one.id}</td>
							</tr>
							<tr>
								<th>昵称</th>
								<td>${empty one.name ? "N/A" :one.name}</td>
							</tr>
							<tr>
								<th>性别</th>
								<td>${empty one.sex  ? "未知" :one.sex eq 1 ?"男":"女"}</td>
							</tr>
							<tr>
								<th>生日</th>
								<td><c:choose>
										<c:when test="${empty one.birthday}">
																	N/A
																</c:when>
										<c:otherwise>
											<fmt:formatDate pattern="yyyy-MM-dd" value="${one.birthday}" />
										</c:otherwise>
									</c:choose></td>
							</tr>
							<tr>
								<th>邮箱</th>
								<td>${one.email}</td>
							</tr>
							<tr>
								<th>硬币数</th>
								<td>${empty one.coin ? "0" :one.coin}</td>
							</tr>
							<tr>
								<th>手机号</th>
								<td>${empty one.phone ? "N/A" :one.phone}</td>
							</tr>
							<tr>
								<th>住址</th>
								<td>${empty one.address ? "N/A" :one.address}</td>
							</tr>
							<tr>
								<th>注册时间</th>
								<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${one.regTime}" /></td>
							</tr>
							<tr>
								<th>状态</th>
								<td><span
									class="layui-btn ${one.state eq 1 ? 'layui-btn-normal' :  'layui-btn-danger'} layui-btn-mini">
										${one.state eq 1 ? "激活" :  "锁定"} </span></td>
							</tr>
							<tr>
								<th>个性签名</th>
								<td>${empty one.signature ? "N/A" :  one.signature}</td>
							</tr>
						</tbody>
					</table>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<script src="<%=basePath%>assets/lib/layui/layui.js" charset="utf-8"></script>
	<script src="<%=basePath%>assets/js/x-layui.js" charset="utf-8"></script>
	<script>
		layui.use([ 'form', 'layer' ], function() {
			$ = layui.jquery;
			var form = layui.form(), layer = layui.layer;

		});
	</script>
</body>

</html>