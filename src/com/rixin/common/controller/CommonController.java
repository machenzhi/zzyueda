package com.rixin.common.controller;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rixin.system.sysinfo.service.ISysinfoService;
import com.rixin.user.model.User;

// 注解配置控制器
@Controller
// 设置访问路径
@RequestMapping("/common")
public class CommonController {
	private final Log log = LogFactory.getLog(getClass());
	@Resource
	@Qualifier("SysinfoServiceImpl")
	private ISysinfoService sysinfoService;

	/**
	 * 后台页面跳转-需要登录验证
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("/gotopage.do")
	public String gotopage(HttpServletRequest request) {
		Map parameterMap = request.getParameterMap();
		request.setAttribute("parameterMap", parameterMap);
		String[] gotourl = (String[]) parameterMap.get("gotourl");
		String url = "";
		for (String str : gotourl) {
			url += str;
		}
		log.debug("跳转页面：" + url);
		return url;
	}

	/**
	 * 前台页面跳转-无需登录验证
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("/gotoQiantaiPage.do")
	public String gotoQiantaiPage(HttpServletRequest request) {
		Map parameterMap = request.getParameterMap();
		request.setAttribute("parameterMap", parameterMap);
		String[] gotourl = (String[]) parameterMap.get("gotourl");
		String url = "../";
		for (String str : gotourl) {
			url += str;
		}
		if (url.equals("../login")) {
			url = "login";
		}
		log.debug("跳转页面：" + url);
		return url;
	}

	/**
	 * 前台页面跳转-无需登录验证
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("/qiantai/gotoPage.do")
	public String qiantaiGotoPage(HttpServletRequest request) {
		Map parameterMap = request.getParameterMap();
		request.setAttribute("parameterMap", parameterMap);
		String[] gotourl = (String[]) parameterMap.get("gotourl");
		String url = "../" + gotourl[0];
		return url;
	}

	/**
	 * 退出登录
	 * 
	 * @param session
	 * @return
	 */
	@RequestMapping("/exit.do")
	public String exit(HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (user != null) {
			try {
				session.removeAttribute("user");
			} catch (Exception e) {
				user = null;
			}
		}
		return "../login";
	}
}
