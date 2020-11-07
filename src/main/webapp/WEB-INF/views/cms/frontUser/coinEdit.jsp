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
       		<c:if test="${not empty errMsg}">
        		<blockquote class="layui-elem-quote">${errMsg}</blockquote>
			</c:if>
            <form action="" method="post" class="layui-form layui-form-pane">
            	 <div class="layui-form-item">
                    <label for="roleid" class="layui-form-label">
                        <span class="x-red">*</span>会员ID
                    </label>
                    <div class="layui-input-inline">
                        <input type="text" id="roleid" name="id" required="" lay-verify="required" value="${one.id}" readonly="readonly"
                        autocomplete="off" class="layui-input">
                    </div>
                </div>
                 <div class="layui-form-item">
                    <label for="roleid" class="layui-form-label">
                        <span class="x-red">*</span>硬币数
                    </label>
                    <div class="layui-input-inline">
                        <input type="text" id="roleid" name="coin" required="" lay-verify="required" value="${empty one.coin ? 0: one.coin}" readonly="readonly"
                        autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
					<label for="rolestate" class="layui-form-label"> <span
						class="x-red">*</span>变动原因
					</label>
					<div class="layui-input-inline">
						      <input type="radio" name="type" value="add" title="奖励" checked>
	    					  <input type="radio" name="type" value="minus" title="惩罚">
					</div>
				</div>
                <div class="layui-form-item">
                    <label for="roleid" class="layui-form-label">
                        <span class="x-red">*</span>改动数目
                    </label>
                    <div class="layui-input-inline">
                        <input type="text" id="roleid" name="num" required="" lay-verify="mine_num" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                <button class="layui-btn" lay-submit="" lay-filter="save">硬币改动</button>
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
            	  mine_num: [/^[0-9]{1,}$/, '请输入有效数字']
               });
              //监听提交
              form.on('submit(save)', function(formData){
            	  $.ajax({
  					url: '<%=basePath%>cms/frontUser/coinEdit',
  					type: "POST",
  					dataType: "JSON",
  					data:formData.field,
  					success: function(data, status) {
  						if(data.success){
  							layer.alert("改动硬币数成功", {icon: 6},function () {
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