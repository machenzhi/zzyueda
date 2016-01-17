package com.rixin.wechat.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rixin.common.util.RixinUtil;
import com.rixin.dictionary.dao.IDictionaryDao;
import com.rixin.dictionary.model.Dictionary;
import com.rixin.news.dao.INewsDao;
import com.rixin.news.model.News;
import com.rixin.wechat.model.message.resp.Article;
import com.rixin.wechat.model.message.resp.NewsMessage;
import com.rixin.wechat.model.message.resp.TextMessage;
import com.rixin.wechat.util.MessageUtil;

/**
 * 核心服务类
 * 
 * @author liufeng
 * @date 2013-05-20
 */
@Service("WechatServiceImpl")
public class WechatServiceImpl implements IWechatService {
	// xml请求解析
	Map<String, String> requestMap;
	// 发送方帐号（open_id）
	String fromUserName;
	// 公众帐号
	String toUserName;
	// 消息类型
	String msgType;
	@Autowired
	private IDictionaryDao dictionaryDao;
	@Autowired
	private INewsDao newsDao;

	/**
	 * 处理微信发来的请求
	 * 
	 * @param request
	 * @return
	 */
	public String processRequest(HttpServletRequest request) {
		String respMessage = null;
		try {
			// 默认返回的文本消息内容
			String respContent = "请求处理异常，请稍候尝试！";

			// xml请求解析
			requestMap = MessageUtil.parseXml(request);
			// 发送方帐号（open_id）
			fromUserName = requestMap.get("FromUserName");
			// 公众帐号
			toUserName = requestMap.get("ToUserName");
			// 消息类型
			msgType = requestMap.get("MsgType");

			// 回复文本消息
			TextMessage textMessage = new TextMessage();
			textMessage.setToUserName(fromUserName);
			textMessage.setFromUserName(toUserName);
			textMessage.setCreateTime(new Date().getTime());
			textMessage.setMsgType(MessageUtil.RESP_MESSAGE_TYPE_TEXT);
			textMessage.setFuncFlag(0);

			// 文本消息
			if (msgType.equals(MessageUtil.REQ_MESSAGE_TYPE_TEXT)) {
				respContent = "您好，请点击下方菜单『关于我们』『在线客服』与客服人员在线沟通。谢谢！";
			}
			// 图片消息
			else if (msgType.equals(MessageUtil.REQ_MESSAGE_TYPE_IMAGE)) {
				respContent = "您发送的是图片消息！";
			}
			// 地理位置消息
			else if (msgType.equals(MessageUtil.REQ_MESSAGE_TYPE_LOCATION)) {
				respContent = "您发送的是地理位置消息！";
			}
			// 链接消息
			else if (msgType.equals(MessageUtil.REQ_MESSAGE_TYPE_LINK)) {
				respContent = "您发送的是链接消息！";
			}
			// 音频消息
			else if (msgType.equals(MessageUtil.REQ_MESSAGE_TYPE_VOICE)) {
				respContent = "您发送的是音频消息！";
			}
			// 事件推送
			else if (msgType.equals(MessageUtil.REQ_MESSAGE_TYPE_EVENT)) {
				// 事件类型
				String eventType = requestMap.get("Event");
				// 订阅
				if (eventType.equals(MessageUtil.EVENT_TYPE_SUBSCRIBE)) {
					// 获取公司图文介绍信息
					respMessage = getCompanyInfo();
					return respMessage;
				}
				// 取消订阅
				else if (eventType.equals(MessageUtil.EVENT_TYPE_UNSUBSCRIBE)) {
					// TODO 取消订阅后用户再收不到公众号发送的消息，因此不需要回复消息
				}
				// 自定义菜单点击事件
				else if (eventType.equals(MessageUtil.EVENT_TYPE_CLICK)) {
					// 事件KEY值，与创建自定义菜单时指定的KEY值对应
					String eventKey = requestMap.get("EventKey");

					if (eventKey.equals("aboutUs")) {
						// 获取公司图文介绍信息
						respMessage = getCompanyInfo();
						return respMessage;
					} else if (eventKey.equals("process")) {
						respContent = "进度查询，正在开发中。给您带来不便请谅解！";
					} else if (eventKey.equals("news")) {
						// 读取配置文件
						String id = RixinUtil.readPropertiesValue("/portal.properties", "xinwenzhongxin");
						Dictionary dictionary = dictionaryDao.getDictionaryById(id);
						News news = new News();
						news.setBegin(0);
						news.setPageSize(5);
						news.setTypepath(dictionary.getAbspath());
						List<News> newsList = newsDao.getNews(news);
						if (newsList.isEmpty()) {
							respContent = "抱歉，暂无任何新闻公告。\n有新的新闻公告时，我们会第一时间通知您。";
						} else {
							respMessage = getNewsInfo(newsList);
							return respMessage;
						}
					} else if (eventKey.equals("huodong")) {
						// 读取配置文件
						String id = RixinUtil.readPropertiesValue("/portal.properties", "youhuihuodong");
						Dictionary dictionary = dictionaryDao.getDictionaryById(id);
						News news = new News();
						news.setBegin(0);
						news.setPageSize(5);
						news.setTypepath(dictionary.getAbspath());
						List<News> newsList = newsDao.getNews(news);
						if (newsList.isEmpty()) {
							respContent = "抱歉，暂无任何优惠活动。\n有新的优惠活动时，我们会第一时间通知您。";
						} else {
							respMessage = getNewsInfo(newsList);
							return respMessage;
						}
					} else if (eventKey.equals("kefu")) {
						// 连接在线客服
						textMessage.setMsgType("transfer_customer_service");
					} else if (eventKey.equals("wifipwd")) {
						respContent = "WIFI：yuedagongshang\n密码：01065825450";
					}
				}
			}

			textMessage.setContent(respContent);
			respMessage = MessageUtil.textMessageToXml(textMessage);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return respMessage;
	}

	/**
	 * 获取公司图文介绍信息
	 * 
	 * @return
	 */
	public String getCompanyInfo() {
		// 创建图文消息
		NewsMessage newsMessage = new NewsMessage();
		newsMessage.setToUserName(fromUserName);
		newsMessage.setFromUserName(toUserName);
		newsMessage.setCreateTime(new Date().getTime());
		newsMessage.setMsgType(MessageUtil.RESP_MESSAGE_TYPE_NEWS);
		newsMessage.setFuncFlag(0);

		List<Article> articleList = new ArrayList<Article>();
		// 单图文消息
		Article article = new Article();
		article.setTitle("悦达工商，感谢您对我们的关注！");
		article.setDescription("悦达工商，专注工商注册11年，专业的团队，一流的水平，为您提供一站式工商注册、财税筹划、商标注册等服务！地址：郑州市中原路万达广场A座2640/2641。电话：0371-55086327  18937115667");
		article.setPicUrl("http://www.zzyueda.com/img/weixinlogo.png");
		article.setUrl("http://www.zzyueda.com");
		articleList.add(article);
		// 设置图文消息个数
		newsMessage.setArticleCount(articleList.size());
		// 设置图文消息包含的图文集合
		newsMessage.setArticles(articleList);
		// 将图文消息对象转换成xml字符串
		String respMessage = MessageUtil.newsMessageToXml(newsMessage);
		return respMessage;
	}

	/**
	 * 获取公司图文介绍信息
	 * 
	 * @return
	 */
	public String getNewsInfo(List<News> newsList) {
		// 创建图文消息
		NewsMessage newsMessage = new NewsMessage();
		newsMessage.setToUserName(fromUserName);
		newsMessage.setFromUserName(toUserName);
		newsMessage.setCreateTime(new Date().getTime());
		newsMessage.setMsgType(MessageUtil.RESP_MESSAGE_TYPE_NEWS);
		newsMessage.setFuncFlag(0);

		List<Article> articleList = new ArrayList<Article>();
		for (int i = 0; i < newsList.size(); i++) {
			News news = newsList.get(i);
			// 单图文消息
			Article article = new Article();
			article.setTitle(news.getTitle());
			// article.setDescription(news.getContent());
			String content = news.getContent();
			try {
				if (content.indexOf("src=") > -1) {
					content = content.substring(content.indexOf("src=") + 5);
					String picurl = content.substring(0, content.indexOf("\""));
					article.setPicUrl("http://www.zzyueda.com/" + picurl);
				} else {
					if (i == 0) {
						article.setPicUrl("http://www.zzyueda.com/img/ydgszncg.png");
					} else {
						article.setPicUrl("http://www.zzyueda.com/img/weixinlogo.png");
					}
				}
			} catch (Exception e) {
			}
			article.setUrl("http://www.zzyueda.com/news/qiantai/getNewsContent4Weixin.do?id=" + news.getId());
			articleList.add(article);
		}
		// 设置图文消息个数
		newsMessage.setArticleCount(articleList.size());
		// 设置图文消息包含的图文集合
		newsMessage.setArticles(articleList);
		// 将图文消息对象转换成xml字符串
		String respMessage = MessageUtil.newsMessageToXml(newsMessage);
		return respMessage;
	}
}
