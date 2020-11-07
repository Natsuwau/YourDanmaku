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
<title>Hi,Danmaku! - 主页</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="application/x-javascript">
			addEventListener("load", function() {
				setTimeout(hideURLbar, 0);
			}, false);

			function hideURLbar() {
				window.scrollTo(0, 1);
			}
</script>
<link rel="shortcut icon" type="image/png" href="<%=basePath%>assets/img/logo.ico" media="screen" />
<!--页面加载进度条,光线,圈圈-->
<script src="<%=basePath%>assets/lib/pace/pace-1.0.2.js"></script>
<link rel="stylesheet" href="<%=basePath%>assets/lib/pace/themes/orange/pace-theme-flash.css" />
<!--聪明的小标题-->
<script src="<%=basePath%>assets/js/cute-title.js"></script>
<link href="<%=basePath%>assets/lib/bootstrap/css/bootstrap.min.css" rel='stylesheet' type='text/css'
	media="all" />
<link rel="stylesheet" href="<%=basePath%>assets/css/x-admin.css" media="all">
<link href="<%=basePath%>assets/css/dashboard.css" rel="stylesheet">
<link href="<%=basePath%>assets/css/style.css" rel='stylesheet' type='text/css' media="all" />
<script src="<%=basePath%>assets/js/jquery-2.2.3.min.js"></script>
<link href="<%=basePath%>assets/lib/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet"
	type="text/css">
<!--回到顶部-->
<link rel="stylesheet" href="<%=basePath%>assets/lib/to-top/to-top.css" media="all">
</head>

<body>
    <!--导航栏-->
	<%@include file="../shared/navbarPart.jsp"%>
	<!--侧面列表-->
	<%@include file="../shared/menuPart.jsp"%>
	<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
		<div class="main-grids">
			<div class="top-grids">
				<div class="recommended-info">
					<h3>
						推荐
						<a class="btn mine-more" href="<%=basePath%>cms/login">更多 »</a>
					</h3>
				</div>
				<c:choose>
				<c:when test="${(empty recommendList) or (fn:length(recommendList)<1)}">
					<blockquote class="layui-elem-quote layui-quote-nm">推荐为空</blockquote>
				</c:when>
				<c:otherwise>
				<c:forEach items="${recommendList}" var="cOne">
				<div class="col-md-4 resent-grid recommended-grid slider-top-grids">
					<div class="resent-grid-img recommended-grid-img zoom-container">
						<a href="<%=basePath%>single/12345">
							<span class="zoom-caption"> <i class="icon-play fa fa-play"></i>
								<p>${cOne.name}</p>
							</span> <img src="<%=imgBasePath%>${cOne.coverUrl}" alt="图片已损坏" />
						</a>
						<div class="time">
							<p>
								<span class="glyphicon glyphicon-time" aria-hidden="true"></span> ${cOne.durationStr}
							</p>
						</div>
						<div class="${cOne.scope eq '@user'?'mark':'no-mark' }">会员专享</div>
					</div>
					<div class="resent-grid-info recommended-grid-info">
						<div class="slid-bottom-grids">
							<div class="slid-bottom-grid">
								<p class="author author-info">
									<a href="<%=basePath%>space/${cOne.frontUserId}" class="author">${cOne.frontUserId}</a>
								</p>
							</div>
							<div class="slid-bottom-grid slid-bottom-right">
								<p class="views views-info">播放: <fmt:formatNumber value="${cOne.hits}" pattern="###,###,###,###"/> <br/></p>
							</div>
							<div class="clearfix"></div>
						</div>
					</div>
				</div>
				</c:forEach>
				</c:otherwise>
				</c:choose>
				
				<div class="col-md-4 resent-grid recommended-grid slider-top-grids">
					<div class="resent-grid-img recommended-grid-img zoom-container ">
						<a href="single.html">
							<span class="zoom-caption"> <i class="icon-play fa fa-play"></i>
								<p>我是歌手</p>
							</span> <img src="<%=basePath%>assets/temp/images/bilibili/10.jpg" alt="" />
							<div class="time">
								<p>
									<span class="glyphicon glyphicon-time" aria-hidden="true"></span> 7:23
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
								<p class="views views-info">播放: 14,200</p>
							</div>
							<div class="clearfix"></div>
						</div>
					</div>
				</div>
				<div class="col-md-4 resent-grid recommended-grid slider-top-grids">
					<div class="resent-grid-img recommended-grid-img zoom-container">
						<a href="single.html">
							<span class="zoom-caption"> <i class="icon-play fa fa-play"></i>
								<p>大佬，很高冷</p>
							</span> <img src="<%=basePath%>assets/temp/images/bilibili/x1.jpg" alt="" />
						</a>
						<div class="time">
							<p>
								<span class="glyphicon glyphicon-time" aria-hidden="true"></span> 4:04
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
								<p class="views views-info">播放: 14,200</p>
							</div>
							<div class="clearfix"></div>
						</div>
					</div>
				</div>
				<div class="clearfix"></div>
			</div>
			<div class="recommended">
				<div class="recommended-grids">
					<div class="recommended-info">
						<h3>
							热门
							<a class="btn mine-more" href="<%=basePath%>cms/login">更多 »</a>
						</h3>
					</div>
					<script src="<%=basePath%>assets/js/responsiveslides.min.js"></script>
					<script>
						/*You can also use */
						$(window)
								.load(
										function() {
											$(function() {
												// Slideshow 4
												$("#slider3")
														.responsiveSlides(
																{
																	auto : true,
																	pager : false,
																	nav : true,
																	speed : 500,
																	namespace : "callbacks",
																	before : function() {
																		$(
																				'.events')
																				.append(
																						"<li>before event fired.</li>");
																	},
																	after : function() {
																		$(
																				'.events')
																				.append(
																						"<li>after event fired.</li>");
																	}
																});
											});
										});
					</script>
					<div id="top" class="callbacks_container">
						<ul class="rslides" id="slider3">
							<li>
								<div class="animated-grids">
									<div class="col-md-3 resent-grid recommended-grid slider-first">
										<div class="resent-grid-img recommended-grid-img zoom-container">
											<a href="single.html">
												<span class="zoom-caption"> <i class="icon-play fa fa-play"></i>
													<p>驯龙传说</p>
												</span> <img src="<%=basePath%>assets/temp/images/bilibili/1.jpg" alt="" />
											</a>
											<div class="time">
												<p>
													<span class="glyphicon glyphicon-time" aria-hidden="true"></span> 4:04
												</p>
											</div>
											<div class="mark">会员专享</div>
										</div>
										<div class="resent-grid-info recommended-grid-info">
											<div class="slid-bottom-grids">
												<div class="slid-bottom-grid">
													<p class="author author-info">
														<a href="#" class="author">John Maniya</a>
													</p>
												</div>
												<div class="slid-bottom-grid slid-bottom-right">
													<p class="views views-info">播放: 14,200</p>
												</div>
												<div class="clearfix"></div>
											</div>
										</div>
									</div>
									<div class="col-md-3 resent-grid recommended-grid slider-first">
										<div class="resent-grid-img recommended-grid-img zoom-container">
											<a href="single.html">
												<span class="zoom-caption"> <i class="icon-play fa fa-play"></i>
													<p>冰雪奇缘</p>
												</span> <img src="<%=basePath%>assets/temp/images/bilibili/2.jpg" alt="" />
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
													<p class="views views-info">播放: 151,201</p>
												</div>
												<div class="clearfix"></div>
											</div>
										</div>
									</div>
									<div class="col-md-3 resent-grid recommended-grid slider-first">
										<div class="resent-grid-img recommended-grid-img zoom-container">
											<a href="single.html">
												<span class="zoom-caption"> <i class="icon-play fa fa-play"></i>
													<p>功夫熊猫-阿宝</p>
												</span> <img src="<%=basePath%>assets/temp/images/bilibili/3.jpg" alt="" />
											</a>
											<div class="time">
												<p>
													<span class="glyphicon glyphicon-time" aria-hidden="true"></span> 2:45
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
													<p class="views views-info">播放: 2,114,200</p>
												</div>
												<div class="clearfix"></div>
											</div>
										</div>
									</div>
									<div class="col-md-3 resent-grid recommended-grid slider-first">
										<div class="resent-grid-img recommended-grid-img zoom-container">
											<a href="single.html">
												<span class="zoom-caption"> <i class="icon-play fa fa-play"></i>
													<p>滑雪大冒险</p>
												</span> <img src="<%=basePath%>assets/temp/images/bilibili/4.jpg" alt="" />
											</a>
											<div class="time">
												<p>
													<span class="glyphicon glyphicon-time" aria-hidden="true"></span> 4:34
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
													<p class="views views-info">播放: 2,114,200</p>
												</div>
												<div class="clearfix"></div>
											</div>
										</div>
									</div>
									<div class="clearfix"></div>
								</div>
							</li>
							<li>
								<div class="animated-grids">
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
													<p class="views views-info">播放: 151,201</p>
												</div>
												<div class="clearfix"></div>
											</div>
										</div>
									</div>
									<div class="col-md-3 resent-grid recommended-grid slider-first">
										<div class="resent-grid-img recommended-grid-img zoom-container">
											<a href="single.html">
												<span class="zoom-caption"> <i class="icon-play fa fa-play"></i>
													<p>功夫熊猫-阿宝10086</p>
												</span> <img src="<%=basePath%>assets/temp/images/bilibili/6.jpg" alt="" />
											</a>
											<div class="time">
												<p>
													<span class="glyphicon glyphicon-time" aria-hidden="true"></span> 2:45
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
													<p class="views views-info">播放: 2,114,200</p>
												</div>
												<div class="clearfix"></div>
											</div>
										</div>
									</div>
									<div class="col-md-3 resent-grid recommended-grid slider-first">
										<div class="resent-grid-img recommended-grid-img zoom-container">
											<a href="single.html">
												<span class="zoom-caption"> <i class="icon-play fa fa-play"></i>
													<p>滑雪大冒险10086</p>
												</span> <img src="<%=basePath%>assets/temp/images/bilibili/7.jpg" alt="" />
											</a>
											<div class="time">
												<p>
													<span class="glyphicon glyphicon-time" aria-hidden="true"></span> 4:34
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
													<p class="views views-info">播放: 2,114,200</p>
												</div>
												<div class="clearfix"></div>
											</div>
										</div>
									</div>
									<div class="col-md-3 resent-grid recommended-grid slider-first">
										<div class="resent-grid-img recommended-grid-img zoom-container">
											<a href="single.html">
												<span class="zoom-caption"> <i class="icon-play fa fa-play"></i>
													<p>驯龙传说10086</p>
												</span> <img src="<%=basePath%>assets/temp/images/bilibili/8.jpg" alt="" />
											</a>
											<div class="time">
												<p>
													<span class="glyphicon glyphicon-time" aria-hidden="true"></span> 4:04
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
													<p class="views views-info">播放: 14,200</p>
												</div>
												<div class="clearfix"></div>
											</div>
										</div>
									</div>
									<div class="clearfix"></div>
								</div>
							</li>
						</ul>
					</div>
				</div>
			</div>
			<div class="recommended">
				<div class="recommended-grids">
					<div class="recommended-info">
						<h3>
							喜欢
							<a class="btn mine-more" href="<%=basePath%>cms/login">更多 »</a>
						</h3>
					</div>
					<div class="col-md-3 resent-grid recommended-grid">
						<div class="resent-grid-img recommended-grid-img zoom-container">
							<a href="single.html">
								<span class="zoom-caption"> <i class="icon-play fa fa-play"></i>
									<p>beyond</p>
								</span> <img src="<%=basePath%>assets/temp/images/bilibili/5.jpg" alt="" />
							</a>
							<div class="time">
								<p>
									<span class="glyphicon glyphicon-time" aria-hidden="true"></span> 2:34
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
									<p class="views views-info">播放: 2,114,200</p>
								</div>
								<div class="clearfix"></div>
							</div>
						</div>
					</div>
					<div class="col-md-3 resent-grid recommended-grid">
						<div class="resent-grid-img recommended-grid-img zoom-container">
							<a href="single.html">
								<span class="zoom-caption"> <i class="icon-play fa fa-play"></i>
									<p>摇滚女王</p>
								</span> <img src="<%=basePath%>assets/temp/images/bilibili/6.jpg" alt="" />
							</a>
							<div class="time">
								<p>
									<span class="glyphicon glyphicon-time" aria-hidden="true"></span> 3:02
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
									<p class="views views-info">播放: 1,222,200</p>
								</div>
								<div class="clearfix"></div>
							</div>
						</div>
					</div>
					<div class="col-md-3 resent-grid recommended-grid">
						<div class="resent-grid-img recommended-grid-img zoom-container">
							<a href="single.html">
								<span class="zoom-caption"> <i class="icon-play fa fa-play"></i>
									<p>两个妹子</p>
								</span> <img src="<%=basePath%>assets/temp/images/bilibili/7.jpg" alt="" />
							</a>
							<div class="time">
								<p>
									<span class="glyphicon glyphicon-time" aria-hidden="true"></span> 1:34
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
									<p class="views views-info">播放: 1,000,200</p>
								</div>
								<div class="clearfix"></div>
							</div>
						</div>
					</div>
					<div class="col-md-3 resent-grid recommended-grid">
						<div class="resent-grid-img recommended-grid-img zoom-container">
							<a href="single.html">
								<span class="zoom-caption"> <i class="icon-play fa fa-play"></i>
									<p>香车美女</p>
								</span> <img src="<%=basePath%>assets/temp/images/bilibili/8.jpg" alt="" />
							</a>
							<div class="time">
								<p>
									<span class="glyphicon glyphicon-time" aria-hidden="true"></span> 2:09
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
									<p class="views views-info">播放: 2,114,200</p>
								</div>
								<div class="clearfix"></div>
							</div>
						</div>
					</div>
					<div class="clearfix"></div>
				</div>
			</div>
			<div class="recommended">
				<div class="recommended-grids">
					<div class="recommended-info">
						<h3>
							最新
							<a class="btn mine-more" href="<%=basePath%>cms/login">更多 »</a>
						</h3>
					</div>
					<div class="col-md-3 resent-grid recommended-grid">
						<div class="resent-grid-img recommended-grid-img zoom-container">
							<a href="single.html">
								<span class="zoom-caption"> <i class="icon-play fa fa-play"></i>
									<p>橄榄球</p>
								</span> <img src="<%=basePath%>assets/temp/images/bilibili/1.jpg" alt="" />
							</a>
							<div class="time">
								<p>
									<span class="glyphicon glyphicon-time" aria-hidden="true"></span> 7:30
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
									<p class="views views-info">播放: 2,114,200</p>
								</div>
								<div class="clearfix"></div>
							</div>
						</div>
					</div>
					<div class="col-md-3 resent-grid recommended-grid">
						<div class="resent-grid-img recommended-grid-img zoom-container">
							<a href="single.html">
								<span class="zoom-caption"> <i class="icon-play fa fa-play"></i>
									<p>篮球</p>
								</span> <img src="<%=basePath%>assets/temp/images/bilibili/2.jpg" alt="" />
							</a>
							<div class="time">
								<p>
									<span class="glyphicon glyphicon-time" aria-hidden="true"></span> 9:34
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
									<p class="views views-info">播放: 2,114,200</p>
								</div>
								<div class="clearfix"></div>
							</div>
						</div>
					</div>
					<div class="col-md-3 resent-grid recommended-grid">
						<div class="resent-grid-img recommended-grid-img zoom-container">
							<a href="single.html">
								<span class="zoom-caption"> <i class="icon-play fa fa-play"></i>
									<p>棒球运动</p>
								</span> <img src="<%=basePath%>assets/temp/images/bilibili/3.jpg" alt="" />
							</a>
							<div class="time">
								<p>
									<span class="glyphicon glyphicon-time" aria-hidden="true"></span> 5:34
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
									<p class="views views-info">播放: 2,114,200</p>
								</div>
								<div class="clearfix"></div>
							</div>
						</div>
					</div>
					<div class="col-md-3 resent-grid recommended-grid">
						<div class="resent-grid-img recommended-grid-img zoom-container">
							<a href="single.html">
								<span class="zoom-caption"> <i class="icon-play fa fa-play"></i>
									<p>罪恶都市</p>
								</span> <img src="<%=basePath%>assets/temp/images/bilibili/4.jpg" alt="" />
							</a>
							<div class="time">
								<p>
									<span class="glyphicon glyphicon-time" aria-hidden="true"></span> 6:55
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
									<p class="views views-info">播放: 2,114,200</p>
								</div>
								<div class="clearfix"></div>
							</div>
						</div>
					</div>
					<div class="clearfix"></div>
				</div>
			</div>
			<a class="to-top itop" title="回到顶部"></a>
		</div>
		<!-- footer -->
		<%@include file="../shared/footerPart.jsp"%>
	</div>
	<script src="<%=basePath%>assets/lib/bootstrap/js/bootstrap.min.js"></script>
	<script src="<%=basePath%>assets/lib/to-top/to-top.js" type="text/javascript" charset="utf-8"></script>
	<script>
		
	</script>
</body>

</html>