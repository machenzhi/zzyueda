package com.rixin.attachment.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rixin.attachment.model.Attachment;
import com.rixin.attachment.service.IAttachmentService;

/**
 * 附件控件器
 * 
 * @author himcz@163.com
 */
@Controller
@RequestMapping("/attachment")
public class AttachmentController {
	@Resource
	@Qualifier("AttachmentServiceImpl")
	private IAttachmentService attachmentService;

	/**
	 * 下载附件
	 * 
	 * @param id
	 *            附件id
	 * @param request
	 *            HttpServletRequest
	 * @param response
	 *            HttpServletResponse
	 * @throws Exception
	 */
	@RequestMapping("/download.do")
	public void download(String id, HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("UTF-8");
		java.io.BufferedInputStream bis = null;
		java.io.BufferedOutputStream bos = null;
		String ctxPath = request.getSession().getServletContext().getRealPath("/");
		Attachment attachment = attachmentService.getAttchmentById(id);
		String downLoadPath = ctxPath + attachment.getPath();
		try {
			long fileLength = new File(downLoadPath).length();
			response.setContentType("application/x-msdownload;");
			// response.setHeader("Content-disposition", "attachment; filename="
			// + new String(attachment.getName().getBytes("utf-8"),
			// "ISO8859-1"));
			response.setHeader("Content-disposition", "attachment; filename="
					+ new String(attachment.getPath().getBytes("utf-8"), "ISO8859-1"));
			response.setHeader("Content-Length", String.valueOf(fileLength));
			bis = new BufferedInputStream(new FileInputStream(downLoadPath));
			bos = new BufferedOutputStream(response.getOutputStream());
			byte[] buff = new byte[2048];
			int bytesRead;
			while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
				bos.write(buff, 0, bytesRead);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (bis != null)
				bis.close();
			if (bos != null)
				bos.close();
		}
	}

}
