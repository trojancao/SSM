package ecloud.com.base.Interceptor;

import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;
import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ecloud.com.base.annotation.SystemLog;

/**
 * aop拦截器 打印方法的输入参数及返回数据（由配置advice来决定拦截哪些方法）
 * 
 */
public class BaseMethodInterceptor implements MethodInterceptor {
	protected Logger logger = LoggerFactory.getLogger(getClass());
	private final static ObjectMapper jsonMapper = new ObjectMapper();

	public Object invoke(MethodInvocation methodInvocation) throws Throwable {
		logger.info("Before: interceptor name: {}", methodInvocation.getMethod());
		logger.info("Arguments: {}", jsonMapper.writeValueAsString(methodInvocation.getArguments()));

		// 执行被拦截的方法，切记，如果此方法不调用，则被拦截的方法不会被执行。
		Object result = methodInvocation.proceed();
//		logger.info("After: result: {}", jsonMapper.writeValueAsString(result));

		// 判断该方法是否加了@LotteryLog 注解
		if (methodInvocation.getMethod().isAnnotationPresent(SystemLog.class)) {
			logger.info("----------this method is added @LoginRequired-------------------------");
		}

		return result;
	}

}