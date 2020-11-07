<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/fn.tld" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/shiro.tld" prefix="shiro" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String imgBasePath = request.getScheme() + "://"
		+ request.getServerName() + ":" + request.getServerPort()
		+ "/data/img/";
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>
			Hi,Danmaku!-CMS
		</title>
		<meta name="renderer" content="webkit">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="format-detection" content="telephone=no">
		<link rel="stylesheet" href="<%=basePath%>assets/css/x-admin.css" media="all">
		<link href="<%=basePath%>assets/lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">
		<link href="<%=basePath%>assets/lib/bootstrap-fileinput/css/fileinput.min.css" media="all" rel="stylesheet" type="text/css" />
		<link href="<%=basePath%>assets/lib/bootstrap-fileinput/themes/explorer/theme.min.css" media="all" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" href="<%=basePath%>assets/lib/font-awesome-4.7.0/css/font-awesome.min.css" media="all">
	</head>

	<body>
		<div class="x-body">
			<blockquote class="layui-elem-quote">
				上传组件测试
			</blockquote>
			<div class="form-group">
				<input id="file-4" type="file" name = "videoFile" class="file-loading" data-min-file-count="1">
			</div>
			<button class="btn" onclick="updateStateCell(0, '50%');">修改进度条</button>
		</div>
		<div class="layui-footer footer footer-demo">
			<div class="layui-main">
				<p>感谢layui,百度Echarts,jquery</p>
				<p>
					<a href="/">
						Copyright ©2017 x-admin v2.3 All Rights Reserved.
					</a>
				</p>
				<p>
					<a href="./" target="_blank">
						本后台系统由X前端框架提供前端技术支持
					</a>
				</p>
			</div>
		</div>
		<script src="<%=basePath%>assets/js/jquery-2.0.0.min.js"></script>
		<script src="<%=basePath%>assets/lib/layui/layui.js" charset="utf-8"></script>
		<script src="<%=basePath%>assets/js/x-admin.js"></script>
		<script src="<%=basePath%>assets/lib/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
		<script src="<%=basePath%>assets/lib/bootstrap-fileinput/js/plugins/sortable.min.js" type="text/javascript"></script>
		<script src="<%=basePath%>assets/lib/bootstrap-fileinput/js/fileinput.js" type="text/javascript"></script>
		<script src="<%=basePath%>assets/lib/bootstrap-fileinput/js/locales/zh.js" type="text/javascript"></script>
		<script src="<%=basePath%>assets/lib/bootstrap-fileinput/themes/explorer/theme.js" type="text/javascript"></script>
		<script>
			$("#file-4").fileinput({
				language: 'zh',
				uploadAsync: true,
				uploadUrl: "<%=basePath%>test/update", //上传的地址
				showPreview: true, //是否显示预览
				allowedPreviewTypes: ['video'], //指定预览格式
				initialPreviewAsData: false, //配置上传后是否显示上传预览
				allowedFileExtensions: ['mp4', 'flv'], //接收的文件后缀
				dropZoneEnabled: true, //是否显示拖拽区域
				browseOnZoneClick: true,
				dropZoneTitle: "你可以拖拽/点击选取视频文件(MP4,FLV)到此处...", //是否显示拖拽区域
				maxFileSize: 0, //单位为kb，如果为0表示不限制文件大小
				maxFileCount: 1, //表示允许同时上传的最大文件个数
				enctype: 'multipart/form-data',
				previewFileIconSettings: {
					'doc': '<i class="fa fa-file-word-o text-muted"></i>',
					'xls': '<i class="fa fa-file-excel-o text-muted"></i>',
					'ppt': '<i class="fa fa-file-powerpoint-o text-muted"></i>',
					'jpg': '<i class="fa fa-file-photo-o text-muted"></i>',
					'jpeg': '<i class="fa fa-file-photo-o text-muted"></i>',
					'bmp': '<i class="fa fa-file-photo-o text-muted"></i>',
					'gif': '<i class="fa fa-file-photo-o text-muted"></i>',
					'jpg': '<i class="fa fa-file-photo-o text-muted"></i>',
					'pdf': '<i class="fa fa-file-pdf-o text-muted"></i>',
					'zip': '<i class="fa fa-file-archive-o text-muted"></i>',
					'mp3': '<i class="fa fa-file-audio-o  text-muted"></i>',
					'OGG': '<i class="fa fa-file-audio-o  text-muted"></i>',
					'WAV': '<i class="fa fa-file-audio-o  text-muted"></i>',
					'AAC': '<i class="fa fa-file-audio-o  text-muted"></i>',
					'avi': '<i class="fa fa-file-video-o  text-muted"></i>',
					'rmvb': '<i class="fa fa-file-video-o  text-muted"></i>',
					'flv': '<i class="fa fa-file-video-o  text-primary"></i>',
					'mp4': '<i class="fa fa-file-video-o text-primary"></i>'
				},
				previewFileIcon: "<i class='fa fa-file' aria-hidden='true'></i>",
				fileActionSettings: { //预览项设置
					showUpload: false,
					showRemove: false,
					showDrag: false
				}
			});
			var errorMsg;//上传错误消息
			//上传回调
			$("#file-4").on("fileuploaded", function(event, data, previewId, index) {
				var form = data.form,
					files = data.files,
					extra = data.extra,
					response = data.response,
					reader = data.reader;
				if(!response.success) {
					errorMsg = response.msg;
				}
			});
			//上传失败回调
			$("#file-4").on('fileuploaderror', function(event, data, msg) {
				var form = data.form,
					files = data.files,
					extra = data.extra,
					response = data.response,
					reader = data.reader;
				console.log('File upload error');
				errorMsg = "文件上传失败!";
				// alert(msg);
			});
			//上传完成回调
			$("#file-4").on('filebatchuploadcomplete', function(event, files, extra) {
				if(errorMsg){
					$(".kv-upload-progress").hide();
					$(".progress-bar").text(errorMsg);
					$(".progress-bar").addClass("progress-bar-danger");
				}else{
					$(".progress-bar").text("文件上传成功!");
				}
				errorMsg = null;
			});
		</script>
		<script>
			function updateStateCell(num, stateValue) {
				$(".progress-bar").width("50%");
				$(".progress-bar").text("123");
				$(".progress-bar").addClass("progress-bar-danger");
			}
		</script>
	</body>

</html>