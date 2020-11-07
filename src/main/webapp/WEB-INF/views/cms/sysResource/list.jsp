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
<link rel="stylesheet" href="<%=basePath%>assets/lib/font-awesome-4.7.0/css/font-awesome.min.css"
	media="all">
</head>
<body>
	<div class="x-nav">
		<span class="layui-breadcrumb"> <a>
				<cite>首页</cite>
			</a> <a>
				<cite>管理员管理</cite>
			</a> <a>
				<cite>资源管理</cite>
			</a>
		</span>
		<a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right"
			href="javascript:location.replace(location.href);" title="刷新">
			<i class="layui-icon" style="line-height:30px">ဂ</i>
		</a>
	</div>
	<div class="x-body">
		<form class="layui-form x-center" action="<%=basePath%>cms/sysResource/list">
			<div class="layui-form-pane" style="margin-top: 15px;">
				<div class="layui-form-item">
					<div class="layui-input-inline">
						<input type="text" name="searchKey" id="searchKey" placeholder="搜索..." autocomplete="off" class="layui-input">
					</div>
					<div class="layui-input-inline" style="width:80px">
						<button class="layui-btn" lay-submit="" lay-filter="sreach">
							<i class="layui-icon">&#xe615;</i>
						</button>
					</div>
				</div>
			</div>
		</form>
		<xblock>
		<button class="layui-btn"
			onclick="resource_add('添加资源','<%=basePath%>/cms/sysResource/add','400','530')">
			<i class="layui-icon">&#xe608;</i>添加
		</button>
		<span class="x-right" style="line-height:40px">共有数据：${pageInfo.rootListSize}条</span></xblock>
		<table class="layui-table">
			<thead>
				<tr>
					<th>资源名</th>
					<th>类型</th>
					<th>级别</th>
					<th>访问URL</th>
					<th>权限字符串</th>
					<th>状态</th>
					<th>操作</th>
				</tr>
			</thead>
			<c:choose>
				<c:when
					test="${(empty pageInfo.basePageList) or (fn:length(pageInfo.basePageList)<1)}">
					<blockquote class="layui-elem-quote layui-quote-nm">系统资源列表为空!</blockquote>
				</c:when>
				<c:otherwise>
					<tbody id="x-link">
						<c:forEach items="${pageInfo.basePageList}" var="one">
							<tr title="资源id:${one.id}">
								<td>${one.name}</td>
								<td>
									<span class="layui-btn layui-btn-mini  layui-btn-warm">
										${one.type eq "menu" ? "菜单资源" :  one.type eq "button" ? "按钮资源" : "一般资源"}
									</span>
								</td>
								<td>
									<span class="layui-btn layui-btn-mini  layui-btn-warm">
										${one.level eq 0 ? "目录菜单" :  one.level eq 1 ? "url菜单" : "N/A"}
									</span>
								</td>
								<td>${one.url}</td>
								<td>${one.permission}</td>
								<td class="td-status">
									<span class="layui-btn ${one.state eq 1 ? 'layui-btn-normal' :  'layui-btn-danger'} layui-btn-mini">
										${one.state eq 1 ? "激活" :  "停用"}
									</span>
								</td>
								<td class="td-manage">
									<a title="编辑" href="javascript:;" onclick="resource_edit('编辑','<%=basePath%>/cms/sysResource/edit','${one.id}','400','530')"
										class="ml-5" style="text-decoration:none">
										<i class="layui-icon">&#xe642;</i>
									</a> <a title="查看详情" href="javascript:;"
										onclick="resource_show('查看详情','<%=basePath%>/cms/sysResource/oneInfo','${one.id}','500','530')"
										style="text-decoration:none">
										<i class="fa fa-eye" aria-hidden="true"></i>
									</a>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</c:otherwise>
			</c:choose>
		</table>
		<div id="page"></div>
	</div>
	<script src="<%=basePath%>assets/lib/layui/layui.js" charset="utf-8"></script>
	<script src="<%=basePath%>assets/js/x-layui.js" charset="utf-8"></script>
	<script>
		layui.use([ 'laydate', 'element', 'laypage', 'layer' ], function() {
			$ = layui.jquery;//jquery
			laydate = layui.laydate;//日期插件
			lement = layui.element();//面包导航
			laypage = layui.laypage;//分页
			layer = layui.layer;//弹出层

			//以上模块根据需要引入
			laypage({
				cont : 'page',
				pages : ${pageInfo.pageCount},
				curr : ${pageInfo.nowPage}, //当前页
				first : 1,
				last : ${pageInfo.pageCount},
				prev : '上一页',
				next : '下一页',
				jump: function(obj, first){
				    //得到了当前页，用于向服务端请求对应数据
				    if(!first){
					    var nowPage = obj.curr;//目标页
					    var url = '<%=basePath%>cms/sysResource/list?nowPage='+nowPage;
					    var searchKey = $('#searchKey').val();
					    if(!searchKey){
					    	url+="&searchKey="+searchKey;
					    }
					    location.href=url;
				    }
			    }
			});
		});

		/*添加*/
		function resource_add(title, url, w, h) {
			x_admin_show(title, url, w, h);
		}

		//查看详情
		function resource_show(title, url, id, w, h) {
			var str = "?id=" + id;
			x_admin_show(title, url + str, w, h);
		}
		//编辑
		function resource_edit(title, url, id, w, h) {
			var str = "?id=" + id;
			x_admin_show(title, url + str, w, h);
		}
	</script>
</body>
</html>