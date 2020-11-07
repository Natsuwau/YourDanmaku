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
	String imgBasePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ "/data/img/";
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
								<th>视频ID</th>
								<td>${one.id}</td>
							</tr>
							<tr>
								<th>名称</th>
								<td>${empty one.name ? "N/A" :one.name}</td>
							</tr>
							<tr>
								<th>观看权限</th>
								<td class="td-status"><span
									class="layui-btn  layui-btn-mini">${one.scope eq "@user" ? "仅限会员" :  "所有人"}
								</span></td>
							</tr>
							<tr>
								<th>类型</th>
								<td>${one.typeName}</td>
							</tr>
							<tr>
								<th>时长</th>
								<td>${one.durationStr}</td>
							</tr>
							<tr>
								<th>类型</th>
								<td>${one.typeName}</td>
							</tr>
							<tr>
								<th>上传时间</th>
								<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${one.uploadTime}" /></td>
							</tr>
							<tr>
								<th>简介</th>
								<td>${one.desc}</td>
							</tr>
							<tr>
								<th>状态</th>
								<td><span
									class="layui-btn layui-btn-mini">
										${one.state eq 1 ? "审核通过" :  one.state eq 0 ?"待审核" :"'BAN'状态"} </span></td>
							</tr>
							<tr>
								<th>封面</th>
								<td><c:choose>
									<c:when test="${empty one.coverUrl}">
										N/A
									</c:when>
									<c:otherwise>
										<img src="<%=imgBasePath%>${ one.coverUrl}"
									height="100px" alt="图片损坏"/>
									</c:otherwise>
								</c:choose></td>
							</tr>
							<tr>
								<th>预览图</th>
								<td><c:choose>
									<c:when test="${empty one.picUrl}">
										N/A
									</c:when>
									<c:otherwise>
										<img src="<%=imgBasePath%>${one.picUrl}"
									height="100px" alt="图片损坏"/>
									</c:otherwise>
								</c:choose></td>
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