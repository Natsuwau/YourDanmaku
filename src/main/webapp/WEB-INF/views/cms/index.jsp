<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/fn.tld" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/shiro.tld" prefix="shiro" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String imgBasePath = request.getScheme() + "://"
		+ request.getServerName() + ":" + request.getServerPort()
		+ "/data/img/";
%>
<!DOCTYPE html>
<html lang="zh-CN">
	<head>
		<meta charset="utf-8">
		<title>
			Hi,Danmaku!-CMS
		</title>
		<meta name="renderer" content="webkit">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		<link rel="shortcut icon" type="image/png" href="<%=basePath%>assets/img/logo-cms.ico" media="screen" />
		<!--聪明的小标题-->
		<script src="<%=basePath%>assets/js/cute-title.js"></script>
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="format-detection" content="telephone=no">
		<link rel="stylesheet" href="<%=basePath%>assets/css/x-admin.css" media="all">
		<style>
			.mine-class{
				background-color: #FFFFFF; 
				color:#333!important;
			}
			.mine-class:hover{
				background-color: #f2f2f2;
			}
		</style>
	</head>

	<body>
		<div class="layui-layout layui-layout-admin">
			<div class="layui-header header header-demo">
				<div class="layui-main">
					<a class="logo" href="#">
						<i class="layui-icon" style="font-size: 35px; color: #FF5722;">&#xe62e;</i>
						<span style="font-family: 'sans-serif';">Hi,Danmaku! - CMS</span>
					</a>
					<ul class="layui-nav" lay-filter="">
						<li class="layui-nav-item" title="${cmsUser.desc}">
						<c:choose>
							<c:when test="${empty cmsUser.icon}">
								<img src="<%=basePath%>assets/img/dog.gif" class="layui-circle" style="border: 2px solid #A9B7B7;" height="35px" alt="">
							</c:when>
							<c:otherwise>
								<img src="<%=imgBasePath%>${cmsUser.icon}" class="layui-circle" style="border: 2px solid #A9B7B7;" height="35px" alt="">
							</c:otherwise>
						</c:choose>
						</li>
						<li class="layui-nav-item">
							<a href="javascript:;" >${cmsUser.name}</a>
							<dl class="layui-nav-child">
								<!-- 二级菜单 -->
								<dd>
									<a  class="mine-class" href="javascript:member_show('个人信息','<%=basePath%>cms/u','10001','360','420');" >
									个人信息
									</a>
								</dd>
								<dd>
									<a  class="mine-class" href="javascript:member_edit('信息修改','<%=basePath%>cms/u/edit','4','1100','600');" >
									信息修改
									</a>
								</dd>
								<dd>
									<a  class="mine-class" href="javascript:member_password('修改密码','<%=basePath%>cms/u/editPWD','10001','500','400');" >
									修改密码
									</a>
								</dd>
							</dl>
						</li>
						<!-- <li class="layui-nav-item">
                        <a href="" title="消息">
                            <i class="layui-icon" style="top: 1px;">&#xe63a;</i>
                        </a>
                        </li> -->
						<li class="layui-nav-item x-index">
							<a href="./logout">注销</a>
						</li>
					</ul>
				</div>
			</div>
			<div class="layui-side layui-bg-black x-side">
				<div class="layui-side-scroll">
					<ul class="layui-nav layui-nav-tree site-demo-nav" lay-filter="side">
						<li class="layui-nav-item">
							<a class="javascript:;" href="javascript:;">
								<i class="layui-icon" style="top: 3px;">&#xe607;</i><cite>可行性测试</cite>
							</a>
							<dl class="layui-nav-child">
								<dd class="">
									<dd class="">
										<a href="javascript:;" _href="<%=basePath%>test/update">
											<cite>上传测试</cite>
										</a>
									</dd>
								</dd>
								<dd class="">
									<dd class="">
										<a href="javascript:;" _href="./zTree-demo.html">
											<cite>树形图demo</cite>
										</a>
									</dd>
								</dd>
							</dl>
						</li>
						<shiro:hasPermission name="admin:all">  
						<li class="layui-nav-item">
							<a class="javascript:;" href="javascript:;">
								<i class="layui-icon" style="top: 3px;">&#xe650;</i><cite>管理员管理</cite>
							</a>
							<dl class="layui-nav-child">
							    <shiro:hasPermission name="sysUser:list">  
							    <dd class="">
									<a href="javascript:;" _href="<%=basePath%>cms/sysUser/list">
										<cite>系统用户管理</cite>
									</a>
								</dd>
    							</shiro:hasPermission>   
								
								<shiro:hasPermission name="sysRole:list">  
							    <dd class="">
									<a href="javascript:;" _href="<%=basePath%>cms/sysRole/list">
										<cite>系统角色管理</cite>
									</a>
								</dd>
    							</shiro:hasPermission>   
								<shiro:hasPermission name="sysResource:list"> 
								<dd class="">
									<a href="javascript:;" _href="<%=basePath%>cms/sysResource/list">
										<cite>系统资源管理</cite>
									</a>
								</dd>
								</shiro:hasPermission>
							</dl>
						</li>
						</shiro:hasPermission>
						<shiro:hasPermission name="frontUser:all">  
						<li class="layui-nav-item">
							<a class="javascript:;" href="javascript:;">
								<i class="layui-icon" style="top: 3px;">&#xe612;</i><cite>会员相关</cite>
							</a>
							<dl class="layui-nav-child">
							<shiro:hasPermission name="frontUser:list">  
								<dd class="">
									<a href="javascript:;" _href="<%=basePath%>cms/frontUser/list">
										<cite>会员管理</cite>
									</a>
								</dd>
								</shiro:hasPermission>
								<dd class="">
									<a href="javascript:;" _href="<%=basePath%>pages/notFinish">
										<cite>任务管理</cite>
									</a>
								</dd>
								<dd class="">
									<a href="javascript:;" _href="<%=basePath%>pages/notFinish">
										<cite>硬币变更记录</cite>
									</a>
								</dd>
								<dd class="">
									<a href="javascript:;" _href="<%=basePath%>pages/notFinish">
										<cite>登录/登出记录</cite>
									</a>
								</dd>
							</dl>
						</li>
						</shiro:hasPermission>
						<shiro:hasPermission name="frontVideo:all">  
						<li class="layui-nav-item">
							<a class="javascript:;" href="javascript:;">
								<i class="layui-icon" style="top: 3px;">&#xe623;</i><cite>视频管理</cite>
							</a>
							<dl class="layui-nav-child">
							<shiro:hasPermission name="frontVideo:checkList">  
								<dd class="">
									<a href="javascript:;" _href="<%=basePath%>cms/frontVideo/checkList">
										<cite>待审核列表</cite>
									</a>
								</dd>
								</shiro:hasPermission>
								<shiro:hasPermission name="frontVideo:passList">  
								<dd class="">
									<a href="javascript:;" _href="<%=basePath%>cms/frontVideo/passList">
										<cite>已 'UP' 列表</cite>
									</a>
								</dd>
								</shiro:hasPermission>
								<shiro:hasPermission name="frontVideo:banList">  
								<dd class="">
									<a href="javascript:;" _href="<%=basePath%>cms/frontVideo/banList">
										<cite>已 'Ban' 列表</cite>
									</a>
								</dd>
								</shiro:hasPermission>
								<dd class="">
									<a href="javascript:;" _href="<%=basePath%>pages/notFinish">
										<cite>申述列表</cite>
									</a>
								</dd>
								<shiro:hasPermission name="frontVideo:recommendList">  
								<dd class="">
									<a href="javascript:;" _href="<%=basePath%>cms/frontVideo/recommendList">
										<cite>推荐视频管理</cite>
									</a>
								</dd>
								</shiro:hasPermission>
							</dl>
						</li>
						</shiro:hasPermission>
						<shiro:hasPermission name="frontDanmaku:list">  
						<li class="layui-nav-item">
							<a class="javascript:;"  href="javascript:;" _href="<%=basePath%>cms/frontDanmaku/list">
								<i class="layui-icon" style="top: 3px;">&#xe63c;</i><cite>弹幕管理</cite>
							</a>
						</li>
						</shiro:hasPermission>
						<shiro:hasPermission name="frontComment:list">  
						<li class="layui-nav-item">
							<a class="javascript:;" href="javascript:;"  _href="<%=basePath%>cms/frontComment/list">
								<i class="layui-icon" style="top: 3px;">&#xe606;</i><cite>评论管理</cite>
							</a>
						</li>
						</shiro:hasPermission>
						<li class="layui-nav-item">
							<a href="javascript:;" _href="<%=basePath%>pages/notFinish">
								<i class="layui-icon" style="top: 3px;">&#xe64d;</i><cite>举报管理</cite>
							</a>
						</li>
						<shiro:hasPermission name="system:all">  
						<li class="layui-nav-item">
							<a class="javascript:;" href="javascript:;">
								<i class="layui-icon" style="top: 3px;">&#xe631;</i><cite>系统相关</cite>
							</a>
							<dl class="layui-nav-child">
								<dd class="">
									<a href="javascript:;" _href="<%=basePath%>pages/notFinish">
										<cite>系统设置</cite>
									</a>
								</dd>
								<shiro:hasPermission name="frontHateWord:list">  
								<dd class="">
									<a href="javascript:;" _href="<%=basePath%>cms/frontHateWord/list">
										<cite>屏蔽词管理</cite>
									</a>
								</dd>
								</shiro:hasPermission>
								<dd class="">
									<a href="javascript:;" _href="<%=basePath%>pages/notFinish">
										<cite>遗留文件管理</cite>
									</a>
								</dd>
							</dl>
						</li>
						</shiro:hasPermission>
						<li class="layui-nav-item">
							<a href="javascript:;" _href="<%=basePath%>pages/notFinish">
								<i class="layui-icon" style="top: 3px;">&#xe60b;</i><cite>关于</cite>
							</a>
						</li>
					</ul>
				</div>
			</div>
			<div class="layui-tab layui-tab-card site-demo-title x-main" lay-filter="x-tab" lay-allowclose="true">
				<div class="x-slide_left"></div>
				<ul class="layui-tab-title">
					<li class="layui-this">
						欢迎页
						<i class="layui-icon layui-unselect layui-tab-close">ဆ</i>
					</li>
				</ul>
				<div class="layui-tab-content site-demo site-demo-body">
					<div class="layui-tab-item layui-show">
						<iframe frameborder="0" src="./welcome" class="x-iframe"></iframe>
					</div>
				</div>
			</div>
			<div class="site-mobile-shade">
			</div>
		</div>
		<script src="<%=basePath%>assets/lib/layui/layui.js" charset="utf-8"></script>
		<script src="<%=basePath%>assets/js/x-admin.js" charset="utf-8"></script>
		<script src="<%=basePath%>assets/js/x-layui.js" charset="utf-8"></script>
		<script>
			layui.use(['laydate', 'element', 'laypage', 'layer'], function() {
				$ = layui.jquery; //jquery
				laydate = layui.laydate; //日期插件
				lement = layui.element(); //面包导航
				layer = layui.layer; //弹出层
			});
			/*密码-修改*/
			function member_password(title, url, id, w, h) {
				x_admin_show(title, url, w, h);
			}
			/*用户-查看*/
			function member_show(title, url, id, w, h) {
				x_admin_show(title, url, w, h);
			}
			// 用户-编辑
			function member_edit(title, url, id, w, h) {
				x_admin_show(title, url, w, h);
			}
		</script>
	</body>

</html>