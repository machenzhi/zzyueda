package com.rixin.attachment.model;

import com.rixin.common.util.Page;

/**
 * 附件javabean
 * 
 * @author himcz@163.com
 *
 */
public class Attachment extends Page {
	// 附件ID
	private String id;
	// 附件名称
	private String name;
	// 外键ID，业务数据ID
	private String dataid;
	// 附件路径
	private String path;
	private String smallPath;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDataid() {
		return dataid;
	}

	public void setDataid(String dataid) {
		this.dataid = dataid;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getSmallPath() {
		return smallPath;
	}

	public void setSmallPath(String smallPath) {
		this.smallPath = smallPath;
	}

}
