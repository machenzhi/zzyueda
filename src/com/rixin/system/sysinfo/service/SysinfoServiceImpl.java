package com.rixin.system.sysinfo.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rixin.system.sysinfo.dao.ISysinfoDao;
import com.rixin.system.sysinfo.model.Sysinfo;

@Service("SysinfoServiceImpl")
public class SysinfoServiceImpl implements ISysinfoService {

	@Autowired
	private ISysinfoDao sysinfoDao;

	public void getSysinfo(HttpServletRequest request) {
		if (request.getSession().getServletContext().getAttribute("sysinfo") == null) {
			Sysinfo sysinfo = sysinfoDao.getSysinfo();
			request.getSession().getServletContext().setAttribute("sysinfo", sysinfo);
		}
		if (request.getSession().getServletContext().getAttribute("basePath") == null) {
			String path = request.getContextPath();
			String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
					+ path + "/";
			request.getSession().getServletContext().setAttribute("basePath", basePath);
		}
	}
}
