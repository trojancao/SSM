package ecloud.com.base.dao.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;

import ecloud.com.base.model.BaseModel;

public class BaseDao<T extends BaseModel> extends SqlSessionDaoSupport {

	// 使用SqlSessionDaoSupport必须注意，此处源码1.1.1中有自动注入，1.2中取消了自动注入，需要手工注入，侵入性强
	// 也可在spring-mybatis.xml中如下配置，但是这种有多少个dao就要配置到少个，多个dao就很麻烦。
	// <bean id="userDao" class="com.hua.saf.dao.UserDao">
	// <property name="sqlSessionFactory" ref="sqlSessionFactory"/>
	// </bean>
	@Autowired
	public void setSqlSessionFactory(SqlSessionFactory sqlSessionFactory) {
		super.setSqlSessionFactory(sqlSessionFactory);
	}

	public int insert(String classMethod, BaseModel entity) throws Exception {
		int count = 0;
		try {
			count = this.getSqlSession().insert(classMethod, entity);
		} catch (Exception e) {
			throw e;
		}
		return count;
	}

	public int update(String classMethod, BaseModel entity) throws Exception {
		int count = 0;
		try {
			count = this.getSqlSession().update(classMethod, entity);
		} catch (Exception e) {
			throw e;
		}
		return count;
	}

	@SuppressWarnings("unchecked")
	public T selectOne(String classMethod, BaseModel entity) throws Exception {
		T result = null;
		try {
			result = (T) this.getSqlSession().selectOne(classMethod, entity);
		} catch (Exception e) {
			throw e;
		}
		return result;
	}

	public List<T> queryForList(String classMethod, Map<String, Object> map) throws Exception {
		List<T> result = new ArrayList<T>();
		try {
			result = this.getSqlSession().selectList(classMethod, map);
		} catch (Exception e) {
			throw e;
		}
		return result;
	}

	public int remove(String classMethod, BaseModel entity) throws Exception {
		int count = 0;
		try {
			count = this.getSqlSession().delete(classMethod, entity);
		} catch (Exception e) {
			throw e;
		}
		return count;
	}
}
