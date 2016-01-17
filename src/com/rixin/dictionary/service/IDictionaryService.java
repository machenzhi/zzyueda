package com.rixin.dictionary.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import com.rixin.dictionary.model.Dictionary;

public interface IDictionaryService {
	/**
	 * 根据pid查询字典信息
	 * 
	 * @param pid
	 * @return List<Dictionary>
	 */
	List<Dictionary> getDictionarysByPid(String pid);

	/**
	 * 根据pid查询字典信息
	 * 
	 * @param pid
	 * @return JSONArray
	 */
	JSONArray getAllDictionarys4JsonByPid(String pid);

	Dictionary getDictionaryById(String id);

	boolean addDictionary(Dictionary dictionary);

	boolean updateDictionaryById(Dictionary dictionary);

	boolean deleteDictionaryById(String id);

	boolean deleteDictionaryByPath(String abspath);

	List<Dictionary> getDictionarys();

	int getMaxId();

	List<Dictionary> getAllLastDictionarys();

	List<Dictionary> getAllDictionarys4InfoType();

	/**
	 * 获取导航栏菜单
	 * 
	 * @param model
	 */
	void getMenu(HttpServletRequest request);

	List<Dictionary> getLeftMenu(Map<String, Object> map);

}
