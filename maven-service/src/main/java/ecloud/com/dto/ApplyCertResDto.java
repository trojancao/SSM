package ecloud.com.dto;

/**
 * 申请CA证书返回信息
 * @author caoqiang
 *
 */
public class ApplyCertResDto {
	private String issuer;
	private String serialNumber;
	private String certNotBefore;
	private String certNotAfter;
	private String userName;

	public String getIssuer() {
		return issuer;
	}

	public void setIssuer(String issuer) {
		this.issuer = issuer;
	}

	public String getSerialNumber() {
		return serialNumber;
	}

	public void setSerialNumber(String serialNumber) {
		this.serialNumber = serialNumber;
	}

	public String getCertNotBefore() {
		return certNotBefore;
	}

	public void setCertNotBefore(String certNotBefore) {
		this.certNotBefore = certNotBefore;
	}

	public String getCertNotAfter() {
		return certNotAfter;
	}

	public void setCertNotAfter(String certNotAfter) {
		this.certNotAfter = certNotAfter;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	@Override
	public String toString() {
		return "ApplyCertResDto [issuer=" + issuer + ", serialNumber=" + serialNumber + ", certNotBefore="
				+ certNotBefore + ", certNotAfter=" + certNotAfter + ", userName=" + userName + "]";
	}

}
