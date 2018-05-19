package ecloud.com.base.controller;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cache.CacheManager;

import ecloud.com.base.model.BaseModel;
import ecloud.com.base.service.BaseService;
import ecloud.com.service.log.LogService;
import net.sf.ehcache.Cache;

public abstract class BaseController<T extends BaseModel> {

	protected abstract Class<T> getInstanceClass();
	protected Logger logger = LoggerFactory.getLogger(getInstanceClass());
	protected abstract BaseService<T> getBaseService();
	@Resource
	protected LogService logService;
	@Resource
	protected CacheManager redisCacheManager;
	@Resource
	protected Cache myCache;

	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	protected Map getRequestParams(HttpServletRequest request) {

		Map map = new HashMap();
		Enumeration names = request.getParameterNames();
		while (names.hasMoreElements()) {
			String paramName = (String) names.nextElement();

			String paramValue = request.getParameter(paramName);
			// 形成键值对应的map
			map.put(paramName, paramValue);
		}
		return map;
	}
}
