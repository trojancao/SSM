package ecloud.com.exception;

import ecloud.com.base.exception.BaseException;

public class EcloudRuntimeException extends BaseException {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public EcloudRuntimeException() {
		super();
	}

	public EcloudRuntimeException(String message) {
		super(message);
	}

	public EcloudRuntimeException(Throwable cause) {
		super(cause);
	}

	public EcloudRuntimeException(String message, Throwable cause) {
		super(message, cause);
	}

}
