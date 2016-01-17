<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
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
<script src="${basePath}assets/js/jquery.min.js"></script>
<script src="${basePath}assets/js/amazeui.min.js"></script>
<!-- JS校验规则 -->
<script type="text/javascript" src="${basePath}rixin_js/validation.js"></script>
<!-- 只读状态控件状态修改 -->
<script type="text/javascript" src="${basePath}rixin_js/readstyle.js"></script>
<script type="text/javascript" charset="utf-8"
	src="${basePath}ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8"
	src="${basePath}ueditor/ueditor.all.js"></script>
<%--建议手动加载语言，避免在ie下有时因为加载语言失败导致编辑器加载失败--%>
<%--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文--%>
<script type="text/javascript" charset="utf-8"
	src="${basePath}ueditor/lang/zh-cn/zh-cn.js"></script>
<script type="text/javascript">
	var viewstate = "${viewstate}";// 获取当前用户 是否为 “read” 状态
	var URL;
	//编辑
	if (viewstate == "update") {
		URL = "${basePath}news/updateNews.do";
	} else {
		URL = "${basePath}news/createNews.do";
	}

	function save() {
		if (formValidate()) {
			getEditorContent();
			if (editorContent == '') {
				alert('内容不能为空，请填写。');
				return;
			}
			$('#content').val(editorContent);
			document.infoForm.action = URL;
			document.infoForm.submit();
		}
	}
	if ('${isSuccess}' != "") {
		if ('${isSuccess}' == "true") {
			opener.initContent("${basePath}news/getNewsListPage.do");
			alert("保存成功");
			window.close();
		} else {
			alert("抱歉，保存失败");
		}
	}
	//删除当前行<tr> 
	function removeAttachment(object) {
		var i = object.parentNode.parentNode.rowIndex;
		document.getElementById("attachmentlist").deleteRow(i);
	}
	////////////////////////////////////////
	/////////////UEditor开始/////////////////
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	var ue = UE.getEditor('editor');
	var editorContent;

	function getEditorContent() {
		var arr = [];
		arr.push(UE.getEditor('editor').getContent());
		editorContent = arr.join("\n");
	}

	function setFocus() {
		UE.getEditor('editor').focus();
	}

	//给编辑器赋值
	function setContent(content) {
		UE.getEditor('editor').setContent(content);
	}

	ue.ready(function() {
		setContent('${news.content}');
	});
	/////////////UEditor结束/////////////////
	////////////////////////////////////////
</script>
</head>
<body style="background-color: #F5F5F5">
	<!--表单头信息-->
	<jsp:include page="../public/formtitle.jsp" />
	<div class="am-container" style="background-color: #FFFFFF">
		<c:if test="${viewstate ne 'read'}">
			<div data-am-widget="titlebar"
				class="am-titlebar am-titlebar-default">
				<h2 class="am-titlebar-title ">文章信息</h2>
				<nav class="am-titlebar-nav"></nav>
			</div>
			<form class="am-form" id="infoForm" name="infoForm" method="post"
				enctype="multipart/form-data">
				<input type="hidden" value="${news.id}" id="id" name="id" /> <input
					type="hidden" id="content" name="content" />
				<div style="margin-top: 5px;"
					class="am-input-group am-u-sm-12 am-u-md-12">
					<span class="am-input-group-label" style="width: 150px">标题</span> <input
						type="text" id="title" name="title" value="${news.title}" required />
				</div>
				<div style="margin-top: 5px;"
					class="am-input-group am-u-sm-12 am-u-md-12">
					<span class="am-input-group-label" style="width: 150px">类型</span> <select
						id="typeid" name="typeid">
						<c:forEach items="${dictionaryList}" var="dictionary">
							<option value="${dictionary.id}#${dictionary.abspath}"
								<c:if test="${dictionary.id==news.typeid}">selected="selected"</c:if>>${dictionary.name}</option>
						</c:forEach>
					</select>
				</div>
				<div style="margin-top: 5px;"
					class="am-input-group am-u-sm-12 am-u-md-12">
					<span class="am-input-group-label" style="width: 150px">作者</span> <input
						type="text" id="author" name="author" value="${news.author}" />
				</div>
				<div style="margin-top: 5px;"
					class="am-input-group am-u-sm-12 am-u-md-12">
					<span class="am-input-group-label" style="width: 150px">文章主图片</span>
					<div
						style="border-style: solid; border-width: 1px; border-color: #ccc; height: 38px; padding: 5px;">
						<input type="file" id="uploadFile" name="uploadFile"
							style="width: 100%" />
					</div>
				</div>
				<c:if
					test="${attachmentList != null && fn:length(attachmentList) > 0}">
					<div style="margin-top: 5px;" class=" am-u-sm-12 am-u-md-12">
						<table id="attachmentlist">
							<tr>
								<td><input type="hidden" name="attachments[0].id"
									value="${attachmentList[0].id}" /> <img class="am-radius"
									alt="140*140" src="${basePath}${attachmentList[0].smallPath}"
									width="140" height="140" /><br>
									<button type="button" class="am-btn am-btn-default am-btn-xs"
										onClick="removeAttachment(this);">
										<span class="am-icon-trash-o"></span>&nbsp;删除
									</button></td>
							</tr>
						</table>
					</div>
				</c:if>
				<div style="margin-top: 5px;" class="am-u-sm-12 am-u-md-12">
					<script id="editor" type="text/plain"
						style="width:100%;height:400px;"></script>
				</div>
			</form>
			<div align="center" class="am-u-sm-12 am-u-md-12"
				style="margin-top: 20px; margin-bottom: 20px;">
				<c:if test="${viewstate ne 'read'}">
					<button type="button" id="mySave" name="mySave"
						class="am-btn am-btn-success" style="width: 100%" onClick="save()">保存</button>
				</c:if>
			</div>
		</c:if>
		<c:if test="${viewstate == 'read'}">
			<div style="margin-top: 10px;" class="am-u-sm-12 am-u-md-12"
				align="center">${news.title}</div>
			<div class="am-u-sm-12 am-u-md-12" align="center">
				<small>${news.author}&nbsp;&nbsp;&nbsp;&nbsp;发布时间：${news.publishtime}</small>
			</div>
			<c:if
				test="${attachmentList != null && fn:length(attachmentList) > 0}">
				<div class="am-u-sm-12 am-u-md-12" align="center">
					<img class="am-radius" alt="140*140"
						src="${basePath}${attachmentList[0].path}" width="700" />
				</div>
			</c:if>
			<div class="am-u-sm-12 am-u-md-12">${news.content}</div>
		</c:if>
	</div>
</body>
</html>