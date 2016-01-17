package com.rixin.dictionary.dao;

import java.util.List;
import java.util.Map;

import com.rixin.common.annotation.MyBatisDao;
import com.rixin.dictionary.model.Dictionary;

@MyBatisDao
public interface IDictionaryDao {

	List<Dictionary> getDictionarysByPid(String pid);

	List<Dictionary> getVisibleDictionarysByPid(String pid);

	Dictionary getDictionaryById(String id);

	int addDictionary(Dictionary dictionary);

	int updateDictionaryById(Dictionary dictionary);

	int deleteDictionaryById(String id);

	int deleteDictionaryByPath(String abspath);

	List<Dictionary> getDictionarys();


	int getMaxId();

	List<Dictionary> getAllLastDictionarys();

	List<Dictionary> getAllDictionarys4InfoType();

	List<Dictionary> getAllFixedDictionarys();

	List<Dictionary> getLeftMenu(Map<String, Object> map);
}
