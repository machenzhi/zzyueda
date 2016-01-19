<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head lang="en">
<meta charset="UTF-8">
<title>${sysinfo.title}-网站后台管理系统</title>
<meta name="description" content="${sysinfo.description}">
<meta name="keywords" content="${sysinfo.keywords}">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="format-detection" content="telephone=no">
<meta name="renderer" content="webkit">
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="icon" type="image/png" href="${basePath}img/favicon.png">
<link rel="stylesheet" href="${basePath}assets/css/amazeui.min.css" />
<script src="${basePath}assets/js/jquery.min.js"></script>
<script src="${basePath}assets/js/amazeui.min.js"></script>
<script type="text/javascript" src="${basePath}rixin_js/validation.js"></script>
<script type="text/javascript">
	$(function() {
		if ("${logout}" == "timeout") {
			top.location.href = "${basePath}login.jsp?logout=timeout";
		}
		if ("${param.logout}" == "timeout") {
			$("#msgTip").show();
			$('#msgTip').html(
					"<div class=\"am-icon-warning\">&nbsp;网络超时，请重新登录。</div>");
		}
		$(window).resize();
		document.onkeydown = function(event) {
			e = event ? event : (window.event ? window.event : null);
			if (e.keyCode == 13) {
				check_login();
			}
		};
	});

	//登录校验      		
	function check_login() {
		var isPass = true;
		$("#username_required").hide();
		$("#password_required").hide();
		$("#msgTip").hide();
		var username = $("#username").val();
		var password = $("#password").val();
		if (username == "") {
			$("#username_required").show();
			isPass = false;
		}
		if (password == "") {
			$("#password_required").show();
			isPass = false;
		}
		if (!isPass) {
			return;
		}
		$.AMUI.progress.start();
		$('#loginButton').html("正在登录");
		$('#loginButton').attr("disabled", "disabled");
		$.post("${basePath}user/login.do", $("#myform").serialize(), function(
				data) {
			if (data.isSuccess) {
				location.href = "${basePath}common/gotopage.do?gotourl=main";
			} else {
				$("#username_required").hide();
				$("#password_required").hide();
				$("#msgTip").show();
				$('#msgTip').html(
						"<div class=\"am-icon-warning\">&nbsp;" + data.msgTip
								+ "</div>");
				$('#loginButton').html("登录");
				$('#loginButton').removeAttr("disabled");
			}
		});
	}
</script>
</head>
<body>
	<div class="am-container">
		<div class="am-u-sm-6 am-u-md-6 am-u-sm-centered am-topbar-brand"
			align="center" style="margin-top: 150px;">
			<strong style="color: #5eb95e; font-size: 20px;">${sysinfo.name}</strong>
			<span class="am-badge">网站后台管理系统 v1.0</span>
		</div>
		<div class="am-u-sm-6 am-u-md-6 am-u-sm-centered">
			<form class="am-form" method="post" id="myform">
				<div class="am-g">
					<div class="am-u-sm-12">
						<input type="text" class="am-form-field" id="username"
							name="username" placeholder="请输入帐号">
						<div id="username_required" style="display: none;"
							class="am-alert am-alert-danger">
							<div class="am-icon-warning">&nbsp;请输入帐号</div>
						</div>
					</div>
				</div>
				<div class="am-g">
					<div class="am-u-sm-12 " style="padding-top: 5px;">
						<input type="password" class="am-form-field" id="password"
							name="password" placeholder="请输入密码">
						<div id="password_required" style="display: none;"
							class="am-alert am-alert-danger">
							<div class="am-icon-warning">&nbsp;请输入密码</div>
						</div>
					</div>
				</div>
				<div class="am-g">
					<div class="am-u-sm-12 ">
						<div id="msgTip" style="display: none; margin-top: 15px"
							class="am-alert am-alert-danger"></div>
						<button type="button" id="loginButton" onclick="check_login()"
							class="am-u-sm-12 am-btn am-btn-primary" style="margin-top: 5px">登录</button>
					</div>
				</div>
				<div class="am-g">
					<div class="am-u-sm-12 " style="margin-top: 20px;">
						<small>Powered by <a href="http://www.shareme.ren"
							target="_blank">晒迷人提供技术服务</a>
						</small>
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
