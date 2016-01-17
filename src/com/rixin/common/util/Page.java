package com.rixin.common.util;

/**
 * 所有分页组件的父类， 封装了分页相关的公共参数。
 * 
 * @author himcz@163.com
 *
 */
public class Page extends BaseModel {

	// 每页最大行数，是常量
	private int pageSize = 20;
	// 当前客户选择的页码，是页面传入的条件，默认为1
	private int currentPage = 1;

	// 由于SQL中的表达式不让直接运算，所以在类中算出来给SQL使用
	private int begin;
	private int end;

	// 需要外界传入总行数条件，用于计算totalPage
	private int rows;
	// 总页数，用于页面上输出页码
	private int totalPage;
	private String pageUrl;// 分页URL
	private String paging = "no";// 是否分页

	/**
	 * 页面调用totalPage属性时，是通过该get方法调用的。 在调用该方法时，计算出totalPage的值。
	 * 此计算需要依赖rows条件，而这个条件需要在页面使用 totalPage属性之前传入到当前对象。
	 */
	public int getTotalPage() {
		if (rows % pageSize == 0) {
			totalPage = rows / pageSize;
		} else {
			totalPage = rows / pageSize + 1;
		}
		if (totalPage == 0) {
			totalPage = 1;
		}
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getRows() {
		return rows;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}

	// SQL中的表达式要访问类中的属性，一定是通过get方法访问的，
	// 所以可以在get方法中将begin、end计算出来。
	public int getBegin() {
		begin = (currentPage - 1) * pageSize;
		return begin;
	}

	public void setBegin(int begin) {
		this.begin = begin;
	}

	public int getEnd() {
		end = currentPage * pageSize + 1;
		return end;
	}

	public void setEnd(int end) {
		this.end = end;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public String getPageUrl() {
		return pageUrl;
	}

	public void setPageUrl(String pageUrl) {
		this.pageUrl = pageUrl;
	}

	public String getPaging() {
		return paging;
	}

	public void setPaging(String paging) {
		this.paging = paging;
	}

}
