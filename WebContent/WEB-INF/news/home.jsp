<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html class="no-js">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>${sysinfo.title}-网站后台管理系统</title>
<meta name="description" content="${sysinfo.description}">
<meta name="keywords" content="${sysinfo.keywords}">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<meta name="renderer" content="webkit">
<meta http-equiv="Cache-Control" content="no-siteapp" />
<!-- amazeui -->
<link rel="icon" type="image/png" href="${basePath}img/favicon.png">
<link rel="apple-touch-icon-precomposed"
	href="../assets/i/app-icon72x72@2x.png">
<meta name="apple-mobile-web-app-title" content="Amaze UI" />
<link rel="stylesheet" href="../assets/css/amazeui.min.css" />
<link rel="stylesheet" href="../assets/css/admin.css">
<link rel="stylesheet" href="../ztree/css/zTreeStyle/zTreeStyle.css"
	type="text/css">
<script src="../assets/js/jquery.min.js"></script>
<script src="../assets/js/amazeui.min.js"></script>
<script type="text/javascript"
	src="${basePath }ztree/js/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript"
	src="${basePath }ztree/js/jquery.ztree.excheck-3.5.js"></script>
<script type="text/javascript"
	src="${basePath }ztree/js/jquery.ztree.exedit-3.5.js"></script>
<style>
.hoverMenu:hover {
	color: #ffffff;
	background-color: #5eb95e;
}

.rx-FirstMenuColor {
	color: #ffbe40;
}
</style>
<script type="text/javascript">
	var leftsideHeight;
	$(function() {
		// 浏览器的高度和div的高度  
		var height = $(window).height();
		var headerHeight = $("#header").height();
		var leftsideHeight = height - headerHeight - 1;
		$("#scolldiv").height(leftsideHeight);
		$("#initContent").height(leftsideHeight);

		$(".hoverMenu")
				.on(
						"click",
						function() {
							$(".hoverMenu").css("color", "");
							$(".hoverMenu").css("background-color", "");
							$(this).css("color", "white");
							$(this).css("background-color", "#5eb95e");
							var classval = $(this).attr("class");
							if (classval.indexOf('am-collapsed') > -1) {
								$(this)
										.children('span')
										.eq(1)
										.attr("class",
												"am-icon-angle-down am-fr am-margin-right");
							} else {
								if ($(this).attr("data-am-collapse") != undefined) {
									$(this)
											.children('span')
											.eq(1)
											.attr("class",
													"am-icon-angle-right am-fr am-margin-right");
								}
							}
						});

		$(document).keydown(function(event) {
			if (event.keyCode == 13) {
				var id = $("input:focus").attr("id");
				switch (id) {
				case "searchKeywords":
					searchKeywords();
					break;
				}
			}
		});
		initContent('${basePath}login/homePage.do');
	});
	function initContent(requestUrl, jsonParameter) {
		requestUrl = encodeURI(requestUrl);
		$.ajax({
			url : requestUrl,
			data : jsonParameter,
			type : "post",
			success : function(data) {
				$("#initContent").html(data);
			}
		});
	}
	function staticHtml(requestUrl) {
		$.ajax({
			url : requestUrl,
			type : "post",
			success : function(data) {
				if (data) {
					alert("静态化完成");
				} else {
					alert("静态化失败");
				}
			}
		});
	}
</script>
</head>
<body>
	<%--[if lte IE 9]>
<p class="browsehappy">你正在使用<strong>过时</strong>的浏览器，Amaze UI 暂不支持。 请 <a href="http://browsehappy.com/" target="_blank">升级浏览器</a>
  以获得更好的体验！</p>
<![endif]--%>
	<header class="am-topbar admin-header" id="header">
	<div class="am-topbar-brand">
		<strong style="color: #5eb95e">${sysinfo.name}</strong> <span
			class="am-badge">后台管理系统 v1.0</span>
	</div>
	<div class="am-collapse am-topbar-collapse" id="topbar-collapse">
		<ul
			class="am-nav am-nav-pills am-topbar-nav am-topbar-right admin-header-list">
			<li><a style="cursor: pointer; color: #EA88AC;"
				onclick="staticHtml('${basePath}sysinfo/staticHtml.do')"><span
					class="am-icon-hand-o-up"></span>一键静态化</a></li>
			<li><a href="${basePath}" target="_blank"><span
					class="am-icon-home"></span>预览网站首页</a></li>
			<li><a href="#"><span class="am-icon-user"></span>${user.truename}</a></li>
			<li><a href="${basePath}common/exit.do"><span
					class="am-icon-power-off"></span>退出</a></li>
		</ul>
	</div>
	</header>
	<div class="admin-content">
		<%-- sidebar start --%>
		<div class="admin-sidebar am-offcanvas" id="scolldiv"
			style="overflow: auto;">
			<div class="am-offcanvas-bar admin-offcanvas-bar">
				<ul class="am-list admin-sidebar-list">
					<li><a class="hoverMenu"
						href="javascript:initContent('${basePath}news/getNewsListPage.do');"><span
							class="rx-FirstMenuColor am-icon-table"></span>&nbsp;信息管理</a></li>
					<li><a class="hoverMenu"
						href="javascript:initContent('${basePath}common/gotopage.do?gotourl=dictionary/dictionary');"
						id="dictionary"><span
							class="rx-FirstMenuColor am-icon-puzzle-piece"></span>&nbsp;信息类型</a></li>
					<li><a class="hoverMenu"
						href="javascript:initContent('${basePath}common/gotopage.do?gotourl=user/updatepassword');">
							<span class="rx-FirstMenuColor am-icon-key"></span>&nbsp;修改密码
					</a></li>
				</ul>
				<div class="am-panel am-panel-default admin-sidebar-panel">
					<div class="am-panel-bd">
						<p>
							<span class="am-icon-bookmark"></span>&nbsp;技术服务
						</p>
						<p>
							黑特网络<br>电话：18103857686<br>Q Q：317605397
						</p>
						<a class="am-badge am-badge-success am-radius">梦想还是要有的，万一实现了呢！</a>
					</div>
				</div>
			</div>
		</div>
		<%-- sidebar end --%>
		<%-- content start --%>
		<div id="initContent" style="overflow: auto;"></div>
		<%-- content end --%>

	</div>
	<%--[if lt IE 9]>
<script src="http://libs.baidu.com/jquery/1.11.1/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="assets/js/polyfill/rem.min.js"></script>
<script src="assets/js/polyfill/respond.min.js"></script>
<script src="assets/js/amazeui.legacy.js"></script>
<![endif]--%>

	<%--[if (gte IE 9)|!(IE)]><!--%>

</body>
</html>
