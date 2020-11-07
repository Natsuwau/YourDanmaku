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
				<cite>角色管理</cite>
			</a>
		</span>
		<a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right"
			href="javascript:location.replace(location.href);" title="刷新">
			<i class="layui-icon" style="line-height:30px">ဂ</i>
		</a>
	</div>
	<div class="x-body">
		<form class="layui-form x-center" action="<%=basePath%>cms/sysRole/list">
			<div class="layui-form-pane" style="margin-top: 15px;">
				<div class="layui-form-item">
					<div class="layui-input-inline">
						<input type="text" id="searchKey" name="searchKey" placeholder="搜索..." autocomplete="off" class="layui-input">
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
		<button class="layui-btn" onclick="role_add('添加角色','<%=basePath%>cms/sysRole/add','400','400')">
			<i class="layui-icon">&#xe608;</i>添加
		</button>
		<span class="x-right" style="line-height:40px">共有数据：${pageInfo.rootListSize}
			条</span></xblock>
		<table class="layui-table">
			<thead>
				<tr>
					<th>角色名</th>
					<th>描述</th>
					<th>状态</th>
					<th>操作</th>
				</tr>
			</thead>
			<c:choose>
				<c:when test="${(empty pageInfo.basePageList) or (fn:length(pageInfo.basePageList)<1)}">
					<blockquote class="layui-elem-quote layui-quote-nm">系统角色列表为空!</blockquote>
				</c:when>
				<c:otherwise>
					<tbody>
						<c:forEach items="${pageInfo.basePageList}" var="one">
							<tr title="角色id:${one.id}">
								<td>${one.name}</td>
								<td>${one.desc}</td>
								<td class="td-status"><span
									class="layui-btn ${one.state eq 1 ? 'layui-btn-normal' :  'layui-btn-danger'} layui-btn-mini">${one.state eq 1 ? "激活" :  "停用"}
								</span>
								</td>
								<td class="td-manage"><a title="编辑" href="javascript:;"
									onclick="role_edit('编辑','<%=basePath%>cms/sysRole/edit','${one.id}','400','450')"
									class="ml-5" style="text-decoration:none">
									<i class="layui-icon">&#xe642;</i>
									</a> <a title="编辑所拥有资源" href="javascript:;"
										onclick="role_editResources('修改拥有资源','<%=basePath%>cms/sysRole/editResources','${one.id}','400','510')"
										class="ml-5" style="text-decoration:none">
										<i class="fa fa-sitemap" aria-hidden="true"></i>
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
					    var url = '<%=basePath%>cms/sysRole/list?nowPage='+nowPage;
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
		function role_add(title, url, w, h) {
			x_admin_show(title, url, w, h);
		}

		//编辑
		function role_edit(title, url, id, w, h) {
			var str = "?id=" + id;
			x_admin_show(title, url + str, w, h);
		}
		//编辑拥有资源
		function role_editResources(title, url, id, w, h) {
			var str = "?id=" + id;
			x_admin_show(title, url + str, w, h);
		}
		/*删除*/
		function role_del(obj, id) {
			layer.confirm('确认要删除吗？', function(index) {
				//发异步删除数据
				$(obj).parents("tr").remove();
				layer.msg('已删除!', {
					icon : 1,
					time : 1000
				});
			});
		}
	</script>
</body>
</html>