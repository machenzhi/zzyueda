package com.rixin.system.sysinfo.dao;

import com.rixin.common.annotation.MyBatisDao;
import com.rixin.system.sysinfo.model.Sysinfo;

/**
 * 信息系统DAO
 * 
 * @author 马晨智
 *
 */

@MyBatisDao
public interface ISysinfoDao {
	Sysinfo getSysinfo();
}
