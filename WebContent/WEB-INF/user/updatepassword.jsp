<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>${sysinfo.name}-网站后台管理系统</title>
<meta name="description" content="">
<meta name="keywords" content="">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<meta name="renderer" content="webkit">
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="apple-touch-icon-precomposed"
	href="../assets/i/app-icon72x72@2x.png">
<link rel="icon" type="image/png" href="../img/favicon.png">
<link rel="stylesheet" href="../assets/css/amazeui.min.css">
<link rel="stylesheet" href="../assets/css/app.css">
<link rel="stylesheet" href="../assets/css/admin.css">
<script src="../assets/js/jquery.min.js"></script>
<script src="../assets/js/amazeui.min.js"></script>

<style>
.error{color: red;}
.success{color: green;}
</style>
<script type="text/javascript">

var flag=false;
$(function(){

		$('input[name=oldPassword]').blur(function(){
				var oldPassword = $(this).val();
				if(oldPassword == ''){
					$("#oldPass").attr('class','error').html("不能为空");
				}
				else{
					$("#oldPass").attr('class','success').html('');
				}
			});
		$('input[name=newPassword]').blur(function(){
				var password=$('#password').val();
				var newPassword = $(this).val();
				//非空验证
				if(newPassword==''){
					$("#newPass").attr('class','error').html("不能为空");
				}else {
					$("#newPass").attr('class','success').html("");
					if(password == newPassword){
						$("#pass").attr('class','success').html('');
					}else{
						flag=false;
						if(password !='')
						$("#pass").attr('class','error').html("两次输入密码不一致");
					}
				}
				
			});
		
		$('input[name=password]').blur(function(){
				var newPassword=$('#newPassword').val();
				var password = $(this).val();
				if(password==''){
					$("#pass").attr('class','error').html("不能为空");
				}else if(password == newPassword){
					$("#pass").attr('class','success').html('');
				}
				else{
					$("#pass").attr('class','error').html("两次输入密码不一致");
				}
			});
});	


function updatePassword(){
	$('input').trigger('blur');//自动触发某类事件
	 var length =$('.error').length;  
	if(length==0){
		$.post("${basePath}user/updatePassword.do", $("#myform").serialize(), function(data) {
			if (data.isSuccess) {
				//修改成功
				$("#newPassword").val('');
				$("#oldPassword").val('');
				$("#password").val('');
				alert("修改成功")
			} else {
				$("#oldPass").attr('class','error').html("密码不正确")
			}
		});
	}
}
		
</script>
<div class="admin-content">
<%-- content start --%>
		<div class="am-fl am-cf" style="margin: 20px">
			<strong class="am-text-primary am-text-lg">修改密码</strong>
		</div><br><br><br>
	<div class="am-u-sm-5 " style="margin: 20px">
		<form method="post" class="am-form" id="myform">
				<label>原密码:</label> 
				<input type="password" name="oldPassword" id="oldPassword" placeholder="请输入原密码"/> <span id="oldPass" style="color: red"></span>
				 <br>
				<label for="password">新密码:</label> 
				<input type="password" name="newPassword" id="newPassword" value="" placeholder="请输入新密码"> <span id="newPass" style="color: red"></span>
				<br> 
				<label for="password">确认新密码:</label> 
				<input type="password" name="password" id="password" value="" placeholder="请再次输入新密码"><span id="pass" style="color: red"></span>
				<br> 
				<div class="am-cf">
					<input onkeydown="javascript:check_login();" type="button" name=""
						value="修改" class="am-btn am-btn-primary am-btn-sm am-fl"
						onclick="javascript:updatePassword();">
				</div>
			</form>
	</div>
	
	</div>