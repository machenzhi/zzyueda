<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:if test="${fn:length(fixedDictionaryList) ne 0}">
	<div class="am-panel am-panel-default am-show-md-up">
		<div class="am-panel-hd" style="border-bottom-style: none;">
			<h3 class="am-panel-title">悦达工商</h3>
		</div>
		<ul class="am-list am-list-static">
			<c:forEach items="${fixedDictionaryList}" var='typeMenu'>
				<li style="height: 35px; padding-top: 5px;"><a
					style="padding: 0px; margin: 0px;"
					onClick="openPage('${basePath}${typeMenu.url}&typename=${typeMenu.name}&typeid=${typeMenu.id}&typepath=${typeMenu.abspath}&htmlName=${typeMenu.id}')"
					href="javascript:void(0)"> ${typeMenu.name} </a></li>
			</c:forEach>
		</ul>
	</div>
</c:if>