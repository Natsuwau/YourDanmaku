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
<!DOCTYPE HTML>
<html>
<head>
<title>${title}</title>
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
<link rel="stylesheet" href="<%=basePath%>assets/lib/layui/css/layui.css" media="all">
<!-- bootstrap -->
<link href="<%=basePath%>assets/lib/bootstrap/css/bootstrap.min.css" rel='stylesheet'
	type='text/css' media="all" />
<link rel="stylesheet" href="<%=basePath%>assets/css/x-admin.css" media="all">
<link href="<%=basePath%>assets/css/dashboard.css" rel="stylesheet">
<!-- Custom Theme files -->
<link href="<%=basePath%>assets/css/style.css" rel='stylesheet' type='text/css' media="all" />
<script src="<%=basePath%>assets/js/jquery-2.2.3.min.js"></script>
<!--start-smoth-scrolling-->
<link href="<%=basePath%>assets/lib/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet"
	type="text/css">
<!--回到顶部-->
<link rel="stylesheet" href="<%=basePath%>assets/lib/to-top/to-top.css" media="all">
</head>

<body>
	<%@include file="../shared/navbarPart.jsp"%>
	<!--侧面列表-->
	<%@include file="../shared/menuPart.jsp"%>
	<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
		<div class="main-grids">
			<div class="recommended ">
				<div class="recommended-info">
					<h3>${title}</h3>
				</div>
				<hr>
				<ul class="recommended-grids flow-default" id="LAY_demo2">
				</ul>
			</div>
			<div class="clearfix"></div>
		</div>

		<!-- footer -->
		<%@include file="../shared/footerPart.jsp"%>
	</div>

	<script src="<%=basePath%>assets/lib/bootstrap/js/bootstrap.min.js"></script>
	<script src="<%=basePath%>assets/lib/layui/layui.js" charset="utf-8"></script>
	<script src="<%=basePath%>assets/lib/to-top/to-top.js" type="text/javascript" charset="utf-8"></script>
	<script>
			layui.use(['layer','flow'], function() {
				var flow = layui.flow;
				layer = layui.layer;
				flow.load({
					elem: '#LAY_demo2' //流加载容器
						,
					scrollElem: '#LAY_demo2' //滚动条所在元素，一般不用填，此处只是演示需要。
						,
					isAuto: false,
					isLazyimg: true,
					done: function(page, next) { //加载下一页
						var url ="<%=basePath%>search";
						//获取数据
						$.post(url,
								{ "type": '${type}',
								  "searchKey": '${paramBag.searchKey}',
								  "nowPage": page,
								}, 
							function(data){
								var lis = [];
								if(data.success){
									var pageInfo = data.obj;
									var pageSize = pageInfo.pageSize;
									var pageCount = pageInfo.pageCount;
									var basePageList = 	pageInfo.basePageList;
									layer.msg("加载中...",{time:1000});
									setTimeout(function() {
										
										for(var i = 0; i < basePageList.length; i++) {
											var one = basePageList[i];
											var scopeHtml ="";
											if(one.scope.toString() =="@user"){
												scopeHtml = '<div class="mark">会员专享</div>';
											}else{
												scopeHtml = '<div class="no-mark">会员专享</div>';
											}
											var x = '<li class=\"col-md-3 resent-grid recommended-grid\"><div class="resent-grid-img recommended-grid-img zoom-container"><a href="<%=basePath%>single/'
												+one.id.toString()+
												'"><span class="zoom-caption"><i class="icon-play fa fa-play"></i><p>'
												+one.name.toString()+
												'</p></span><img src="<%=imgBasePath%>'
												+one.coverUrl.toString()+
												'" alt="图片损坏" /></a><div class="time"><p><span class="glyphicon glyphicon-time" aria-hidden="true"></span>&nbsp;'
												+one.durationStr.toString()+'</p></div>'+scopeHtml+'</div><div class="resent-grid-info recommended-grid-info"><div class="slid-bottom-grids"><div class="slid-bottom-grid"><p class="author author-info">' +
												'<a href="<%=basePath%>space/'
												+one.frontUserId.toString()+
												'" class="author">'
												+one.frontUserId.toString()+
												'</a></p></div><div class="slid-bottom-grid slid-bottom-right"><p class="views views-info">播放量: '
												+one.hits.toString()+
												'</p></div><div class="clearfix"> </div></div></div></li>';
											lis.push(x);
										}
										if(lis.length>0){
											lis.push("<hr>");
										}
										next(lis.join(''), page < pageCount); //总页数
									}, 500);
								}else{
									layer.msg(data.msg);
									next(lis.join(''), page < 0); //总页数
									return;
								}
						},"JSON");
					}
				});
			});
		</script>
</body>
</html>