package ecloud.com.base.exception;

public class BusiException extends BaseException {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String code;
	
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public BusiException() {
		super();
	}

	public BusiException(String message) {
		super(message);
	}

	public BusiException(Throwable cause) {
		super(cause);
	}

	public BusiException(String message, Throwable cause) {
		super(message, cause);
	}
	public BusiException(String code, String message, Throwable cause) {
		super(message, cause);
		this.code = code;
	}
}
