<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script type="text/javascript">
	//附件添加一行<tr> 
	function addAttachment() {
		var content = "<tr><td>";
		content += "<input type='file' id='uploadFile' name='uploadFile'></td><td align='right'><button type='button' class='am-btn am-btn-default am-btn-xs am-text-danger' onclick='removeAttachment(this)'><span class='am-icon-trash-o'></span>&nbsp;删除</button>";
		content += "</td></tr>";
		$("#attachmentlist").append(content);
	}

	//删除当前行<tr> 
	function removeAttachment(object) {
		var i = object.parentNode.parentNode.rowIndex;
		document.getElementById("attachmentlist").deleteRow(i);
	}

	//显示大图
	function promptBigImg(obj) {
		$('#my-prompt').attr("src", obj.attr("src"));
		$('#my-prompt').modal({
			relatedTarget : this,
		});
	}
</script>
<div class="am-u-sm-12">
	<c:choose>
		<c:when test="${viewstate == 'read'}">
			<ul data-am-widget="gallery"
				class="am-gallery am-avg-sm-2 am-avg-md-3 am-avg-lg-4 am-gallery-imgbordered"
				data-am-gallery="{  }">
				<c:forEach items="${attachmentList}" var="attachment"
					varStatus="status">
					<c:if
						test="${fn:contains(attachment.path,'png')||fn:contains(attachment.path,'jpg')}">
						<li>
							<div class="am-gallery-item">
								<img src="${basePath}${attachment.path}"
									onClick="promptBigImg($(this))" />
							</div>
						</li>
					</c:if>
				</c:forEach>
			</ul>
		</c:when>
		<c:otherwise>
			<table class="am-table am-table-striped am-table-hover table-main"
				id="attachmentlist">
				<c:forEach items="${attachmentList}" var="attachment"
					varStatus="status">
					<c:if
						test="${fn:contains(attachment.path,'png')||fn:contains(attachment.path,'jpg')}">
						<tr>
							<td><input type="hidden"
								name="attachments[${status.index}].id" value="${attachment.id}" />
								<img class="am-img-thumbnail"
								src="${basePath}${attachment.path}" width="140" height="140"
								onClick="promptBigImg($(this))" /></td>
							<td align="right"><c:if test="${viewstate ne 'read'}">
									<button type="button"
										class="am-btn am-btn-default am-btn-xs am-text-danger"
										onClick="removeAttachment(this);">
										<span class="am-icon-trash-o"></span>&nbsp;删除
									</button>
								</c:if></td>
						</tr>
					</c:if>
				</c:forEach>
			</table>
		</c:otherwise>
	</c:choose>
</div>
<img class="am-modal am-modal-prompt am-img-thumbnail"
	src="${basePath}${attachment.path}" id="my-prompt" />
