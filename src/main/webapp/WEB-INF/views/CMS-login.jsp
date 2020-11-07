<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="zh-CN">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<title>CMS - 登录</title>
		<!-- Tell the browser to be responsive to screen width -->
		<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
		<link rel="shortcut icon" type="image/png" href="<%=basePath%>assets/img/logo-cms.ico" media="screen" />
		<!--聪明的小标题-->
		<script src="<%=basePath%>assets/js/cute-title.js"></script>
		<!-- Bootstrap 3.3.6 -->
		<link rel="stylesheet" href="<%=basePath%>assets/lib/bootstrap/css/bootstrap.min.css">

		<link rel="stylesheet" href="<%=basePath%>assets/css/cms-login.css">

		<!-- iCheck -->
		<link rel="stylesheet" href="<%=basePath%>assets/lib/iCheck/square/blue.css">

		<link rel="stylesheet" href="<%=basePath%>assets/css/x-admin.css" media="all">
	</head>

	<body class="hold-transition login-page">
		<div>
			<div class="login-box">
				<div class="login-logo">
					<a href="<%=basePath%>home"><b>Hi,Danmaku!</b></a> - <a href="<%=basePath%>cms/index">CMS</a>
				</div>
				<!-- /.login-logo -->
				<div class="login-box-body">
					<p class="login-box-msg"> (｡◕‿◕｡ ) 皮皮虾,CMS登录走起~ </p>

					<form action="" method="post">
						<div class="form-group has-feedback">
							<input type="text" id="cms-id" class="form-control" placeholder="用户ID">
							<span class="glyphicon  glyphicon-user form-control-feedback"></span>
						</div>
						<div class="form-group has-feedback">
							<input type="password" id="cms-password" class="form-control" placeholder="密码">
							<span class="glyphicon glyphicon-lock form-control-feedback"></span>
						</div>
						<div class="row">
							<div class="col-xs-8">
								<div class="checkbox icheck">
									<label>
						              <input id="rememberMe" type="checkbox" checked="checked"> 记住我
						            </label>
								</div>
							</div>
							<!-- /.col -->
							<div class="col-xs-4">
								<label id="login-btn" class="btn btn-primary btn-block btn-flat">登录</label >
							</div>
							<!-- /.col -->
						</div>
					</form>

				</div>
			</div>
			<!-- /.login-box -->
			<section class="canvas-wrap">
				<div class="canvas-content">
				</div>
				<div id="canvas" class="gradient"></div>
			</section>
		</div>
		<script src="<%=basePath%>assets/js/jquery.min.js"></script>
		<!-- iCheck -->
		<script src="<%=basePath%>assets/lib/iCheck/icheck.min.js"></script>

		<script src="<%=basePath%>assets/lib/layui/layui.js" charset="utf-8"></script>
		  <script src="<%=basePath%>assets/js/x-layui.js" charset="utf-8"></script>
		<!-- 线条动画 -->
		<script src="<%=basePath%>assets/js/line/three.min.js"></script>
		<script src="<%=basePath%>assets/js/line/projector.js"></script>
		<script src="<%=basePath%>assets/js/line/canvas-renderer.js"></script>
		<script src="<%=basePath%>assets/js/line/3d-lines-animation.js"></script>
		<script src="<%=basePath%>assets/js/line/color.js"></script>
		<script>
			/*复选框设置*/
			$(function() {
				$('input').iCheck({
					checkboxClass: 'icheckbox_square-blue',
					radioClass: 'iradio_square-blue',
					increaseArea: '50%' // optional
				});
				layui.use(['form','layer']);
				/*监听回车操作,默认提交表单*/  
				$('body').bind('keypress',function(event){  
				    if(event.keyCode == "13") {
				    	$('#login-btn').click();  
				    }
				});
				$('#login-btn').click(function() {
					//获取输入账号和密码,并去空格
					var userName = $("#cms-id").val();
					var userPwd = $("#cms-password").val();
					userName = $.trim(userName);
					userPwd = $.trim(userPwd);
					//获取记住我选中状态
					var rememberMe = '';
					if($('#rememberMe').is(':checked')) {
   						rememberMe ="rememberMe";
					}
					
					var errMsg;
					if(!userName){
						errMsg = "用户名不能为空!";
					}
					if((!errMsg) && (!userPwd)){
						errMsg = "密码不能为空!";
					}
					if((!errMsg) && (userName.length < 2 || userName.length > 16)){
						errMsg = "用户名长度限制2-16位!";
					}
					if((!errMsg) && (userPwd.length < 4 || userPwd.length > 16)){
						errMsg = "密码长度限制4-16位!";
					}
					if(errMsg){
						layer.msg(errMsg , {
							offset: '35%',
							anim: 6,
							icon: 5,
						});
						return;
					}
					var index= layer.msg('登录中...',{icon: 16 , offset: '35%',time:0});
					//登录
					jQuery.ajax({
						url: '<%=basePath%>cms/login',
						type: "POST",
						dataType: "JSON",
						data: { 
							"cmsId": userName ,
							"password": userPwd,
							"rememberMe":rememberMe
						},
						success: function(data, status) {
							layer.close(index);
							if(data.success){
								if(!data.msg){//正常登录成功
									layer.msg('登录成功,即将跳转!', {
										offset: '35%',
										anim: 1,
										icon: 1,
									});
									//延迟一秒跳转
									setTimeout(function(){
										location.href="<%=basePath%>cms/index";
									},1000);
								}else{//已有登录账号
									layer.confirm(data.msg,{offset: '30%'},function() {
										layer.msg('正在跳转...', {
											offset: '35%',
											icon: 1,
											time: 1000
										});
										//延迟一秒跳转
										setTimeout(function(){
											location.href="<%=basePath%>cms/index";
										},1000);
									});
								}
							}else{
								layer.msg(data.msg, {
									offset: '35%',
									anim: 6,
									icon: 5,
								});	
							}
						},
						error: function() {
							layer.close(index);
							layer.msg('连接服务器失败!', {
								offset: '35%',
								anim: 6,
								icon: 2,
							});
						}
	
					});
					return false;
				});
			});
		</script>
	</body>

</html>