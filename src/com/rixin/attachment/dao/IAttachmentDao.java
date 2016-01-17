package com.rixin.attachment.dao;

import java.util.List;

import com.rixin.attachment.model.Attachment;
import com.rixin.common.annotation.MyBatisDao;

/**
 * 附件DAO
 * 
 * @author himcz@163.com
 *
 */
@MyBatisDao
public interface IAttachmentDao {
	/**
	 * 批量添加附件
	 * 
	 * @param attachmentList
	 *            附件集合
	 * @return int
	 */
	int addAttchments(List<Attachment> attachmentList);

	/**
	 * 批量删除附件
	 * 
	 * @param attachmentList
	 *            附件集合
	 * @return int
	 */
	int deleteAttchments(List<Attachment> attachmentList);

	/**
	 * 通过业务数据ID获取附件
	 * 
	 * @param dataid
	 *            业务数据ID
	 * @return List<Attachment>
	 */
	List<Attachment> getAttchmentsByDataid(String dataid);

	/**
	 * 通过id获得附件信息
	 * 
	 * @param id
	 *            附件id
	 * @return Attachment
	 */
	Attachment getAttchmentById(String id);
}
