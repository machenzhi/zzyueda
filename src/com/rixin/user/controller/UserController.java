package com.rixin.user.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
	/**
	 * 成功
	 */
	private final static int SUCCESS = 0;
	/**
	 * 用户名错误
	 */
	private final static int USERNAME_ERROR = 1;
	/**
	 * 密码错误
	 */
	private final static int PASSWORD_ERROR = 2;

	// 注入LoginServiceImpl对象
	@Resource
	@Qualifier("UserServiceImpl")
	private IUserService userService;

	/**
	 * 登陆页面跳转和登陆验证
	 * 
	 * @param username
	 *            用户名
	 * @param password
	 *            密码
	 * @param session
	 *            保存session方便拦截器使用
	 */
	@RequestMapping("/login.do")
	@ResponseBody
	public Map<String, Object> login(String username, String password, HttpSession session) {
		/*
		 * 创建map，存储判断名称和ID
		 */
		Map<String, Object> result = new HashMap<String, Object>();
		/*
		 * 创建User实体类，存储查询到的数据
		 */
		User user = userService.login(username);
		/*
		 * 判断
		 */
		if (user == null) {
			/*
			 * 如果user为空，说明没有查询到数据返回USERNAME_ERROR
			 */
			result.put("flag", USERNAME_ERROR);
			return result;
		} else if (!user.getPassword().equals(RixinUtil.MD5(password))) {
			/*
			 * 如果user不为空，判断密码，如果密码不一致，返回 PASSWORD_ERROR
			 */
			result.put("flag", PASSWORD_ERROR);
			return result;
		} else {
			/*
			 * 否则验证通过，返回SUCCESS 并记录session
			 */
			session.setAttribute("user", user);
			result.put("flag", SUCCESS);
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
