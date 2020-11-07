<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/fn.tld" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/fmt.tld" prefix="fmt"%>
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
<!DOCTYPE HTML>
<html>
<head>
<title>${empty one.name ?'single': one.name}</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="shortcut icon" type="image/png" href="<%=basePath%>assets/img/logo.ico" media="screen" />
<script type="application/x-javascript">
			addEventListener("load", function() {
				setTimeout(hideURLbar, 0);
			}, false);

			function hideURLbar() {
				window.scrollTo(0, 1);
			}
</script>
<!--聪明的小标题-->
<script src="<%=basePath%>assets/js/cute-title.js"></script>
<!--页面加载进度条,光线,圈圈-->
<script src="<%=basePath%>assets/lib/pace/pace-1.0.2.js"></script>
<link rel="stylesheet" href="<%=basePath%>assets/lib/pace/themes/orange/pace-theme-flash.css" />
<link rel="stylesheet" href="<%=basePath%>assets/lib/layui/css/layui.css" media="all">
<!-- bootstrap -->
<link href="<%=basePath%>assets/lib/bootstrap/css/bootstrap.min.css" rel='stylesheet'
	type='text/css' media="all" />
<link rel="stylesheet" href="<%=basePath%>assets/css/x-admin.css" media="all">
<!-- //bootstrap -->
<link href="<%=basePath%>assets/css/dashboard.css" rel="stylesheet">
<!-- Custom Theme files -->
<link href="<%=basePath%>assets/css/style.css" rel='stylesheet' type='text/css' media="all" />
<script src="<%=basePath%>assets/js/jquery-1.11.1.min.js"></script>
<!--start-smoth-scrolling-->
<link href="<%=basePath%>assets/lib/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet"
	type="text/css">
<!--回到顶部-->
<link rel="stylesheet" href="<%=basePath%>assets/lib/to-top/to-top.css" media="all">
<style>
.dplayer .dplayer-controller .dplayer-icons .dplayer-comment .dplayer-comment-box .dplayer-comment-setting-box .dplayer-comment-setting-type label
	{
	display: inline !important;
}

a {
	text-decoration: none !important;
}
</style>
</head>
<body>
	<!--导航栏-->
	<%@include file="../shared/navbarPart.jsp"%>
	<!--侧面列表-->
	<%@include file="../shared/menuPart.jsp"%>

	<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
		<div class="show-top-grids">
			<div class="col-sm-10 single-left">
				<c:choose>
					<c:when test="${(not empty errorMsg)}">
						<blockquote class="layui-elem-quote layui-quote-nm">${errorMsg}</blockquote>
					</c:when>
					<c:otherwise>
						<div class="song">
							<div class="video-grid">
								<div id="playerOne" class="dplayer"></div>
							</div>
						</div>
						<div class="song-info">
							<h3>视频名:${one.name}</h3>
						</div>
						<div class="clearfix"></div>
						<div class="published">
							<div class="load_more">
								<ul id="myList">
									<li>
										<h4>
											上传用户:
											<a href="<%=basePath%>space/${one.frontUserId}" class="author">${one.frontUserId}</a>
										</h4>
										<hr>
										<table>
											<tbody>
												<tr>
													<td width="150"><b>类型:&nbsp;</b>${one.typeName}</td>
													<td width="150"><b>观看权限:&nbsp;</b> <span>${one.scope eq "@user" ? "仅限会员" :  "所有人"}
													</span></td>
													<td width="250"><b>上传时间:&nbsp;</b> <fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
															value="${one.uploadTime}" /></td>
													<td width="200"><b>视频长度:&nbsp;</b>${one.durationStr}</td>
												</tr>
											</tbody>
										</table>
										<hr>
										<h4>简介</h4>
										<p>${one.desc }</p>
									</li>
								</ul>
							</div>
						</div>
						<div class="all-comments">
							<div class="all-comments-info">
								<div class="box">
									<form id="saveInfo" class="layui-form" action="">
										<div class="layui-form-item layui-form-text">
											<div class="">
												<input type="hidden" name="id" value="${sessionUser.id }" lay-verify="mine_id"
													class="layui-input">
													<input type="hidden" name="vid" value="${one.id }" lay-verify="required"
													class="layui-input">
												<textarea id = "mine_text" name="text" autocomplete="off" placeholder="写点什么吧" class="layui-textarea" lay-verify="iText"></textarea>
											</div>
										</div>
										<div class="layui-form-item">
											<div class="">
												<button class="layui-btn layui-btn-danger" lay-filter="saveInfo" lay-submit="">
													立即评论</button>
											</div>
										</div>
										<div class="clearfix"></div>
									</form>
								</div>
							</div>
							<h4>所有评论</h4>
							<ul class="media-grids flow-default" id="LAY_demo2">
							</ul>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="col-md-2 single-right">
				<h3>相关视频</h3>
				<div class="single-grid-right">
					<c:choose>
						<c:when test="${(empty relevantList) or (fn:length(relevantList)<1)}">
							<blockquote class="layui-elem-quote layui-quote-nm">相关为空</blockquote>
						</c:when>
						<c:otherwise>
							<c:forEach items="${relevantList}" var="rOne">
								<div class="single-right-grids">
									<div class="resent-grid-img recommended-grid-img zoom-container">
										<a href="<%=basePath%>single/${rOne.id}">
											<span class="zoom-caption"> <i class="icon-play fa fa-play mini-icon"></i>
												<p>${rOne.name}</p>
											</span> <img src="<%=imgBasePath%>${rOne.coverUrl}" alt="图片已损坏" />
										</a>
									</div>
									<div class="clearfix"></div>
								</div>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<div class="clearfix"></div>
		</div>
		<a class="to-top itop" title="回到顶部"></a>
		<!-- footer -->
		<%@include file="../shared/footerPart.jsp"%>
	</div>
	<div class="clearfix"></div>
	<script src="<%=basePath%>assets/lib/bootstrap/js/bootstrap.min.js"></script>
	<script src="<%=basePath%>assets/lib/layui/layui.js" charset="utf-8"></script>
	<script src="<%=basePath%>assets/js/x-admin.js"></script>
	<script src="<%=basePath%>assets/js/DPlayer.min.js"></script>
	<script src="<%=basePath%>assets/lib/to-top/to-top.js" type="text/javascript" charset="utf-8"></script>
	<script>
			var dp = new DPlayer({
				element: document.getElementById('playerOne'), // Optional, player element
				autoplay: false, // Optional, autoplay video, not supported by mobile browsers
				theme: '#F7764E', // Optional, theme color, default: #b7daff
				loop: false, // Optional, loop play music, default: true
				lang: 'zh', // Optional, language, `zh` for Chinese, `en` for English, default: Navigator language
				screenshot: true, // Optional, enable screenshot function, default: false, NOTICE: if set it to true, video and video poster must enable Cross-Origin
				hotkey: true, // Optional, binding hot key, including left right and Space, default: true
				preload: 'auto', // Optional, the way to load music, can be 'none' 'metadata' 'auto', default: 'auto'
				video: { // Required, video info
					url: '<%=basePath%>assets/uploadData/video/${one.url}', // Required, video link
					pic: '<%=imgBasePath%>${one.picUrl}', // Optional, video poster
				type : 'auto' // Optional, video type, `flv` for flv format, `hls` for m3u8 format, `normal` for mp4 ogg and webm format, `auto` for automatic detection, default: `auto`
			},
			danmaku : { // Optional, showing danmaku, ignore this option to hide danmaku
				id : '${one.id}', // Required, danmaku id, NOTICE: it must be unique, can not use these in your new player: `https://api.prprpr.me/dplayer/list`
				//				api: 'http://127.0.0.1/DanmakuDemo/danmaku', // Required, danmaku api  
				api : '<%=basePath%>single/danmaku',
				author : '${sessionUser.id}',
				token : 'Hi,Danmaku!', // Optional, danmaku token for api
				maximum : 1000, // Optional, maximum quantity of danmaku 弹幕总量
			//				addition: ['https://api.prprpr.me/dplayer/bilibili?aid=4157142'] // Optional, additional danmaku, see: `Bilibili 弹幕支持`

			}
		});
	</script>
	<script type="text/javascript">
	Date.prototype.Format = function (fmt) { //author: meizz 
	    var o = {
	        "M+": this.getMonth() + 1, //月份 
	        "d+": this.getDate(), //日 
	        "h+": this.getHours(), //小时 
	        "m+": this.getMinutes(), //分 
	        "s+": this.getSeconds(), //秒 
	        "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
	        "S": this.getMilliseconds() //毫秒 
	    };
	    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
	    for (var k in o)
	    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
	    return fmt;
	}; 
	</script>
	<script>
	var xNext = null;
	function load_comment(page, xNext) {
			var url ="<%=basePath%>single/comment";
			//获取数据
			$.get(url,
					{ 
					  "vid":'${one.id}',
					  "nowPage": page,
					  "pageSize":4
					}, 
				function(data){
					var lis = [];
					if(data.success){
						var pageInfo = data.obj;
						var pageSize = pageInfo.pageSize;
						var pageCount = pageInfo.pageCount;
						var basePageList = 	pageInfo.basePageList;
						layer.msg("评论加载中...",{time:1000});
						setTimeout(function() {
							
							for(var i = 0; i < basePageList.length; i++) {
								var one = basePageList[i];
								var name = one.frontUser.name == null?"用户未命名":one.frontUser.name.toString();
								var x = '<li class="media"><div class="media-left"><a href="<%=basePath%>space/'
										+one.frontUser.id.toString()+
										'"><img src="<%=basePath%>assets/img/dog.gif"'
										+'class="layui-circle"style="border: 2px solid #A9B7B7;" height="64px;" alt=""/></a>'
										+'</div><div class="media-body"><h5>'
										+name+
										'</h5><p>'
										+one.content.toString()+
										'</p><span>评论时间 :'
										+new Date(one.time).Format("yyyy-MM-dd hh:mm:ss").toString()+
										'</span></div></li>';
								lis.push(x);
							}
							if(lis.length>0){
								lis.push("<hr>");
							}
							next(lis.join(''), page < pageCount); //总页数
						}, 500);
					}else{
						layer.msg(data.msg);
						next(lis.join(''), page < 0); //总页数
						return;
					}
			},"JSON");
		}
layui.use(['layer','flow','form'], function() {
	var flow = layui.flow;
	layer = layui.layer;
	var form = layui.form();
	flow.load({
		elem: '#LAY_demo2' //流加载容器
			,
		scrollElem: '#LAY_demo2' //滚动条所在元素，一般不用填，此处只是演示需要。
			,
		isAuto: false,
		isLazyimg: true,
		done:function(page, next) { xNext = next;  
		var url ="<%=basePath%>single/comment";
		//获取数据
		$.get(url,
				{ 
				  "vid":'${one.id}',
				  "nowPage": page,
				  "pageSize":4
				}, 
			function(data){
				var lis = [];
				if(data.success){
					var pageInfo = data.obj;
					var pageSize = pageInfo.pageSize;
					var pageCount = pageInfo.pageCount;
					var basePageList = 	pageInfo.basePageList;
					layer.msg("评论加载中...",{time:1000});
					setTimeout(function() {
						
						for(var i = 0; i < basePageList.length; i++) {
							var one = basePageList[i];
							var name = one.frontUser.name == null?"用户未命名":one.frontUser.name.toString();
							var x = '<li class="media"><div class="media-left"><a href="<%=basePath%>space/'
									+one.frontUser.id.toString()+
									'"><img src="<%=basePath%>assets/img/dog.gif"'
									+'class="layui-circle"style="border: 2px solid #A9B7B7;" height="64px;" alt=""/></a>'
									+'</div><div class="media-body"><h5>'
									+name+
									'</h5><p>'
									+one.content.toString()+
									'</p><span>评论时间 :'
									+new Date(one.time).Format("yyyy-MM-dd hh:mm:ss").toString()+
									'</span></div></li>';
							lis.push(x);
						}
						if(lis.length>0){
							lis.push("<hr>");
						}
						next(lis.join(''), page < pageCount); //总页数
					}, 500);
				}else{
					layer.msg(data.msg);
					next(lis.join(''), page < 0); //总页数
					return;
				}
		},"JSON");
		}
	});
	
	form.verify({
              mine_id:function(value){
                 if(!value){
                    return '登录后才能评论...';
             }
           },
           iText:function(value){
                 if(value.length < 4){
                    return '多写一点吧!';
             }
           }
           });
	//监听提交
	form.on('submit(saveInfo)', function(formData) {
		var url = "<%=basePath%>single/comment";
		var fData = formData.field;
		$.post(url,fData, 
			function(data){
			if(data.success){
				layer.msg("评论成功,刷新可见",{time:1000});
				$('#mine_text').val("");
				//load_comment(1,xNext);
			}else{
				layer.msg(data.msg,{time:1000});
			}		
		});
		return false;
	});
});
		</script>
	<script>
		$(document).ready(function() {
			size_li = $("#myList li").size();
			x = 1;
			$('#myList li:lt(' + x + ')').show();
			$('#loadMore').click(function() {
				x = (x + 1 <= size_li) ? x + 1 : size_li;
				$('#myList li:lt(' + x + ')').show();
			});
			$('#showLess').click(function() {
				x = (x - 1 < 0) ? 1 : x - 1;
				$('#myList li').not(':lt(' + x + ')').hide();
			});
		});
	</script>
</body>

</html>