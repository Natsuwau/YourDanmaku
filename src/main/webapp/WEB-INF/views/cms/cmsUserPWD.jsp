<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/fn.tld" prefix="fn" %>
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
			Hi,Danmaku!-CMS
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
			<form class="layui-form">
				<div class="layui-form-item">
					<label for="L_userid" class="layui-form-label">
                        	<span class="x-red">*</span>用户ID
                    </label>
					<div class="layui-input-inline">
						<input type="text" id="L_userid" name="id" readonly="readonly" value="<shiro:principal property="id" />" class="layui-input">
					</div>
					<div class="layui-form-mid layui-word-aux">
						<span class="x-red">*</span>用户ID无法修改
					</div>
				</div>
				<div class="layui-form-item">
					<label for="L_oldpass" class="layui-form-label">
                        <span class="x-red">*</span>旧密码
                    </label>
					<div class="layui-input-inline">
						<input type="password" id="L_oldpass" name="oldPassword" required="" lay-verify="iPassword" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
					<label for="L_newpass" class="layui-form-label">
                        <span class="x-red">*</span>新密码
                    </label>
					<div class="layui-input-inline">
						<input type="password" id="L_newpass" name="newPassword" required="" lay-verify="iPassword" autocomplete="off" class="layui-input">
					</div>
					<div class="layui-form-mid layui-word-aux">
						<span class="x-red">*</span>4到16个字符
					</div>
				</div>
				<div class="layui-form-item">
					<label for="L_repass" class="layui-form-label">
                        <span class="x-red">*</span>确认密码
                    </label>
					<div class="layui-input-inline">
						<input type="password" id="L_repass" name="repass" required="" lay-verify="rePassword" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
					<label for="L_repass" class="layui-form-label">
                    </label>
					<button class="layui-btn" lay-filter="save" lay-submit="">
                        	密码修改
                    </button>
				</div>
			</form>
		</div>
		<script src="<%=basePath%>assets/lib/layui/layui.js" charset="utf-8" /></script>
		<script src="<%=basePath%>assets/js/x-layui.js" charset="utf-8"></script>
		<script>
			layui.use(['form', 'layer'], function() {
				$ = layui.jquery;
				var form = layui.form(),
					layer = layui.layer;
				
				form.verify({
	                iPassword:function(value){
		                  if(value.length < 4 || value.length > 16){
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
				//监听提交
				form.on('submit(save)', function(formData) {
					var id= $('#L_userid').val();
					var oldPass= $('#L_oldpass').val();
					var newPass= $('#L_newpass').val();
					$.ajax({
						url: '<%=basePath%>cms/u/editPWD',
						type: "POST",
						dataType: "JSON",
						data:{
							"id":id,
							"oldPassword":oldPass,
							"newPassword":newPass
						},
						success: function(data, status) {
							if(data.success){
								layer.alert("修改密码成功!", {icon: 6},function () {
									parent.location.reload(); //刷新父页面
				                    var index = parent.layer.getFrameIndex(window.name);  // 获得frame索引
				                    parent.layer.close(index);//关闭当前frame
				                });
							}else{
								layer.msg(data.msg, {
									offset: '35%',
									anim: 6,
									icon: 5,
								});	
							}
						},
						error: function() {
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