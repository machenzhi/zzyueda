<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<style type="text/css">
.footTitle {
	color: #000000;
	font-size: 14px;
}

.footLink {
	color: #666666;
	font-size: 12px;
}

.banquan {
	color: #666666;
	font-size: 12px;
	padding: 5px;
}
</style>
</head>
<body>
	<%--  **************底部 ****** 开始*************************    --%>
	<hr data-am-widget="divider" style=""
		class="am-divider am-divider-default" />
	<div class="am-u-g">
		<div class="am-container" style="padding: 10px;">
			<ul class="am-avg-sm-2 am-avg-md-5">
				<li><span class="footTitle">新闻中心</span> <br> <c:forEach
						items="${xinwenzhongxinSubTypes}" var="type">
						<a
							onClick="openPage('${basePath}${type.url}&typename=${type.name}&typeid=${type.id}&typepath=${type.abspath}&htmlName=${type.id}')"
							href="javascript:void(0)" class="footLink">${type.name}</a>
						<br>
					</c:forEach></li>
				<li><span class="footTitle">业务范围</span> <br> <c:forEach
						items="${yewufanweiSubTypes}" var="type">
						<a
							onClick="openPage('${basePath}${type.url}&typename=${type.name}&typeid=${type.id}&typepath=${type.abspath}&htmlName=${type.id}')"
							href="javascript:void(0)" class="footLink">${type.name}</a>
						<br>
					</c:forEach></li>
				<li><span class="footTitle">联系我们</span> <br> <span
					class="footLink">${lianxiwomengaikuang.newsList[0].content}
				</span></li>
				<li><span class="footTitle">保持接触</span> <br> <span
					class="footLink">微信平台升级中</span><br></li>
				<li><span class="footTitle">友情链接</span> <br> <a
					href="http://www.baidu.com" target="_blank" class="footLink">百度</a><br>
					<a href="http://www.163.com" target="_blank" class="footLink">网易</a><br>
					<a href="http://weibo.com" target="_blank" class="footLink">新浪微博</a><br>
			</ul>
		</div>
		<div class="banquan" align="center">
			郑州市悦达企业管理咨询有限公司 版权所有©2014-2017 豫ICP备15001822号  <a
				href="http://tongji.baidu.com/web/welcome/login" target="_blank"
				class="footLink">百度统计</a> 技术支持：黑特网络 18103857686
		</div>
	</div>
	<%--  **************底部 ****** 结束*************************    --%>
</body>
</html>