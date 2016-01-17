package com.rixin.news.model;

import java.io.Serializable;

import com.rixin.common.util.Page;

/**
 * 文章信息类
 * 
 */
public class News extends Page implements Serializable {

	/**
	 * 为了方便将结果集转换成对象，该类中的属性与表中字段一致。 为了能够封装页面上传入的null值，所有的属性都 使用封装类型。
	 */
	private static final long serialVersionUID = 1L;
	private String id;
	private String author;
	private String title;
	private String content;
	private String img;
	private String typeid;
	private String typepath;
	private String typename;
	private String typeurl;
	private String publishtime;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public String getTypeid() {
		return typeid;
	}

	public void setTypeid(String typeid) {
		this.typeid = typeid;
	}

	public String getTypepath() {
		return typepath;
	}

	public void setTypepath(String typepath) {
		this.typepath = typepath;
	}

	public String getTypename() {
		return typename;
	}

	public void setTypename(String typename) {
		this.typename = typename;
	}

	public String getTypeurl() {
		return typeurl;
	}

	public void setTypeurl(String typeurl) {
		this.typeurl = typeurl;
	}

	public String getPublishtime() {
		return publishtime;
	}

	public void setPublishtime(String publishtime) {
		this.publishtime = publishtime;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

}
