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
		<title>Hi,Danmaku!-CMS</title>
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
            <form class="layui-form">
               <div class="layui-form-item">
				<label for="id" class="layui-form-label"> <span
					class="x-red">*</span>用户ID
				</label>
				<div class="layui-input-inline">
					<input type="text" id="userid" name="id" required="" readonly="readonly"
						lay-verify="userId" autocomplete="off" value="${one.id}" class="layui-input">
				</div>
				<div class="layui-form-mid layui-word-aux">
					<span class="x-red">*</span>用户ID无法修改
				</div>
			</div>
                <div class="layui-form-item">
				<label for="name" class="layui-form-label"> <span
					class="x-red">*</span>昵称
				</label>
				<div class="layui-input-inline">
					<input type="text" id="username" name="name" required="" 
						lay-verify="username" autocomplete="off" value="${one.name}" class="layui-input">
				</div>
				<div class="layui-form-mid layui-word-aux">
					<span class="x-red">*</span>长度2-10位
				</div>
			</div>
               <div class="layui-form-item">
				<label for="userState" class="layui-form-label"> <span
					class="x-red">*</span>账号状态
				</label>
				<div class="layui-input-inline">
					<select id="userState" name="state">
						<option value="0" ${one.state eq 0 ? 'selected="selected"' :  ''}>冻结</option>
						<option value="1" ${one.state eq 1 ? 'selected="selected"' :  ''}>激活</option>
					</select>
				</div>
			</div>
			<div class="layui-form-item">
				<label for="userdesc" class="layui-form-label"> <span
					class="x-red"></span>说明
				</label>
				<div class="layui-input-inline">
					<textarea id="userdesc" name="desc" placeholder="随便写点什么吧"
						class="layui-textarea">${one.desc}</textarea>
				</div>
				<div class="layui-form-mid layui-word-aux">
					<span class="x-red">可选</span>
				</div>
			</div>
                <div class="layui-form-item">
                    <label for="L_repass" class="layui-form-label">
                    </label>
                    <button  class="layui-btn" lay-filter="save" lay-submit="">
                        保存修改
                    </button>
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
              form.on('submit(save)', function(formData){
               //JSON.stringify(data.field);
                $.ajax({
					url: '<%=basePath%>cms/sysUser/edit',
					type: "POST",
					dataType: "JSON",
					data:formData.field,
					success: function(data, status) {
						if(data.success){
							layer.alert("修改成功", {icon: 6},function () {
								//刷新父页面
								parent.location.reload(); 
			                    // 获得frame索引
			                    var index = parent.layer.getFrameIndex(window.name);
			                    //关闭当前frame
			                    parent.layer.close(index);
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