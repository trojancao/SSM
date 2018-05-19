package ecloud.com.base.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.transaction.annotation.Transactional;

import ecloud.com.base.annotation.MyCacheable;
import ecloud.com.base.annotation.SystemLog;
import ecloud.com.base.dao.IBusiBaseDao;
import ecloud.com.base.model.BaseModel;
import ecloud.com.base.model.PageBean;
import ecloud.com.base.redis.RedisGeneratorDao;
import ecloud.com.mapper.base.SqlMapper;

public abstract class BaseServiceImpl<T extends BaseModel> extends RedisGeneratorDao implements BaseService<T> {

	protected Logger logger = LoggerFactory.getLogger(getInstanceClass());
	
	protected abstract Class<T> getInstanceClass();

	protected abstract IBusiBaseDao<T> getBaseDao();

	protected abstract SqlMapper<T> getSqlMapper();
	
	@MyCacheable
	public <E> E selectByPrimaryKey(String id) throws Exception {
		return getBaseDao().selectByPrimaryKey(id);
	}

	/**
	 * 
	 * @param params
	 * @return <E> 声明返回类型
	 * @throws Exception
	 */
	@Override
	@MyCacheable
	public <E> List<E> queryForList(Map<String, Object> params) throws Exception {
		logger.debug("3#################################BaseServiceImpl.queryForList");
		return getBaseDao().queryForList(params);
	}
	@Override
	@MyCacheable
	@SystemLog(module="日志查询",description="BaseServiceImpl分页查询日志",methods="queryForPage",operation="查询")
	public <E> PageBean<E> queryForPage(Map<String, Object> params,int pageSize,int pageNum) throws Exception {
		PageBean<E> pageBean = new PageBean<E>();
		pageBean.setPageNum(pageNum);
		pageBean.setPageSize(pageSize);
		pageBean.setQueryCondition(params);
		return getBaseDao().queryForPage(pageBean);
	}
	
	
	/**
	 * insert 根据实体类名查找sqlid
	 * BaseModel entity/T entity 都可以
	 */
	@Override
	@Transactional
	public int insertSelective(T entity) throws Exception {
		logger.info("################ getBaseDao() " + getInstanceClass().getName());
		return getBaseDao().insertSelective(entity);
	}

	/**
	 * sqlmapper方式插入表数据
	 * BaseModel entity/T entity 都可以
	 */
	@Transactional
	public int insert(T entity) throws Exception {
		logger.info("################getSqlMapper() " + getInstanceClass().getName());
		return getSqlMapper().insertSelective(entity);
	}

	public T selectByKey(String id) {
		logger.info("################getSqlMapper() " + getInstanceClass().getName());
		return getSqlMapper().selectByPrimaryKey(id);
	}
}
