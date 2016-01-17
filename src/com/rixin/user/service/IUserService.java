package com.rixin.user.service;

import java.util.Map;

import com.rixin.user.model.User;


public interface IUserService {
	/**
	 * 用户登陆查询
	 * 
	 * @param user
	 * @return
	 */
	User login(String username);
	boolean updatePassword(Map map);
}
