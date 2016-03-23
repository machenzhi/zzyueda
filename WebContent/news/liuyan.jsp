<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
<html class="no-js">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="icon" type="image/png" href="${basePath}img/favicon.png">
<title>${sysinfo.title}</title>
<meta name="description" content="${sysinfo.description}">
<meta name="keywords" content="${sysinfo.keywords}">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<meta name="renderer" content="webkit">
<meta http-equiv="Cache-Control" content="no-siteapp" />
<script src="${basePath}assets/js/jquery.min.js"></script>
<script src="${basePath}assets/js/amazeui.min.js"></script>
</head>
<body>
	<%-- **************公共头部*****************   --%>
	<jsp:include page="../public/top.jsp" />
	<%-- ***********************************	  --%>
	<%-- *****************中部********开始*********************     --%>
	<div class="am-container">
		<%--     ************中部1  左侧菜单*************** --%>
		<div class="am-u-sm-12 am-u-md-3 am-u-lg-3" style="margin-top: 10px">
			<%-- 固定类型 start --%>
			<jsp:include page="fixedmenu.jsp" />
			<%-- 固定类型 end --%>
			<%-- 活动促销 start --%>
			<jsp:include page="huodongcuxiao.jsp" />
			<%-- 活动促销 end --%>
			<%-- 联系我们 start --%>
			<jsp:include page="contactus.jsp" />
			<%-- 联系我们 end --%>
		</div>
		<%-- 		************中部1  左侧菜单结束***************** --%>
		<%--     ************中部2  右侧信息列表*************** --%>
		<div class="am-u-sm-12 am-u-md-9 am-u-lg-9"
			style="border-color: #979797; margin-top: 10px;">
			<div class="am-cf">
				<ol class="am-breadcrumb">
					<li><a class="am-icon-home" onClick="openPage('${basePath}')"
						href="javascript:void(0)">首页</a></li>
					<li><a href="javascript:void(0)">留言</a></li>
				</ol>
				<!-- 多说评论框 start -->
				<div class="ds-thread" data-thread-key="shareme" data-title="晒迷人"
					data-url="www.shareme.ren"></div>
				<!-- 多说评论框 end -->
				<!-- 多说公共JS代码 start (一个网页只需插入一次) -->
				<script type="text/javascript">
					var duoshuoQuery = {
						short_name : "shareme"
					};
					(function() {
						var ds = document.createElement('script');
						ds.type = 'text/javascript';
						ds.async = true;
						ds.src = (document.location.protocol == 'https:' ? 'https:'
								: 'http:')
								+ '//static.duoshuo.com/embed.js';
						ds.charset = 'UTF-8';
						(document.getElementsByTagName('head')[0] || document
								.getElementsByTagName('body')[0])
								.appendChild(ds);
					})();
				</script>
				<!-- 多说公共JS代码 end -->
			</div>
		</div>
	</div>
	<%-- *****************中部********结束*********************     --%>
	<%--  **************底部 ****** 开始*************************--%>
	<jsp:include page="../public/foot.jsp" />
	<%--  **************底部 ****** 结束*************************--%>

</body>
</html>