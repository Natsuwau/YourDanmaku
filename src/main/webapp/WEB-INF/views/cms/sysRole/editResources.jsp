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
        <link rel="stylesheet" href="<%=basePath%>assets/lib/zTree/css/metroStyle/metroStyle.css" media="all">
    </head>
    
    <body>
        <div class="x-body">
            <form action="" method="post" class="layui-form layui-form-pane">
            	<div class="layui-form-item layui-form-text">
                    <label for="sysRoleid" class="layui-form-label">
                        <span class="x-red">*</span>角色ID
                    </label>
                    <div class="layui-input-inline ">
                        <input type="text" id="sysRoleid" name="id" required="" lay-verify="required" value="${id}" readonly="readonly"
                        autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item layui-form-text">
                    <label for="treeDemoTwo" class="layui-form-label">
                        	所拥有资源
                    </label>
                    <div class="layui-input-block">
                        <ul id="treeDemoTwo" class="ztree"></ul>
                    </div>
                </div>
                <div class="layui-form-item">
                <button class="layui-btn" lay-submit="" lay-filter="save">保存修改</button>
              </div>
            </form>
        </div>
        <script src="<%=basePath%>assets/lib/layui/layui.js" charset="utf-8"></script>
        <script src="<%=basePath%>assets/js/x-layui.js" charset="utf-8"></script>
        <script src="<%=basePath%>assets/js/jquery.min.js" charset="utf-8"></script>
        <script src="<%=basePath%>assets/lib/zTree/js/jquery.ztree.core.min.js" charset="utf-8"></script>
        <script src="<%=basePath%>assets/lib/zTree/js/jquery.ztree.excheck.min.js" charset="utf-8"></script>
        <script>
            layui.use(['form','layer'], function(){
            	$ = layui.jquery;
    			var form = layui.form(), 
    			layer = layui.layer;
              //监听提交
              form.on('submit(save)', function(formData){
            	 //获取id
            	 var id  = $('#sysRoleid').val();
            	 //获取选中数组
            	 var zTree = $.fn.zTree.getZTreeObj("treeDemoTwo");
            	 var checkedResources = zTree.getCheckedNodes(true);
            	 var resources = new Array();
            	 for(var i=0;i<checkedResources.length;i++){
            		 resources.push(checkedResources[i].id);
     			}
            	 $.ajax({
 					url: '<%=basePath%>cms/sysRole/editResources',
 					type: "POST",
 					dataType: "JSON",
 					traditional: true,
 					data:{
 						"id":id,
 						"resources":resources
 					},
 					success: function(data, status) {
 						if(data.success){
 							layer.alert("修改角色拥有资源成功!", {icon: 6},function () {
 								parent.location.reload(); //刷新父页面
 			                    var index = parent.layer.getFrameIndex(window.name);// 获得frame索引
 			                    parent.layer.close(index);  //关闭当前frame
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
        <script  type="text/javascript">
		var settingTwo = {
			check: {
				enable: true,
				chkboxType:{ "Y" : "ps", "N" : "ps" }
			},
			data: {
				simpleData: {
					enable: true
				}
			}
			
		};

		var zNodesTwo =[
			<c:forEach items="${target}" var="one" varStatus="oneInfo">
				{ id:"${one.id}",
				  pId:"${one.upLevelId}", name:"${one.name}", 
				  checked:${one.checked}
				}
				${oneInfo.last ? "" :","}
			</c:forEach>
		];
		
		$(document).ready(function(){
			$.fn.zTree.init($("#treeDemoTwo"), settingTwo, zNodesTwo);
		});
		
		function show(){
			var zTree = $.fn.zTree.getZTreeObj("treeDemoTwo");
			var checkCount = zTree.getCheckedNodes(true);
			var nocheckCount = zTree.getCheckedNodes(false);
			var changeCount = zTree.getChangeCheckedNodes();
			var str="";
			for(var i=0;i<checkCount.length;i++){
				str=str+" ["+checkCount[i].id+"_"+checkCount[i].name+"]";
			}
			alert(str);
		}
        </script>
    </body>

</html>