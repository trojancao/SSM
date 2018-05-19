package ecloud.com.base.cache;

import java.lang.reflect.Method;

import org.springframework.cache.interceptor.KeyGenerator;

public class CustomKeyGenerator implements KeyGenerator {

	public Object generate(Object o, Method method, Object... objects) {
		StringBuilder sb = new StringBuilder();
		sb.append(o.getClass().getSimpleName()).append(".");
		sb.append(method.getName());
		for (Object obj : objects) {
			sb.append("|");
			sb.append(obj.toString());
		}
		return sb.toString();
	}
}
