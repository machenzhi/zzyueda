package com.rixin.news.dao;

import java.util.List;

import com.rixin.common.annotation.MyBatisDao;
import com.rixin.news.model.News;

@MyBatisDao
public interface INewsDao {
	int createNews(News news);

	List<News> getNews(News news);

	int updateNews(News news);

	int deleteNewsById(String id);

	News queryById(String id);

	News getNewsById(String id);

	List<News> getNewsByTypeId(String typeid);

}
