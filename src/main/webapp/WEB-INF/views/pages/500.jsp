<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="zh-CN">
	<head>
		<meta charset="utf-8">
		<title>
			500页面
		</title>
		<meta name="renderer" content="webkit">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="format-detection" content="telephone=no">
		<link rel="shortcut icon" type="image/png" href="<%=basePath%>assets/img/logo-cms.ico" media="screen" />
		<link rel="stylesheet" href="<%=basePath%>assets/css/code-page.css" media="all">
		<link rel="stylesheet" href="<%=basePath%>assets/css/x-admin.css" media="all">
	</head>

	<body>
		<div class="cw_code">
			<div class="cw_code_top">
				<div class="top_code">Error:500</div>
			</div>
			<div class="cw_code_nr">
				<div class="nr_top">服务器内部错误！</div>

				<div class="nr_min">
					<div class="min_top">你可以选择:</div>
					<blockquote class="layui-elem-quote">
						<div class="min_choose">
							<a  href="JavaScript:window.top.location.href='<%=basePath%>';">返回首页</a> &nbsp;
						</div>
						<div class="min_choose">
							<a href="JavaScript:history.go(-1);location.reload();">返回上一页</a> &nbsp;
						</div>
					</blockquote>
					<div class="min_top">详细信息:</div>
					<blockquote class="layui-elem-quote">
							N/A
					</blockquote>
					<div class="cw_poetry">
						<img src="<%=basePath%>assets/img/poetry.jpg"  height="200px" title="王维 - 《相思》" alt="图片也走丢了?"/>
					</div>
				</div>
				<div class="nr_foot">Hi,Danmaku! Copyright © 2017 yebukong </div>
			</div>
		</div>
		<script src="<%=basePath%>assets/lib/layui/layui.js" charset="utf-8"></script>
		<script src="<%=basePath%>assets/js/x-admin.js"></script>
	</body>