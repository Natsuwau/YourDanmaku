<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/fn.tld" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/shiro.tld" prefix="shiro"%>
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
		<title>修改视频信息</title>
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
		<c:if test="${not empty errMsg}">
			<blockquote class="layui-elem-quote">${errMsg}</blockquote>
		</c:if>
		<form action="" method="post" class="layui-form layui-form-pane">
			<div class="layui-form-item">
				<label for="roleid" class="layui-form-label">
					<span class="x-red">*</span>视频ID
				</label>
				<div class="layui-input-inline">
					<input type="text" id="roleid" name="id" required="" lay-verify="required" value="${one.id}"
						readonly="readonly" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label for="rolename" class="layui-form-label">
					<span class="x-red">*</span>视频名
				</label>
				<div class="layui-input-inline">
					<input type="text"  name="name"  lay-verify=" iName"
						value="${one.name}" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label for="rolestate" class="layui-form-label">
					<span class="x-red">*</span>视频类型
				</label>
				<div class="layui-input-inline">
					<select name="type" lay-verify="required">
						<option value="ACG"  ${one.type eq 'ACG' ? 'selected="selected"' :''}>动漫/番剧</option>
						<option value="MOVIE"  ${one.type eq 'MOVIE' ? 'selected="selected"' :''}>影视</option>
						<option value="SG"  ${one.type eq 'SG' ? 'selected="selected"' :''}>科技/游戏</option>
						<option value="MAD"  ${one.type eq 'MAD' ? 'selected="selected"' :''}>鬼畜</option>
						<option value="FUN"  ${one.type eq 'FUN' ? 'selected="selected"' :''}>时尚/娱乐</option>
						<option value="MUSIC" ${one.type eq 'MUSIC' ? 'selected="selected"' :''}>音乐</option>
						<option value="OTHER" ${one.type eq 'OTHER' ? 'selected="selected"' :''}>其他</option>
					</select>
				</div>
			</div>
			<div class="layui-form-item">
				<label for="rolestate" class="layui-form-label">
					<span class="x-red">*</span>权限范围
				</label>
				<div class="layui-input-inline">
					<select  name="scope">
						<option value="0" ${one.scope eq '@all' ? 'selected="selected"' :  ''}>所有人</option>
						<option value="1" ${one.scope eq '@user' ? 'selected="selected"' :  ''}>仅限会员</option>
					</select>
				</div>
			</div>
			<div class="layui-form-item layui-form-text">
				<label for="roleDesc" class="layui-form-label"> 描述 </label>
				<div class="layui-input-block">
					<textarea placeholder="请输入内容" id="roleDesc" name="desc" lay-verify="iDesc" class="layui-textarea">${one.desc}</textarea>
				</div>
			</div>
			<div class="layui-form-item">
				<button class="layui-btn" lay-submit="" lay-filter="save">保存修改</button>
			</div>
		</form>
	</div>
	<script src="<%=basePath%>assets/lib/layui/layui.js" charset="utf-8"></script>
	<script src="<%=basePath%>assets/js/x-layui.js" charset="utf-8"></script>
	<script>
		layui.use([ 'form', 'layer' ], function() {
			$ = layui.jquery;
			var form = layui.form(), layer = layui.layer;

			form.verify({
                iName:function(value){
	                  if(value.length < 2 || value.length > 16){
		                    return '视频名长度限制2-16位!';
		             }
	            },
	            iDesc:function(value){
	                  if(value.length < 4){
		                    return '简介多写点吧,太少了!';
		             }
	            }
             });
			//监听提交
			form.on('submit(save)', function(formData) {
				$.ajax({
					url : '<%=basePath%>space/videoEdit',
  					type: "POST",
  					dataType: "JSON",
  					data:formData.field,
  					success: function(data, status) {
  						if(data.success){
  							layer.alert("修改成功", {icon: 6},function () {
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