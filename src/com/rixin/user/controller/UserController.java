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
import com.rixin.user.model.User;
import com.rixin.user.service.IUserService;

@Controller
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

	/**
	 * 修改用户密码
	 * @param id
	 * @param password_old
	 * @param password_new
	 * @return
	 */
	@RequestMapping("/updateUserPassword.do")
	@ResponseBody
	public Map<String, Object> updateUserPassword(String id, String password_old, String password_new,
			HttpSession session) {
		Map<String, Object> result = new HashMap<String, Object>();
		boolean isSuccess = true;
		try {
			User user = new User();
			User sessionUser = (User) session.getAttribute("user");
			if ("admin".equals(sessionUser.getUsername())) {
				user.setId(id);
				user.setPassword(password_new);
				userService.updateUserPassword(user);
			} else {
				user = userService.getUserById(id);
				if (user.getPassword().equals(MD5Util.MD5(password_old))) {
					user.setPassword(password_new);
					userService.updateUserPassword(user);
				} else {
					isSuccess = false;
					result.put("msg", "原密码输入错误");
				}
			}
		} catch (Exception e) {
			isSuccess = false;
			e.printStackTrace();
		}
		result.put("isSuccess", isSuccess);
		return result;
	}

}
