<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String randomNum = String.valueOf(Math.random()).substring(2);
%>
<script type="text/javascript">
	$(function() {
		$(document).keydown(function(event) {
			if (event.keyCode == 13) {
				var id = $("input:focus").attr("id");
				switch (id) {
				case "<%=randomNum%>toPageNum":
					toPage();
					break;
				}
			}
		});
	});

	//分页跳转
	function toPage(){
		var toPage = parseInt($("#<%=randomNum%>toPageNum").val());//跳转页码数
		var totalPage = "${page.totalPage}";//总页码数
		var currentPage = "${page.currentPage}";//当前页码数
		if(toPage == currentPage){
			return;
		}else{
			if(toPage <= totalPage && toPage > 0){
				pageFunction(toPage)
			} else {
				alert("请输入正确的页码，如：1 2 3。");
			}
		}
	}
</script>
<div class="am-fr" style="margin: 5px;">
	<ul class="am-pagination am-pagination-centered">
		<li><small>共${page.rows}条记录</small></li>
		<li id="firstPage"
			<c:if test="${page.currentPage==1}">class="am-disabled"</c:if>><a
			class="am-btn-sm" href="javascript:pageFunction('1')"
			<c:if test="${page.currentPage==1}">disabled="disabled"</c:if>>首页</a>
		</li>
		<li id="previousPage"
			<c:if test="${page.currentPage==1}">class="am-disabled"</c:if>><a
			class="am-btn-sm"
			href="javascript:pageFunction('${page.currentPage-1<1?1:page.currentPage-1}')"
			<c:if test="${page.currentPage==1}">disabled="disabled"</c:if>>上一页</a>
		</li>
		<li><small>第${page.currentPage}页/共${page.totalPage}页</small></li>
		<li id="nextPage"
			<c:if test="${page.currentPage==page.totalPage}">class="am-disabled"</c:if>><a
			class="am-btn-sm"
			href="javascript:pageFunction('${page.currentPage+1<=page.totalPage?page.currentPage+1:page.totalPage}')"
			<c:if test="${page.currentPage==page.totalPage}">disabled="disabled"</c:if>>下一页</a>
		</li>
		<li id="lastPage"
			<c:if test="${page.currentPage==page.totalPage}">class="am-disabled"</c:if>><a
			class="am-btn-sm" href="javascript:pageFunction('${page.totalPage}')"
			<c:if test="${page.currentPage==page.totalPage}">disabled="disabled"</c:if>>尾页</a>
		</li>
		<li <c:if test="${page.totalPage=='1'}">class="am-disabled"</c:if>><small>第
				<input style="width: 30px;" id="<%=randomNum%>toPageNum"
				name="<%=randomNum%>toPageNum"
				<c:if test="${page.totalPage=='1'}">disabled="disabled"</c:if>>
				页
		</small></li>
		<li <c:if test="${page.totalPage=='1'}">class="am-disabled"</c:if>><a
			class="am-btn-sm" href="javascript:toPage();"
			<c:if test="${page.totalPage=='1'}">disabled="disabled"</c:if>>跳转</a></li>
	</ul>
</div>
