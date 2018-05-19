package ecloud.com.base.aop;

import ecloud.com.base.annotation.SystemLog;
import ecloud.com.model.Log;
import ecloud.com.service.log.LogService;
import ecloud.common.utils.IdGenerator;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.lang.reflect.Method;
import java.util.Date;

/**
 * 用于注解@SystemLog，添加操作日志
 * 
 * @author caoqiang
 *
 */
@Aspect
//@Component
public class LogAspect {

	protected Logger logger = LoggerFactory.getLogger(getClass());
	@Resource
	LogService logService;// 日志记录Service
	private ObjectMapper jsonMapper = new ObjectMapper();
	private String DEFAULT_LOGIN = "adminUserId";

	/**
	 * 添加业务逻辑方法切入点
	 */
	@Pointcut("@annotation(ecloud.com.base.annotation.SystemLog)")
	public void insertServiceCall() {
		System.out.println("#####################################方法执行后执行insertServiceCall.....");
	}


	/**
	 * 管理员添加操作日志(后置通知)
	 * 
	 * @param joinPoint
	 * @throws Throwable
	 */
	@AfterReturning(value="insertServiceCall()")
	public void insertServiceCallCalls(JoinPoint joinPoint) throws Throwable {
		logger.info("2#####################################后置通知，添加操作日志");
		// 获取登录管理员id
		String adminUserId = DEFAULT_LOGIN;

		// 获取方法名
		String methodName = joinPoint.getSignature().getName();
		// 获取类名
		String targetName = joinPoint.getTarget().getClass().getSimpleName();
		String sourceLocation = joinPoint.getSourceLocation().toString();

		// 获取操作内容
		String opContent = targetName.concat("|").concat(methodName).concat("|").concat(jsonMapper.writeValueAsString(joinPoint.getArgs()));

		String[] module = getServiceMthodDescription(joinPoint);
		// 创建日志对象
		Log log = new Log();
		log.setUserid(adminUserId);// 设置管理员id
		log.setCreatedate(new Date());// 操作时间
		log.setContent(opContent);// 操作内容
		log.setOperation(module[1]);// 操作
		log.setId(IdGenerator.idGenerator());
//		log.setId(UUIDUtil.getUUID());
		log.setModule(module[0]);

		logService.insertSelective(log);// 添加日志
	}


	/**
	 * 异常通知 用于拦截service层记录异常日志
	 * 
	 * @param joinPoint
	 * @param e
	 * @throws Exception
	 */
	@AfterThrowing(pointcut = "insertServiceCall()", throwing = "e")
	public void doAfterThrowing(JoinPoint joinPoint, Throwable e) throws Exception {
		logger.info("serviceAspect———-doAfterThrowing");
		logger.error(e.getMessage(),e);

		// 获取登录管理员id
		String adminUserId = DEFAULT_LOGIN;

		// 获取方法名
		String methodName = joinPoint.getSignature().getName();
		// 获取类名
		String targetName = joinPoint.getTarget().getClass().getName();
		String sourceLocation = joinPoint.getSourceLocation().toString();

		// 获取操作内容
		String opContent = targetName.concat("|").concat(methodName).concat("|").concat(jsonMapper.writeValueAsString(joinPoint.getArgs())).concat("|异常|").concat(e.getMessage());

		String[] module = getServiceMthodDescription(joinPoint);
		// 创建日志对象
		Log log = new Log();
		log.setUserid(adminUserId);// 设置管理员id
		log.setCreatedate(new Date());// 操作时间
		log.setContent(opContent);// 操作内容
		log.setOperation(module[1]);// 操作
		log.setId(IdGenerator.idGenerator());
//		log.setId(UUIDUtil.getUUID());
		log.setModule(module[0]);

		logService.insert(log);// 添加日志
	}

	/**
	 * 获取注解中对方法的描述信息 用于注解@SystemLog
	 * 方法不能包含重载方法
	 * 
	 * @param joinPoint
	 *            切点
	 * @return 方法描述
	 * @throws Exception
	 */
	private String[] getServiceMthodDescription(JoinPoint joinPoint) throws Exception {
		String targetName = joinPoint.getTarget().getClass().getName();
		String methodName = joinPoint.getSignature().getName();
		Object[] arguments = joinPoint.getArgs();
		Class targetClass = Class.forName(targetName);
		Method[] methods = targetClass.getMethods();
		String[] module = new String[2];
		for (Method method : methods) {
			if (method.getName().equals(methodName)) {
				Class[] clazzs = method.getParameterTypes();
				if (clazzs.length == arguments.length) {
					module[0] = method.getAnnotation(SystemLog.class).module();
					module[1] = method.getAnnotation(SystemLog.class).operation();
					break;
				}
			}
		}
		return module;
	}
	//action 用
//	private String[] getServiceMthodDescription(JoinPoint joinPoint) throws Exception {
//		MethodSignature method = (MethodSignature) joinPoint.getSignature();
//		String[] module = new String[2];
//		module[0] = method.getMethod().getAnnotation(SystemLog.class).module();
//		module[1] = method.getMethod().getAnnotation(SystemLog.class).operation();
//		return module;
//	}
}
