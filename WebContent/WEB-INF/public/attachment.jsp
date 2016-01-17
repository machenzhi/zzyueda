<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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

	$(function() {
		$('#prompt-toggle').on('click', function() {
			$('#my-prompt').attr("src", $('#prompt-toggle').attr("src"));
			$('#my-prompt').modal({
				relatedTarget : this,
			});
		});
	});
</script>
<c:if
	test="${viewstate ne 'read' || (attachmentList != null && fn:length(attachmentList) > 0)}">
	<strong class="am-u-sm-12 am-u-md-12"
		style="margin-top: 5px; margin-bottom: 5px;">附件</strong>
</c:if>
<div class="am-u-sm-12">
	<c:if test="${viewstate ne 'read'}">
		<a href="#" onclick="addAttachment()"> <i class="am-icon-plus"></i>
			添加附件
		</a>
	</c:if>
	<table class="am-table am-table-striped am-table-hover table-main"
		id="attachmentlist">
		<c:forEach items="${attachmentList}" var="attachment"
			varStatus="status">
			<tr>
				<td>${status.index+1 }.&nbsp;&nbsp;<input type="hidden"
					name="attachments[${status.index}].id" value="${attachment.id}" />
					<a href="${basePath}attachment/download.do?id=${attachment.id}"
					target="_blank">${attachment.name}</a>
				</td>
				<td><c:if
						test="${fn:contains(attachment.path,'png')||fn:contains(attachment.path,'jpg')}">
						<img class="am-img-thumbnail" alt="140*140"
							src="${basePath}${attachment.path}" width="140" height="140"
							id="prompt-toggle" />
					</c:if></td>
				<td align="right"><c:if test="${viewstate ne 'read'}">
						<button type="button"
							class="am-btn am-btn-default am-btn-xs am-text-danger"
							onClick="removeAttachment(this);">
							<span class="am-icon-trash-o"></span>&nbsp;删除
						</button>
					</c:if></td>
			</tr>
		</c:forEach>
	</table>
</div>
<img class="am-modal am-modal-prompt am-img-thumbnail" alt="140*140"
	src="${basePath}${attachment.path}" id="my-prompt" />
