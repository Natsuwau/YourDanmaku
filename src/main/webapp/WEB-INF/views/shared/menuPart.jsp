<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div class="col-sm-3 col-md-2 sidebar" style=" ">
	<div class="drop-navigation drop-navigation">
		<ul class="nav nav-sidebar">
			<li class="${empty type?'active':''}">
				<a href="<%=basePath%>home" class="home-icon">
					<span class="glyphicon glyphicon-home" aria-hidden="true"></span>主页
				</a>
			</li>
			<li class="${paramBag.searchKey eq '@ACG'?'active':''}">
				<a href="<%=basePath%>search?searchKey=@ACG" class="user-icon ">
					<span class="glyphicon glyphicon-magnet" aria-hidden="true"></span>动漫/番剧
				</a>
			</li>
			<li class="${paramBag.searchKey eq '@MOVIE'?'active':''}">
				<a href="<%=basePath%>search?searchKey=@MOVIE" class="user-icon ">
					<span class="glyphicon glyphicon-film" aria-hidden="true"></span>影视频道<span
						class="glyphicon glyphicon-menu-down" aria-hidden="true"></span>
				</a>
			</li>
			<li class="${paramBag.searchKey eq '@SG'?'active':''}">
				<a href="<%=basePath%>search?searchKey=@SG" class="user-icon ">
					<span class="glyphicon glyphicon-flash" aria-hidden="true"></span>科技/游戏
				</a>
			</li>
			<li class="${paramBag.searchKey eq '@MAD'?'active':''}">
				<a href="<%=basePath%>search?searchKey=@MAD" class="user-icon ">
					<span class="glyphicon glyphicon-fire" aria-hidden="true"></span>鬼畜专区
				</a>
			</li>
			<li class="${paramBag.searchKey eq '@FUN'?'active':''}">
				<a href="<%=basePath%>search?searchKey=@FUN" class="user-icon ">
					<span class="glyphicon glyphicon-glass" aria-hidden="true"></span>时尚/娱乐
				</a>
			</li>
			<li class="${paramBag.searchKey eq '@MUSIC'?'active':''}">
				<a href="<%=basePath%>search?searchKey=@MUSIC" class="user-icon ">
					<span class="glyphicon glyphicon-music" aria-hidden="true"></span>音乐MV
				</a>
			</li>
			<li class="${paramBag.searchKey eq '@OTHER'?'active':''}">
				<a href="<%=basePath%>search?searchKey=@OTHER" class="user-icon ">
					<span class="glyphicon glyphicon-globe" aria-hidden="true"></span>其他
				</a>
			</li>
		</ul>
		<div class="side-bottom">
			<div class="side-bottom-icons">
				<ul class="nav2">
					<li>
						<a href="#" title="GitHub">
							<span class="fa fa-2x fa-github" style="color: #fff; background-color: #272C2E;"></span>
						</a>
					</li>
					<li>
						<a href="#" title="码云Git地址">
							<span class="fa fa-2x fa-git-square" style="color: #fff; background-color: #272C2E;"></span>
						</a>
					</li>
					<li>
						<a href="#" title="关于">
							<span class="fa fa-2x fa-info-circle" style="color: #fff; background-color: #272C2E;"></span>
						</a>
					</li>
				</ul>
			</div>
			<div class="copyright">
				<p class="center-block">
					基于SSM的弹幕动漫网站<br>
					<a href="<%=basePath%>home" target="_blank" title="网站首页">首页</a>
					-
					<a href="<%=basePath%>cms/login" target="_blank" title="后台CMS">后台CMS</a>
					<br>
				</p>
			</div>
		</div>
	</div>
</div>