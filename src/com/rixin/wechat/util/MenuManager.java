package com.rixin.wechat.util;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.rixin.wechat.model.AccessToken;
import com.rixin.wechat.model.Button;
import com.rixin.wechat.model.CommonButton;
import com.rixin.wechat.model.ComplexButton;
import com.rixin.wechat.model.Menu;

/**
 * 菜单管理器类
 * 
 * @author liufeng
 * @date 2013-08-08
 */
public class MenuManager {
	private static final Log log = LogFactory.getLog(MenuManager.class);

	public static void main(String[] args) {
		// 第三方用户唯一凭证
		String appId = "wx2a3a8d40027d9253";
		// 第三方用户唯一凭证密钥
		String appSecret = "766c068294af28717561467788df8656";

		// 调用接口获取access_token
		AccessToken at = WeixinUtil.getAccessToken(appId, appSecret);

		if (null != at) {
			// 调用接口创建菜单
			int result = WeixinUtil.createMenu(getMenu(), at.getToken());

			// 判断菜单创建结果
			if (0 == result)
				log.info("菜单创建成功！");
			else
				log.info("菜单创建失败，错误码：" + result);
		}
	}

	/**
	 * 组装菜单数据
	 * 
	 * @return
	 */
	private static Menu getMenu() {

		CommonButton mainNews_news = new CommonButton();
		mainNews_news.setName("新闻公告");
		mainNews_news.setType("click");
		mainNews_news.setKey("news");

		CommonButton mainNews_huodong = new CommonButton();
		mainNews_huodong.setName("优惠活动");
		mainNews_huodong.setType("click");
		mainNews_huodong.setKey("huodong");

		ComplexButton mainNews = new ComplexButton();
		mainNews.setName("新闻公告");
		mainNews.setSub_button(new CommonButton[] { mainNews_news, mainNews_huodong });

		CommonButton mainProcess_process = new CommonButton();
		mainProcess_process.setName("进度查询");
		mainProcess_process.setType("click");
		mainProcess_process.setKey("process");

		ComplexButton mainProcess = new ComplexButton();
		mainProcess.setName("业务查询");
		mainProcess.setSub_button(new CommonButton[] { mainProcess_process });

		CommonButton mainAboutUs_website = new CommonButton();
		mainAboutUs_website.setName("官方网站");
		mainAboutUs_website.setType("view");
		mainAboutUs_website.setUrl("http://www.zzyueda.com");

		CommonButton mainAboutUs_kefu = new CommonButton();
		mainAboutUs_kefu.setName("在线客服");
		mainAboutUs_kefu.setType("click");
		mainAboutUs_kefu.setKey("kefu");

		CommonButton mainAboutUs_wifi = new CommonButton();
		mainAboutUs_wifi.setName("WIFI密码");
		mainAboutUs_wifi.setType("click");
		mainAboutUs_wifi.setKey("wifipwd");

		CommonButton mainAboutUs_aboutUs = new CommonButton();
		mainAboutUs_aboutUs.setName("关于我们");
		mainAboutUs_aboutUs.setType("click");
		mainAboutUs_aboutUs.setKey("aboutUs");

		ComplexButton mainAboutUs = new ComplexButton();
		mainAboutUs.setName("关于我们");
		mainAboutUs.setSub_button(new CommonButton[] { mainAboutUs_website, mainAboutUs_kefu, mainAboutUs_wifi,
				mainAboutUs_aboutUs });

		/**
		 * 每个一级菜单都不一定必须有二级菜单项<br>
		 * 
		 * 在某个一级菜单下没有二级菜单的情况，menu该如何定义呢？<br>
		 * 第三个一级菜单项是"公司公告"，那么menu应该这样定义：<br>
		 * menu.setButton(new Button[] { mainBtn1, mainBtn2, btn33 });
		 */
		Menu menu = new Menu();
		menu.setButton(new Button[] { mainNews, mainProcess, mainAboutUs });

		return menu;
	}

}
