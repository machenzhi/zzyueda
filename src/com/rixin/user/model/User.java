package com.rixin.user.model;

import java.io.Serializable;

/**
 * 值对象
 * 作用：保存数据
 * @author 陈玉竹
 *
 */
public class User implements Serializable {

	/**
	 *为了方便将结果集转换成对象，该类中的属性与表中字段一致。
 	 *为了能够封装页面上传入的null值，所有的属性都
 	 *使用封装类型。
	 */
	private static final long serialVersionUID = 1L;
	private String id;
	private String username;
	private String password;
	private String truename;
	private String age;
	private String sex;
	private String mobilephone;
	private String roleid;
	private String createdate;
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getMobilephone() {
		return mobilephone;
	}
	public void setMobilephone(String mobilephone) {
		this.mobilephone = mobilephone;
	}
	public String getRoleid() {
		return roleid;
	}
	public void setRoleid(String roleid) {
		this.roleid = roleid;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	private String nickname;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getTruename() {
		return truename;
	}
	public void setTruename(String truename) {
		this.truename = truename;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
}
