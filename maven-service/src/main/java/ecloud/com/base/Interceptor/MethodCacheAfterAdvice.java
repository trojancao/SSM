package ecloud.com.base.Interceptor;

import java.lang.reflect.Method;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.aop.AfterReturningAdvice;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.util.Assert;

import net.sf.ehcache.Cache;
public class MethodCacheAfterAdvice implements AfterReturningAdvice, InitializingBean {

	protected Logger logger = LoggerFactory.getLogger(getClass());
	private Cache cache;

	public void setCache(Cache cache) {
		this.cache = cache;
	}

	public MethodCacheAfterAdvice() {
		super();
	}

	/**
	 * 删除当前service下所有缓存
	 */
	public void afterReturning(Object arg0, Method arg1, Object[] arg2, Object arg3) throws Throwable {
		logger.info("========================================后置通知，cachename："+ cache.getName());
		 System.err.println("arg3"+arg3.getClass().getSimpleName());;
		String className = arg3.getClass().getSimpleName();
		
		List list = cache.getKeys();
		for (int i = 0; i < list.size(); i++) {
			String cacheKey = String.valueOf(list.get(i));
			logger.info("================cacheKey："+ cacheKey);
			if (cacheKey.startsWith(className)) {
				cache.remove(cacheKey);
				logger.info("remove cache " + cacheKey);
			}
		}
	}

	public void afterPropertiesSet() throws Exception {
		Assert.notNull(cache, "Need a cache. Please use setCache(Cache) create it.");
	}

}