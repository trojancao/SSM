package ecloud.com.base.Interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * aop拦截器 打印方法的输入参数及返回数据（由配置advice来决定拦截哪些方法）
 * 
 */
public class PrintParamsInterceptor extends BaseInterceptor{
	protected Logger logger = LoggerFactory.getLogger(getClass());
	private final static ObjectMapper jsonMapper = new ObjectMapper();
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		logger.info("request:uri->params:{}->{}",request.getRequestURI(),jsonMapper.writeValueAsString(request.getParameterMap()));
		return true;
	}
	
//	@Override
//	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		
//		logger.info("response:{}",modelAndView.getModelMap().toString());
		
//	}
}