<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<title>Hi,Danmaku!-CMS</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="format-detection" content="telephone=no">
<link rel="stylesheet" href="<%=basePath%>assets/css/x-admin.css"
	media="all">
</head>
<body>
	<div class="x-body">
		<form class="layui-form">
			<div class="layui-form-item">
				<label for="id" class="layui-form-label"> <span
					class="x-red">*</span>用户ID
				</label>
				<div class="layui-input-inline">
					<input type="text" id="userid" name="id" required=""
						lay-verify="userId" autocomplete="off" class="layui-input">
				</div>
				<div class="layui-form-mid layui-word-aux">
					<span class="x-red">*</span>将会成为您的登入ID
				</div>
			</div>
			<div class="layui-form-item">
				<label for="name" class="layui-form-label"> <span
					class="x-red">*</span>昵称
				</label>
				<div class="layui-input-inline">
					<input type="text" id="username" name="name" required=""
						lay-verify="username" autocomplete="off" class="layui-input">
				</div>
				<div class="layui-form-mid layui-word-aux">
					<span class="x-red">*</span>长度2-10位
				</div>
			</div>
			<div class="layui-form-item">
				<label for="role" class="layui-form-label"> <span
					class="x-red">*</span>账号状态
				</label>
				<div class="layui-input-inline">
					<select id="userstate" name="state">
						<option value="0" selected="">冻结</option>
						<option value="1">激活</option>
					</select>
				</div>
			</div>
			<div class="layui-form-item">
				<label for="desc" class="layui-form-label"> <span
					class="x-red"></span>说明
				</label>
				<div class="layui-input-inline">
					<textarea id="userdesc" name="desc" placeholder="请输入内容"
						class="layui-textarea"></textarea>
				</div>
				<div class="layui-form-mid layui-word-aux">
					<span class="x-red">可选</span>
				</div>
			</div>
			<div class="layui-form-item">
				<label for="L_repass" class="layui-form-label"> </label>
				<button class="layui-btn" lay-filter="add" lay-submit="">
					增加</button>
			</div>
		</form>
	</div>
	<script src="<%=basePath%>assets/lib/layui/layui.js" charset="utf-8">
        </script>
	<script src="<%=basePath%>assets/js/x-layui.js" charset="utf-8">
        </script>
	<script>
            layui.use(['form','layer'], function(){
                $ = layui.jquery;
              var form = layui.form()
              ,layer = layui.layer;
            
              //自定义验证规则
              form.verify({
            	  userId: function(value){
	                  if(value.length < 2 || value.length > 10){
	                    return '用户ID长度限制2-10位!';
	                  }
               	 }
                ,username: [/(.+){2,10}$/, '昵称长度限制2-10位']
              });
              //监听提交
              form.on('submit(add)', function(formData){
            	//JSON.stringify(data.field);
                $.ajax({
					url: '<%=basePath%>cms/sysUser/add',
					type: "POST",
					dataType: "JSON",
					data:formData.field,
					success: function(data, status) {
						if(data.success){
							layer.alert("增加成功", {icon: 6},function () {
								parent.location.reload(); //刷新父页面
  			                    var index = parent.layer.getFrameIndex(window.name);// 获得frame索引
  			                    parent.layer.close(index); //关闭当前frame
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