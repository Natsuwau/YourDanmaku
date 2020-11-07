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
		<form action="" method="post" class="layui-form layui-form-pane">
			<div class="layui-form-item">
				<label for="name" class="layui-form-label">
					<span class="x-red">*</span>用户ID
				</label>
				<div class="layui-input-inline">
					<input type="text" id="sysUserId" name="id" required="" value="${id}" autocomplete="off"
						readonly="readonly" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item layui-form-text">
				<label class="layui-form-label"> 所有角色 </label>
				<table class="layui-table layui-input-block">
					<tbody><tr><td>
						<div class="layui-input-block">
							<!-- 嵌套循环，有点浪费服务器资源...,其实可以用js的 -->
							<c:if test="${not empty allRoles}">
								<c:forEach items="${allRoles}" var="role">
									<input type="checkbox" name="roles" title="${role.name}"  value ="${role.id}" 
										<c:forEach items="${userRoles}" var="userRole">
											${role.id eq userRole.id ? "checked": "" }
										</c:forEach>
									/>
								</c:forEach>
							</c:if>
						</div>
					</td></tr></tbody>
				</table>
			</div>
			<div class="layui-form-item">
				<button class="layui-btn" lay-submit="" lay-filter="save">修改角色</button>
			</div>
		</form>
	</div>
	<script src="<%=basePath%>assets/lib/layui/layui.js" charset="utf-8"></script>
	<script src="<%=basePath%>assets/js/x-layui.js" charset="utf-8"></script>
	<script>
		layui.use([ 'form', 'layer' ], function() {
			$ = layui.jquery;
			var form = layui.form(), 
			layer = layui.layer;

			//监听提交
			form.on('submit(save)', function(formData) {
				var id  = $('#sysUserId').val();
				//手动获取roles吧
				var allCheckBoxs = $('[name="roles"]');
              	var size=allCheckBoxs.length;
              	var roles = new Array();
              	for(var i=0;i < size;i++){
              		var obj = $(allCheckBoxs[i]);
              		var divObj =  $(obj.next("div"));
              		if(divObj.hasClass("layui-form-checked")){
              			roles.push(obj.val());
              		}
              	}
				$.ajax({
					url: '<%=basePath%>cms/sysUser/editRoles',
					type: "POST",
					dataType: "JSON",
					traditional: true,
					data:{
						"id":id,
						"roles":roles
					},
					success: function(data, status) {
						if(data.success){
							layer.alert("修改角色成功!", {icon: 6},function () {
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