<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="icon" type="image/png" href="${basePath}img/favicon.png">
<title>${sysinfo.title}</title>
<meta name="description" content="${sysinfo.description}">
<meta name="keywords" content="${sysinfo.keywords}">
<script src="${basePath}assets/js/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		var htmlUrl = "${basePath}html/index.html";
		var requestUrl = "${basePath}news/qiantai/getMainContent.do?htmlName=index";
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
	});
</script>
</head>
<body>
	<div id="indexContent"></div>
</body>
</html>