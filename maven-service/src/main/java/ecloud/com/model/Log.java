package ecloud.com.model;

import java.util.Date;

import ecloud.com.base.model.BaseModel;

public class Log extends BaseModel {

	private static final long serialVersionUID = 1024792477652984770L;

	private String userid;// 管理员id
	private Date createdate;// 日期
	private String content;// 日志内容
	private String operation;// 操作(主要是"添加"、"修改"、"删除")
	private String id;
	private String module;
	
	public String getModule() {
		return module;
	}

	public void setModule(String module) {
		this.module = module;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public Date getCreatedate() {
		return createdate;
	}

	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getOperation() {
		return operation;
	}

	public void setOperation(String operation) {
		this.operation = operation;
	}

	@Override
	public String toString() {
		return "Log [userid=" + userid + ", createdate=" + createdate + ", content=" + content + ", operation=" + operation + ", id=" + id
				+ ", module=" + module + "]";
	}
}
