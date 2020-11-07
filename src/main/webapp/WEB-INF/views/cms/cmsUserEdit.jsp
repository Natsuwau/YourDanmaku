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
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<title>Hi,Danmaku!-CMS</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="format-detection" content="telephone=no">
<link rel="stylesheet" href="<%=basePath%>assets/lib/amazeui-cropper/css/amazeui.min.css">
<link rel="stylesheet" href="<%=basePath%>assets/lib/amazeui-cropper/css/amazeui.cropper.css">
<link rel="stylesheet" href="<%=basePath%>assets/lib/amazeui-cropper/css/custom_up_img.css">
<link rel="stylesheet" href="<%=basePath%>assets/css/x-admin.css" media="all">
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>assets/lib/font-awesome-4.7.0/css/font-awesome.min.css">
<style>
.mine-center {
	text-align: center;
}
</style>
</head>

<body>
	<div class="x-body">
		<!--图片上传框-->
		<div class="am-modal am-modal-no-btn up-frame-bj " tabindex="-1" id="doc-modal-1">
			<div class="am-modal-dialog up-frame-parent up-frame-radius">
				<div class="am-modal-hd up-frame-header">
					<label>修改头像</label>
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
							<img alt="" src="" id="image" aspectRatio="1">
						</div>
						<div class="up-pre-after up-frame-radius"></div>
					</div>
					<div class="am-g am-fl">
						<div class="up-control-btns">
							<span class="am-icon-rotate-left" onclick="rotateimgleft()"></span> <span
								class="am-icon-rotate-right" onclick="rotateimgright()"></span> <span
								class="am-icon-check" id="up-btn-ok" url="<%=basePath%>cms/u/editIcon"></span>
						</div>
					</div>
	
				</div>
			</div>
		</div>
	
		<!--加载框-->
		<div class="am-modal am-modal-loading am-modal-no-btn" tabindex="-1" id="my-modal-loading">
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
		<form class="layui-form" style="margin: 0 auto; width: 360px;">
			<div class="layui-form-item">
				<div class="mine-center " id="up-img-touch">
					<c:choose>
						<c:when test="${empty user.icon}">
							<img src="<%=basePath%>assets/img/dog.gif" class="layui-circle" style="border: 0px solid #A9B7B7;" height="65px" alt="头像路径无效" data-am-popover="{theme: 'sm', content: '点击修改', trigger: 'hover focus'}">
						</c:when>
						<c:otherwise>
							<img src="<%=imgBasePath%>${user.icon}" class="layui-circle" style="border: 0px solid #A9B7B7;" height="65px" alt="头像路径无效" data-am-popover="{theme: 'sm', content: '点击修改', trigger: 'hover focus'}">
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<div class="layui-form-item">
				<label for="id" class="layui-form-label">
					<span class="x-red">*</span>用户ID
				</label>
				<div class="layui-input-inline">
					<input type="text" id="userid" name="id" required="" readonly="readonly" lay-verify="userId"
						autocomplete="off" value="${user.id}" class="layui-input">
				</div>
				<div class="layui-form-mid layui-word-aux">
					<span class="x-red">*</span>ID无法修改
				</div>
			</div>
			<div class="layui-form-item">
				<label for="name" class="layui-form-label">
					<span class="x-red">*</span>昵称
				</label>
				<div class="layui-input-inline">
					<input type="text" id="username" name="name" required="" lay-verify="username"
						autocomplete="off" value="${user.name}" class="layui-input">
				</div>
				<div class="layui-form-mid layui-word-aux">
					<span class="x-red">*</span>长度2-10位
				</div>
			</div>
			<div class="layui-form-item layui-form-text">
				<label for="L_sign" class="layui-form-label"> 说明 </label>
				<div class="layui-input-inline">
					<textarea id="userdesc" name="desc" placeholder="随便写些什么刷下存在感" class="layui-textarea">${user.desc}</textarea>
				</div>
				<div class="layui-form-mid layui-word-aux">
					<span class="x-red">*</span>可选
				</div>
			</div>
			<div class="layui-form-item">
				<label for="L_sign" class="layui-form-label"> </label>
				<button class="layui-btn" key="set-mine" lay-filter="save" lay-submit>保存修改</button>
			</div>
		</form>
	</div>
	<script src="<%=basePath%>assets/lib/layui/layui.js" charset="utf-8" /></script>
	<script src="<%=basePath%>assets/js/x-layui.js" charset="utf-8"></script>
	<script src="<%=basePath%>assets/lib/amazeui-cropper/js/jquery-1.8.3.min.js"></script>
	<script src="<%=basePath%>assets/lib/amazeui-cropper/js/amazeui.min.js" charset="utf-8"></script>
	<script src="<%=basePath%>assets/lib/amazeui-cropper/js/cropper.min.js" charset="utf-8"></script>
	<script src="<%=basePath%>assets/lib/amazeui-cropper/js/custom_up_img.js" charset="utf-8"></script>
	<script>
			layui.use(['form', 'layer'], function() {
				$ = layui.jquery;
				var form = layui.form(),
					layer = layui.layer;

				 //自定义验证规则
	              form.verify({
	            	 username: [/(.+){2,10}$/, '昵称长度限制2-10位']
	              });
				//监听提交
				form.on('submit(save)', function(formData) {
					 $.ajax({
							url: '<%=basePath%>cms/u/edit',
							type: "POST",
							dataType: "JSON",
							data:formData.field,
							success: function(data, status) {
								if(data.success){
									layer.alert("修改成功", {icon: 6},function () {
										parent.location.reload(); //刷新父页面
					                    var index = parent.layer.getFrameIndex(window.name);// 获得frame索引
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