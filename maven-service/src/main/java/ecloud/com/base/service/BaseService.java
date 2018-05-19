package ecloud.com.base.service;

import ecloud.com.base.model.BaseModel;
import ecloud.com.base.model.PageBean;

import java.util.List;
import java.util.Map;

public interface BaseService<T extends BaseModel> {

    int insertSelective(T entity) throws Exception;

    int insert(T entity) throws Exception;

    <E> E selectByPrimaryKey(String id) throws Exception;

    <E> PageBean<E> queryForPage(Map<String, Object> params, int pageSize, int pageNum) throws Exception;

    <E> List<E> queryForList(Map<String, Object> params) throws Exception;

    T selectByKey(String id);
}
