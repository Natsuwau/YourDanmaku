<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/fn.tld" prefix="fn"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String imgBasePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ "/data/img/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>简单视频播放</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--页面加载进度条,光线,圈圈-->
<script src="<%=basePath%>assets/lib/pace/pace-1.0.2.js"></script>
<link rel="stylesheet" href="<%=basePath%>assets/lib/pace/themes/orange/pace-theme-flash.css" />

</head>

<body>
	<c:choose>
		<c:when test="${not empty errorMsg}">
			<h3>${errorMsg}</h3>
		</c:when>
		<c:otherwise>
			<div id="playerOne" class="dplayer"></div>
		</c:otherwise>
	</c:choose>
</body>
<script src="<%=basePath%>assets/js/DPlayer.min.js"></script>
<c:if test="${not empty one}">
	<script>
	var dp = new DPlayer({
		element: document.getElementById('playerOne'), // Optional, player element
		autoplay: true, // Optional, autoplay video, not supported by mobile browsers
		theme: '#F7764E', // Optional, theme color, default: #b7daff
		loop: false, // Optional, loop play music, default: true
		lang: 'zh', // Optional, language, `zh` for Chinese, `en` for English, default: Navigator language
		screenshot: true, // Optional, enable screenshot function, default: false, NOTICE: if set it to true, video and video poster must enable Cross-Origin
		hotkey: true, // Optional, binding hot key, including left right and Space, default: true
		preload: 'auto',
		video: { 
			url: '<%=basePath%>assets/uploadData/video/${one.url}', // Required, video link
			pic: '<%=imgBasePath%>${one.picUrl}', // Optional, video poster
			type : 'auto'
		}
		});
	</script>
</c:if>
</html>
