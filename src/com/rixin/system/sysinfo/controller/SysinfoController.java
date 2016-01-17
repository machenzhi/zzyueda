package com.rixin.system.sysinfo.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.rixin.common.util.RixinUtil;

/**
 * 系统信息
 * 
 * @author 马晨智
 *
 */
// 注解配置控制器
@Controller
// 设置访问路径
@RequestMapping("/sysinfo")
public class SysinfoController {

	@RequestMapping("/staticHtml.do")
	@ResponseBody
	public boolean staticHtml(HttpServletRequest request) {
		// 删除html里的所有子文件
		return RixinUtil.delAllFile(request);
	}

}
