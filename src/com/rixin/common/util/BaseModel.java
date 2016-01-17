package com.rixin.common.util;

import java.util.ArrayList;
import java.util.List;

import com.rixin.attachment.model.Attachment;

/**
 * 基础javabean，供业务javabean继承使用
 * 
 * @author himcz@163.com
 *
 */
public class BaseModel {
	private String searchKeywords;// 全文检索条件
	private String viewstate;// 表单状态。查看read，新增create，修改update，复写copy
	private String entryUserId;// 录入人ID
	private String entryUserTrueName;// 录入人名称
	private String entryTime;// 录入时间
	private String createUserId;// 创建人ID
	private String createUserTrueName;// 创建人名称
	private String createTime;// 创建时间
	private String modifyUserId;// 修改人ID
	private String modifyUserTrueName;// 修改人名称
	private String modifyTime;// 修改时间
	private String currentUserId;// 系统当前登录人ID
	private String currentUserTrueName;// 系统当前登录人名称
	private List<Attachment> attachments = new ArrayList<Attachment>();
	private String startTime;// 开始时间
	private String endTime;// 结束时间

	public String getSearchKeywords() {
		return searchKeywords;
	}

	public void setSearchKeywords(String searchKeywords) {
		if (searchKeywords != null) {
			this.searchKeywords = searchKeywords.trim();
		} else {
			this.searchKeywords = searchKeywords;
		}
	}

	public String getViewstate() {
		return viewstate;
	}

	public void setViewstate(String viewstate) {
		this.viewstate = viewstate;
	}

	public String getEntryUserId() {
		return entryUserId;
	}

	public void setEntryUserId(String entryUserId) {
		this.entryUserId = entryUserId;
	}

	public String getEntryUserTrueName() {
		return entryUserTrueName;
	}

	public void setEntryUserTrueName(String entryUserTrueName) {
		this.entryUserTrueName = entryUserTrueName;
	}

	public String getEntryTime() {
		if (entryTime == null || "".equals(entryTime)) {
			entryTime = RixinUtil.getCurrentDateTime();
		}
		return entryTime;
	}

	public void setEntryTime(String entryTime) {
		this.entryTime = entryTime;
	}

	public String getCreateUserId() {
		return createUserId;
	}

	public void setCreateUserId(String createUserId) {
		this.createUserId = createUserId;
	}

	public String getCreateUserTrueName() {
		return createUserTrueName;
	}

	public void setCreateUserTrueName(String createUserTrueName) {
		this.createUserTrueName = createUserTrueName;
	}

	public String getCreateTime() {
		if (createTime == null || "".equals(createTime)) {
			createTime = RixinUtil.getCurrentDateTime();
		}
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getModifyUserId() {
		return modifyUserId;
	}

	public void setModifyUserId(String modifyUserId) {
		this.modifyUserId = modifyUserId;
	}

	public String getModifyUserTrueName() {
		return modifyUserTrueName;
	}

	public void setModifyUserTrueName(String modifyUserTrueName) {
		this.modifyUserTrueName = modifyUserTrueName;
	}

	public String getModifyTime() {
		if (modifyTime == null || "".equals(modifyTime)) {
			modifyTime = RixinUtil.getCurrentDateTime();
		}
		return modifyTime;
	}

	public void setModifyTime(String modifyTime) {
		this.modifyTime = modifyTime;
	}

	public String getCurrentUserId() {
		return currentUserId;
	}

	public void setCurrentUserId(String currentUserId) {
		this.currentUserId = currentUserId;
	}

	public String getCurrentUserTrueName() {
		return currentUserTrueName;
	}

	public void setCurrentUserTrueName(String currentUserTrueName) {
		this.currentUserTrueName = currentUserTrueName;
	}

	public List<Attachment> getAttachments() {
		return attachments;
	}

	public void setAttachments(List<Attachment> attachments) {
		this.attachments = attachments;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

}
