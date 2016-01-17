package com.rixin.news.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import com.rixin.news.model.News;

public interface INewsService {

	void createNews(News news, List<MultipartFile> uploadFile, HttpServletRequest request) throws Exception;

	List<News> getNews(News news);

	News getNewsById(String id);

	List<News> getNewsByTypeId(String typeid);

	void deleteNewsByIds(String ids);

	void updateNews(News news, List<MultipartFile> uploadFile, HttpServletRequest request) throws Exception;

	public void getPropNews(HttpServletRequest request);

	// 固定菜单
	void getFixedMenu(HttpServletRequest request);
}
