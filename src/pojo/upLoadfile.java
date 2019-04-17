package pojo;

import java.sql.Timestamp;

public class upLoadfile {

	private Integer id;
	private Long userid;
	private String upName;
	private String path;
	private Timestamp createDate;
	private String userName;
	
	
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Long getUserid() {
		return userid;
	}
	public void setUserid(Long userid) {
		this.userid = userid;
	}
	public String getUpName() {
		return upName;
	}
	public void setUpName(String upName) {
		this.upName = upName;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public Timestamp getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Timestamp createDate) {
		this.createDate = createDate;
	}
	@Override
	public String toString() {
		return "upLoadfile [id=" + id + ", userid=" + userid + ", upName=" + upName + ", path=" + path + ", createDate="
				+ createDate + "]";
	}
	
	
	
	
	
}
