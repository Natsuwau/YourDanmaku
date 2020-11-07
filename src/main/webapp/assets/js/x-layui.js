/*弹出层*/
/*
	参数解释：
	title	标题
	url		请求的url
	id		需要操作的数据id
	w		弹出层宽度（缺省调默认值）
	h		弹出层高度（缺省调默认值）
*/
function x_admin_show(title,url,w,h){
	if (title == null || title == '') {
		title=false;
	};
	if (url == null || url == '') {
		url="404.html";
	};
	if (w == null || w == '') {
		w=800;
	};
	if (h == null || h == '') {
		h=($(window).height() - 50);
	};
	layer.open({
		type: 2,
		area: [w+'px', h +'px'],
		fix: false, //不固定
		maxmin: true,
		shadeClose: true,
		scrollbar: false,
		shade:0.4,
		title: title,
		content: url
	});
}

/*关闭弹出框口*/
function x_admin_close(){
	var index = parent.layer.getFrameIndex(window.name);
	parent.layer.close(index);
}

function mineAjax(url,fromData,offset,async){
	if(!offset){
		offset = "50%";
	}
	var flag = "";
	$.ajax({
			url: url,
			async: async,
			type: "POST",
			dataType: "JSON",
			data:fromData,
			success: function(data, status) {
				if(data.success){
					flag = "true";
					layer.alert(data.msg, {icon: 6});
				}else{
					flag = "false";
					layer.msg(data.msg, {
						offset: offset,
						anim: 6,
						icon: 5,
					});	
				}
			},
			error: function() {
				flag = "false";
				layer.msg('连接服务器失败!', {
					offset: offset,
					anim: 6,
					icon: 2,
				});
			}
		});
	return flag;
}