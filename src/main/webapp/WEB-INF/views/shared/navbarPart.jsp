<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script src="<%=basePath%>assets/lib/layui/layui.js" charset="utf-8"></script>

<nav class="navbar navbar-inverse navbar-fixed-top">
	<div class="container-fluid">

		<div id="navbar" class="navbar-collapse collapse">
		<table  width="100%">
		<tbody>
		<tr>
		<td width="240">
			<div class="navbar-left mine-logo">
				<a class="navbar-brand" href="<%=basePath%>home">
					<div style="height: 59px;">
						<img src="<%=basePath%>assets/img/logo-pro.png" title="Hi,Danmaku!" height="49px" />
					</div>
				</a>
			</div>
			</td>
			<td>
			<div class="top-search navbar-left mine-search">
				<form class="navbar-form " action="<%=basePath%>search" method="get">
					<input name="searchKey" type="text" autocomplete="off" class="form-control" placeholder="搜索...">
					<input type="submit" value=" ">
				</form>
			</div>
			</td>
			<td width="270">
			<div class=" navbar-left mine-btn">
				<div class="file">
					<a href="<%=basePath%>upload">上传视频</a>
				</div>
				<c:choose>
					<c:when test="${empty sessionUser}">
						<div class="signin">
							<a href="<%=basePath%>login" class="play-icon popup-with-zoom-anim">登录</a>
						</div>
						<div class="signin">
							<a href="<%=basePath%>register" class="play-icon popup-with-zoom-anim">注册</a>
						</div>
					</c:when>
					<c:otherwise>
						<div class="signin mine-icon">
							<li class="dropdown">
										<a data-toggle="dropdown" class="dropdown-toggle" href="#">
											<c:choose>
												<c:when test="${not empty sessionUser.icon}">

													<img src="<%=imgBasePath%>${sessionUser.icon}" class="layui-circle"
														style="border: 2px solid #A9B7B7;" height="45px;" alt="">
													<strong class="caret">
												</c:when>
												<c:otherwise>
													<img src="<%=basePath%>assets/img/dog.gif" class="layui-circle"
														style="border: 2px solid #A9B7B7;" height="45px;" alt="">
													<strong class="caret">
												</c:otherwise>
											</c:choose>
											</strong>
										</a>
												<ul class="dropdown-menu">
									<li style="text-align: center;">
										<b onclick="javascript:location.href = '<%=basePath%>space/${sessionUser.id}';"
											style="${empty sessionUser.name?'color:#CCCCCC;':''}" title="点击进入个人空间">${empty sessionUser.name?"昵称尚未设置":sessionUser.name}</b>
									</li>
									<li class="divider">
									<li>
										<span class="span-left" title="uid"> <i class="fa fa-address-card-o"
											aria-hidden="true"></i>${sessionUser.id}
										</span> <span class="span-right" title="硬币"> <i class="fa fa-star-half-o"
											aria-hidden="true"></i>${sessionUser.coin}
										</span>
										<div class="clearfix"></div>
									</li>
									<li class="divider">
									<li>
										<a href="<%=basePath%>logout" class="mine-a">注销</a>
									</li>
								</ul>
							</li>
						</div>
						<div class="signin">
							<a id="mine_mark" onclick="signOn();" href="javascript:;"
								${sessionUser.marked?'class="mine-marked" disabled="disabled"':''}>${sessionUser.marked?' 已签到':'签到'}</a>
						</div>
					</c:otherwise>
				</c:choose>
				<div class="clearfix"></div>
			</div>
			</td>
			</tr>
			</tbody>
		</table>
		</div>
		<div class="clearfix"></div>
	</div>
</nav>
<script type="text/javascript">
	layui.use(['layer','flow','form'], function() {
		var flow = layui.flow;
		layer = layui.layer;
		var form = layui.form();
		});
		//签到请求
		function signOn(){
			var uid = '${sessionUser.id}';
			if(!uid){
				layer.msg("还没有登录...",{time:1000});
				return false;
			}
			var url = "<%=basePath%>space/${sessionUser.id}/signOn";
			$.post(url,{uid:uid}, 
					function(data){
					if(data.success){
						layer.msg("签到成功",{time:1000});
						$('#mine_mark').html("已签到");
						$('#mine_mark').addClass('mine-marked');
						//事件失效
						$('#mine_mark').unbind('click');
					}else{
						layer.msg(data.msg,{time:1000});
					}		
				});
		}
	</script>