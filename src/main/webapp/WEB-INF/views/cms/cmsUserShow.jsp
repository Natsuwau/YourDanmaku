<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/fn.tld" prefix="fn"%>
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
<link rel="stylesheet" href="<%=basePath%>assets/lib/zTree/css/metroStyle/metroStyle.css"
	media="all">
</head>
<body>
	<div class="x-body">
		<blockquote class="layui-elem-quote">
			<c:choose>
				<c:when test="${empty cmsUser.icon}">
					<img src="<%=basePath%>assets/img/dog.gif" class="layui-circle" style="width:50px;float:left">
				</c:when>
				<c:otherwise>
					<img src="<%=imgBasePath%>${cmsUser.icon}" class="layui-circle" style="width:50px;float:left"/>
				</c:otherwise>
			</c:choose>
			<dl style="margin-left:98px; color:#019688">
				<dt>
					<span>ID:</span> <span>${cmsUser.id}</span>
				</dt>
				<dd style="margin-left:0">
					<span>昵称:</span> <span>${cmsUser.name}</span>
				</dd>
			</dl>
		</blockquote>
		<div class="pd-20">
			<table class="layui-table">
				<tbody>
					<tr>
						<th width="70">账号状态</th>
						<td><span
							class="layui-btn ${cmsUser.state eq 1 ? 'layui-btn-normal' :  'layui-btn-danger'} layui-btn-mini">${cmsUser.state eq 1 ? "激活" :  "停用"}
						</span></td>
					</tr>
					<tr>
						<th>账号简介</th>
						<td>${empty cmsUser.desc ? "这家话很懒，什么也没留下" :  cmsUser.desc}</td>
					</tr>
					<tr>
						<th>拥有角色</th>
						<td><c:forEach items="${cmsUser.roles}" var="role">
								<span class="layui-btn layui-btn-mini cancle-margin"> ${role.name} </span>
							</c:forEach></td>
					</tr>
					<tr>
						<th>拥有权限</th>
						<td>
							<div class="">
								<ul id="treeDemo" class="ztree"></ul>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<script src="<%=basePath%>assets/lib/layui/layui.js" charset="utf-8" /></script>
	<script src="<%=basePath%>assets/js/x-layui.js" charset="utf-8"></script>
	<script src="<%=basePath%>assets/js/jquery.min.js" charset="utf-8"></script>
	<script src="<%=basePath%>assets/lib/zTree/js/jquery.ztree.core.min.js" charset="utf-8"></script>
	<script src="<%=basePath%>assets/lib/zTree/js/jquery.ztree.excheck.min.js" charset="utf-8"></script>
	<script type="text/javascript">
		var setting = {
			data: {
				simpleData: {
					enable: true
				}
			}
		};
		var zNodes =[
			<c:forEach items="${cmsUser.resources}" var="oneResource" varStatus="oneInfo">
			{ 
				id:"${oneResource.id}",pId:"${oneResource.upLevelId}", 
				name:"${oneResource.name}"
			}
			${oneInfo.last ? "" :","}
		</c:forEach>
		];

		$(document).ready(function(){
			$.fn.zTree.init($("#treeDemo"), setting, zNodes);
		});
		
        </script>
</body>

</html>