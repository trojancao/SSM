package ecloud.com.base.dto;
/** 
 * @ClassName: JsonResp
 * @Description: Json返回对象
 */
public class JsonResp{

	/** 
	* @Fields success : 请求是否成功
	* <p>
	* 1：成功
	* 0：失败
	* </p>
	*/ 
	private int result;
	
	private String code;
	/** 
	* @Fields error_msg : 请求错误信息
	* <p>
	* 成功时为空,失败时会返回失败信息
	* </p>
	*/ 
	private String msg = "";
	private Object data;
	
	
	public Object getData() {
		return data;
	}

	public void setData(Object data) {
		this.data = data;
	}

	public JsonResp() {
		this.result = 1;
	}
	
	public JsonResp(int _result, String _code, String _msg,Object data) {
		this.result = _result;
		this.code = _code;
		this.msg = _msg;
		this.data = data;
	}

	/**
	 * @return the result
	 */
	public int getResult() {
		return result;
	}

	/**
	 * @param result the result to set
	 */
	public void setResult(int result) {
		this.result = result;
	}

	/**
	 * @return the code
	 */
	public String getCode() {
		return code;
	}

	/**
	 * @param code the code to set
	 */
	public void setCode(String code) {
		this.code = code;
	}

	/**
	 * @return the msg
	 */
	public String getMsg() {
		return msg;
	}

	/**
	 * @param msg the msg to set
	 */
	public void setMsg(String msg) {
		this.msg = msg;
	}

}
