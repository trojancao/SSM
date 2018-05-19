package ecloud.com.base.model;

public class RequestModel {
	private String timestamp;
	private String appKey;
	private String v;
	private String info;
	public String getTimestamp() {
		return timestamp;
	}
	public void setTimestamp(String timestamp) {
		this.timestamp = timestamp;
	}
	public String getAppKey() {
		return appKey;
	}
	public void setAppKey(String appKey) {
		this.appKey = appKey;
	}
	public String getV() {
		return v;
	}
	public void setV(String v) {
		this.v = v;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	@Override
	public String toString() {
		return "RequestModel [timestamp=" + timestamp + ", appKey=" + appKey + ", v=" + v + ", info=" + info + "]";
	}

}
