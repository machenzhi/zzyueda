<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<head>
<link rel="stylesheet" href="../assets/css/admin.css">
<header class="am-topbar admin-header">
	<div class="am-topbar-brand">
		<strong style="color: #5eb95e">${sysinfo.name}</strong> <span
			class="am-badge">网站后台管理系统 v1.0</span>
	</div>
	<div class="am-collapse am-topbar-collapse" id="topbar-collapse">
		<ul
			class="am-nav am-nav-pills am-topbar-nav am-topbar-right admin-header-list">
			<li><a href="#"><span class="am-icon-user"></span>${user.truename}</a></li>
			<li><a href="${basePath}login/exit.do"><span
					class="am-icon-sign-out"></span> 退出</a></li>
		</ul>
	</div>
</header>