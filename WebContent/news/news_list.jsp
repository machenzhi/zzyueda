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
		<div class="am-u-sm-12 am-u-md-3 am-u-lg-3" style="margin-top: 10px;">
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
				<ul class="am-list">
					<c:forEach items="${newsList}" var='news'>
						<li class="am-g am-list-item-dated"><a
							class="am-list-item-hd "
							onClick="openPage('${basePath}news/qiantai/getNewsContent.do?id=${news.id}&typename=${news.typename}&htmlName=${news.id}')"
							href="javascript:void(0)">${news.title}</a> <span
							class="am-list-date">${fn:substring(news.publishtime, 0,10)}</span></li>
					</c:forEach>
				</ul>
				<ul
					class="am-pagination am-pagination-centered am-u-sm-12 am-u-md-12 am-u-lg-12">
					<li>共${page.rows}条记录</li>
					<li id="firstPage"
						<c:if test="${page.currentPage==1}">class="am-disabled"</c:if>>
						<a
						href="${basePath}news/qiantai/getNewsList.do?typename=${page.typename}&typeid=${page.typeid}&typepath=${page.typepath}&currentPage=1&htmlName=${page.typeid}_1"
						<c:if test="${page.currentPage==1}">disabled="disabled"</c:if>>首页</a>
					</li>
					<li id="previousPage"
						<c:if test="${page.currentPage==1}">class="am-disabled"</c:if>>
						<a
						href="${basePath}news/qiantai/getNewsList.do?typename=${page.typename}&typeid=${page.typeid}&typepath=${page.typepath}&currentPage=${page.currentPage-1<1?1:page.currentPage-1}&htmlName=${page.typeid}_${page.currentPage-1<1?1:page.currentPage-1}"
						<c:if test="${page.currentPage==1}">disabled="disabled"</c:if>>上一页</a>
					</li>
					<li>${page.currentPage}/${page.totalPage}</li>
					<li id="nextPage"
						<c:if test="${page.currentPage>=page.totalPage}">class="am-disabled"</c:if>>
						<a
						href="${basePath}news/qiantai/getNewsList.do?typename=${page.typename}&typeid=${page.typeid}&typepath=${page.typepath}&currentPage=${page.currentPage+1<=page.totalPage?page.currentPage+1:page.totalPage}&htmlName=${page.typeid}_${page.currentPage+1<=page.totalPage?page.currentPage+1:page.totalPage}"
						<c:if test="${page.currentPage>=page.totalPage}">disabled="disabled"</c:if>>下一页</a>
					</li>
					<li id="lastPage"
						<c:if test="${page.currentPage>=page.totalPage}">class="am-disabled"</c:if>>
						<a
						href="${basePath}news/qiantai/getNewsList.do?typename=${page.typename}&typeid=${page.typeid}&typepath=${page.typepath}&currentPage=${page.totalPage}&htmlName=${page.typeid}_${page.totalPage}"
						<c:if test="${page.currentPage>=page.totalPage}">disabled="disabled"</c:if>>尾页</a>
					</li>
				</ul>
			</div>
		</div>
	</div>
	<%-- *****************中部********结束*********************     --%>
	<%--  **************底部 ****** 开始*************************--%>
	<jsp:include page="../public/foot.jsp" />
	<%--  **************底部 ****** 结束*************************--%>

</body>
</html>