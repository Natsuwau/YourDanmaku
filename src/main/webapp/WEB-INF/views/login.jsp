<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/fn.tld" prefix="fn" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="zh-CN">
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title> ${empty registerFlag ? '用户登录' : '用户注册' }</title>
		<link rel="shortcut icon" type="image/png" href="<%=basePath%>assets/img/logo.ico" media="screen" />
		<!--页面加载进度条,光线,圈圈-->
		<script src="<%=basePath%>assets/lib/pace/pace-1.0.2.js"></script>
		<link rel="stylesheet" href="<%=basePath%>assets/lib/pace/pace-theme-blue-flash.css" />
		<!--聪明的小标题-->
		<script src="<%=basePath%>assets/js/cute-title.js"></script>
		<!-- Theme style -->
		<link rel="stylesheet" href="<%=basePath%>assets/lib/bootstrap/css/bootstrap.min.css">
		<link rel="stylesheet" href="<%=basePath%>assets/css/x-admin.css" media="all">
		<link rel="stylesheet" href="<%=basePath%>assets/css/login.css">
		<style type="text/css">
			.mineColor {
				color: #E65025!important;
			}
			.form h1 {
				margin-bottom: 10px;
			}
			.form h1 a{
				text-decoration:none!important;
				color: #fff;
			}
		</style>
	</head>

	<body class="login1">
		<div class="wrapper ">
			<div class='container ${empty loginFlag ?"":"active" }' id="loginBody">

				<form class="form">
					<h1>欢迎登录<a href="<%=basePath%>home" title="主页">Hi,Danmaku!</a></h1>
					<span class="has-feedback">
					<input id="loginUserId" type="text" placeholder="用户ID" autocomplete="off">
    				<span class=" glyphicon glyphicon-user form-control-feedback "></span>
					</span>
					<span class="has-feedback">
					<input id="loginUserPassword" type="password" placeholder="密码" >
					<span class="showPDW glyphicon glyphicon-lock form-control-feedback "></span>
					</span>
					<button type="submit" id="login-button" class="">登录</button>
					<div class="reg-div">
						<a href="" class="reg-btn">注册账号</a>
					</div>
				</form>
			</div>
			<div class="container ${empty registerFlag ? '' : 'active' } " id="registerBody">

				<form class="form">
					<h1>欢迎注册 <a href="<%=basePath%>home" title="主页">Hi,Danmaku!</a></h1>
					<span class="has-feedback">
					<input id = "regUserId" type="text" placeholder="用户ID" autocomplete="off">
    				<span class="glyphicon glyphicon-user form-control-feedback " ></span>
					</span>
					<span class="has-feedback">
					<input id = "regUserEmail" type="email" placeholder="邮箱" autocomplete="off">
					<span class="glyphicon glyphicon-envelope form-control-feedback " ></span>
					</span>
					<span class="has-feedback">
					<input id = "regUserPwd" type="password" placeholder="密码">
					<span class="glyphicon glyphicon-lock form-control-feedback " ></span>
					</span>
					<span class="has-feedback">
					<input id = "regReUserPwd" type="password" placeholder="确认密码">
					<span class="glyphicon glyphicon-log-in form-control-feedback " ></span>
					</span>
					<button type="submit" class="" id="register-button">注册</button>
					<div class="reg-div">
						<a href="" class="reg-btn">已有账号</a>
					</div>
				</form>
			</div>

			<ul class="bg-bubbles">
				<li></li>
				<li></li>
				<li></li>
				<li></li>
				<li></li>
				<li></li>
				<li></li>
				<li></li>
				<li></li>
				<li></li>
			</ul>
		</div>
		<!-- jQuery 2.2.3 -->
		<script src="<%=basePath%>assets/js/jquery.min.js"></script>
		<script src="<%=basePath%>assets/lib/layui/layui.js" charset="utf-8"></script>
		<script src="<%=basePath%>assets/js/x-layui.js" charset="utf-8"></script>
		<script>
			$(function() {
				layui.use(['form','layer']);
				$('#login-button').click(function() {
					//获取用户ID,密码
					var userId = $("#loginUserId").val();
					var userPwd = $("#loginUserPassword").val();
					userId = $.trim(userId);
					userPwd = $.trim(userPwd);
					var errMsg = "";
					if(!userId){
						errMsg = "用户ID不能为空!";
					}
					if((!errMsg) && (!userPwd)){
						errMsg = "密码不能为空!";
					}
					if((!errMsg) && (userId.length < 4 || userId.length > 16)){
						errMsg = "用户Id长度限制4-16位!";
					}
					if((!errMsg) && (userPwd.length < 4 || userPwd.length > 16)){
						errMsg = "密码长度限制4-16位!";
					}
					if(errMsg){
						layer.msg(errMsg , {
							offset: '40%',
							anim: 6,
							icon: 5,
						});
						return false;
					}
					var index = layer.load(0, {offset: '45%',shade: false}); 
					$.ajax({
						url: '<%=basePath%>login',
						type: "POST",
						dataType: "JSON",
						data: { 
							"id": userId ,
							"password": userPwd
						},
						success: function(data, status) {
							layer.close(index);
							if(data.success){
								layer.msg('登录成功,即将跳转!', {
									offset: '40%',
									anim: 1,
									icon: 1,
								});
								//延迟一秒跳转
								setTimeout(function(){
									location.href="<%=basePath%>home";
								},1000);
							}else{
								layer.msg(data.msg, {
									offset: '40%',
									anim: 6,
									icon: 5,
								});	
							}
						},
						error: function() {
							layer.close(index);
							layer.msg('连接服务器失败!', {
								offset: '40%',
								anim: 6,
								icon: 2,
							});
						}
					});
					return false;
				});
				$('#register-button').click(function() {
					//获取信息
					var userId = $("#regUserId").val();
					var userPwd = $("#regUserPwd").val();
					var userRePwd = $("#regReUserPwd").val();
					var userEmail = $("#regUserEmail").val();
					userId = $.trim(userId);
					userPwd = $.trim(userPwd);
					userRePwd = $.trim(userRePwd);
					userEmail = $.trim(userEmail);
					var errMsg = "";
					if(!userId){
						errMsg = "用户ID不能为空!";
					}
					if((!errMsg) && (!userEmail)){
						errMsg = "邮箱不能为空!";
					}
					if((!errMsg) && (!userPwd)){
						errMsg = "密码不能为空!";
					}
					if((!errMsg) && (!userRePwd)){
						errMsg = "确认密码不能为空!";
					}
					if((!errMsg) && (userId.length < 4 || userId.length > 16)){
						errMsg = "用户Id长度限制4-16位!";
					}
					if((!errMsg) && (!userEmail.match( /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/))){
						errMsg = "邮箱格式不正确!";
					}
					if((!errMsg) && (userPwd.length < 4 || userPwd.length > 16)){
						errMsg = "密码长度限制4-16位!";
					}
					if((!errMsg) && (userPwd!=userRePwd)){
						errMsg = "两次输入密码不一致!";
					}
					if(errMsg){
						layer.msg(errMsg , {
							offset: '40%',
							anim: 6,
							icon: 5,
						});
						return false;
					}
					var index= layer.msg('&nbsp;&nbsp;&nbsp;&nbsp;注册中...',{icon: 16, offset: '40%',time:0});
					$.ajax({
						url: '<%=basePath%>register',
						type: "POST",
						dataType: "JSON",
						data: { 
							"id": userId ,
							"password": userPwd,
							"email": userEmail
						},
						success: function(data, status) {
							layer.close(index);
							if(data.success){
								layer.msg('注册成功,即将切换到登录!', {
									offset: '40%',
									icon: 1,
								});
								//延迟一秒切换到登录
								setTimeout(function(){
									//清空注册信息
									$("#regUserId").val="";
									$("#regUserPwd").val="";
									$("#regReUserPwd").val="";
									$("#regUserEmail").val="";
									toggleLoginOrReg();
								},1000);
							}else{
								layer.msg(data.msg, {
									offset: '40%',
									anim: 6,
									icon: 5,
								});	
							}
						},
						error: function() {
							layer.close(index);
							layer.msg('连接服务器失败!', {
								offset: '40%',
								anim: 6,
								icon: 2,
							});
						}
					});
					return false;
				});
			});
		</script>
		<script>
			$(".reg-btn").on("click", function() {
				toggleLoginOrReg();
				if($('#loginBody').is('.active')) {
					document.title = '用户登录';
				} else {
					document.title = '用户注册';
				}
				return false;
			});
			function  toggleLoginOrReg(){
				$("#loginBody").toggleClass("active");
				$("#registerBody").toggleClass("active");
			}
			
	   </script>
</body>
</html>