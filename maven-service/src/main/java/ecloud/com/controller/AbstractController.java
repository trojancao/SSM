package ecloud.com.controller;

import ecloud.com.base.controller.BaseController;
import ecloud.com.base.model.BaseModel;
import ecloud.com.base.service.BaseServiceImpl;
import ecloud.com.dao.ILogDao;
import ecloud.com.mapper.base.LogMapper;
import ecloud.com.mapper.base.UserMapper;
import org.springframework.cache.CacheManager;

import javax.annotation.Resource;

public abstract class AbstractController<T extends BaseModel> extends BaseController<T>{
	@Resource
	protected CacheManager redisCacheManager;

}
