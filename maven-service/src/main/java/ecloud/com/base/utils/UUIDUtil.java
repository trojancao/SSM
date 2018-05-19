/**
 * 
 */
package ecloud.com.base.utils;

import java.util.UUID;

/**
 * @author caoqiang
 *
 */
public class UUIDUtil {
	public static String getUUID() {
		return UUID.randomUUID().toString().trim().replace("-", "");
	}

}
