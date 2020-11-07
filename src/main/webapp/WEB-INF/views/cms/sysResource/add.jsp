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
            <form action="" method="post" class="layui-form layui-form-pane">
                <div class="layui-form-item">
                    <label for="resourceName" class="layui-form-label">
                        <span class="x-red">*</span>资源名
                    </label>
                    <div class="layui-input-inline">
                        <input type="text" id="resourceName" name="name" required="" lay-verify="resourceName"
                        autocomplete="off" class="layui-input">
                    </div>
                </div>
                  <div class="layui-form-item">
					<label for="resourceType" class="layui-form-label"> 
					<span class="x-red">*</span>类型
					</label>
					<div class="layui-input-inline">
						<select id="resourceType" name="type">
							<option value="menu" >菜单资源</option>
							<option value="button" >按钮资源</option>
							<option value="common" >一般资源</option>
						</select>
					</div>
				</div>
                <div class="layui-form-item">
					<label for="resourceLevel" class="layui-form-label"> 
						<span class="x-red"></span>菜单级别
					</label>
					<div class="layui-input-inline">
						<select id="resourceLevel" name="level" lay-verify="resourceLevel">
							<option value="-1" >未设置</option>
							<option value="0" >目录菜单</option>
							<option value="1" >url菜单</option>
						</select>
					</div>
				</div>
                <div class="layui-form-item">
					<label for="resourceUplevelid" class="layui-form-label"> 
						<span class="x-red"></span>上级菜单
					</label>
					<div class="layui-input-inline">
						<select id="resourceUplevelid" name="upLevelId" lay-verify="resourceUplevelid">
							<option value="-1" >未设置</option>
							<option value="0" >顶级菜单</option>
							<c:if test="${not empty cataMenus}">
								<c:forEach items="${cataMenus}" var="oneMenu">
									<option value="${oneMenu.id}" >${oneMenu.name}</option>
								</c:forEach>
							</c:if>
						</select>
					</div>
				</div>
				 <div class="layui-form-item">
                    <label for="resourceIcon" class="layui-form-label">
                       	<a href="http://www.layui.com/doc/element/icon.html" target="_blank" title="点击查看图标信息,不需要分号">资源图标</a>
                    </label>
                    <div class="layui-input-inline">
                        <input type="text" id="resourceIcon" name="icon"  autocomplete="off" class="layui-input">
                    </div>
                </div>
				<div class="layui-form-item ">
                    <label for="resourcePriority" class="layui-form-label">
                    	    显示顺序
                    </label>
                    <div class="layui-input-block">
                        <input type="text" id="resourcePriority" name="priority"  autocomplete="off" class="layui-input">
                    </div>
                </div>
                 <div class="layui-form-item ">
                    <label for="resourceUrl" class="layui-form-label">
                    	    资源URL
                    </label>
                    <div class="layui-input-block">
                        <input type="text" id="resourceUrl" name="url"  autocomplete="off" class="layui-input">
                    </div>
                </div>
                 <div class="layui-form-item ">
                    <label for="resourcePermission" class="layui-form-label">
                    	    权限字符
                    </label>
                    <div class="layui-input-block">
                        <input type="text" id="resourcePermission" name="permission"  autocomplete="off" class="layui-input">
                    </div>
                </div>
                 <div class="layui-form-item">
					<label for="role" class="layui-form-label"> <span
						class="x-red">*</span>资源状态
					</label>
					<div class="layui-input-inline">
						<select id="rolestate" name="state">
							<option value="0" >冻结</option>
							<option value="1" >激活</option>
						</select>
					</div>
				</div>
                <div class="layui-form-item layui-form-text ">
                    <label for="resourceOther" class="layui-form-label">
                    	    补充信息
                    </label>
                    <div class="layui-input-block">
                        <input type="text" id="resourceOther" name="other"  autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                <button class="layui-btn" lay-submit="" lay-filter="add">资源添加</button>
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
            	  resourceName: function(value){
	                  if(value.length < 2 || value.length > 10){
	                    return '资源名长度限制2-10位!';
	                  }
               	 },resourceLevel: function(value){
               		  var type = $("#resourceType").val();
	                  if(type == "menu" && value == "-1" ){
	                    return '菜单资源需要选择菜单级别!';
	                  }
             	 },resourceUplevelid: function(value){
             		  var type = $("#resourceType").val();
	                  if((type == "menu" || type == "button") && value == "-1"){
		                  return '非一般资源需要选择上级菜单!';
		              }
             	 }
              });
              //监听提交
              form.on('submit(add)', function(formData){
            	  $.ajax({
  					url: '<%=basePath%>cms/sysResource/add',
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