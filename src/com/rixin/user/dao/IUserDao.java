package com.rixin.user.dao;

import java.util.Map;

import com.rixin.common.annotation.MyBatisDao;
import com.rixin.user.model.User;

/**
 * MyBaties映射文件 Mapper接口
 * 
 * @author 于辉
 */
@MyBatisDao
public interface IUserDao {
	User login(String username);
	
	int updatePassword(Map map);
}
