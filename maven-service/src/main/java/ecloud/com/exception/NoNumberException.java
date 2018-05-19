package ecloud.com.exception;

import ecloud.com.base.exception.BaseException;

public class NoNumberException extends BaseException {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public NoNumberException() {
		super();
	}

	public NoNumberException(String message) {
		super(message);
	}

	public NoNumberException(Throwable cause) {
		super(cause);
	}

	public NoNumberException(String message, Throwable cause) {
		super(message, cause);
	}

}
