$(document).ready(function() {
	$("#up-img-touch").click(function() {
		$("#doc-modal-1").modal({
			width : '600px'
		});
	});
});
// base64转blob
function dataURLtoBlob(base64Url) {
	var arr = base64Url.split(','), mime = arr[0].match(/:(.*?);/)[1], bstr = atob(arr[1]), n = bstr.length, u8arr = new Uint8Array(
			n);
	while (n--) {
		u8arr[n] = bstr.charCodeAt(n);
	}
	return new Blob([ u8arr ], {
		type : mime
	});
}
$(function() {
	'use strict';
	// 初始化
	var $image = $('#image');
	var ratio = $image.attr("aspectRatio");
	if (!ratio) {
		ratio = "1";
	}
	$image.cropper({
		aspectRatio : ratio,
		autoCropArea : 0.8,
		preview : '.up-pre-after',

	});

	// 事件代理绑定事件
	$('.docs-buttons').on(
			'click',
			'[data-method]',
			function() {

				var $this = $(this);
				var data = $this.data();
				var result = $image.cropper(data.method, data.option,
						data.secondOption);
				switch (data.method) {
				case 'getCroppedCanvas':
					if (result) {
						// 显示 Modal
						$('#cropped-modal').modal().find('.am-modal-bd').html(
								result);
						$('#download').attr('href',
								result.toDataURL('image/jpeg'));
					}
					break;
				}
			});

	// 上传图片
	var $inputImage = $('#inputImage');
	var URL = window.URL || window.webkitURL;
	var blobURL;

	if (URL) {
		$inputImage.change(function() {
			var files = this.files;
			var file;

			if (files && files.length) {
				file = files[0];

				if (/^image\/\w+$/.test(file.type)) {
					blobURL = URL.createObjectURL(file);
					$image.one('built.cropper', function() {
						// Revoke when load complete
						URL.revokeObjectURL(blobURL);
					}).cropper('reset').cropper('replace', blobURL);
					$inputImage.val('');
				} else {
					window.alert('上传类型应该为图片!');
				}
			}

			// Amazi UI 上传文件显示代码
			var fileNames = '';
			$.each(this.files,
					function() {
						fileNames += '<span class="am-badge">' + this.name
								+ '</span> ';
					});
			$('#file-list').html(fileNames);
		});
	} else {
		$inputImage.prop('disabled', true).parent().addClass('disabled');
	}

	// 绑定上传事件
	$('#up-btn-ok').on('click', function() {
		var $modal = $('#my-modal-loading');
		var $modal_alert = $('#my-alert');
		var img_src = $image.attr("src");
		if (img_src == "") {
			set_alert_info("没有选择上传的图片");
			$modal_alert.modal();
			return false;
		}
		if (typeof FormData == 'undefine') {
			set_alert_info("浏览器版本过低,上传失败!");
			$modal_alert.modal();
			return false;
		}
		$modal.modal();

		var url = $(this).attr("url");
		var canvas = $("#image").cropper('getCroppedCanvas');
		var base64Data = canvas.toDataURL("image/png"); // 转成base64,指定格式
		var blobData = dataURLtoBlob(base64Data);
		var fd = new FormData();
		// 自动生成图片名
		var imgName = new Date().getTime() + ".png";
		fd.append('imageFile', blobData, imgName);
		$.ajax({
			url : url,
			dataType : 'json',
			type : "POST",
			data : fd,
			async : false,
			cache : false,
			contentType : false,
			processData : false,
			success : function(data, status) {
				$modal.modal('close');
				$("#doc-modal-1").modal('close');//关闭剪截框
				set_alert_info(data.msg);
				$modal_alert.modal();
				if(data.success){
					if(data.obj){
						$("#up-img-touch img").attr("src", data.obj.toString());//更新头像
					}
				}
			},
			error : function() {
				$modal.modal('close');
				set_alert_info("服务器连接失败!");
				$modal_alert.modal();
			}
		});

	});

});

function rotateimgright() {
	$("#image").cropper('rotate', 90);
}

function rotateimgleft() {
	$("#image").cropper('rotate', -90);
}

function set_alert_info(content) {
	$("#alert_content").html(content);
}
