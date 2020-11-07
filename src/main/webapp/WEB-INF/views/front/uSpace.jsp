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
<!DOCTYPE HTML>
<html>
<head>
<title>他人个人空间</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="shortcut icon" type="image/png" href="<%=basePath%>assets/img/logo.ico" media="screen" />
<script type="application/x-javascript">
	
		
			addEventListener("load", function() {
				setTimeout(hideURLbar, 0);
			}, false);

			function hideURLbar() {
				window.scrollTo(0, 1);
			}


</script>
<!--聪明的小标题-->
<script src="<%=basePath%>assets/js/cute-title.js"></script>
<!--页面加载进度条,光线,圈圈-->
<script src="<%=basePath%>assets/lib/pace/pace-1.0.2.js"></script>
<link rel="stylesheet" href="<%=basePath%>assets/lib/pace/themes/orange/pace-theme-flash.css" />
<!-- bootstrap -->
<link href="<%=basePath%>assets/lib/bootstrap/css/bootstrap.min.css" rel='stylesheet'
	type='text/css' media="all" />
<link rel="stylesheet" href="<%=basePath%>assets/css/x-admin.css" media="all">
<link href="<%=basePath%>assets/css/dashboard.css" rel="stylesheet">
<!-- Custom Theme files -->
<link href="<%=basePath%>assets/css/style.css" rel='stylesheet' type='text/css' media="all" />
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>assets/lib/font-awesome-4.7.0/css/font-awesome.min.css">
<script src="<%=basePath%>assets/js/jquery-2.2.3.min.js"></script>

<!--回到顶部-->
<link rel="stylesheet" href="<%=basePath%>assets/lib/to-top/to-top.css" media="all">
<style>
.mine-upload {
	padding-top: 3em;
}

.mine-ul {
	width: 10%;
	position: fixed;
	border-bottom: 0px solid #e2e2e2 !important;
	top: 190px;
}

.mine-ul li {
	display: block;
}

.mine-ul li.layui-this {
	background-color: #fff;
	color: #000 !important;
}

.mine-ul li.layui-this::after {
	border-bottom: 0px solid #F7764E !important;
	border-left: 5px solid #F7764E !important;
}

.mine-container {
	width: 85%;
	margin-left: 10%;
	padding-left: 0px;
}

.mine-layui-tab-content {
	padding-left: 0px;
}



.mine-icon li a.dropdown-toggle {
	background-color: #fff !important;
	padding: 0px;
}

.mine-icon li ul.dropdown-menu {
	left: -75px;
	width: 200px;
	padding: 10px;
}

.mine-a {
	text-align: center;
	color: #fff !important;
}

.mine-icon li span.span-left {
	display: inline-block;
	width: 47%;
	text-align: left;
	padding-left: 5px;
}

.mine-icon li span.span-right {
	display: inline-block;
	width: 47%;
	text-align: right;
}

.mine-icon li i {
	margin-right: 10px;
}

.mine-a:hover {
	color: #000 !important;
}

.mine-icon li b:hover {
	color: #F7764E !important;
	cursor: pointer;
}

.mine-marked {
	background-color: #F7F7F7 !important;
	color: #B6B6B6 !important;
	cursor: default;
}

.mine-layui-tab-content .layui-form-label {
	width: 100px;
}
</style>
<!--start-smoth-scrolling-->
</head>

<body>
	<!--导航栏-->
	<%@include file="../shared/navbarPart.jsp"%>
	<div class="upload mine-upload">
		<!-- container -->
		<div class="container mine-container">
			<div class="upload-grids">
				<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
					<ul class="layui-tab-title mine-ul">
						<li class="layui-this">'TA'的信息</li>
						<li>'UP'的视频</li>
					</ul>
					<div class="layui-tab-content mine-layui-tab-content">
						<div class="upload-right layui-tab-item layui-show">
							<div class="x-body">
								<blockquote class="layui-elem-quote" style="border-left:5px solid #F7764E;">
									'TA'的信息</blockquote>
								<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
									<ul class="layui-tab-title">
										<li class="layui-this">基本信息</li>

									</ul>
									<div class="layui-tab-content mine-layui-tab-content" style="min-height: 238px;">
										<div class="layui-tab-item layui-show">
											<blockquote class="layui-elem-quote">
												<c:choose>
													<c:when test="${empty one.icon}">
														<img src="<%=basePath%>assets/img/dog.gif" class="layui-circle"
															style="width:50px;float:left">
													</c:when>
													<c:otherwise>
														<img src="<%=imgBasePath%>${one.icon}" class="layui-circle"
															style="width:50px;float:left">
													</c:otherwise>
												</c:choose>
												<dl style="margin-left:80px; color:#019688">
													<dd>
														<span>UID:</span> <span>${one.id}</span>
													</dd>
													<dd style="margin-left:0">
														<span>昵称:</span> <span>${empty one.name ? "N/A" :one.name}</span>
													</dd>
												</dl>
											</blockquote>
											<table class="layui-table" lay-skin="line">
												<tbody>
													<tr>
														<th width="150">硬币数</th>
														<td>${one.coin}</td>
													</tr>
													<tr>
														<th>性别</th>
														<td><span class="layui-btn layui-btn-normal layui-btn-mini">${empty one.sex  ? "未知" :one.sex eq 0 ?"男":"女"}</span></td>
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
														<th>联系方式</th>
														<td>${empty one.phone ? "N/A" :one.phone}</td>
													</tr>
													<tr>
														<th>住址</th>
														<td>${empty one.address ? "N/A" :one.address}</td>

													</tr>
													<tr>
														<th>个性签名</th>
														<td>${empty one.signature ? "这家话很懒，什么也没留下" :  one.signature}</td>
													</tr>
													<tr>
														<th>注册时间</th>
														<td><fmt:formatDate pattern="yyyy-MM-dd" value="${one.regTime}" /></td>
													</tr>
													<tr>
														<th>账号状态</th>
														<td><span
															class="layui-btn ${one.state eq 1 ? 'layui-btn-normal' :  'layui-btn-danger'} layui-btn-mini">
																${one.state eq 1 ? "正常" :  "锁定"} </span></td>
													</tr>
												</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="upload-right layui-tab-item">
							<div class="x-body">
								<blockquote class="layui-elem-quote" style="border-left:5px solid #F7764E;">
									'TA'已上传的视频</blockquote>
								<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
									<ul class="layui-tab-title">
										<li class="layui-this">已 'UP' 视频</li>
									</ul>
									<div class="layui-tab-content mine-layui-tab-content" style="min-height: 238px;">
										<div class="layui-tab-item layui-show">
											<div class="animated-grids">
											<c:choose>
													<c:when test="${(empty upVideoList) or (fn:length(upVideoList)<1)}">
														<blockquote class="layui-elem-quote layui-quote-nm">数据为空</blockquote>
													</c:when>
													<c:otherwise>
														<c:forEach items="${upVideoList}" var="uOne" varStatus= "uOneInfo">
															<div class="col-md-3 resent-grid recommended-grid slider-first">
																<div class="resent-grid-img recommended-grid-img zoom-container">
																	<a href="<%=basePath%>single/${uOne.id}">
																		<span class="zoom-caption"> <i class="icon-play fa fa-play"></i>
																			<p>${uOne.name }</p>
																		</span> <img src="<%=imgBasePath%>${uOne.coverUrl}" alt="图片已损坏" />
																	</a>
																	<div class="time">
																		<p>
																			<span class="glyphicon glyphicon-time" aria-hidden="true"></span>&nbsp;${uOne.durationStr}
																		</p>
																	</div>
																	<div class="${uOne.scope eq '@user'?'mark':'no-mark' }">会员专享</div>
																</div>
																<div class="resent-grid-info recommended-grid-info">
														<div class="slid-bottom-grids">
															<div class="slid-bottom-grid">
																<p class="views views-info">播放量:<fmt:formatNumber value="${uOne.hits}" pattern="###,###,###,###" /></p>
															</div>
															<div class="clearfix"></div>
														</div>
													</div>
															</div>
															${(uOneInfo.count%4 eq 0) ?'<hr>':''}
														</c:forEach>
													</c:otherwise>
												</c:choose>
												<div class="clearfix"></div>
											</div>
										</div>
										</div>

									</div>
								</div>
							</div>
						</div>
						<div class="clearfix"></div>
					</div>
				</div>

			</div>
		</div>
		<a class="to-top itop" title="回到顶部"></a>
	</div>
	<!-- footer -->
	<%@include file="../shared/footerPart.jsp"%>
	<script src="<%=basePath%>assets/lib/layui/layui.js" charset="utf-8"></script>
	<script src="<%=basePath%>assets/js/x-admin.js"></script>
	<script src="<%=basePath%>assets/lib/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="<%=basePath%>assets/lib/to-top/to-top.js" type="text/javascript" charset="utf-8"></script>

	<!-- Just to make our placeholder images work. Don't actually copy the next line! -->

	<script>
		layui
				.use(
						[ 'form', 'layedit', 'laydate' ],
						function() {
							var form = layui.form(), layer = layui.layer, layedit = layui.layedit, laydate = layui.laydate;
							//监听提交
							form.on('submit(formDemo)', function(data) {
								layer.msg(JSON.stringify(data.field));
								return false;
							});
						});
	</script>
	<script>
		var _hmt = _hmt || [];
		(function() {
			var hm = document.createElement("script");
			hm.src = "https://hm.baidu.com/hm.js?b393d153aeb26b46e9431fabaf0f6190";
			var s = document.getElementsByTagName("script")[0];
			s.parentNode.insertBefore(hm, s);
		})();
	</script>
</body>

</html>