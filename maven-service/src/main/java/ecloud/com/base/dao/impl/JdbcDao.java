package ecloud.com.base.dao.impl;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;

import ecloud.com.base.model.BaseModel;

public class JdbcDao<T extends BaseModel> {
	@Resource
	private SqlSessionTemplate sqlSessionTemplate;
	  
    public T get(int id) {
        return sqlSessionTemplate.selectOne(this.getClass().getName() + ".get", id);
    }   
}
