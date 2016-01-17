package com.rixin.dictionary.model;

import java.io.Serializable;
import java.util.List;

import com.rixin.news.model.News;

/**
 * 字典类
 * 
 */
public class Dictionary implements Serializable {

	private static final long serialVersionUID = 1L;
	private String id;
	private String name;
	private String visible;
	private String pid;
	private String abspath;
	private String isinfo;
	private String url;
	private String css;
	private String sort;
	private String date;
	private List<News> newsList;

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

	public String getVisible() {
		return visible;
	}

	public void setVisible(String visible) {
		this.visible = visible;
	}

	public String getPid() {
		return pid;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}

	public String getAbspath() {
		return abspath;
	}

	public void setAbspath(String abspath) {
		this.abspath = abspath;
	}

	public String getIsinfo() {
		return isinfo;
	}

	public void setIsinfo(String isinfo) {
		this.isinfo = isinfo;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getCss() {
		return css;
	}

	public void setCss(String css) {
		this.css = css;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public List<News> getNewsList() {
		return newsList;
	}

	public void setNewsList(List<News> newsList) {
		this.newsList = newsList;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

}
