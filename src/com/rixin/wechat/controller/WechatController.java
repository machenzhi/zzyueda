package com.rixin.wechat.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.rixin.wechat.service.IWechatService;
import com.rixin.wechat.util.SHA1;

/**
 * 核心请求处理类
 * 
 * @author 马晨智
 *
 */
@Controller
@RequestMapping("/wechat")
public class WechatController {
	@Resource
	@Qualifier("WechatServiceImpl")
	private IWechatService wechatService;

	private String token = "yueda";// 公众平台上，开发者设置的token
	private String encodingAesKey = "GQnO3hnNuriaXfr1Qefd9ANF5iMt73SlRPogxfwOxgS";// 公众平台上，开发者设置的EncodingAESKey
	private String appId = "wx2a3a8d40027d9253"; // 公众平台appid

	/**
	 * 确认请求来自微信服务器
	 * 
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value = { "/coreJoin.do" }, method = RequestMethod.GET)
	public void coreJoinGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 微信加密签名
		String signature = request.getParameter("signature");
		// 随机字符串
		String echostr = request.getParameter("echostr");
		// 时间戳
		String timestamp = request.getParameter("timestamp");
		// 随机数
		String nonce = request.getParameter("nonce");
		String[] str = { token, timestamp, nonce };
		Arrays.sort(str); // 字典序排序
		String bigStr = str[0] + str[1] + str[2];
		// SHA1加密
		String digest = SHA1.getSHA1(bigStr).toLowerCase();
		// 确认请求来至微信
		if (digest.equals(signature)) {
			response.getWriter().print(echostr);
		}
	}

	/**
	 * 处理微信服务器发来的消息
	 * 
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value = { "/coreJoin.do" }, method = RequestMethod.POST)
	public void coreJoinPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 将请求、响应的编码均设置为UTF-8（防止中文乱码）
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");

		// 微信加密签名
		// String msg_signature = request.getParameter("msg_signature");
		// // 时间戳
		// String timestamp = request.getParameter("timestamp");
		// // 随机数
		// String nonce = request.getParameter("nonce");
		//
		// // 从请求中读取整个post数据
		// InputStream inputStream = request.getInputStream();
		// String postData = IOUtils.toString(inputStream, "UTF-8");
		// System.out.println(postData);
		//
		// String msg = "";
		// WXBizMsgCrypt wxcpt = null;
		// try {
		// wxcpt = new WXBizMsgCrypt(token, encodingAesKey, appId);
		// // 解密消息
		// msg = wxcpt.decryptMsg(msg_signature, timestamp, nonce, postData);
		// } catch (AesException e) {
		// e.printStackTrace();
		// }
		// System.out.println("msg=" + msg);

		// 调用核心业务类接收消息、处理消息
		String respMessage = wechatService.processRequest(request);
		System.out.println("respMessage=" + respMessage);

		// String encryptMsg = "";
		// try {
		// // 加密回复消息
		// encryptMsg = wxcpt.encryptMsg(respMessage, timestamp, nonce);
		// } catch (AesException e) {
		// e.printStackTrace();
		// }

		// 响应消息
		PrintWriter out = response.getWriter();
		// out.print(encryptMsg);
		out.print(respMessage);
		out.close();

	}

}
