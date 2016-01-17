package com.rixin.attachment.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import com.rixin.attachment.model.Attachment;

/**
 * 附件接口
 * 
 * @author himcz@163.com
 *
 */
public interface IAttachmentService {
	/**
	 * 上传文件（可以是单个或者多个）
	 * 
	 * @param dataid
	 *            业务数据ID
	 * @param oldAttachments
	 *            更新后的历史附件ID。ID之间用英文逗号分隔，如：123,abc,444
	 * @param uploadFiles
	 *            上传文件数组
	 * @param request
	 *            HttpServletRequest
	 * @return Map<String, Object>
	 */
	Map<String, Object> uploadFiles(String dataid, List<Attachment> oldAttachments, List<MultipartFile> uploadFiles,
			HttpServletRequest request) throws Exception;

	/**
	 * 上传单个图片（新图片会覆盖旧图片）
	 * 
	 * @param oldImgPath
	 *            旧图片路径
	 * @param uploadImg
	 *            新上传图片文件
	 * @param request
	 *            HttpServletRequest
	 * @return Map<String, Object>
	 */
	Map<String, Object> uploadSingleImg(String oldImgPath, MultipartFile uploadImg, HttpServletRequest request)
			throws Exception;

	/**
	 * 批量添加附件
	 * 
	 * @param attachmentList
	 * @throws Exception
	 */
	void addAttchments(List<Attachment> attachmentList) throws Exception;

	/**
	 * 批量删除附件
	 * 
	 * @param delAttachmentList
	 * @param request
	 * @throws Exception
	 */
	void deleteAttchments(List<Attachment> delAttachmentList, HttpServletRequest request) throws Exception;

	/**
	 * 通过外键删除附件
	 * 
	 * @param dataIds
	 * @param request
	 * @throws Exception
	 */
	void deleteAttchmentByDataIds(String dataIds, HttpServletRequest request) throws Exception;

	/**
	 * 通过外键获得附件相关信息
	 * 
	 * @param dataid
	 * @return
	 */
	List<Attachment> getAttchmentsByDataid(String dataid);

	/**
	 * 根据附件id获取附件
	 * 
	 * @param id
	 * @return
	 */
	Attachment getAttchmentById(String id);

	List<Attachment> getImgAttchmentsByDataid(String dataId);
}
