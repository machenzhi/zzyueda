package com.rixin.wechat.model;

/**
 * 普通按钮（子按钮）
 * 
 * @author liufeng
 * @date 2013-08-08
 */
public class CommonButton extends Button {
	private String type;
	private String url;
	private String key;

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

}
