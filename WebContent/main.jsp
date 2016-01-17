<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!doctype html>
<html class="no-js">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="icon" type="image/png" href="${basePath }img/favicon.png">
<title>${sysinfo.title}</title>
<meta name="description" content="${sysinfo.description}">
<meta name="keywords" content="${sysinfo.keywords}">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<meta name="renderer" content="webkit">
<meta http-equiv="Cache-Control" content="no-siteapp" />
<script src="${basePath}assets/js/jquery.min.js"></script>
<script src="${basePath}assets/js/amazeui.min.js"></script>
</head>
<body>
	<%-- **************公共头部*****************   --%>
	<jsp:include page="public/top.jsp" />
	<%-- ***********************************	  --%>
	<%-- *****************中部********开始*********************     --%>
	<div class="am-container">
		<div class="am-u-sm-12 am-u-md-4 am-u-lg-4" style="padding: 0px 5px;">
			<div class="am-panel am-panel-default" style="margin-bottom: 10px;">
				<div class="am-panel-hd am-u-sm-12">
					<div class="am-fl">
						<h3 class="am-panel-title" style="color: #009800">&raquo;联系我们</h3>
					</div>
					<div class="am-fr">
						<a
							onClick="openPage('${basePath}news/qiantai/getNewsContent.do?id=${lianxiwomen.newsList[0].id}&typeid=${lianxiwomen.newsList[0].typeid}&typename=${lianxiwomen.newsList[0].typename}&htmlName=${lianxiwomen.newsList[0].id}')"
							href="javascript:void(0)">更多</a>
					</div>
				</div>
				<div class="am-panel-bd" style="height: 335px">
					<div
						style="width: 100%; height: 295px; overflow: hidden; text-overflow: ellipsis;">
						${lianxiwomengaikuang.newsList[0].content}</div>
				</div>
			</div>
		</div>
		<div class="am-u-sm-12 am-u-md-8 am-u-lg-8" style="padding: 0px 5px;">
			<div class="am-panel am-panel-default" style="margin-bottom: 10px;">
				<div class="am-panel-hd am-u-sm-12">
					<div class="am-fl">
						<h3 class="am-panel-title" style="color: #009800">&raquo;关于我们</h3>
					</div>
					<div class="am-fr">
						<a
							onClick="openPage('${basePath}news/qiantai/getNewsContent.do?id=${guanYuWoMen.newsList[0].id}&typeid=${guanYuWoMen.newsList[0].typeid}&typename=${guanYuWoMen.newsList[0].typename}&htmlName=${guanYuWoMen.newsList[0].id}')"
							href="javascript:void(0)">更多</a>
					</div>
				</div>
				<div class="am-panel-bd" style="height: 335px;">
					<div
						style="width: 100%; height: 295px; overflow: hidden; text-overflow: ellipsis;">
						<p class="am-align-left">
							<img
								src="${basePath}${guanYuWoMen.newsList[0].attachments[0].smallPath}"
								title="公司风采" alt="公司风采" style="width: 200px; padding-top: 10px;" />
						</p>
						${fn:replace(guanYuWoMen.newsList[0].content,"<img", "<img hidden='true' ")}
					</div>
				</div>
			</div>
		</div>
		<div class="am-u-sm-12" style="padding: 0px 5px;">
			<div class="am-panel am-panel-default" style="margin-bottom: 10px;">
				<div class="am-panel-hd am-u-sm-12">
					<div class="am-fl">
						<h3 class="am-panel-title" style="color: #009800">&raquo;业务范围</h3>
					</div>
					<div class="am-fr">
						<a
							onClick="openPage('${basePath}news/qiantai/getNewsImgList.do?typename=${productcenter.name}&typeid=${productcenter.id}&typepath=${productcenter.abspath}&htmlName=${productcenter.id}')"
							href="javascript:void(0)">更多</a>
					</div>
				</div>
				<div class="am-panel-bd" style="padding: 0px">
					<div class="am-g">
						<ul data-am-widget="gallery"
							class="am-gallery am-avg-sm-2 am-avg-md-4 am-avg-lg-6 am-gallery-bordered"
							data-am-gallery="{  }">
							<c:forEach items="${yewufanwei.newsList}" var='news'
								varStatus="news_stas">
								<li>
									<div class="am-gallery-item">
										<a
											onClick="openPage('${basePath}news/qiantai/getNewsContent.do?id=${news.id}&typename=${news.typename}&htmlName=${news.id}')"
											href="javascript:void(0)"> <img
											src="${basePath}${news.attachments[0].smallPath}"
											title="亲，点我会变大哦~" alt="亲，点我会变大哦 #^_^#" style="height: 150px" />
											<h3 class="am-gallery-title">${news.title}&nbsp;</h3>
											<div class="am-gallery-desc">
												<a class="am-badge am-badge-success"
													onClick="openPage('${news.typeurl}&typename=${news.typename}&typeid=${news.typeid}&typepath=${news.typepath}&htmlName=${news.typeid}')"
													href="javascript:void(0)">${news.typename}</a>
											</div>
										</a>
									</div>
								</li>
							</c:forEach>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<div class="am-u-sm-12" style="padding: 0px 5px;">
			<div class="am-panel am-panel-default" style="margin-bottom: 10px;">
				<div class="am-panel-hd am-u-sm-12">
					<div class="am-fl">
						<h3 class="am-panel-title" style="color: #009800">&raquo;活动促销</h3>
					</div>
					<div class="am-fr">
						<a
							onClick="openPage('${basePath}news/qiantai/getNewsImgList.do?typename=${huodongcuxiao.name}&typeid=${huodongcuxiao.id}&typepath=${huodongcuxiao.abspath}&htmlName=${huodongcuxiao.id}')"
							href="javascript:void(0)">更多</a>
					</div>
				</div>
				<div class="am-panel-bd" style="padding: 0px">
					<c:if test="${fn:length(huodongcuxiao.newsList) ne 0}">
						<div class="am-g">
							<ul data-am-widget="gallery"
								class="am-gallery am-avg-sm-2 am-avg-md-4 am-avg-lg-6 am-gallery-bordered"
								data-am-gallery="{  }">
								<c:forEach items="${huodongcuxiao.newsList}" var='news'
									varStatus="news_stas">
									<li>
										<div class="am-gallery-item">
											<a
												onClick="openPage('${basePath}news/qiantai/getNewsContent.do?id=${news.id}&typename=${news.typename}&htmlName=${news.id}')"
												href="javascript:void(0)"> <img
												src="${basePath}${news.attachments[0].smallPath}"
												title="亲，点我会变大哦~" alt="亲，点我会变大哦 #^_^#" style="height: 150px" />
												<h3 class="am-gallery-title">${news.title}&nbsp;</h3>
												<div class="am-gallery-desc">
													<a class="am-badge am-badge-success"
														onClick="openPage('${news.typeurl}&typename=${news.typename}&typeid=${news.typeid}&typepath=${news.typepath}&htmlName=${news.typeid}')"
														href="javascript:void(0)">${news.typename}</a>
												</div>
											</a>
										</div>
									</li>
								</c:forEach>
							</ul>
						</div>
					</c:if>
					<c:if test="${fn:length(huodongcuxiao.newsList) eq 0}">
							&nbsp;&nbsp;&nbsp;&nbsp;暂无内容
						</c:if>
				</div>
			</div>
		</div>
	</div>
	<%-- *****************中部********结束*********************--%>
	<%--  **************底部 ****** 开始*************************--%>
	<jsp:include page="public/foot.jsp" />
	<%--  **************底部 ****** 结束*************************--%>
</body>
</html>
