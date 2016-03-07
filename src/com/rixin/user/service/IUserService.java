package com.rixin.user.service;

import com.rixin.user.model.User;

public interface IUserService {

	User login(String username);

	User getUserById(String id);

	void updateUserPassword(User user) throws Exception;
}
