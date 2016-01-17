package com.rixin.common.util;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.List;
import java.util.Properties;
import java.util.UUID;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletResponseWrapper;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * 系统工具类
 * 
 * @author 马晨智
 * 
 */
public class RixinUtil {
	private static final Log log = LogFactory.getLog(RixinUtil.class);
	private static ServletContext sc = null;

	/**
	 * 获取唯一的32位字符串
	 * 
	 * @return
	 */
	public static String getUUID() {
		String str = UUID.randomUUID().toString();
		// 去掉"-"符号
		String uuid = str.substring(0, 8) + str.substring(9, 13) + str.substring(14, 18) + str.substring(19, 23)
				+ str.substring(24);
		return uuid;
	}

	/**
	 * 获取系统当时时间。时间格式：yyyy-MM-dd HH:mm:ss
	 * 
	 * @return 时间格式：yyyy-MM-dd HH:mm:ss
	 */
	public static String getCurrentDateTime() {
		Date currentTime = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String datetime = formatter.format(currentTime);
		return datetime;
	}

	/**
	 * 获取系统当时时间。时间格式：yyyy-MM-dd
	 * 
	 * @return 时间格式：yyyy-MM-dd
	 */
	public static String getCurrentDate() {
		Date currentTime = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String date = formatter.format(currentTime);
		return date;
	}

	/**
	 * MD5 加密
	 * 
	 * @param inStr
	 * @return
	 */
	public static String MD5(String inStr) {
		MessageDigest md5 = null;
		try {
			md5 = MessageDigest.getInstance("MD5");
		} catch (Exception e) {
			log.error(e, e);
			return "";
		}
		char[] charArray = inStr.toCharArray();
		byte[] byteArray = new byte[charArray.length];

		for (int i = 0; i < charArray.length; i++)
			byteArray[i] = (byte) charArray[i];
		byte[] md5Bytes = md5.digest(byteArray);
		StringBuffer hexValue = new StringBuffer();
		for (int i = 0; i < md5Bytes.length; i++) {
			int val = ((int) md5Bytes[i]) & 0xff;
			if (val < 16)
				hexValue.append("0");
			hexValue.append(Integer.toHexString(val));
		}
		return hexValue.toString();
	}

	/**
	 * 读取配置文件
	 * 
	 * @param filePath
	 *            配置文件路径
	 * @param key
	 *            键名
	 * @return 键值
	 */
	public static String readPropertiesValue(String filePath, String key) {
		Properties props = new Properties();
		try {
			String s = RixinUtil.class.getResource(filePath).getPath();
			InputStream in = new BufferedInputStream(new FileInputStream(s));
			props.load(in);
			String value = props.getProperty(key);
			return value;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	// 读取properties的全部信息
	public static List<String> readPropertiesKeys(String filePath) {
		Properties props = new Properties();
		List<String> propKeys = new ArrayList<String>();
		try {
			String s = RixinUtil.class.getResource(filePath).getPath();
			InputStream in = new BufferedInputStream(new FileInputStream(s));
			props.load(in);
			Enumeration en = props.propertyNames();
			// 在这里遍历
			while (en.hasMoreElements()) {
				String key = en.nextElement().toString();// key值
				propKeys.add(key);
			}
			return propKeys;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * jsp静态化 工具
	 * 
	 * @param request
	 * @param response
	 * @param url
	 *            需要静态化的页面
	 */
	public static void htmlStatic(HttpServletRequest request, HttpServletResponse response, String url,
			String htmlName) {
		if (htmlName != null) {
			response.setContentType("text/html; charset=utf-8");
			try {
				sc = request.getSession().getServletContext();
				log.debug("静态化开始");
				myService(url, request, response, htmlName);
				log.debug("静态化结束");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	public static synchronized void myService(String url, HttpServletRequest request, HttpServletResponse response,
			String htmlName) {
		String htmlPath = sc.getRealPath("/") + "html/";
		FileOutputStream fos = null;
		try {
			String name = htmlPath + htmlName + ".html";
			RequestDispatcher rd = sc.getRequestDispatcher("/" + url);
			final ByteArrayOutputStream os = new ByteArrayOutputStream();
			final ServletOutputStream stream = new ServletOutputStream() {
				public void write(byte[] data, int offset, int length) {
					os.write(data, offset, length);
				}

				public void write(int b) throws IOException {
					os.write(b);
				}
			};
			final PrintWriter pw = new PrintWriter(new OutputStreamWriter(os, "utf-8"));
			HttpServletResponse rep = new HttpServletResponseWrapper(response) {
				public ServletOutputStream getOutputStream() {
					return stream;
				}

				public PrintWriter getWriter() {
					return pw;
				}
			};
			rd.include(request, rep);
			pw.flush();
			log.debug("静态化文件路径：" + name);
			fos = new FileOutputStream(name);
			// 把jsp输出的内容写到xxx.htm
			os.writeTo(fos);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				fos.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 删除html文件夹里所有的文件
	 * 
	 * @param request
	 */
	public static boolean delAllFile(HttpServletRequest request) {
		boolean isSuccess = false;
		String path = request.getSession().getServletContext().getRealPath("/");
		String htmlPath = path + "html/";
		// 删除html文件夹内所有子文件
		File file = new File(htmlPath);
		if (file.exists()) {
			String[] tempList = file.list();
			if (tempList.length == 0) {
				return true;
			}
			File temp = null;
			for (int i = 0; i < tempList.length; i++) {
				if (htmlPath.endsWith(File.separator)) {
					temp = new File(htmlPath + tempList[i]);
				} else {
					temp = new File(htmlPath + File.separator + tempList[i]);
				}
				if (temp.isFile()) {
					isSuccess = temp.delete();
					if (!isSuccess) {
						return isSuccess;
					}
				}
			}
		}
		return isSuccess;
	}
}
