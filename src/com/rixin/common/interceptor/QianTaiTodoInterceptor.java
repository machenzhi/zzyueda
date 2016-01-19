package com.rixin.common.interceptor;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.rixin.common.util.RixinUtil;
import com.rixin.dictionary.service.IDictionaryService;
import com.rixin.news.service.INewsService;

/**
 * 前台请求必做操作拦截器
 * 
 * @author Administrator
 *
 */
public class QianTaiTodoInterceptor implements HandlerInterceptor {
	@Resource(name = "NewsServiceImpl")
	private INewsService newsService;
	@Resource(name = "DictionaryServiceImpl")
	private IDictionaryService dictionaryService;

	/**
	 * preHandle方法是进行处理器拦截用的，顾名思义，该方法将在Controller处理之前进行调用，
	 * SpringMVC中的Interceptor拦截器是链式的，可以同时存在
	 * 多个Interceptor，然后SpringMVC会根据声明的前后顺序一个接一个的执行
	 * ，而且所有的Interceptor中的preHandle方法都会在
	 * Controller方法调用之前调用。SpringMVC的这种Interceptor链式结构也是可以进行中断的
	 * ，这种中断方式是令preHandle的返 回值为false，当preHandle的返回值为false的时候整个请求就结束了。
	 */
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object obj) throws Exception {
		if (request.getSession().getServletContext().getAttribute("basePath") == null) {
			String path = request.getContextPath();
			String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
					+ path + "/";
			request.getSession().getServletContext().setAttribute("basePath", basePath);
		}
		return true;
	}

	/**
	 * 这个方法只会在当前这个Interceptor的preHandle方法返回值为true的时候才会执行。
	 * postHandle是进行处理器拦截用的，它的执行时间是在处理器进行处理之后
	 * ，也就是在Controller的方法调用之后执行，但是它会在DispatcherServlet进行视图的渲染之前执行
	 * ，也就是说在这个方法中你可以对ModelAndView进行操作。
	 * 这个方法的链式结构跟正常访问的方向是相反的，也就是说先声明的Interceptor拦截器该方法反而会后调用
	 */
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object arg2, ModelAndView mv)
			throws Exception {
		// 获取菜单
		dictionaryService.getMenu(request);
		// 固定菜单
		newsService.getFixedMenu(request);
		newsService.getPropNews(request);
		// 静态化页面
		RixinUtil.htmlStatic(request, response, mv.getViewName().substring(3) + ".jsp",
				request.getParameter("htmlName"));
	}

	/**
	 * 该方法也是需要当前对应的Interceptor的preHandle方法的返回值为true时才会执行。该方法将在整个请求完成之后，
	 * 也就是DispatcherServlet渲染了视图执行，
	 * 这个方法的主要作用是用于清理资源的，当然这个方法也只能在当前这个Interceptor的preHandle方法的返回值为true时才会执行。
	 */
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object arg2, Exception arg3)
			throws Exception {
		// 清理资源
	}

}
