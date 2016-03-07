package com.rixin.user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rixin.common.util.MD5Util;
import com.rixin.user.dao.IUserDao;
import com.rixin.user.model.User;

@Service("UserServiceImpl")
public class UserServiceImpl implements IUserService {

	@Autowired
	private IUserDao userDao;

	/**
	 * 登陆查询
	 */
	public User login(String username) {
		User user = userDao.login(username);
		return user;
	}

	/**
	 * 根据ID查询用户详细信息
	 */
	public User getUserById(String id) {
		User user = userDao.getUserById(id);
		return user;
	}

	@Override
	public void updateUserPassword(User user) {
		if (user.getPassword() != null && !"".equals(user.getPassword())) {
			user.setPassword(MD5Util.MD5(user.getPassword()));
		} else {
			user.setPassword(MD5Util.MD5("123456"));
		}
		userDao.updateUserPassword(user);
	}

}
