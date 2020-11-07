<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/fn.tld" prefix="fn"%>
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
					<c:when
						test="${(empty one)}">
						<blockquote class="layui-elem-quote">信息传递失败!</blockquote>
					</c:when>
					<c:otherwise>
						<table class="layui-table" >
							<tbody>
								<tr>
									<th>ID</th>
									<td>${one.id}</td>
								</tr>
								<tr>
									<th>资源名</th>
									<td>${one.name}</td>
								</tr>
								<tr>
									<th>资源类型：</th>
									<td>
										<span class="layui-btn layui-btn-mini">
												${one.type eq "menu" ? "菜单资源" :  one.type eq "button" ? "按钮资源" : "一般资源"}
										</span>
									</td>
								</tr>
								<tr>
									<th>菜单级别</th>
									<td>
										<span class="layui-btn layui-btn-mini">
												${one.level eq 0 ? "目录菜单" :  one.level eq 1 ? "url菜单" : "N/A"}
										</span>
									</td>
								</tr>
								<tr>
									<th>上级ID</th>
									<td>${empty one.upLevelId ? 'N/A' : one.upLevelId}</td>
								</tr>
								<tr>
									<th>显示顺序</th>
									<td>${one.priority}</td>
								</tr>
								<tr>
									<th>资源图标</th>
									<td><i class="layui-icon" >${one.icon}</i></td>
								</tr>
								<tr>
									<th>访问路径</th>
									<td>${empty one.url ? 'N/A' : one.url}</td>
								</tr>
								<tr>
									<th>权限字符</th>
									<td>${empty one.permission ? 'N/A' : one.permission }</td>
								</tr>
								<tr>
									<th>资源状态</th>
									<td>
										<span class="layui-btn ${one.state eq 1 ? 'layui-btn-normal' :  'layui-btn-danger'} layui-btn-mini">
											${one.state eq 1 ? "激活" :  "停用"}
										</span>
									</td>
								</tr>
								<tr>
									<th>补充信息</th>
									<td>${empty one.other ? 'N/A' : one.other}</td>
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
			layui.use(['form', 'layer'], function() {
				$ = layui.jquery;
				var form = layui.form(),
					layer = layui.layer;

			});
		</script>
	</body>

</html>