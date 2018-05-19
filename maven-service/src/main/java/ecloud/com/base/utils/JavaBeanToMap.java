package ecloud.com.base.utils;

import java.beans.PropertyDescriptor;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.beanutils.PropertyUtilsBean;
import org.apache.commons.lang3.StringUtils;

/**
 * 将javabean转换成Map
 * @author xlj
 *
 */
public class JavaBeanToMap {

	/**
	 * 将javaBean转换成Map
	 * @param obj
	 * @return
	 */
	public static Map<String,Object> getMapByBean(Object obj) {
		Map<String,Object> map=new HashMap<String, Object>(0);
		try {
			PropertyUtilsBean propertyUtilsBean=new PropertyUtilsBean();
			PropertyDescriptor[] propertyDescriptor=propertyUtilsBean.getPropertyDescriptors(obj);
			for (PropertyDescriptor property: propertyDescriptor) {
				String name=property.getName();
				if(!StringUtils.equals(name,"class")){
					map.put(name, propertyUtilsBean.getNestedProperty(obj,name));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
}
