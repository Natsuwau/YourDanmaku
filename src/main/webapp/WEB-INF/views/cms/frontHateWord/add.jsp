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
        <title>Hi,Danmaku!-CMS </title>
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
            <form action="" method="post" class="layui-form layui-form-pane">
                <div class="layui-form-item">
                    <label for="roleName" class="layui-form-label">
                        <span class="x-red">*</span>角色名
                    </label>
                    <div class="layui-input-inline">
                        <input type="text" id="roleName" name="name" required="" lay-verify="roleName"
                        autocomplete="off" class="layui-input">
                    </div>
                </div>
                 <div class="layui-form-item">
				<label for="role" class="layui-form-label"> <span
					class="x-red">*</span>角色状态
				</label>
				<div class="layui-input-inline">
					<select id="rolestate" name="state">
						<option value="0" >冻结</option>
						<option value="1" >激活</option>
					</select>
				</div>
			</div>
                <div class="layui-form-item layui-form-text">
                    <label for="desc" class="layui-form-label">
                    	    描述
                    </label>
                    <div class="layui-input-block">
                        <textarea placeholder="随便写点什么吧" id="desc" name="desc" class="layui-textarea"></textarea>
                    </div>
                </div>
                <div class="layui-form-item">
                <button class="layui-btn" lay-submit="" lay-filter="add">增加</button>
              </div>
            </form>
        </div>
       <script src="<%=basePath%>assets/lib/layui/layui.js" charset="utf-8"></script>
        <script src="<%=basePath%>assets/js/x-layui.js" charset="utf-8"></script>
        <script>
            layui.use(['form','layer'], function(){
                $ = layui.jquery;
              var form = layui.form()
              ,layer = layui.layer;
              
              form.verify({
            	 roleName: [/(.+){2,10}$/, '角色名长度限制2-10位']
              });
              //监听提交
              form.on('submit(add)', function(formData){
            	  $.ajax({
  					url: '<%=basePath%>cms/sysRole/add',
  					type: "POST",
  					dataType: "JSON",
  					data:formData.field,
  					success: function(data, status) {
  						if(data.success){
  							layer.alert("增加成功", {icon: 6},function () {
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