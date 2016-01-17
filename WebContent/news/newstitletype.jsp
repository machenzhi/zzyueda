<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:if test="${fn:length(NewsTitleMenu) ne 0}">
	<div class="am-panel am-panel-default am-show-md-up">
		<div class="am-panel-hd" style="border-bottom-style: none;">
			<h3 class="am-panel-title">${typename}</h3>
		</div>
		<%-- 	***********遍历出左侧列表************ --%>
		<ul class="am-list am-list-static">
			<c:forEach items="${NewsTitleMenu}" var='newsTitle'>
				<li style="height: 35px; padding-top: 5px;"><a
					style="padding: 0px; margin: 0px;"
					onClick="openPage('${basePath}${NewsTitleMenuUrl}&id=${newsTitle.id}&typename=${newsTitle.typename}&typeid=${newsTitle.typeid}&typepath=${newsTitle.typepath}&htmlName=${newsTitle.id}')"
					href="javascript:void(0)"> ${newsTitle.title} </a></li>
			</c:forEach>
		</ul>
	</div>
</c:if>