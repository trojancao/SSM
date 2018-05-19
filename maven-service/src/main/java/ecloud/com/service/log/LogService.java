package ecloud.com.service.log;

import ecloud.com.base.service.BaseService;
import ecloud.com.model.Log;

public interface LogService extends BaseService<Log>{
	/**
	 * 获取登录管理员ID
	 */
	public String getLoginUserId();
}
