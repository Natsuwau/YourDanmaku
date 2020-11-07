<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/tlds/shiro.tld" prefix="shiro" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="zh-CN">
    <head>
        <meta charset="utf-8">
        <title>
            welcome
        </title>
        <meta name="renderer" content="webkit">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <meta name="apple-mobile-web-app-status-bar-style" content="black">
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="format-detection" content="telephone=no">
        <link rel="stylesheet" href="<%=basePath%>assets/css/x-admin.css" media="all">
    </head>
    <body>
        <div class="x-body">
			<blockquote class="layui-elem-quote">
				欢迎来到Hi,Danmaku! - <span class="f-14">CMS</span>
			</blockquote>
			<fieldset class="layui-elem-field layui-field-title site-title">
				<legend>
					<a name="default">信息统计</a>
				</legend>
			</fieldset>
			<table class="layui-table">
				<thead>
					<tr>
						<th colspan="2" scope="col">系统信息</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th width="30%">服务器路径</th>
						<td><span id="lbServerName">http://127.0.0.1/</span></td>
					</tr>
					<tr>
						<td>服务器端口 </td>
						<td>80</td>
					</tr>
					<tr>
						<td>服务器 </td>
						<td>Tomcat8</td>
					</tr>
					<tr>
						<td>数据库</td>
						<td>MySQL5.5</td>
					</tr>
					<tr>
						<td>项目名</td>
						<td>MineDanmaku</td>
					</tr>
					<tr>
						<td>网站名称</td>
						<td>Hi,Danmaku!</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="layui-footer footer footer-demo">
			<div class="layui-main">
				<p>
					<a href="/">
						Copyright ©2017 Hi,Danmaku - CMS.
					</a>
				</p>
				<p>
					<a href="./" target="_blank">
						本后台系统由X-amdin前端框架提供前端技术支持
					</a>
				</p>
			</div>
		</div>
        <script src="<%=basePath%>assets/lib/layui/layui.js" charset="utf-8"></script>
        <script src="<%=basePath%>assets/js/x-admin.js"></script>
    </body>
</html>