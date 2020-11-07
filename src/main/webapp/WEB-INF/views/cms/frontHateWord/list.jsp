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
<link rel="stylesheet" href="<%=basePath%>assets/lib/font-awesome-4.7.0/css/font-awesome.min.css"
	media="all">
</head>
<body>
	<div class="x-nav">
		<span class="layui-breadcrumb"> <a>
				<cite>首页</cite>
			</a> <a>
				<cite>系统管理</cite>
			</a> <a>
				<cite>关键字管理</cite>
			</a>
		</span>
		<a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right"
			href="javascript:location.replace(location.href);" title="刷新">
			<i class="layui-icon" style="line-height:30px">ဂ</i>
		</a>
	</div>
	<div class="x-body">
		<form class="layui-form x-center" action="" style="width:50%">
                <div class="layui-form-pane" style="margin-top: 15px;">
                  <div class="layui-form-item">
                    <div class="layui-input-inline" style="width:120px;text-align: left">
                        <input type="text" name="word"  placeholder="关键字" required autocomplete="off" class="layui-input">
                    </div>
                    <div class="layui-input-inline" style="width:120px">
                        <input type="text" name="target"  placeholder="替换字" required autocomplete="off" class="layui-input">
                    </div>
                    <div class="layui-input-inline" style="width:80px">
                        <button class="layui-btn"  lay-submit="" lay-filter="add"><i class="layui-icon">&#xe608;</i>增加</button>
                    </div>
                  </div>
                </div> 
            </form>
		<form class="layui-form x-center" action="<%=basePath%>cms/frontHateWord/list">
			<div class="layui-form-pane" style="margin-top: 15px;">
				<div class="layui-form-item">
					<div class="layui-input-inline">
						<input type="text" id="searchKey" name="searchKey" placeholder="搜索..." autocomplete="off" class="layui-input">
					</div>
					<div class="layui-input-inline" style="width:80px">
						<button class="layui-btn" lay-submit="" lay-filter="sreach">
							<i class="layui-icon">&#xe615;</i>
						</button>
					</div>
				</div>
			</div>
		</form>
		<xblock>
		<button class="layui-btn layui-btn-warm" onclick="push()">
			<i class="layui-icon">&#xe609;</i>&nbsp;Push最新
		</button>
		<span class="x-right" style="line-height:40px">共有数据：${pageInfo.rootListSize}
			条</span></xblock>
		<table class="layui-table">
			<thead>
				<tr>
					<th>源字符</th>
					<th>目标字符</th>
					<th>状态</th>
					<th>操作</th>
				</tr>
			</thead>
			<c:choose>
				<c:when test="${(empty pageInfo.basePageList) or (fn:length(pageInfo.basePageList)<1)}">
					<blockquote class="layui-elem-quote layui-quote-nm">关键字列表为空!</blockquote>
				</c:when>
				<c:otherwise>
					<tbody>
						<c:forEach items="${pageInfo.basePageList}" var="one">
							<tr title="id:${one.id}">
								<td>${one.word}</td>
								<td>${one.target}</td>
								<td class="td-status"><span
									class="layui-btn ${one.state eq 1 ? 'layui-btn-normal' :  'layui-btn-danger'} layui-btn-mini">${one.state eq 1 ? "激活" :  "停用"}
								</span>
								</td>
								<td class="td-manage"><a title="删除" href="javascript:;" onclick="del(this,'${one.id}')"
										style="text-decoration:none">
										<i class="layui-icon" >&#x1006;</i>
									</a>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</c:otherwise>
			</c:choose>
		</table>

		<div id="page"></div>
	</div>
	<script src="<%=basePath%>assets/lib/layui/layui.js" charset="utf-8"></script>
	<script src="<%=basePath%>assets/js/x-layui.js" charset="utf-8"></script>
	<script>
		layui.use([ 'form', 'laypage', 'layer' ], function() {
			$ = layui.jquery;//jquery
			form = layui.form();
			laydate = layui.laydate;//日期插件
			laypage = layui.laypage;//分页
			layer = layui.layer;//弹出层
			
			//监听提交
            form.on('submit(add)', function(formData){
          	  $.ajax({
					url: '<%=basePath%>cms/frontHateWord/add',
					type: "POST",
					dataType: "JSON",
					data:formData.field,
					success: function(data, status) {
						if(data.success){
							layer.alert("增加成功", {icon: 6},function () {
								location.replace(location.href);
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
			
			//以上模块根据需要引入
			laypage({
				cont : 'page',
				pages : ${pageInfo.pageCount},
				curr : ${pageInfo.nowPage}, //当前页
				first : 1,
				last : ${pageInfo.pageCount},
				prev : '上一页',
				next : '下一页',
				jump: function(obj, first){
				    //得到了当前页，用于向服务端请求对应数据
				    if(!first){
					    var nowPage = obj.curr;//目标页
					    var url = '<%=basePath%>cms/frontHateWord/list?nowPage='+nowPage;
					    var searchKey = $('#searchKey').val();
					    if(!searchKey){
					    	url+="&searchKey="+searchKey;
					    }
					    location.href=url;
				    }
			    }
			});
		});

		function push() {
			var url ="<%=basePath%>cms/frontHateWord/pushNew";
			$.post(url,{}, function(data){
				if(data.success){
					var msg = "已推送";					
					layer.msg(msg);
				}else{
					layer.msg(data.msg);
				}
			},"JSON");
		}

		/*删除*/
		function del(obj, id) {
			layer.confirm('确认要删除吗？', function(index) {
				//发异步删除数据
				var url ="<%=basePath%>cms/frontHateWord/del";
				$.post(url,{ "id": id}, function(data){
					if(data.success){
						var msg = "关键字已删除";					
						layer.alert(msg, {icon: 6},function () {
							location.replace(location.href);
		                });
					}else{
						layer.msg(data.msg, {
							offset: '20%',
							anim: 6,
							icon: 5,
						});	
					}
				},"JSON");
			});
		}
	</script>
</body>
</html>