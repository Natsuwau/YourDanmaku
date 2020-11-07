<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/fn.tld" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/shiro.tld" prefix="shiro"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String imgBasePath = request.getScheme() + "://"
			+ request.getServerPort()
			+ "/data/img/";
%>
<!DOCTYPE HTML>
<html>
	<head>
		<title>视频上传</title>
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
		<link href="<%=basePath%>assets/lib/bootstrap/css/bootstrap.min.css" rel='stylesheet' type='text/css'
		media="all" />
		<link rel="stylesheet" href="<%=basePath%>assets/css/x-admin.css" media="all">
		<link rel="stylesheet" href="<%=basePath%>assets/lib/amazeui-cropper/css/amazeui.min.css">
		<link rel="stylesheet" href="<%=basePath%>assets/lib/amazeui-cropper/css/amazeui.cropper.css">
		<link rel="stylesheet" href="<%=basePath%>assets/lib/amazeui-cropper/css/custom_up_img.css">
		<link href="<%=basePath%>assets/css/dashboard.css" rel="stylesheet">
		<!-- Custom Theme files -->
		<link href="<%=basePath%>assets/css/style.css" rel='stylesheet' type='text/css' media="all" />
		<link rel="stylesheet" href="<%=basePath%>assets/css/x-admin.css" media="all">
		<link href="<%=basePath%>assets/lib/bootstrap-fileinput/css/fileinput.min.css" media="all" rel="stylesheet" type="text/css" />
		<link href="<%=basePath%>assets/lib/bootstrap-fileinput/themes/explorer/theme.min.css" media="all" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" type="text/css" href="<%=basePath%>assets/lib/font-awesome-4.7.0/css/font-awesome.min.css">
		<script src="<%=basePath%>assets/js/jquery-2.2.3.min.js"></script>
		<!--回到顶部-->
		<link rel="stylesheet" href="<%=basePath%>assets/lib//to-top/to-top.css" media="all">
	</head>
	<body>
		<!--导航栏-->
		<%@include file="../shared/navbarPart.jsp"%>
		<!-- upload -->
		<div class="upload">
			<!-- container -->
			<div class="container">
				<div class="upload-grids">
					<div class="upload-right">
						<div class="x-body">
							<blockquote class="layui-elem-quote" style="border-left:5px solid #F7764E;">
								步骤一:视频文件上传 
								<c:if test="${not (empty tempVideoInfo or empty tempVideoInfo.url)}">
								&nbsp;&nbsp;&nbsp;&nbsp;
								<button class="layui-btn layui-btn-small" onclick="video_show('视频预览','<%=basePath%>upload/videoShow','900','550')">
									<i class="layui-icon">&#xe623;</i>点击预览[存在临时视频]
								</button>
								</c:if>
							</blockquote>
							<div class="form-group">
								<input id="file-4" type="file" name="videoFile" class="file-loading" data-min-file-count="1">
							</div>
						</div>
					</div>
					<div class="upload-right-bottom-grids">
						<div class="x-body">
							<blockquote class="layui-elem-quote" style="border-left:5px solid #F7764E;">
								步骤二:视频相关图片上传
							</blockquote>
							<table class="layui-table">
								<thead>
									<tr>
										<td align="center"><b>视频封面图像</b></td>
										<td align="center"><b>视频预览图像</b></td>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td align="center">
											<div class="mine-center up-img-touch" aspectRatio="1.604" uploadUrl="<%=basePath%>upload/stepTwo/VideoConver">
												<c:choose>
													<c:when test="${not empty tempVideoInfo.coverUrl}">
														<img src="<%=imgBasePath%>${tempVideoInfo.coverUrl}" style="border: 0px solid #A9B7B7;" height="150px" alt="图片路径无效" data-am-popover="{theme: 'sm', content: '点击设置', trigger: 'hover focus'}">
													</c:when>
													<c:otherwise>
														<img src="<%=basePath%>assets/img/take-place.jpg" style="border: 0px solid #A9B7B7;" height="150px" alt="图片路径无效" data-am-popover="{theme: 'sm', content: '点击设置', trigger: 'hover focus'}">
													</c:otherwise>
												</c:choose>
											</div>
										</td>
										<td align="center">
											<div class="mine-center up-img-touch" aspectRatio="1.775" uploadUrl="<%=basePath%>upload/stepTwo/VideoPic">
												<c:choose>
													<c:when test="${not empty tempVideoInfo.picUrl}">
														<img src="<%=imgBasePath%>${tempVideoInfo.picUrl}" style="border: 0px solid #A9B7B7;" height="150px" alt="图片路径无效" data-am-popover="{theme: 'sm', content: '点击设置', trigger: 'hover focus'}">
													</c:when>
													<c:otherwise>
														<img src="<%=basePath%>assets/img/take-place.jpg" style="border: 0px solid #A9B7B7;" height="150px" alt="图片路径无效" data-am-popover="{theme: 'sm', content: '点击设置', trigger: 'hover focus'}">
													</c:otherwise>
												</c:choose>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
							<div>
								<!--图片上传框-->
								<div class="am-modal am-modal-no-btn up-frame-bj " tabindex="-1" id="doc-modal-1">
									<div class="am-modal-dialog up-frame-parent up-frame-radius">
										<div class="am-modal-hd up-frame-header">
											<label>上传图片</label>
											<a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
										</div>
										<div class="am-modal-bd  up-frame-body">
											<div class="am-g am-fl">
												<div class="am-form-group am-form-file">
													<div class="am-fl">
														<button type="button" class="am-btn am-btn-default am-btn-sm">
			 									 <i class="am-icon-cloud-upload"></i> 选择要上传的图片</button>
													</div>
													<input type="file" id="inputImage">
												</div>
											</div>
											<div class="am-g am-fl">
												<div class="up-pre-before up-frame-radius">
													<img alt="" src="" id="image">
												</div>
												<div class="up-pre-after up-frame-radius">
												</div>
											</div>
											<div class="am-g am-fl">
												<div class="up-control-btns">
													<span class="am-icon-rotate-left" onclick="rotateimgleft()"></span>
													<span class="am-icon-rotate-right" onclick="rotateimgright()"></span>
													<span class="am-icon-check" id="up-btn-ok"></span>
												</div>
											</div>

										</div>
									</div>
								</div>

								<!--加载框-->
								<div class="am-modal am-modal-loading am-modal-no-btn" tabindex="-1" id="my-modal-loading">
									<div class="am-modal-dialog">
										<div class="am-modal-hd">正在上传...</div>
										<div class="am-modal-bd">
											<span class="am-icon-spinner am-icon-spin"></span>
										</div>
									</div>
								</div>

								<!--警告框-->
								<div class="am-modal am-modal-alert" tabindex="-1" id="my-alert">
									<div class="am-modal-dialog">
										<div class="am-modal-hd">信息</div>
										<div class="am-modal-bd" id="alert_content">
											成功了
										</div>
										<div class="am-modal-footer">
											<span class="am-modal-btn">确定</span>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="upload-right-bottom-grids">
						<div class="box x-body">
							<blockquote class="layui-elem-quote" style="border-left:5px solid #F7764E;">
								步骤三:视频信息保存
							</blockquote>
							<form id = "saveInfo" class="layui-form" action="">
								<div class="layui-form-item">
									<label class="layui-form-label">视频名</label>
									<div class="layui-input-block">
										<input type="text" name="name" value = "${tempVideoInfo.name }" lay-verify="iName" placeholder="输入视频名称" autocomplete="off" class="layui-input">
									</div>
								</div>
								<div class="layui-form-item">
									<label class="layui-form-label">类型</label>
									<div class="layui-input-block">
										<select name="type" lay-verify="required">
											<option value="ACG" ${tempVideoInfo.type eq 'ACG' ? 'selected = "selected"' :''}>动漫/番剧</option>
											<option value="MOVIE" ${tempVideoInfo.type eq 'MOVIE' ? 'selected = "selected"' :''}>影视</option>
											<option value="SG" ${tempVideoInfo.type eq 'SG' ? 'selected = "selected"' :''}>科技/游戏</option>
											<option value="MAD" ${tempVideoInfo.type eq 'MAD' ? 'selected = "selected"' :''}>鬼畜</option>
											<option value="FUN" ${tempVideoInfo.type eq 'FUN' ? 'selected = "selected"' :''}>时尚/娱乐</option>
											<option value="MUSIC" ${tempVideoInfo.type eq 'MUSIC' ? 'selected = "selected"' :''}>音乐</option>
											<option value="OTHER" ${tempVideoInfo.type eq 'OTHER' ? 'selected = "selected"' :''}>其他</option>
										</select>
									</div>
								</div>
								<div class="layui-form-item">
									<label class="layui-form-label">范围</label>
									<div class="layui-input-block">
										<select name="scope" lay-verify="required">
											<option value="@all" ${tempVideoInfo.scope eq '@all' ? 'selected = "selected"' :''} >所有用户</option>
											<option value="@user"  ${tempVideoInfo.scope eq '@user' ? 'selected = "selected"' :''}>会员专享</option>
										</select>
									</div>
								</div>
								<div class="layui-form-item layui-form-text">
									<label class="layui-form-label">简介</label>
									<div class="layui-input-block">
										<textarea name="desc" placeholder="写点什么吧" class="layui-textarea"  lay-verify="iDesc" value = "${tempVideoInfo.desc }"></textarea>
									</div>
								</div>
								<div class="layui-form-item">
									<div class="layui-input-block">
										<button class="layui-btn layui-btn-danger" lay-filter="saveInfo" lay-submit="">
															保存信息</button>
									</div>
								</div>
								<div class="clearfix"> </div>
							</form>
						</div>
					</div>
					<div class="clearfix"> </div>
				</div>
			</div>
			<a class="to-top itop" title="回到顶部"></a>
		</div>
		<!-- //container -->
		<!-- footer -->
		<div class="mine-footer">
			<div class="container">
				<div class="footer-grids">
					<div class="copyright" title="空落落的，不知道放什么,瞎写的">
						<p class="center-block">
							基于SSM的弹幕动漫网站 - Hi,Danmaku!&nbsp;&nbsp;
							基于SSM的弹幕动漫网站 - Hi,Danmaku!&nbsp;&nbsp;
					<a href="<%=basePath%>home" target="_blank" title="网站首页">首页</a>
					-
					<a href="<%=basePath%>cms/login" target="_blank" title="后台CMS">后台CMS</a> <br> Copyright &copy; 2017
							<a href="https://git.oschina.net/yebukong" title="yebukong" target="_blank">yebukong </a>
						</p>
					</div>
				</div>
			</div>
		</div>
		<script src="<%=basePath%>assets/lib/layui/layui.js" charset="utf-8"></script>
			<script src="<%=basePath%>assets/js/x-layui.js" charset="utf-8"></script>
		<script src="<%=basePath%>assets/js/x-admin.js"></script>
		<script src="<%=basePath%>assets/lib/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
		<script src="<%=basePath%>assets/lib/bootstrap-fileinput/js/plugins/sortable.min.js" type="text/javascript"></script>
		<script src="<%=basePath%>assets/lib/bootstrap-fileinput/js/fileinput.js" type="text/javascript"></script>
		<script src="<%=basePath%>assets/lib/bootstrap-fileinput/js/locales/zh.js" type="text/javascript"></script>
		<script src="<%=basePath%>assets/lib/amazeui-cropper/js/amazeui.min.js" charset="utf-8"></script>
		<script src="<%=basePath%>assets/lib/amazeui-cropper/js/cropper.min.js" charset="utf-8"></script>
		<script src="<%=basePath%>assets/lib/amazeui-cropper/js/custom_up_img_pro.js" charset="utf-8"></script>
		<script src="<%=basePath%>assets/lib/bootstrap-fileinput/themes/explorer/theme.js" type="text/javascript"></script>
		<script src="<%=basePath%>assets/lib/to-top/to-top.js" type="text/javascript" charset="utf-8"></script>
		<script>
			$("#file-4").fileinput({
				language: 'zh',
				uploadAsync: true,
				uploadUrl: "<%=basePath%>upload/stepOne", //上传的地址
				showPreview: true, //是否显示预览
				allowedPreviewTypes: ['video'], //指定预览格式
				initialPreviewAsData: false, //配置上传后是否显示上传预览
				allowedFileExtensions: ['mp4', 'webm'], //接收的文件后缀
				dropZoneEnabled: true, //是否显示拖拽区域
				browseOnZoneClick: true,
				dropZoneTitle: "你可以拖拽/点击选取视频文件(MP4,WEBM)到此处...", //是否显示拖拽区域
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
				setTimeout(function(){
					if(errorMsg){
						$(".kv-upload-progress").hide();
						$(".progress-bar").text(errorMsg);
						$(".progress-bar").addClass("progress-bar-danger");
					}else{
						$(".progress-bar").text("文件上传成功!");
					}
				},1000);
				
				errorMsg = null;
			});
		</script>
		<script>
			layui.use('form', function() {
				var form = layui.form();
				
				form.verify({
	                iName:function(value){
		                  if(value.length < 2 || value.length > 16){
			                    return '视频名长度限制2-16位!';
			             }
		            },
		            iDesc:function(value){
		                  if(value.length < 4){
			                    return '简介多写点吧,太少了!';
			             }
		            }
	             });
				//监听提交
				form.on('submit(saveInfo)', function(formData) {
					var url = "<%=basePath%>upload/stepThree";
					var data = formData.field;
					var offset = "50%";
					var result = mineAjax(url,data,offset,false);
					if('true' == result){
						$('#saveInfo')[0].reset();
						//刷新本页面
						setTimeout(function(){
							location.reload(true);
						},500);
					}
					return false;
				});
			});
		</script>
		<script>
			function video_show(title, url, w, h) {
				x_admin_show(title, url, w, h);
			}
			var _hmt = _hmt || [];
			(function() {
				var hm = document.createElement("script");
				hm.src = "https://hm.baidu.com/hm.js?b393d153aeb26b46e9431fabaf0f6190";
				var s = document.getElementsByTagName("script")[0];
				s.parentNode.insertBefore(hm, s);
			})();
		</script>
	</body>

</html>