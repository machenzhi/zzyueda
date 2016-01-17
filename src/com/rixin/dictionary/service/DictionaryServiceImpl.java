package com.rixin.dictionary.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rixin.dictionary.dao.IDictionaryDao;
import com.rixin.dictionary.model.Dictionary;

@Service("DictionaryServiceImpl")
public class DictionaryServiceImpl implements IDictionaryService {

	@Autowired
	private IDictionaryDao dictionaryDao;

	public List<Dictionary> getDictionarysByPid(String pid) {
		List<Dictionary> dictionaryList = dictionaryDao.getDictionarysByPid(pid);
		return dictionaryList;
	}

	public JSONArray getAllDictionarys4JsonByPid(String pid) {
		JSONArray jsonArray = new JSONArray();
		List<Dictionary> dictionaryList = dictionaryDao.getDictionarysByPid(pid);
		for (Dictionary dictionary : dictionaryList) {
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("id", dictionary.getId());
			jsonObj.put("text", dictionary.getName());
			jsonObj.put("name", dictionary.getName());
			jsonObj.put("visible", dictionary.getVisible());
			jsonObj.put("isinfo", dictionary.getIsinfo());
			jsonObj.put("url", dictionary.getUrl());
			jsonObj.put("css", dictionary.getCss());
			jsonObj.put("sort", dictionary.getSort());
			jsonObj.put("pid", dictionary.getPid());
			jsonObj.put("abspath", dictionary.getAbspath());
			JSONArray jsonArrayTemp = getAllDictionarys4JsonByPid(dictionary.getId());
			if (!jsonArrayTemp.isEmpty()) {
				jsonObj.put("children", jsonArrayTemp);
			}
			jsonArray.add(jsonObj);
		}
		return jsonArray;
	}

	public JSONArray getAllVisibleDictionarys4JsonByPid(String pid) {
		JSONArray jsonArray = new JSONArray();
		List<Dictionary> dictionaryList = dictionaryDao.getVisibleDictionarysByPid(pid);
		for (Dictionary dictionary : dictionaryList) {
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("id", dictionary.getId());
			jsonObj.put("text", dictionary.getName());
			jsonObj.put("name", dictionary.getName());
			jsonObj.put("visible", dictionary.getVisible());
			jsonObj.put("isinfo", dictionary.getIsinfo());
			jsonObj.put("url", dictionary.getUrl());
			jsonObj.put("css", dictionary.getCss());
			jsonObj.put("sort", dictionary.getSort());
			jsonObj.put("pid", dictionary.getPid());
			jsonObj.put("abspath", dictionary.getAbspath());
			JSONArray jsonArrayTemp = getAllVisibleDictionarys4JsonByPid(dictionary.getId());
			if (!jsonArrayTemp.isEmpty()) {
				jsonObj.put("children", jsonArrayTemp);
			}
			jsonArray.add(jsonObj);
		}
		return jsonArray;
	}

	/**
	 * 根据ID查询字典信息，显示一条记录
	 */
	public Dictionary getDictionaryById(String id) {
		Dictionary dictionary = dictionaryDao.getDictionaryById(id);
		return dictionary;
	}

	/**
	 * 新增字典信息
	 */
	public boolean addDictionary(Dictionary dictionary) {
		boolean isSuccess = true;
		int num = 0;
		try {
			num = dictionaryDao.addDictionary(dictionary);
		} catch (Exception e) {
			e.printStackTrace();
			isSuccess = false;
			return isSuccess;
		}
		return isSuccess;
	}

	/**
	 * 根据ID更新字典信息
	 */
	public boolean updateDictionaryById(Dictionary dictionary) {
		boolean isSuccess = true;
		int num = 0;
		try {
			num = dictionaryDao.updateDictionaryById(dictionary);
		} catch (Exception e) {
			e.printStackTrace();
			isSuccess = false;
			return isSuccess;
		}
		return isSuccess;
	}

	/**
	 * 根据ID删除字典信息
	 */
	public boolean deleteDictionaryById(String id) {
		boolean isSuccess = true;
		int num = 0;
		try {
			num = dictionaryDao.deleteDictionaryById(id);
		} catch (Exception e) {
			e.printStackTrace();
			isSuccess = false;
			return isSuccess;
		}
		return isSuccess;
	}

	/**
	 * 根据abspath删除本级和子集的信息
	 */
	public boolean deleteDictionaryByPath(String abspath) {
		boolean isSuccess = true;
		int num = 0;
		try {
			num = dictionaryDao.deleteDictionaryByPath(abspath);
		} catch (Exception e) {
			e.printStackTrace();
			isSuccess = false;
			return isSuccess;
		}
		return isSuccess;
	}

	public List<Dictionary> getDictionarys() {
		List<Dictionary> dictionaryList = dictionaryDao.getDictionarys();
		return dictionaryList;
	}

	public int getMaxId() {
		int count = dictionaryDao.getMaxId();
		return count;
	}

	public List<Dictionary> getAllLastDictionarys() {
		List<Dictionary> dictionaryList = dictionaryDao.getAllLastDictionarys();
		return dictionaryList;
	}

	public List<Dictionary> getAllDictionarys4InfoType() {
		List<Dictionary> dictionaryList = dictionaryDao.getAllDictionarys4InfoType();
		return dictionaryList;
	}

	public void getMenu(HttpServletRequest request) {
		JSONArray array = getAllVisibleDictionarys4JsonByPid("0");
		request.setAttribute("dictionarys", array);
	}

	// 查询左侧菜单
	public List<Dictionary> getLeftMenu(Map<String, Object> map) {
		List<Dictionary> menuList = dictionaryDao.getLeftMenu(map);
		return menuList;
	}
}
