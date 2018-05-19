package ecloud.com.model;

public class LogVO extends Log {
	private String version;

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}

	@Override
	public String toString() {
		return "LogVO [getVersion()=" + getVersion() + ", getModule()=" + getModule() + ", getId()=" + getId() + ", getUserid()=" + getUserid()
				+ ", getCreatedate()=" + getCreatedate() + ", getContent()=" + getContent() + ", getOperation()=" + getOperation() + ", toString()="
				+ super.toString() + ", getClass()=" + getClass() + ", hashCode()=" + hashCode() + "]";
	}

}
