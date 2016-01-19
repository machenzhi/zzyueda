package com.rixin.user.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.rixin.common.util.MD5Util;
import com.rixin.common.util.RixinUtil;
import com.rixin.user.model.User;
import com.rixin.user.service.IUserService;

/**
 * 登陆
 * 
 * @author 于辉
 * 
 */
// 注解配置控制器
@Controller
// 设置访问路径
@RequestMapping("/user")
public class UserController {
	// 注入LoginServiceImpl对象
	@Resource
	@Qualifier("UserServiceImpl")
	private IUserService userService;

	/**
	 * 登录系统
	 * 
	 * @param username
	 * @param password
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping("/login.do")
	@ResponseBody
	public Map<String, Object> login(String username, String password, HttpSession session,
			HttpServletRequest request) {
		Map<String, Object> result = new HashMap<String, Object>();
		User user = userService.login(username);
		if (user != null) {
			if (user.getPassword().equals(MD5Util.MD5(password))) {
				session.setAttribute("user", user);
				result.put("isSuccess", true);
				return result;
			} else {
				result.put("isSuccess", false);
				result.put("msgTip", "密码错误");
				return result;
			}
		} else {
			result.put("isSuccess", false);
			result.put("msgTip", "帐号错误");
			return result;
		}
	}

	@RequestMapping("/updatePassword.do")
	@ResponseBody
	public Map<String, Object> updatePassword(String oldPassword, String newPassword, HttpSession session) {
		Map<String, Object> result = new HashMap<String, Object>();
		User oldUser = (User) session.getAttribute("user");
		if (RixinUtil.MD5(oldPassword).equals(oldUser.getPassword())) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", oldUser.getId());
			map.put("password", RixinUtil.MD5(newPassword));
			boolean isSuccess = userService.updatePassword(map);
			if (isSuccess) {
				User user = userService.login(oldUser.getUsername());
				session.setAttribute("user", user);
			}
			result.put("isSuccess", isSuccess);
			return result;
		}
		result.put("isSuccess", false);
		return result;
	}

	public static void main(String[] args) {
		System.out.println(RixinUtil.MD5("1"));
	}
}
