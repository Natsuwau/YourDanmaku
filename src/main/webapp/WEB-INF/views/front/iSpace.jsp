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
			+ request.getServerPort()
			+ "/data/img/";
%>
<!DOCTYPE HTML>
<html>
<head>
<title>个人空间</title>
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
<link rel="stylesheet" href="<%=basePath%>assets/lib/amazeui-cropper/css/amazeui.min.css">
<link rel="stylesheet" href="<%=basePath%>assets/lib/amazeui-cropper/css/amazeui.cropper.css">
<link rel="stylesheet" href="<%=basePath%>assets/lib/amazeui-cropper/css/custom_up_img.css">
<link href="<%=basePath%>assets/lib/bootstrap/css/bootstrap.min.css" rel='stylesheet'
	type='text/css' media="all" />
<link rel="stylesheet" href="<%=basePath%>assets/css/x-admin.css" media="all">
<link href="<%=basePath%>assets/css/dashboard.css" rel="stylesheet">
<!-- Custom Theme files -->
<link href="<%=basePath%>assets/css/style.css" rel='stylesheet' type='text/css' media="all" />

<link rel="stylesheet" type="text/css"
	href="<%=basePath%>assets/lib/font-awesome-4.7.0/css/font-awesome.min.css">

<!--回到顶部-->
<link rel="stylesheet" href="<%=basePath%>assets/lib/to-top/to-top.css" media="all">
<script src="<%=basePath%>assets/js/jquery-2.2.3.min.js"></script>
<script src="<%=basePath%>assets/lib/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
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

.views-info a{
	text-decoration: none !important;
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
						<li class="layui-this">个人信息相关</li>
						<li>已上传视频</li>
						<li>已收藏视频</li>
						<li>举报管理</li>
						<li>个性设置</li>
					</ul>
					<div class="layui-tab-content mine-layui-tab-content">
						<div class="upload-right layui-tab-item layui-show">
							<div class="x-body">
								<blockquote class="layui-elem-quote" style="border-left:5px solid #F7764E;">
									个人信息相关</blockquote>
								<div class="layui-tab layui-tab-brief" lay-filter="">
									<ul class="layui-tab-title">
										<li class="layui-this">基本信息</li>
										<li>任务中心</li>
										<li>信息修改</li>
										<li>密码修改</li>
									</ul>
									<div class="layui-tab-content mine-layui-tab-content" style="min-height: 260px;">
										<div class="layui-tab-item layui-show">
											<!--图片上传框-->
											<div class="am-modal am-modal-no-btn up-frame-bj " tabindex="-1" id="doc-modal-1">
												<div class="am-modal-dialog up-frame-parent up-frame-radius">
													<div class="am-modal-hd up-frame-header">
														<label>上传图片</label>
														<a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
													</div>
													<div class="am-modal-bd  up-frame-body">
														<div class="am-g am-fl">
															<div class="am-form-group am-form-file">
																<div class="am-fl">
																	<button type="button" class="am-btn am-btn-default am-btn-sm">
																		<i class="am-icon-cloud-upload"></i> 选择要上传的图片
																	</button>
																</div>
																<input type="file" id="inputImage">
															</div>
														</div>
														<div class="am-g am-fl">
															<div class="up-pre-before up-frame-radius">
																<img alt="" src="" id="image">
															</div>
															<div class="up-pre-after up-frame-radius"></div>
														</div>
														<div class="am-g am-fl">
															<div class="up-control-btns">
																<span class="am-icon-rotate-left" onclick="rotateimgleft()"></span> <span
																	class="am-icon-rotate-right" onclick="rotateimgright()"></span> <span
																	class="am-icon-check" id="up-btn-ok"></span>
															</div>
														</div>

													</div>
												</div>
											</div>

											<!--加载框-->
											<div class="am-modal am-modal-loading am-modal-no-btn" tabindex="-1"
												id="my-modal-loading">
												<div class="am-modal-dialog">
													<div class="am-modal-hd">正在上传...</div>
													<div class="am-modal-bd">
														<span class="am-icon-spinner am-icon-spin"></span>
													</div>
												</div>
											</div>

											<!--警告框-->
											<div class="am-modal am-modal-alert" tabindex="-1" id="my-alert">
												<div class="am-modal-dialog">
													<div class="am-modal-hd">信息</div>
													<div class="am-modal-bd" id="alert_content">成功了</div>
													<div class="am-modal-footer">
														<span class="am-modal-btn">确定</span>
													</div>
												</div>
											</div>
											<blockquote class="layui-elem-quote">
												<div class="mine-center up-img-touch" aspectRatio="1"
													uploadUrl="<%=basePath%>space/editIcon">
													<c:choose>
														<c:when test="${not empty one.icon}">
															<img src="<%=imgBasePath%>${one.icon}" class="layui-circle"
																style="border: 0px solid #A9B7B7; width:50px; float:left;" alt="头像路径无效"
																data-am-popover="{theme: 'sm', content: '点击修改', trigger: 'hover focus'}">
														</c:when>
														<c:otherwise>
															<img src="<%=basePath%>assets/img/dog.gif" class="layui-circle"
																style="border: 0px solid #A9B7B7; width:50px; float:left;" alt="头像路径无效"
																data-am-popover="{theme: 'sm', content: '点击修改', trigger: 'hover focus'}">
														</c:otherwise>
													</c:choose>
												</div>
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
														<td><span class="layui-btn layui-btn-normal layui-btn-mini">${empty one.sex  ? "未知" :one.sex eq 1 ?"男":"女"}</span></td>
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
										<div class="layui-tab-item">
											<table class="layui-table" lay-even="" lay-skin="nob">
												<colgroup>
													<col width="250">
													<col>
													<col width="90">
													<col width="90">
												</colgroup>
												<thead>
													<tr>
														<th>任务</th>
														<th>说明</th>
														<th>进度</th>
														<th>状态</th>
													</tr>
												</thead>
												<tbody>
													<c:forEach items="${taskInfoList}" var="tOne">
														<tr>
															<td>${tOne.name }</td>
															<td>${tOne.desc }</td>
															<td>${ empty tOne.frontTask.nowNum ? '0':tOne.frontTask.nowNum}/${tOne.maxNum }</td>
															<td><button
																	class="layui-btn  ${tOne.maxNum eq tOne.frontTask.nowNum  ?'' :'layui-btn-danger'}
														layui-btn-small  ">${tOne.maxNum eq tOne.frontTask.nowNum ?'已完成' :'进行中'}</button></td>
														</tr>
													</c:forEach>

												</tbody>
											</table>

										</div>
										<div class="layui-tab-item">
											<form id="editFrom" class="layui-form" action="" style="width: 60%;">
												<div class="layui-form-item">
													<label class="layui-form-label">昵称</label>
													<div class="layui-input-block">
														<input type="hidden" name="uid" value="${one.id}">
														<input type="text" name="name" required lay-verify="required" value="${one.name }"
															placeholder="取一个昵称吧" autocomplete="off" class="layui-input">
													</div>
												</div>
												<div class="layui-form-item">
													<label class="layui-form-label">性别</label>
													<div class="layui-input-block">
														<input name="sex" value="1" title="男" ${one.sex ne 2 ?'checked="check"' :''}
															type="radio">
														<input name="sex" value="2" title="女" ${one.sex eq 2 ?'checked="check"' :''}
															type="radio">

													</div>
												</div>
												<div class="layui-form-item">
													<label class="layui-form-label">生日</label>
													<div class="layui-input-block">
														<input name="birthday" id="date" lay-verify="date" placeholder="生日" autocomplete="off"
															class="layui-input" onclick="layui.laydate({elem: this})"
															value="<fmt:formatDate pattern="yyyy-MM-dd" value="${one.birthday}" />" type="text">
													</div>
												</div>
												<div class="layui-form-item">
													<label class="layui-form-label">手机号</label>
													<div class="layui-input-block">
														<input name="phone" lay-verify="phone" value="${one.phone }" autocomplete="off"
															class="layui-input" type="tel" placeholder="联系方式">
													</div>
												</div>
												<div class="layui-form-item">
													<label class="layui-form-label">邮箱</label>
													<div class="layui-input-block">
														<input name="email" lay-verify="email" value="${one.email }" autocomplete="off"
															class="layui-input" type="text" placeholder="常用邮箱">
													</div>
												</div>
												<div class="layui-form-item">
													<label class="layui-form-label">地址</label>
													<div class="layui-input-block">
														<input type="text" name="address" value="${one.address }" placeholder="地址"
															autocomplete="off" class="layui-input">
													</div>
												</div>
												<div class="layui-form-item layui-form-text">
													<label class="layui-form-label">个性签名</label>
													<div class="layui-input-block">
														<textarea name="signature" placeholder="写点什么吧" value="${one.signature }"
															class="layui-textarea"></textarea>
													</div>
												</div>
												<div class="layui-form-item">
													<div class="layui-input-block">
														<button class="layui-btn layui-btn-danger" lay-filter="editInfo" lay-submit="">
															信息更新</button>
													</div>
												</div>

												<div class="clearfix"></div>
											</form>
										</div>
										<div class="layui-tab-item">
											<form id="editPdwFrom" class="layui-form" action="" style="width: 60%;">
												<div class="layui-form-item">
													<label class="layui-form-label">旧密码</label>
													<div class="layui-input-block">
														<input type="hidden" name="uid" value="${one.id}">
														<input type="password" id="oldPassword" name="oldPassword" lay-verify="iPassword"
															placeholder="输入旧密码" autocomplete="off" class="layui-input">
													</div>
												</div>
												<div class="layui-form-item">
													<label class="layui-form-label">新密码</label>
													<div class="layui-input-block">
														<input type="password" id="newPassword" name="newPassword" lay-verify="iPassword"
															placeholder="输入新密码" autocomplete="off" class="layui-input">
													</div>
												</div>
												<div class="layui-form-item">
													<label class="layui-form-label">重输密码</label>
													<div class="layui-input-block">
														<input type="password" id="rePassword" lay-verify="rePassword" placeholder="重输新密码"
															autocomplete="off" class="layui-input">
													</div>
												</div>
												<div class="layui-form-item">
													<div class="layui-input-block">
														<button class="layui-btn layui-btn-danger" lay-filter="editPassword" lay-submit="">
															密码修改</button>
													</div>
												</div>
												<div class="clearfix"></div>
											</form>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="upload-right layui-tab-item">
							<div class="x-body">
								<blockquote class="layui-elem-quote" style="border-left:5px solid #F7764E;">
									已上传视频</blockquote>
								<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
									<ul class="layui-tab-title">
										<li class="layui-this">已 'UP' 视频</li>
										<li>已'BAN' 视频</li>
										<li>待审核视频</li>
									</ul>
									<div class="layui-tab-content mine-layui-tab-content" style="min-height: 238px;">
										<div class="layui-tab-item layui-show">
											<div class="animated-grids">
												<c:choose>
													<c:when test="${(empty upVideoList) or (fn:length(upVideoList)<1)}">
														<blockquote class="layui-elem-quote layui-quote-nm">数据为空</blockquote>
													</c:when>
													<c:otherwise>
														<c:forEach items="${upVideoList}" var="uOne" varStatus="uOneInfo">
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
																			<p class="views views-info">
																				<a
																					onclick="video_show('预览','<%=basePath%>space/videoShow','${uOne.id}','500','530')"
																					href="javascript:;">预览</a>
																				|
																				<a
																					onclick="video_show('查看详情','<%=basePath%>space/videoInfo','${uOne.id}','500','530')"
																					href="javascript:;">详情</a>
																				|
																				<a
																					onclick="video_show('视频信息修改','<%=basePath%>space/videoEdit','${uOne.id}','500','530')"
																					href="javascript:;">修改</a>
																			</p>
																		</div>
																		<div class="slid-bottom-grid slid-bottom-right">
																			<p class="views views-info">
																				<a onclick="changeState('${sessionUser.id}','${uOne.id}',-1,'确定要取消UP吗?');"
																					href="javascript:;">取消UP</a>
																			</p>
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
										<div class="layui-tab-item">
											<div class="animated-grids">
												<c:choose>
													<c:when test="${(empty banVideoList) or (fn:length(banVideoList)<1)}">
														<blockquote class="layui-elem-quote layui-quote-nm">数据为空</blockquote>
													</c:when>
													<c:otherwise>
														<c:forEach items="${banVideoList}" var="bOne" varStatus="bOneInfo">
															<div class="col-md-3 resent-grid recommended-grid slider-first">
																<div class="resent-grid-img recommended-grid-img zoom-container">
																	<a href="<%=basePath%>single/${bOne.id}">
																		<span class="zoom-caption"> <i class="icon-play fa fa-play"></i>
																			<p>${bOne.name }</p>
																		</span> <img src="<%=imgBasePath%>${bOne.coverUrl}" alt="图片已损坏" />
																	</a>
																	<div class="time">
																		<p>
																			<span class="glyphicon glyphicon-time" aria-hidden="true"></span>&nbsp;${bOne.durationStr}
																		</p>
																	</div>
																	<div class="${bOne.scope eq '@user'?'mark':'no-mark' }">会员专享</div>
																</div>
																<div class="resent-grid-info recommended-grid-info">
																	<div class="slid-bottom-grids">
																		<div class="slid-bottom-grid">
																			<p class="views views-info">
																				<a
																					onclick="video_show('预览','<%=basePath%>space/videoShow','${bOne.id}','500','530')"
																					href="javascript:;">预览</a>
																				|
																				<a
																					onclick="video_show('查看详情','<%=basePath%>space/videoInfo','${bOne.id}','500','530')"
																					href="javascript:;">详情</a>
																				|
																				<a
																					onclick="video_show('视频信息修改','<%=basePath%>space/videoEdit','${bOne.id}','500','530')"
																					href="javascript:;">修改</a>
																			</p>
																		</div>
																		<div class="slid-bottom-grid slid-bottom-right">
																			<p class="views views-info">
																				<a onclick="changeState('${sessionUser.id}','${bOne.id}',0,'确定要重新UP吗?');"
																					href="javascript:;">重新'UP'视频</a>
																			</p>
																		</div>
																		<div class="clearfix"></div>
																	</div>
																</div>
															</div>
															${(bOneInfo.count%4 eq 0) ?'<hr>':''}
														</c:forEach>
													</c:otherwise>
												</c:choose>
												<div class="clearfix"></div>
											</div>
										</div>
										<div class="layui-tab-item">
											<div class="animated-grids">
												<c:choose>
													<c:when test="${(empty checkVideoList) or (fn:length(checkVideoList)<1)}">
														<blockquote class="layui-elem-quote layui-quote-nm">数据为空</blockquote>
													</c:when>
													<c:otherwise>
														<c:forEach items="${checkVideoList}" var="cOne" varStatus="cOneInfo">
															<div class="col-md-3 resent-grid recommended-grid slider-first">
																<div class="resent-grid-img recommended-grid-img zoom-container">
																	<a href="<%=basePath%>single/${cOne.id}">
																		<span class="zoom-caption"> <i class="icon-play fa fa-play"></i>
																			<p>${cOne.name }</p>
																		</span> <img src="<%=imgBasePath%>${cOne.coverUrl}" alt="图片已损坏" />
																	</a>
																	<div class="time">
																		<p>
																			<span class="glyphicon glyphicon-time" aria-hidden="true"></span>&nbsp;${cOne.durationStr}
																		</p>
																	</div>
																	<div class="${cOne.scope eq '@user'?'mark':'no-mark' }">会员专享</div>
																</div>
																<div class="resent-grid-info recommended-grid-info">
																	<div class="slid-bottom-grids">
																		<div class="slid-bottom-grid">
																			<p class="views views-info">
																				<a
																					onclick="video_show('预览','<%=basePath%>space/videoShow','${cOne.id}','500','530')"
																					href="javascript:;">预览</a>
																				|
																				<a
																					onclick="video_show('查看详情','<%=basePath%>space/videoInfo','${cOne.id}','500','530')"
																					href="javascript:;">详情</a>
																			</p>
																		</div>
																		<div class="clearfix"></div>
																	</div>
																</div>
															</div>
															${(cOneInfo.count%4 eq 0) ?'<hr>':''}
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
						<div class="upload-right layui-tab-item">
							<div class="x-body">
								<blockquote class="layui-elem-quote" style="border-left:5px solid #F7764E;">
									已收藏视频</blockquote>
								<div class="animated-grids " style="min-height: 238px;">
									<div class="col-md-3 resent-grid recommended-grid slider-first">
										<div class="resent-grid-img recommended-grid-img zoom-container">
											<a href="single.html">
												<span class="zoom-caption"> <i class="icon-play fa fa-play"></i>
													<p>冰雪奇缘10086</p>
												</span> <img src="<%=basePath%>assets/temp/images/bilibili/5.jpg" alt="" />
											</a>
											<div class="time">
												<p>
													<span class="glyphicon glyphicon-time" aria-hidden="true"></span> 14:01
												</p>
											</div>
										</div>
										<div class="resent-grid-info recommended-grid-info">
											<div class="slid-bottom-grids">
												<div class="slid-bottom-grid">
													<p class="author author-info">
														<a href="#" class="author">John Maniya</a>
													</p>
												</div>
												<div class="slid-bottom-grid slid-bottom-right">
													<p class="views views-info">取消收藏</p>
												</div>
												<div class="clearfix"></div>
											</div>
										</div>
									</div>
									<div class="clearfix"></div>
								</div>
							</div>
						</div>
						<div class="upload-right layui-tab-item">
							<div class="x-body">
								<blockquote class="layui-elem-quote" style="border-left:5px solid #F7764E;">
									举报管理</blockquote>
								<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
									<ul class="layui-tab-title">
										<li class="layui-this">已验证举报</li>
										<li>待审核举报</li>
										<li>未通过举报</li>
									</ul>
									<div class="layui-tab-content mine-layui-tab-content" style="min-height: 238px;">
										<div class="layui-tab-item layui-show">内容不一样是要有，因为你可以监听tab事件（阅读下文档就是了）</div>
										<div class="layui-tab-item">内容2</div>
										<div class="layui-tab-item">内容3</div>
									</div>
								</div>
							</div>
						</div>
						<div class="upload-right layui-tab-item">
							<div class="x-body">
								<blockquote class="layui-elem-quote" style="border-left:5px solid #F7764E;">
									个性设置</blockquote>
								<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
									<ul class="layui-tab-title">
										<li class="layui-this">视频相关</li>
										<li>其他</li>
									</ul>
									<div class="layui-tab-content mine-layui-tab-content" style="min-height: 238px;">
										<div class="layui-tab-item layui-show">内容不一样是要有，因为你可以监听tab事件（阅读下文档就是了）</div>
										<div class="layui-tab-item">内容2</div>
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
	<%@include file="../shared/footerPart.jsp"%>
	<script src="<%=basePath%>assets/lib/amazeui-cropper/js/jquery-1.8.3.min.js"></script>
	<script src="<%=basePath%>assets/lib/amazeui-cropper/js/amazeui.min.js" charset="utf-8"></script>
		<script src="<%=basePath%>assets/lib/amazeui-cropper/js/cropper.min.js" charset="utf-8"></script>
		<script src="<%=basePath%>assets/lib/amazeui-cropper/js/custom_up_img_pro.js" charset="utf-8"></script>
	<script src="<%=basePath%>assets/lib/layui/layui.js" charset="utf-8"></script>
	<script src="<%=basePath%>assets/js/x-admin.js"></script>
	<script src="<%=basePath%>assets/js/x-layui.js"></script>
	
	
	<script src="<%=basePath%>assets/lib/to-top/to-top.js" type="text/javascript" charset="utf-8"></script>
	
	<!-- Just to make our placeholder images work. Don't actually copy the next line! -->

	<script>
layui.use([ 'form', 'layedit', 'laydate' ,'layer'],
		function() {
			var form = layui.form(), 
			layer = layui.layer,
			layedit = layui.layedit,
			laydate = layui.laydate;
			layer = layui.layer; //弹出层
			form.verify({
                iPassword:function(value){
               	if(value.length<4 || value.length>16){
	                    return '密码长度限制4-16位!';
	             }
	            },
	            rePassword: function(value){
					  var newPass= $('#L_newpass').val();
					  var rePass= $('#L_repass').val();
	                  if(rePass != newPass){
	                    return '两次密码输入不一致!';
	                 }
               	}
             });
			//监听修改密码提交
			form.on('submit(editPassword)', function(formData) {
				var url = "<%=basePath%>space/${one.id}"+"/editPassword";
				var data = formData.field;
				var offset = "50%";
				var result = mineAjax(url,data,offset,false);
				if('true' == result){
					$('#editPdwFrom')[0].reset();
				}
				return false;
			});
			//监听修改信息提交
			form.on('submit(editInfo)', function(formData) {
				var url = "<%=basePath%>space/${one.id}"+"/edit";
				var data = formData.field;
				var offset = "50%";
				var result = mineAjax(url,data,offset,false);
				if('true' == result){
					$('#editFrom')[0].reset();
				}
				return false;
			});
		});
		function one(uid,vid,state) {
			var url ="<%=basePath%>space/${sessionUser.id}/changeVideoState";
			$.post(url,{ "uid": uid,
				 		 "vid": vid,
						 "state":state},
			 function(data){
				if(data.success){
					layer.alert("操作成功!", {offset: '40%',icon: 6},function () {
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
		//修改视频状态
		function changeState(uid,vid,state,msg) {
			layer.confirm('<center>'+msg+'<center>',
					{btn:['确认','取消'],
				offset: '35%'
				},function(index) {
				one(uid,vid,state);	
			});
		}
		//查看详情
		function video_show(title, url, id, w, h) {
			var str = "?id=" + id;
			x_admin_show(title, url + str, w, h);
		}
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