package com.rixin.attachment.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.rixin.attachment.dao.IAttachmentDao;
import com.rixin.attachment.model.Attachment;
import com.rixin.common.util.CompressPic;
import com.rixin.common.util.RixinUtil;

/**
 * 附件接口实现类
 * 
 * @author himcz@163.com
 *
 */
@Service("AttachmentServiceImpl")
public class AttachmentServiceImpl implements IAttachmentService {

	@Resource
	private IAttachmentDao attachmentDao;

	@Override
	public Map<String, Object> uploadFiles(String dataid, List<Attachment> oldAttachments,
			List<MultipartFile> uploadFiles, HttpServletRequest request) {
		String oldAttachmentIds = "";
		if (oldAttachments != null) {
			for (Attachment attachment : oldAttachments) {
				oldAttachmentIds += attachment.getId() + ",";
			}
		}
		// 需要删除的历史附件
		List<Attachment> delAttachmentList = new ArrayList<Attachment>();
		List<Attachment> attachments = getAttchmentsByDataid(dataid);
		for (Attachment attachment : attachments) {
			if (oldAttachmentIds.indexOf(attachment.getId()) == -1) {
				delAttachmentList.add(attachment);
			}
		}
		deleteAttchments(delAttachmentList, request);
		List<Attachment> addAttachmentList = new ArrayList<Attachment>();
		for (MultipartFile myfile : uploadFiles) {
			if (!myfile.isEmpty()) {
				String filename = myfile.getOriginalFilename();
				// 获取上传文件类型的扩展名
				String ext = filename.substring(filename.lastIndexOf(".") + 1);
				// 获取文件上传路径
				String realPath = request.getSession().getServletContext().getRealPath("/");
				String uploadFolder = "upload";
				String fileName = RixinUtil.getUUID() + "." + ext;
				String fileNameNew = uploadFolder + "/" + fileName;
				File targetFile = new File(realPath, fileNameNew);
				if (!targetFile.exists()) {
					targetFile.mkdirs();
				}
				try {
					myfile.transferTo(targetFile);
					// 生成图片压缩后的副本
					CompressPic mypic = new CompressPic();
					String compressPicPath = realPath + uploadFolder;
					compressPicPath = compressPicPath.replaceAll("\\\\", "\\\\\\\\");
					mypic.compressPic(compressPicPath + "\\\\\\\\", compressPicPath + "\\\\\\\\", fileName,
							fileName.replace(".", "_small."), 300, 300, true);
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
				Attachment att = new Attachment();
				att.setId(RixinUtil.getUUID());
				att.setName(filename);
				att.setDataid(dataid);
				att.setPath(fileNameNew);
				att.setSmallPath(fileNameNew.replace(".", "_small."));
				addAttachmentList.add(att);
			}
		}
		if (addAttachmentList.size() > 0) {
			addAttchments(addAttachmentList);
		}
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("attachmentList", addAttachmentList);
		return resultMap;
	}

	@Override
	public Map<String, Object> uploadSingleImg(String oldImgPath, MultipartFile uploadImg, HttpServletRequest request) {
		String newImgPath = "";
		// 上传了新图片
		if (!uploadImg.isEmpty()) {
			// 获取文件上传路径
			String realPath = request.getSession().getServletContext().getRealPath("/");
			if (!"img/default_user_img.png".equals(oldImgPath)) {
				String oldImgRealPath = realPath + "\\" + oldImgPath;
				File file = new File(oldImgRealPath);
				if (file.exists()) {
					file.delete();
				}
			}
			String filename = uploadImg.getOriginalFilename();
			// 获取上传文件类型的扩展名
			String ext = filename.substring(filename.lastIndexOf(".") + 1);
			String fileNameNew = "upload/" + RixinUtil.getUUID() + "." + ext;
			File targetFile = new File(realPath, fileNameNew);
			if (!targetFile.exists()) {
				targetFile.mkdirs();
			}
			try {
				uploadImg.transferTo(targetFile);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			newImgPath = fileNameNew;
		}
		// 传输页面所需参数
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("newImgPath", newImgPath);
		return resultMap;
	}

	@Override
	public void addAttchments(List<Attachment> attachmentList) {
		attachmentDao.addAttchments(attachmentList);
	}

	@Override
	public List<Attachment> getAttchmentsByDataid(String dataid) {
		List<Attachment> attachmentList = attachmentDao.getAttchmentsByDataid(dataid);
		return attachmentList;
	}

	@Override
	public void deleteAttchments(List<Attachment> delAttachmentList, HttpServletRequest request) {
		for (Attachment attachment : delAttachmentList) {
			String realPath = request.getSession().getServletContext().getRealPath("/") + "\\" + attachment.getPath();
			File file = new File(realPath);
			String realSmallPath = request.getSession().getServletContext().getRealPath("/") + "\\"
					+ attachment.getSmallPath();
			File file_small = new File(realSmallPath);
			if (file.exists()) {
				file.delete();
			}
			if (file_small.exists()) {
				file_small.delete();
			}
		}
		if (delAttachmentList.size() > 0) {
			attachmentDao.deleteAttchments(delAttachmentList);
		}
	}

	@Override
	public void deleteAttchmentByDataIds(String dataIds, HttpServletRequest request) {
		String[] dataIdArray = dataIds.split(",");
		for (String dataId : dataIdArray) {
			List<Attachment> attachments = getAttchmentsByDataid(dataId);
			deleteAttchments(attachments, request);
		}
	}

	@Override
	public Attachment getAttchmentById(String id) {
		Attachment attachment = attachmentDao.getAttchmentById(id);
		return attachment;
	}

	@Override
	public List<Attachment> getImgAttchmentsByDataid(String dataId) {
		List<Attachment> imgAttachments = new ArrayList<Attachment>();
		List<Attachment> attachments = getAttchmentsByDataid(dataId);
		for (Attachment att : attachments) {
			// 获取附件中的图片附件
			if (att.getPath().indexOf(".png") > -1 || att.getPath().indexOf(".jpg") > -1) {
				imgAttachments.add(att);
			}
		}
		return imgAttachments;
	}
}
