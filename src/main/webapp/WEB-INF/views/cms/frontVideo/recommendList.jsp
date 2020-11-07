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
		<span class="layui-breadcrumb"> <a><cite>首页</cite></a> <a><cite>前台视频管理</cite></a>
			<a><cite>推荐视频管理</cite></a>
		</span> <a class="layui-btn layui-btn-small"
			style="line-height:1.6em;margin-top:3px;float:right"
			href="javascript:location.replace(location.href);" title="刷新"><i
			class="layui-icon" style="line-height:30px">ဂ</i></a>
	</div>
	<div class="x-body">
		<form class="layui-form x-center"
			action="<%=basePath%>/cms/frontVideo/banList">
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
		<button class="layui-btn" onclick="recommend_add()">
			<i class="layui-icon">&#xe608;</i>添加推荐
		</button>
		<span class="x-right" style="line-height:40px">共有数据：${pageInfo.rootListSize}
			条</span>
		</xblock>
		<table class="layui-table">
			<thead>
				<tr >
					<th>视频名</th>
					<th>上传用户</th>
					<th>类型</th>
					<th>视频权限</th>
					<th>状态</th>
					<th>上传时间</th>
					<th>操作</th>
				</tr>
			</thead>
			<c:choose>
				<c:when
					test="${(empty pageInfo.basePageList) or (fn:length(pageInfo.basePageList)<1)}">
					<blockquote class="layui-elem-quote layui-quote-nm">推荐视频列表为空!</blockquote>
				</c:when>
				<c:otherwise>
					<tbody>
						<c:forEach items="${pageInfo.basePageList}" var="one">
							<tr title="${one.id}">
								<td>${one.name}</td>
								<td>
								<a title="查看详情" href="javascript:;"
										onclick="user_show('用户信息','<%=basePath%>/cms/frontUser/oneInfo','${one.frontUserId}','500','530')"
										style="text-decoration:none">
										${one.frontUserId}
								</a>
								</td>
								<td>${one.typeName}</td>
								<td class="td-status"><span
									class="layui-btn  layui-btn-mini">${one.scope eq "@user" ? "仅限会员" :  "所有人"}
								</span></td>
								<td><span
									class="layui-btn layui-btn-mini">
										${one.state eq 1 ? "审核通过" :  one.state eq 0 ?"待审核" :"'BAN'状态"} </span></td>
								<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${one.uploadTime}" /></td>
								<td class="td-manage">
									<a title="视频预览" href="javascript:;"
										onclick="user_show('预览','<%=basePath%>cms/frontVideo/videoShow','${one.id}','500','530')"
										style="text-decoration:none">
										<i class="layui-icon">&#xe623;</i>
									</a>
									<a title="查看详情" href="javascript:;"
										onclick="user_show('查看详情','<%=basePath%>cms/frontVideo/oneInfo','${one.id}','500','530')"
										style="text-decoration:none">
										<i class="fa fa-eye" aria-hidden="true"></i>
									</a>
									<a title="删除推荐" href="javascript:;" onclick="change_state(this,'${one.frontFavoriteId}')"
										style="text-decoration:none">
										<i class="layui-icon" >&#x1006;</i>
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
					    var url = '<%=basePath%>/cms/frontVideo/recommendList?nowPage='+nowPage;
					    var searchKey = $('#searchKey').val();
					    if(!searchKey){
					    	url+="&searchKey="+searchKey;
					    }
					    location.href=url;
				    }
			    }
			});
		});

		//查看详情
		function user_show(title, url, id, w, h) {
			var str = "?id=" + id;
			x_admin_show(title, url + str, w, h);
		}
		
		function recommend_add() {
			//prompt层
			layer.prompt({title: '输入一个视频的ID，并确认', formType: 3}, function(vid, index){
			  layer.close(index);
			  var url ="<%=basePath%>cms/frontVideo/recommendAdd";
			  $.post(url,{ "vid": vid}, function(data){
					if(data.success){
						var msg = "已添加推荐";					
						layer.alert(msg, {icon: 6},function () {
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
		
		//编辑
		function admin_edit(title, url, id, w, h) {
			var str = "?id=" + id;
			x_admin_show(title, url + str, w, h);
		}
		
		function editVideo(id) {
			var url ="<%=basePath%>cms/frontVideo/recommendDel";
			$.post(url,{ "id": id}, function(data){
				if(data.success){
					var msg = "已取消推荐";					
					layer.alert(msg, {icon: 6},function () {
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
		}
		/*状态切换*/
		function change_state(obj, id,state) {
			layer.confirm('<center>确认要取消推荐此视频伐 ?<center>',
					{btn:['确认','取消'],
				offset: '20%'
				},function(index) {
					editVideo(id);
			});
		}
		
	</script>
</body>

</html>