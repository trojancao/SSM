package ecloud.com.base.dao;

import java.util.List;
import java.util.Map;

import ecloud.com.base.model.BaseModel;
import ecloud.com.base.model.PageBean;

public interface IBusiBaseDao<T extends BaseModel> {
	
	public int insertSelective(BaseModel entity) throws Exception;
	<E> E selectByPrimaryKey(String id) throws Exception;
	int updateSelective(BaseModel entity) throws Exception;
	<E> List<E> queryForList(Map<String, Object> params) throws Exception;
	<E> PageBean<E> queryForPage(PageBean<E> pageBean) throws Exception;
}
