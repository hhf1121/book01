package pojo;

import java.sql.Timestamp;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotEmpty;

public class User {

	private Long id;
	@NotEmpty(message="账号不能为空")
	private String userName;
	@NotEmpty(message="密码不能为空")
	private String passWord;
	private String name;
	private String address;
	private Integer yes;//权限、默认0。
	private String yesText;//权限、默认0。
	private Timestamp createDate;
	private String picPath;//头像路径。

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Integer getYes() {
		return yes;
	}

	public void setYes(Integer yes) {
		this.yes = yes;
	}

	public String getYesText() {
		return yesText;
	}

	public void setYesText(String yesText) {
		this.yesText = yesText;
	}

	public String getPicPath() {
		return picPath;
	}
	public void setPicPath(String picPath) {
		this.picPath = picPath;
	}

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public Timestamp getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Timestamp createDate) {
		this.createDate = createDate;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassWord() {
		return passWord;
	}
	public void setPassWord(String password) {
		this.passWord = password;
	}
	@Override
	public String toString() {
		return "User [id=" + id + ", userName=" + userName + ", passWord=" + passWord + ", name=" + name + ", address="
				+ address + ", yes=" + yes + ", createDate=" + createDate + ", picPath=" + picPath + "]";
	}



}
