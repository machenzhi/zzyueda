package com.rixin.user.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	
	public boolean updatePassword(Map map){
		
		boolean isSuccess = false;
		
		int num = 0;
		try {
			num=userDao.updatePassword(map);
		} catch (Exception e) {
			return isSuccess;
		}
		if (num > 0) {
			isSuccess = true;
		}
		return isSuccess;
	}

}
