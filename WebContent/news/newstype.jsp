<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:if test="${fn:length(typeMenuList) ne 0}">
	<div class="am-panel am-panel-default am-show-md-up">
		<div class="am-panel-hd" style="border-bottom-style: none;">
			<h3 class="am-panel-title">${typename}</h3>
		</div>
		<%-- 	***********遍历出左侧列表************ --%>
		<ul class="am-list am-list-static">
			<c:forEach items="${typeMenuList}" var='typeMenu'>
				<li style="height: 35px; padding-top: 5px;"><a
					style="cursor: pointer; padding: 0px; margin: 0px;"
					onclick="initContent('${basePath}${typeMenu.url}&typename=${typeMenu.name}&typeid=${typeMenu.id}&typepath=${typeMenu.abspath}&htmlName=${typeMenu.id}_1')">
						${typeMenu.name} </a></li>
			</c:forEach>
		</ul>
	</div>
</c:if>