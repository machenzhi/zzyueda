package com.rixin.common.listener;

import javax.servlet.ServletContext;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Component;
import org.springframework.web.context.ServletContextAware;

import com.rixin.system.sysinfo.dao.ISysinfoDao;
import com.rixin.system.sysinfo.model.Sysinfo;

/**
 * 服务启动监听器
 * 
 * @author himcz@163.com
 *
 */
@Component
public class StartupListener implements ApplicationContextAware, ServletContextAware, InitializingBean,
		ApplicationListener<ContextRefreshedEvent> {
	private final Log log = LogFactory.getLog(getClass());
	@Autowired
	private ISysinfoDao sysinfoDao;

	@Override
	public void setApplicationContext(ApplicationContext ctx) throws BeansException {
		log.info("1 => StartupListener.setApplicationContext");
	}

	@Override
	public void setServletContext(ServletContext context) {
		log.info("2 => StartupListener.setServletContext");
		Sysinfo sysinfo = sysinfoDao.getSysinfo();
		context.setAttribute("sysinfo", sysinfo);
	}

	@Override
	public void afterPropertiesSet() throws Exception {
		log.info("3 => StartupListener.afterPropertiesSet");
	}

	@Override
	public void onApplicationEvent(ContextRefreshedEvent evt) {
		log.info("4.1 => MyApplicationListener.onApplicationEvent");
		if (evt.getApplicationContext().getParent() == null) {
			log.info("4.2 => MyApplicationListener.onApplicationEvent");
		}
	}
}
