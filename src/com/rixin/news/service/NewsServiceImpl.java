package com.rixin.news.service;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.rixin.attachment.model.Attachment;
import com.rixin.attachment.service.IAttachmentService;
import com.rixin.common.util.RixinUtil;
import com.rixin.dictionary.dao.IDictionaryDao;
import com.rixin.dictionary.model.Dictionary;
import com.rixin.news.dao.INewsDao;
import com.rixin.news.model.News;

@Service("NewsServiceImpl")
public class NewsServiceImpl implements INewsService {

	@Autowired
	private INewsDao newsDao;

	@Autowired
	private IDictionaryDao dictionaryDao;
	@Resource
	@Qualifier("AttachmentServiceImpl")
	private IAttachmentService attachmentService;

	/**
	 * 添加新闻
	 * 
	 * @throws Exception
	 */
	public void createNews(News news, List<MultipartFile> uploadFile, HttpServletRequest request) throws Exception {
		String id = RixinUtil.getUUID();
		news.setId(id);
		String[] types = news.getTypeid().split("#");
		news.setTypeid(types[0]);
		news.setTypepath(types[1]);
		news.setPublishtime(RixinUtil.getCurrentDateTime());
		newsDao.createNews(news);
		attachmentService.uploadFiles(news.getId(), null, uploadFile, request);
	}

	public List<News> getNews(News news) {
		List<News> list = newsDao.getNews(news);
		return list;
	}

	public News getNewsById(String id) {
		News news = newsDao.getNewsById(id);
		return news;
	}

	public List<News> getNewsByTypeId(String typeid) {
		List<News> news = newsDao.getNewsByTypeId(typeid);
		return news;
	}

	public void deleteNewsByIds(String ids) {
		String[] idArray = ids.split(",");
		for (String id : idArray) {
			newsDao.deleteNewsById(id);
		}
	}

	public void updateNews(News news, List<MultipartFile> uploadFile, HttpServletRequest request) throws Exception {
		String[] types = news.getTypeid().split("#");
		news.setTypeid(types[0]);
		news.setTypepath(types[1]);
		news.setPublishtime(RixinUtil.getCurrentDateTime());
		newsDao.updateNews(news);
		if (!uploadFile.get(0).isEmpty()) {
			attachmentService.uploadFiles(news.getId(), null, uploadFile, request);
		} else {
			attachmentService.uploadFiles(news.getId(), news.getAttachments(), uploadFile, request);
		}
	}

	public void getPropNews(HttpServletRequest request) {
		List<String> propKeys = RixinUtil.readPropertiesKeys("/portal.properties");
		for (String key : propKeys) {
			// 读取配置文件
			String id = RixinUtil.readPropertiesValue("/portal.properties", key);
			Dictionary dictionary = dictionaryDao.getDictionaryById(id);
			if (dictionary != null) {
				News news = new News();
				news.setTypepath(dictionary.getAbspath());
				// 获取类型及子类型下所有文章
				List<News> newsList = newsDao.getNews(news);
				// 获取图片附件
				for (News n : newsList) {
					List<Attachment> attachments = attachmentService.getImgAttchmentsByDataid(n.getId());
					n.setAttachments(attachments);
				}
				dictionary.setNewsList(newsList);
				request.setAttribute(key, dictionary);
				List<Dictionary> subTypes = dictionaryDao.getDictionarysByPid(id);
				request.setAttribute(key + "SubTypes", subTypes);
			}
		}
	}

	@Override
	public void getFixedMenu(HttpServletRequest request) {
		List<Dictionary> fixedDictionaryList = dictionaryDao.getAllFixedDictionarys();
		request.setAttribute("fixedDictionaryList", fixedDictionaryList);
	}

}
