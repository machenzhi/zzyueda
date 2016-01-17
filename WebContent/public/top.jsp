<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet" href="${basePath}assets/css/amazeui.min.css">
<link href="${basePath}css/navigation.css" rel="stylesheet"
	type="text/css" />
<script src="${basePath}assets/js/jquery.min.js"></script>
<script type="text/javascript"
	src="${basePath}js/jquery.flexslider-min.js"></script>
<script type="text/javascript" src="${basePath}js/navigation.js"></script>
<style type="text/css">
.wcolor {
	color: #FFFFFF;
	font-weight: bold;
}

/* flexslider */
.flexslider {
	position: relative;
	height: 360px;
	overflow: hidden;
	background: url(${basePath}img/slider/loading.gif) 50% no-repeat;
}

.slides {
	position: relative;
	z-index: 1;
}

.slides li {
	height: 380px;
}

.flex-control-nav {
	position: absolute;
	bottom: 10px;
	z-index: 2;
	width: 100%;
	text-align: center;
}

.flex-control-nav li {
	display: inline-block;
	width: 14px;
	height: 14px;
	margin: 0 5px;
	*display: inline;
	zoom: 1;
}

.flex-control-nav a {
	display: inline-block;
	width: 14px;
	height: 14px;
	line-height: 40px;
	overflow: hidden;
	background: url(${basePath}img/slider/dot.png) right 0 no-repeat;
	cursor: pointer;
}

.flex-control-nav .flex-active {
	background-position: 0 0;
}

.flex-direction-nav {
	position: absolute;
	z-index: 3;
	width: 100%;
	top: 45%;
}

.flex-direction-nav li a {
	display: block;
	width: 50px;
	height: 50px;
	overflow: hidden;
	cursor: pointer;
	position: absolute;
}

.flex-direction-nav li a.flex-prev {
	left: 40px;
	background: url(${basePath}img/slider/prev.png) center center no-repeat;
}

.flex-direction-nav li a.flex-next {
	right: 40px;
	background: url(${basePath}img/slider/next.png) center center no-repeat;
}
</style>
<script type="text/javascript">
	jQuery(document).ready(function() {
		$('.flexslider').flexslider({
			directionNav : true,
			pauseOnAction : false
		});
	});

	function click_who(who) {
		who.click();
	}

	function openPage(requestUrl) {
		var htmlName = "htmlName";
		var htmlNameIdx = requestUrl.indexOf("htmlName");
		if (htmlNameIdx > -1) {
			htmlName = requestUrl.substring(htmlNameIdx + 9);
		}
		var htmlUrl = "${basePath}html/" + htmlName + ".html";
		$.ajax({
			url : htmlUrl,
			success : function(data) {
				//存在静态页面，则打开
				window.location.href = htmlUrl;
			},
			error : function() {
				//不存在静态页面，则动态申请页面
				window.location.href = requestUrl;
			}
		});
	}
</script>
<%-- 	*****************手机导航开始********************************** --%>
<%-- Header --%>
<header data-am-widget="header"
	class="am-header-default am-show-sm-only"
	style="background-color: #009800; position: relative; width: 100%; height: 49px; line-height: 49px; padding: 0 10px;">
	<h1 class="am-header-title">
		<a onClick="openPage('${basePath}${dictionarys[0].url}')"
			href="javascript:void(0)"><img
			src="${basePath}img/titlelogo_sm.png"> </a>郑州达企业管理咨询有限公司
	</h1>
</header>
<%-- Menu --%>
<nav data-am-widget="menu" class="am-menu  am-menu-offcanvas1"
	data-am-menu-offcanvas>
	<a href="javascript: void(0)" class="am-menu-toggle"> <i
		class="am-menu-toggle-icon am-icon-bars"></i>
	</a>
	<div class="am-offcanvas">
		<div class="am-offcanvas-bar">
			<ul class="am-menu-nav sm-block-grid-1">
				<c:forEach items="${dictionarys}" var="menu_1">
					<li <c:if test="${!empty menu_1.children}">class="am-parent"</c:if>>
						<a
						onClick="openPage('${basePath}${menu_1.url}&typename=${menu_1.name}&typeid=${menu_1.id}&typepath=${menu_1.abspath}&htmlName=${menu_1.id}')"
						href="javascript:void(0)">${menu_1.name}</a>
						<ul class="am-menu-sub am-collapse  sm-block-grid-2">
							<c:forEach items="${menu_1.children}" var="menu_2">
								<c:choose>
									<c:when test="${!empty menu_2.children}">
										<ul class="am-menu-nav sm-block-grid-1">
											<li class="am-parent"><a
												onClick="openPage('${basePath}${menu_2.url}&typename=${menu_2.name}&typeid=${menu_2.id}&typepath=${menu_2.abspath}&htmlName=${menu_2.id}')"
												href="javascript:void(0)">${menu_2.name}</a>
												<ul class="am-menu-sub am-collapse  sm-block-grid-3 ">
													<c:forEach items="${menu_2.children}" var="menu_3">
														<a
															onClick="openPage('${basePath}${menu_3.url}&typename=${menu_3.name}&typeid=${menu_3.id}&typepath=${menu_3.abspath}&htmlName=${menu_1.id}')"
															href="javascript:void(0)">${menu_3.name}</a>
													</c:forEach>
												</ul></li>
										</ul>
									</c:when>
									<c:otherwise>
										<a
											onClick="openPage('${basePath}${menu_2.url}&typename=${menu_2.name}&typeid=${menu_2.id}&typepath=${menu_2.abspath}&htmlName=${menu_2.id}')"
											href="javascript:void(0)">${menu_2.name}</a>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</ul>
					</li>
				</c:forEach>
			</ul>
		</div>
	</div>
</nav>
<%-- 	*********************手机导航结束******************************* --%>


<%--    **********************顶部   区域1************************** --%>
<div class="am-show-md-up">
	<div class="am-container">
		<div class="am-fl">
			<a
				onClick="openPage('${basePath}')"
				href="javascript:void(0)"> <img
				src="${basePath}img/titlelogo.png" />
			</a>
		</div>
		<div class="am-fr" style="margin-top: 10px; margin-bottom: 10px;">
			<h3>专业 专心 专注</h3>
			<h3>企业宗旨：天道酬勤 商道酬信 诚信是金</h3>
			<h3>咨询电话：13183000936</h3>
		</div>
	</div>
</div>
<%-- ******************************************************** --%>
<%-- *******************电脑导航栏开始************************ --%>
<div class="am-u-g am-show-md-up" style="padding: 0px;">
	<div data-am-sticky>
		<div class="navbg">
			<div class="col960">
				<ul id="navul">
					<c:forEach items="${dictionarys}" var="menu_1">
						<li>
							<!--导航条一级菜单 --> <span id="yiji"> <a
								onClick="openPage('${basePath}${menu_1.url}&typename=${menu_1.name}&typeid=${menu_1.id}&typepath=${menu_1.abspath}&htmlName=${menu_1.id}')"
								href="javascript:void(0)"> ${menu_1.name}</a>
						</span> <!--导航条二级菜单 -->
							<ul>
								<c:if test="${menu_1.css eq 'kuai'}">
									<div style="display: inline; white-space: nowrap;">
										<c:forEach items="${menu_1.children}" var="menu_2">
											<span style="display: inline-block; vertical-align: top;">
												<a
												onClick="openPage('${basePath}${menu_2.url}&typename=${menu_2.name}&typeid=${menu_2.id}&typepath=${menu_2.abspath}&htmlName=${menu_2.id}')"
												href="javascript:void(0)">${menu_2.name}</a>
												<hr style="margin: 10px 20px 0px 10px;"> <c:forEach
													items="${menu_2.children}" var="menu_3">
													<a style="font: normal 14px 'microsoft yahei';"
														onClick="openPage('${basePath}${menu_3.url}&typename=${menu_3.name}&typeid=${menu_3.id}&typepath=${menu_3.abspath}&htmlName=${menu_3.id}')"
														href="javascript:void(0)">${menu_3.name}</a>
												</c:forEach>
											</span>
										</c:forEach>
									</div>
								</c:if>
								<c:if test="${menu_1.css eq 'wenben'}">
									<c:forEach items="${menu_1.children}" var="menu_2">
										<li><a
											onClick="openPage('${basePath}${menu_2.url}&typename=${menu_2.name}&typeid=${menu_2.id}&typepath=${menu_2.abspath}&htmlName=${menu_2.id}')"
											href="javascript:void(0)">${menu_2.name}</a></li>
									</c:forEach>
								</c:if>
							</ul>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
	<div style="height: 45px;"></div>
</div>
<%-- *******************电脑导航栏结束****************************	 --%>


<%-- *****************图片轮播 开始********************** --%>
<div class="am-u-sm-12" style="padding: 0px; margin-bottom: 10px;">
	<div class="am-u-sm-12 am-slider am-slider-default am-show-sm-only"
		data-am-flexslider="{playAfterPaused: 8000}">
		<ul class="am-slides">
			<li><img src="${basePath}img/slider/1.png"></li>
			<li><img src="${basePath}img/slider/2.png"></li>
		</ul>
	</div>
	<div class="am-slider am-slider-default am-show-md-up"
		data-am-flexslider="{playAfterPaused: 8000}">
		<ul class="am-slides">
			<li style="background:url(${basePath}img/slider/1bg.png) repeat-x"><img
				style="width: 1000px; height: 300px;" class="am-u-sm-centered"
				src="${basePath}img/slider/1.png" /></li>
			<li style="background:url(${basePath}img/slider/2bg.png) repeat-x"><img
				style="width: 1000px; height: 300px;" class="am-u-sm-centered"
				src="${basePath}img/slider/2.png" /></li>
		</ul>
	</div>
</div>
<%-- *****************图片轮播 结束********************** --%>

