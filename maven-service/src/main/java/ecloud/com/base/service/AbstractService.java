package ecloud.com.base.service;

import javax.annotation.Resource;

import org.springframework.cache.CacheManager;

import ecloud.com.base.model.BaseModel;
import ecloud.com.dao.ILogDao;
import ecloud.com.mapper.base.LogMapper;
import ecloud.com.mapper.base.UserMapper;

public abstract class AbstractService<T extends BaseModel> extends BaseServiceImpl<T>{
	@Resource
	protected CacheManager redisCacheManager;
	@Resource
	protected LogMapper logMapper;
	@Resource
	protected UserMapper userMapper;
	@Resource
	protected ILogDao iLogDao;
	
}
