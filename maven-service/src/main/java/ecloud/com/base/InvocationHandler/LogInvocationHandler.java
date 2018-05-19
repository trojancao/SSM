package ecloud.com.base.InvocationHandler;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;
import java.util.Arrays;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * JDK 动态代理 加减乘除，JDK 代理<br/>
 * 只能代理接口,不能代理类
 * 
 */
public class LogInvocationHandler implements InvocationHandler {
	// 动态代理只有在运行时才知道代理谁，所以定义为Object类型
	private Object target; // 代理目标
	private Object proxy; // 代理对象
	protected Logger logger = LoggerFactory.getLogger(getClass());

	/**
	 * 通过构造函数传入原对象
	 * 
	 * @param target
	 *            要代理的对象
	 */
	public LogInvocationHandler(Object target) {
		this.target = target;
	}

	private static HashMap<Class<?>, LogInvocationHandler> invoHandlers = new HashMap<Class<?>, LogInvocationHandler>();

	private LogInvocationHandler() {
	}

	/** * 通过Class来生成动态代理对象Proxy * @param clazz * @return */
	public synchronized static <T> T getProxyInstance(Class<T> clazz) {
		LogInvocationHandler invoHandler = invoHandlers.get(clazz);
		if (null == invoHandler) {
			invoHandler = new LogInvocationHandler();
			try {
				T tar = clazz.newInstance();
				invoHandler.setTarget(tar);
				invoHandler.setProxy(Proxy.newProxyInstance(tar.getClass().getClassLoader(), tar.getClass().getInterfaces(), invoHandler));
			} catch (Exception e) {
				e.printStackTrace();
			}
			invoHandlers.put(clazz, invoHandler);
		}
		return (T) invoHandler.getProxy();
	}

	@Override
	public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {

		Object result = method.invoke(target, args); // 执行业务处理
		// 打印日志
		logger.info("____invoke method: " + method.getName() 
			+ "; args: " + (null == args ? "null" : Arrays.asList(args).toString()) 
			+ "; return: " + result);
		
		return result;
	}

	public Object getTarget() {
		return target;
	}

	public void setTarget(Object target) {
		this.target = target;
	}

	public Object getProxy() {
		return proxy;
	}

	public void setProxy(Object proxy) {
		this.proxy = proxy;
	}

}
