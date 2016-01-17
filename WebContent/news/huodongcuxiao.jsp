<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="am-panel am-panel-default am-show-md-up">
	<div class="am-panel-hd am-u-sm-12">
		<div class="am-fl">
			<h3 class="am-panel-title">活动促销</h3>
		</div>
		<div class="am-fr">
			<a
				onClick="openPage('${basePath}news/qiantai/getNewsImgList.do?typename=${huodongcuxiao.name}&typeid=${huodongcuxiao.id}&typepath=${huodongcuxiao.abspath}&htmlName=${huodongcuxiao.id}')"
				href="javascript:void(0)">更多</a>
		</div>
	</div>
	<div class="am-panel-bd" style="padding: 0px">
		<c:if test="${fn:length(huodongcuxiao.newsList) ne 0}">
			<ul data-am-widget="gallery"
				class="am-gallery am-avg-sm-2 am-gallery-bordered"
				data-am-gallery="{  }">
				<c:forEach items="${huodongcuxiao.newsList}" var='news'
					varStatus="news_stas">
					<li>
						<div class="am-gallery-item">
							<a
								onClick="openPage('${basePath}news/qiantai/getNewsContent.do?id=${news.id}&typename=${news.typename}&htmlName=${news.id}')"
								href="javascript:void(0)"> <img
								src="${basePath}${news.attachments[0].smallPath}"
								title="亲，点我会变大哦~" alt="亲，点我会变大哦 #^_^#" style="height: 100px" />
								<h3 class="am-gallery-title">${news.title}</h3>
								<div class="am-gallery-desc">
									<a class="am-badge am-badge-success"
										onClick="openPage('${basePath}${news.typeurl}&typename=${news.typename}&typeid=${news.typeid}&typepath=${news.typepath}&htmlName=${news.typeid}')"
										href="javascript:void(0)">${news.typename}</a>
								</div>
							</a>
						</div>
					</li>
				</c:forEach>
			</ul>
		</c:if>
		<c:if test="${fn:length(huodongcuxiao.newsList) eq 0}">
		&nbsp;&nbsp;&nbsp;&nbsp;暂无内容
		</c:if>
	</div>
</div>