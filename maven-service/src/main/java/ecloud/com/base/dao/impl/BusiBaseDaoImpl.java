package ecloud.com.base.dao.impl;

import com.github.pagehelper.PageHelper;
import ecloud.com.base.dao.IBusiBaseDao;
import ecloud.com.base.model.BaseModel;
import ecloud.com.base.model.PageBean;

import java.util.List;
import java.util.Map;

public abstract class BusiBaseDaoImpl<T extends BaseModel> extends BaseDao<T> implements IBusiBaseDao<T> {

	protected abstract Class<?> getEClass();

	protected String getClassName() {
		return getEClass().getName();
	}

	
	public <E> E selectByPrimaryKey(String id) throws Exception {
		return this.getSqlSession().selectOne(getSelectSqlMapId(), id);
	}

	
	public int insertSelective(BaseModel entity) throws Exception {
		System.err.println("getStatement" + getStatement(getInsertSqlMapId()));
		System.err.println("参数：" + entity.toString());
		return this.getSqlSession().insert(getInsertSqlMapId(), entity);
	}

	
	public int updateSelective(BaseModel entity) throws Exception {
		return this.getSqlSession().update(getUpdateSqlMapId(), entity);
	}

	private String getUpdateSqlMapId() {
		return getClassName().concat(".updateSelective");
	}

	private String getSelectSqlMapId() {
		return getClassName().concat(".selectByPrimaryKey");
	}

	private String getInsertSqlMapId() {
		return getClassName().concat(".insertSelective");
	}

	public <E> List<E> queryForList(Map<String, Object> params) throws Exception {
		return this.getSqlSession().selectList(getStatement(SQL_QUERYFORLIST), params);
	}

	public <E> PageBean<E> queryForPage(PageBean<E> pageBean) throws Exception{
		PageHelper.startPage(pageBean.getPageNum(), pageBean.getPageSize());
		List<E> list = queryForList(pageBean.getQueryCondition());
		pageBean.setList(list);
		return pageBean;
	}
	private final static String SQL_QUERYFORLIST = "queryForList";
	protected String getStatement(String sqlId) {
		// 决定了mapper.xml namespace中的值
		String name = this.getClass().getName();
		StringBuilder sb = new StringBuilder();
		sb.append(name).append(".").append(sqlId);
		return sb.toString();
	}
}
