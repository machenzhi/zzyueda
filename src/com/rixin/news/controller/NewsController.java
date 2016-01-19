package com.rixin.news.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.rixin.attachment.model.Attachment;
import com.rixin.attachment.service.IAttachmentService;
import com.rixin.dictionary.model.Dictionary;
import com.rixin.dictionary.service.IDictionaryService;
import com.rixin.news.model.News;
import com.rixin.news.service.INewsService;
import com.rixin.system.sysinfo.service.ISysinfoService;

/**
 * 新闻控制器
 * 
 * @author 马晨智
 * 
 */
// 注解配置控制器
@Controller
// 设置访问路径
@RequestMapping("/news")
public class NewsController {
	private final Log log = LogFactory.getLog(getClass());
	@Resource
	@Qualifier("NewsServiceImpl")
	private INewsService newsService;
	@Resource
	@Qualifier("DictionaryServiceImpl")
	private IDictionaryService dictionaryService;
	@Resource
	@Qualifier("SysinfoServiceImpl")
	private ISysinfoService sysinfoService;
	@Resource
	@Qualifier("AttachmentServiceImpl")
	private IAttachmentService attachmentService;

	@RequestMapping("/main.do")
	public ModelAndView main(HttpSession session) {
		ModelAndView mav = new ModelAndView("main");
		return mav;
	}

	@RequestMapping("/createNews.do")
	public ModelAndView createNews(News news, HttpServletRequest request) {
		// 转型为MultipartHttpRequest：
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		// 获得文件
		List<MultipartFile> files = multipartRequest.getFiles("uploadFile");
		boolean isSuccess = true;
		try {
			newsService.createNews(news, files, request);
		} catch (Exception e) {
			isSuccess = false;
			e.printStackTrace();
		}
		ModelAndView mav = new ModelAndView("news/newsdetail");
		mav.addObject("isSuccess", isSuccess);
		return mav;
	}

	@RequestMapping("/getNewsListPage.do")
	public String getNewsListPage(News news, HttpServletRequest request) {
		news.setRows(newsService.getNews(news).size());
		news.setPaging("yes");
		List<News> newsList = newsService.getNews(news);
		request.setAttribute("newsList", newsList);
		request.setAttribute("news", news);
		request.setAttribute("page", news);
		return "news/newslist";
	}

	@RequestMapping("/getNewsDetailPage.do")
	public ModelAndView getNewsDetailPage(News news, HttpServletRequest request) {
		String viewstate = news.getViewstate();
		List<Attachment> attachmentList = null;
		ModelAndView mav = new ModelAndView("news/newsdetail");
		if (news.getId() != null && !"".equals(news.getId())) {
			news = newsService.getNewsById(news.getId());
			attachmentList = attachmentService.getAttchmentsByDataid(news.getId());
			mav.addObject("news", news);
		}
		List<Dictionary> dictionaryList = dictionaryService.getAllDictionarys4InfoType();
		mav.addObject("dictionaryList", dictionaryList);
		mav.addObject("attachmentList", attachmentList);
		mav.addObject("viewstate", viewstate);
		return mav;
	}

	@RequestMapping("/updateNews.do")
	@ResponseBody
	public ModelAndView updateNews(HttpServletRequest request, News news) {
		// 转型为MultipartHttpRequest：
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		// 获得文件
		List<MultipartFile> files = multipartRequest.getFiles("uploadFile");
		boolean isSuccess = true;
		try {
			newsService.updateNews(news, files, request);
		} catch (Exception e) {
			isSuccess = false;
			e.printStackTrace();
		}
		ModelAndView mav = new ModelAndView("news/newsdetail");
		mav.addObject("isSuccess", isSuccess);
		return mav;
	}

	@RequestMapping("/deleteNewsByIds.do")
	@ResponseBody
	public Map<String, Object> deleteNewsByIds(String ids, HttpServletRequest request) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		boolean isSuccess = true;
		try {
			newsService.deleteNewsByIds(ids);
		} catch (Exception e) {
			isSuccess = false;
			e.printStackTrace();
		}
		resultMap.put("isSuccess", isSuccess);
		return resultMap;
	}

	// *****************************我是分割线，以下是前台页面的方法
	// ^_^**************************************************************************************************************

	/**
	 * 首页加载数据
	 * 
	 * @return
	 */
	@RequestMapping("/qiantai/getMainContent.do")
	public ModelAndView getMainContent(HttpServletRequest request, HttpServletResponse response, String htmlName) {
		ModelAndView mav = new ModelAndView("../main");
		return mav;
	}

	/**
	 * 获取文章标题菜单
	 * 
	 * @param request
	 * @param typename
	 * @param typeid
	 */
	public void getNewsTitleMenu(HttpServletRequest request, String typename, String typeid) {
		List<News> menuList = newsService.getNewsByTypeId(typeid);
		request.setAttribute("NewsTitleMenu", menuList);
		request.setAttribute("NewsTitleMenuUrl", "news/qiantai/getNewsContentWithTitleMenu.do?demo=1");
		request.setAttribute("typename", typename);
	}

	/**
	 * 获取面包屑菜单
	 * 
	 * @param request
	 * @param typepath
	 */
	public void getmianbaoMenu(HttpServletRequest request, String typepath) {
		List<Dictionary> mianbaoList = new ArrayList<Dictionary>();
		typepath = typepath.substring(2);
		String temptypepath = typepath.replace(".", "#");
		String[] paths = temptypepath.split("#");
		Dictionary dic = new Dictionary();
		dic.setId("0");
		dic.setName("首页");
		dic.setUrl("common/qiantai/gotoPage.do?gotourl=main");
		mianbaoList.add(dic);
		for (String typeid : paths) {
			Dictionary dictionary = dictionaryService.getDictionaryById(typeid);
			mianbaoList.add(dictionary);
		}
		request.setAttribute("mianbaoMenu", mianbaoList);
	}

	/**
	 * 信息列表页面
	 * 
	 * @param request
	 * @param news
	 * @param typeid
	 * @return
	 */
	@RequestMapping("/qiantai/getNewsList.do")
	public ModelAndView getNewsList(HttpServletRequest request, HttpServletResponse response, News news,
			String htmlName) {
		// 获取面包屑菜单
		getmianbaoMenu(request, news.getTypepath());
		news.setRows(newsService.getNews(news).size());
		news.setPaging("yes");
		// 查询分页内容
		List<News> newsList = newsService.getNews(news);
		// 获取图片附件
		for (News n : newsList) {
			List<Attachment> attachments = attachmentService.getImgAttchmentsByDataid(n.getId());
			n.setAttachments(attachments);
		}
		request.setAttribute("newsList", newsList);
		request.setAttribute("page", news);
		ModelAndView mav = new ModelAndView("../news/news_list");
		return mav;
	}

	/**
	 * 图片信息列表展示
	 * 
	 * @param request
	 * @param news
	 * @param typename
	 * @param typeid
	 * @return
	 */
	@RequestMapping("/qiantai/getNewsImgList.do")
	public ModelAndView getNewsImgList(HttpServletRequest request, HttpServletResponse response, News news,
			String htmlName) {
		// 获取面包屑菜单
		getmianbaoMenu(request, news.getTypepath());
		news.setRows(newsService.getNews(news).size());
		news.setPaging("yes");
		// 查询分页内容
		List<News> newsList = newsService.getNews(news);
		// 获取图片附件
		for (News n : newsList) {
			List<Attachment> attachments = attachmentService.getImgAttchmentsByDataid(n.getId());
			n.setAttachments(attachments);
		}
		request.setAttribute("newsList", newsList);
		request.setAttribute("page", news);
		ModelAndView mav = new ModelAndView("../news/news_imglist");
		return mav;
	}

	/**
	 * 信息内容页面
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping("/qiantai/getNewsContent.do")
	public ModelAndView getNewsContent(HttpServletRequest request, HttpServletResponse response, String typeid,
			String typename, String typepath, String id, String htmlName) {
		News news = newsService.getNewsById(id);
		if (news == null) {
			news = new News();
			List<News> newsList = newsService.getNewsByTypeId(typeid);
			if (newsList.size() > 0) {
				news = newsList.get(0);
			} else {
				news.setTypeid(typeid);
				news.setTypename(typename);
				news.setTypepath(typepath);
				news.setContent("暂无内容");
			}
		}
		// 获取面包屑菜单
		getmianbaoMenu(request, news.getTypepath());
		request.setAttribute("news", news);
		ModelAndView mav = new ModelAndView("../news/news_detail");
		return mav;
	}

	/**
	 * 信息内容页面_微信
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping("/qiantai/getNewsContent4Weixin.do")
	public ModelAndView getNewsContent4Weixin(HttpServletRequest request, HttpServletResponse response, String id) {
		News news = newsService.getNewsById(id);
		ModelAndView mav = new ModelAndView("../news/news_detail_weixin");
		mav.addObject("news", news);
		return mav;
	}

	@RequestMapping("/qiantai/getNewsContentWithTitleMenu.do")
	public ModelAndView getNewsContentWithTitleMenu(HttpServletRequest request, HttpServletResponse response,
			String typeid, String typename, String typepath, String id, String htmlName) {
		News news = newsService.getNewsById(id);
		if (news == null) {
			news = new News();
			List<News> newsList = newsService.getNewsByTypeId(typeid);
			if (newsList.size() > 0) {
				news = newsList.get(0);
			} else {
				news.setTypeid(typeid);
				news.setTypename(typename);
				news.setTypepath(typepath);
				news.setContent("暂无内容");
			}
		}
		// 获取文章标题菜单
		getNewsTitleMenu(request, news.getTypename(), news.getTypeid());
		// 获取面包屑菜单
		getmianbaoMenu(request, news.getTypepath());
		request.setAttribute("news", news);
		ModelAndView mav = new ModelAndView("../news/news_detail_titlelist");
		return mav;
	}

}
