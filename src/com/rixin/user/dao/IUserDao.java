package com.rixin.user.dao;

import com.rixin.common.annotation.MyBatisDao;
import com.rixin.user.model.User;

@MyBatisDao
public interface IUserDao {
	User login(String username);

	User getUserById(String id);

	int updateUserPassword(User user);

}
