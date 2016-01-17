<%@page pageEncoding="utf-8" isELIgnored="false"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head lang="en">
<meta charset="UTF-8">
<title>${sysinfo.name}-网站后台管理系统</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="format-detection" content="telephone=no">
<meta name="renderer" content="webkit">
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="icon" type="image/png" href="../img/favicon.png">
<link rel="stylesheet" href="../assets/css/amazeui.min.css" />
<script src="../assets/js/jquery.min.js"></script>
<script src="../assets/js/amazeui.min.js"></script>

<script type="text/javascript">
	$(function(){
		document.onkeydown=function(event){ 
	        e = event ? event :(window.event ? window.event : null); 
	        if(e.keyCode==13){ 
	            check_login();
	        } 
	    }; 
	});

	//登录校验      		
	function check_login() {
		var admin_code = $("#admin_code").val();
		//alert(admin_code);
		if (admin_code == "") {
			//alert(admin_code+"1");
			$("#admin_code_msg").text("请输入帐号.");
			return;
		}
		var password = $("#password").val();
		//alert(password);
		if (password == "") {
			$("#password_msg").text("请输入密码.");
			return;
		}
		$.post("${basePath}user/login.do", $("#myform").serialize(), function(data) {
			$.AMUI.progress.start();
			if (data.flag == 1) {
				$.AMUI.progress.done();
				//帐号错误
				$("#admin_code_msg").text("帐号有误或不存在");
			} else if (data.flag == 2) {
				$.AMUI.progress.done();
				//密码错误
				$("#password_msg").text("密码错误!");
			} else {
				//成功
				//alert(data);
				$('#loginButton').html("<i class='am-icon-spinner am-icon-spin'></i> 登 录");//登录按钮为 加载的动画样式
				$.AMUI.progress.done();
				location.href = "${basePath}common/gotopage.do?gotourl=news/home";
			}
		});
	}
	//设置提示信息
	function set_msg(id, msg) {
		var admin_code = $("#admin_code").val();
		if (admin_code == "") {
			$("#" + id).text("");
		} else {
			$("#" + id).text(msg);
		}

	}
</script>
<style>
.header {
	text-align: center;
}

.header h1 {
	font-size: 200%;
	color: #333;
	margin-top: 30px;
}

.header p {
	font-size: 14px;
}
</style>
</head>
<body>
	<div class="header">
		<div class="am-g">
			<h1>${sysinfo.name}-网站后台管理系统</h1>
		</div>
		<hr />
	</div>
	<div class="am-g">
		<div class="am-u-lg-6 am-u-md-8 am-u-sm-centered">
			<form method="post" class="am-form" id="myform">
				<label>帐号:</label> <input type="text" name="username"
					onfocus="set_msg('admin_code_msg','');" id="admin_code"
					onblur="set_msg('admin_code_msg','');" placeholder="请输入帐号" /> <span
					class="required" id="admin_code_msg" style="color: red;"></span> <br>
				<label for="password">密码:</label> <input type="password"
					name="password" id="password" value="" placeholder="请输入密码">
				<span class="required" id="password_msg" style="color: red;"></span>
				<br> <br />
				<div class="am-cf">
					<button type="button" id="loginButton" class="am-btn am-btn-primary" onclick="check_login()">登 录</button>
				</div>
			</form>
			<hr>
			<p>黑特网络提供技术服务 电话：18103857686 QQ：317605397</p>
		</div>
	</div>
</body>
</html>