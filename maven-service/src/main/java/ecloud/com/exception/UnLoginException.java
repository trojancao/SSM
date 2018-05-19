package ecloud.com.exception;

import ecloud.com.base.exception.BaseException;

public class UnLoginException extends BaseException {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public UnLoginException() {
		super();
	}

	public UnLoginException(String message) {
		super(message);
	}

	public UnLoginException(Throwable cause) {
		super(cause);
	}

	public UnLoginException(String message, Throwable cause) {
		super(message, cause);
	}

}
