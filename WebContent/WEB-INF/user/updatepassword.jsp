<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<META HTTP-EQUIV="pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
<META HTTP-EQUIV="expires" CONTENT="Wed, 26 Feb 1997 08:21:57GMT">
<title>${sysinfo.title}</title>
<meta name="description" content="${sysinfo.description}">
<meta name="keywords" content="${sysinfo.keywords}">
<link rel="apple-touch-icon-precomposed"
	href="../assets/i/app-icon72x72@2x.png">
<link rel="icon" type="image/png" href="../img/favicon.png">
<link rel="stylesheet" href="../assets/css/amazeui.min.css">
<link rel="stylesheet" href="../assets/css/app.css">
<link rel="stylesheet" href="../assets/css/admin.css">
<link rel="stylesheet" href="../ztree/css/zTreeStyle/zTreeStyle.css"
	type="text/css">
<script src="../assets/js/jquery.min.js"></script>
<script src="../assets/js/amazeui.min.js"></script>
<!-- JS校验规则 -->
<script type="text/javascript" src="${basePath}rixin_js/validation.js"></script>
<!-- 只读状态控件状态修改 -->
<script type="text/javascript" src="${basePath}rixin_js/readstyle.js"></script>
<script type="text/javascript" src="${basePath}rixin_js/jquery.form.js"></script>
</head>
<script type="text/javascript">
	var viewstate = "${viewstate}";// 获取当前用户 是否为read状态
	//提交
	var url = "${basePath}user/updateUserPassword.do";

	$(function() {
		$('#submitButton').on('click', function() {
			if (formValidate()) {
				$("#submitForm").ajaxSubmit({
					type : "POST",
					url : url,
					dataType : "json",
					success : function(data) {
						if (data.isSuccess) {
							alert("恭喜，密码修改成功。");
							window.close();
						} else {
							alert("抱歉，密码修改失败，请重新操作。");
						}
					}
				});
			}
		});
	});
</script>
<body style="background-color: #F5F5F5">
	<!--表单头信息-->
	<jsp:include page="../public/formtitle.jsp" />
	<div class="am-container" style="background-color: #FFFFFF">
		<div data-am-widget="titlebar" class="am-titlebar am-titlebar-default">
			<h2 class="am-titlebar-title ">修改密码</h2>
			<nav class="am-titlebar-nav"></nav>
		</div>
		<form class="am-form" method="post" id="submitForm" name="submitForm">
			<input type="hidden" name="id" id="id" value="${sessionScope.user.id}">
			<div class="am-g">
				<div style="margin-top: 2px;"
					class="am-input-group am-u-sm-12 am-u-md-12">
					<span class="am-input-group-label" style="width: 150px">原密码</span>
					<input type="password" id="password_old" name="password_old"
						placeholder="请输入原密码" required />
				</div>
				<div style="margin-top: 2px;"
					class="am-input-group am-u-sm-12 am-u-md-12">
					<span class="am-input-group-label" style="width: 150px">新密码</span>
					<input type="password" id="password_new" name="password_new"
						placeholder="请输入新密码（至少6位）" minLength="6"
						valueSameTo="password:main" required />
				</div>
				<div style="margin-top: 2px;"
					class="am-input-group am-u-sm-12 am-u-md-12">
					<span class="am-input-group-label" style="width: 150px">再次输入新密码</span>
					<input type="password" id="password_new2" name="password_new2"
						placeholder="请再次输入新密码（至少6位）" minLength="6"
						valueSameTo="password:other||两次填写的密码不一致" required />
				</div>
			</div>
		</form>
		<div align="center" class="am-u-sm-12 am-u-md-12"
			style="margin-top: 20px; margin-bottom: 20px;">
			<button type="button" id="submitButton" name="submitButton"
				class="am-btn am-btn-success" style="width: 100%">保存</button>
		</div>
	</div>
</body>
</html>