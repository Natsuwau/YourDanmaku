/**
 *使用方法:将此js文件引入页面即可 
 *改进:叶小空
 *码云:https://git.oschina.net/yebukong
 *原作者：DIYgod
 *原作者链接：https://www.anotherhome.net/2153
 */
var HIDDEN_STR = "(●_●) 打入冷宫~ ";
var FOCUS_STR = "(╯▽╰) 重获恩宠~ ";
var MAX_TIME = 2333;
var titleTime;

document.addEventListener('visibilitychange', function() {
	var originTitile = getOriginTitile();
	if(document.hidden) {
		document.title = HIDDEN_STR + originTitile;
		clearTimeout(titleTime);
	} else {
		document.title = FOCUS_STR + originTitile;
		titleTime = setTimeout(function() {
			document.title = getOriginTitile();
		}, MAX_TIME);
	}
});

/**
 * 加一步验证title是否在其他地方修改过,(ps:这么写有点影响性能吧,一丢丢啦，考虑全面一点也好)
 */
function getOriginTitile() {
	var originTitile = document.title;
	var index = originTitile.indexOf(HIDDEN_STR);
	if(index != -1) {
		originTitile = originTitile.substring(index + HIDDEN_STR.length);
	} else {
		index = originTitile.indexOf(FOCUS_STR);
		if(index != -1) {
			originTitile = originTitile.substring(index + FOCUS_STR.length);
		}
	}
	return originTitile;
}