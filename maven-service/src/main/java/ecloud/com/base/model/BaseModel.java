package ecloud.com.base.model;

import java.io.Serializable;

public abstract class BaseModel implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8355306973460642850L;

	/**
	 * 将对象字符串化
	 */
	@Override
	public abstract String toString();

}
