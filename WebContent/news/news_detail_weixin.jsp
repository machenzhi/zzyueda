<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!doctype html>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="icon" type="image/png" href="<%=basePath%>img/favicon.png">
<link rel="stylesheet" href="<%=basePath%>assets/css/amazeui.min.css">
<script src="<%=basePath%>assets/js/jquery.min.js"></script>
<script src="<%=basePath%>assets/js/amazeui.min.js"></script>
<title>悦达企业管理</title>
<meta name="description" content="${sysinfo.description}">
<meta name="keywords" content="${sysinfo.keywords}">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<meta name="renderer" content="webkit">
<meta http-equiv="Cache-Control" content="no-siteapp" />

<%-- *****************中部********开始*********************     --%>
<div class="am-container">
	<%--     ************中部2*************** --%>
	<div class="am-u-sm-12 am-u-md-12 am-u-lg-12"
		style="border-color: #979797; margin-top: 10px;">
		<div class="am-cf">
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

