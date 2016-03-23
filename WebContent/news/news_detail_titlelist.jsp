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
		<%--     ************中部1*************** --%>
		<div class="am-u-sm-12 am-u-md-3 am-u-lg-3" style="margin-top: 10px">
			<%-- 文章标题 start --%>
			<jsp:include page="newstitletype.jsp" />
			<%-- 文章标题 end --%>
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

		<%--     ************中部2*************** --%>
		<div class="am-u-sm-12 am-u-md-9 am-u-lg-9" style="margin-top: 10px;">
			<div class="am-cf">
				<ol class="am-breadcrumb">
					<c:forEach items="${mianbaoMenu}" var="mianbaomenu"
						varStatus="varstatus">
						<li><a
							<c:if test="${varstatus.index==0}">class="am-icon-home"</c:if>
							onClick="openPage('${basePath}${mianbaomenu.url}&typename=${mianbaomenu.name}&typeid=${mianbaomenu.id}&typepath=${mianbaomenu.abspath}&htmlName=${mianbaomenu.id}')"
							href="javascript:void(0)">${mianbaomenu.name} </a></li>
					</c:forEach>
				</ol>
				<article class="am-article">
					<div class="am-article-hd">
						<h1 class="am-article-title" align="center">${news.title}</h1>
						<p class="am-article-meta" align="center">${news.author}</p>
					</div>
					<div class="am-article-bd">${news.content}</div>
				</article>
			</div>
		</div>
	</div>

	<%-- *****************中部********结束*********************     --%>
	<%--  **************底部 ****** 开始*************************--%>
	<jsp:include page="../public/foot.jsp" />
	<%--  **************底部 ****** 结束*************************--%>

</body>
</html>