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
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="format-detection" content="telephone=no">
<link rel="stylesheet" href="<%=basePath%>assets/css/x-admin.css"
	media="all">
<link rel="stylesheet" href="<%=basePath%>assets/lib/font-awesome-4.7.0/css/font-awesome.min.css" media="all">
</head>

<body>
	<div class="x-nav">
		<span class="layui-breadcrumb"> <a><cite>首页</cite></a> <a><cite>管理员管理</cite></a>
			<a><cite>系统用户列表</cite></a>
		</span> <a class="layui-btn layui-btn-small"
			style="line-height:1.6em;margin-top:3px;float:right"
			href="javascript:location.replace(location.href);" title="刷新"><i
			class="layui-icon" style="line-height:30px">ဂ</i></a>
	</div>
	<div class="x-body">
		<form class="layui-form x-center"
			action="<%=basePath%>/cms/sysUser/list">
			<div class="layui-form-pane" style="margin-top: 15px;">
				<div class="layui-form-item">
					<div class="layui-input-inline">
						<input type="text" id="searchKey" name="searchKey" placeholder="搜索..."
							autocomplete="off" class="layui-input">
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
			onclick="admin_add('添加用户','<%=basePath%>cms/sysUser/add','500','450')">
			<i class="layui-icon">&#xe608;</i>添加
		</button>
		<span class="x-right" style="line-height:40px">共有数据：${pageInfo.rootListSize}
			条</span></xblock>
		<table class="layui-table">
			<thead>
				<tr>
					<th>ID</th>
					<th>登录名</th>
					<th>头像</th>
					<th>拥有角色</th>
					<th>描述</th>
					<th>状态</th>
					<th>操作</th>
				</tr>
			</thead>
			<c:choose>
				<c:when
					test="${(empty pageInfo.basePageList) or (fn:length(pageInfo.basePageList)<1)}">
					<blockquote class="layui-elem-quote layui-quote-nm">系统用户列表为空!</blockquote>
				</c:when>
				<c:otherwise>
					<tbody>
						<c:forEach items="${pageInfo.basePageList}" var="one">
							<tr>
								<td>${one.id}</td>
								<td>${one.name}</td>
								<td>
								<c:choose>
									<c:when test="${empty one.icon}">
										<img src="<%=basePath%>assets/img/dog.gif"
									height="35px" alt="默认头像" title="默认头像" />
									</c:when>
									<c:otherwise>
										<img src="<%=imgBasePath%>${one.icon}"
										height="35px" alt="头像" title="头像" />
									</c:otherwise>
								</c:choose>
								</td>
								<td>
								<c:choose>
									<c:when test="${'admin' eq one.id}">
										<span class="layui-btn layui-btn-primary layui-btn-mini cancle-margin">
											拥有全部角色
										 </span>
									</c:when>
									<c:otherwise>
										<c:forEach items="${one.roles}" var="role">
										<span class="layui-btn layui-btn-mini cancle-margin">
											${role.name} </span>
										</c:forEach>
									</c:otherwise>
								</c:choose>
								</td>
								<td>${one.desc}</td>
								<td class="td-status"><span
									class="layui-btn ${one.state eq 1 ? 'layui-btn-normal' :  'layui-btn-danger'} layui-btn-mini">${one.state eq 1 ? "激活" :  "停用"}
								</span></td>
								<td class="td-manage">
									<a title="编辑" href="javascript:;"
										onclick="admin_edit('编辑','<%=basePath%>cms/sysUser/edit','${one.id}','500','450')"
										class="ml-5" style="text-decoration:none"> <i
											class="layui-icon">&#xe642;</i>
									</a> 
									
									<a title="修改所属角色" href="javascript:;" onclick="edit_roles('修改所属角色','${one.id}','500','450')"
										style="text-decoration:none">
										<i class="fa fa-user-secret " aria-hidden="true"></i>
									</a>
									<a title="重置密码" href="javascript:;" onclick="password_reset(this,'${one.id}')"
										style="text-decoration:none">
										<i class="fa fa-minus-square-o" aria-hidden="true"></i> 
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
			$ = layui.jquery; //jquery
			laydate = layui.laydate; //日期插件
			lement = layui.element(); //面包导航
			laypage = layui.laypage; //分页
			layer = layui.layer; //弹出层

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
					    var url = '<%=basePath%>cms/sysUser/list?nowPage='+nowPage;
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
		function admin_add(title, url, w, h) {
			x_admin_show(title, url, w, h);
		}
		//编辑
		function admin_edit(title, url, id, w, h) {
			var str = "?id=" + id;
			x_admin_show(title, url + str, w, h);
		}
		
		//修改角色页面
		function edit_roles(title, id, w, h) {
			var url="<%=basePath%>cms/sysUser/editRoles";
			var str = "?id=" + id;
			x_admin_show(title, url + str, w, h);
		}
		/*密码重置*/
		function password_reset(obj, id) {
			layer.confirm('确认要重置密码吗？', function(index) {
				var url ="<%=basePath%>cms/sysUser/resetPassword";
				$.get(url,{ id: id}, function(data){
					if(data.success){
						layer.alert("重置密码成功!", {icon: 6},function () {
							location.replace(location.href);
		                });
					}else{
						layer.msg(data.msg, {
							offset: '35%',
							anim: 6,
							icon: 5,
						});	
					}
				},"JSON");
			});
		}
	</script>
</body>
</html>