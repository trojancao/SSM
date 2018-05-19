package ecloud.com.base.utils;

import java.util.ResourceBundle;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

public class SystemConfig {

	final static String DEFAULT_FILE_NAME = "system";

	public static String getValue(String key) {
		ResourceBundle sysSetting = ResourceBundle.getBundle(DEFAULT_FILE_NAME);
		return sysSetting.getString(key);
	}
	public static HttpServletRequest getRequest() {
		return ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest(); 
		
	}
}
