package ecloud.com.base.Interceptor;

import java.lang.reflect.Method;

import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.util.Assert;

import net.sf.ehcache.Cache;
import net.sf.ehcache.Element;

public class MethodCacheInterceptor implements MethodInterceptor, InitializingBean {
	public MethodCacheInterceptor() {
		// TODO Auto-generated constructor stub
	}

	private Cache cache;
	protected Logger logger = LoggerFactory.getLogger(getClass());

	/**
	 * @see MethodInterceptor#invoke(MethodInvocation)
	 */
	public Object invoke(MethodInvocation invocation) throws Throwable {
		Method method = invocation.getMethod();
		String methodName = method.getName();
		Object[] arguments = invocation.getArguments();
		Object result = null;
		String targetName = method.getDeclaringClass().getSimpleName();
		System.err.println(method.getDeclaringClass().getName());
		System.err.println(method.getDeclaringClass().getSimpleName());
		String key = getCacheKey(targetName, methodName, arguments);
		logger.info("cacheKey: {}", key);
		Element element = cache.get(key);

		if (element == null) {

			result = invocation.proceed();
			logger.info("第一次调用方法并缓存其值:" + result);
			cache.put(new Element(key, result));
		} else {
			result = element.getObjectValue();
			logger.info("从缓存中取得的值为：" + result);
		}
		return result;

	}

	/**
	 * implement InitializingBean， 检查 cache 是否为空
	 * 
	 * @throws Exception
	 */
	public void afterPropertiesSet() throws Exception {
		Assert.notNull(cache, "Need a cache. Please use setCache(Cache) create it.");

	}

	/**
	 * 生成缓存中的KEY值。
	 */
	protected String getCacheKey(String targetName, String methodName, Object[] arguments) {
		StringBuffer sb = new StringBuffer();
		sb.append(targetName).append(".").append(methodName);
		if ((arguments != null) && (arguments.length != 0)) {
			for (int i = 0; i < arguments.length; i++) {
				sb.append(".").append(arguments[i]);
			}
		}
		return sb.toString();
	}

	public void setCache(Cache cache) {
		this.cache = cache;
	}

}