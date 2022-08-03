package com.lzy.domain;

import lombok.Data;
import lombok.ToString;

@Data // get set
@ToString // toString
public class Admin {
	private Integer adminId;

	private String adminNum;

	private String adminName;

	private String adminPsw;
//	对一
	private Org adminOrg;
//	对一
	private Dep adminDep;
//	对一
	private Clas adminClass;

	private String adminPhone;

	private String adminQq;

	private String adminPermission;

	public Admin(Integer adminId, String adminNum, String adminName, String adminPsw, Org adminOrg, Dep adminDep,
			Clas adminClass, String adminPhone, String adminQq, String adminPermission) {
		super();
		this.adminId = adminId;
		this.adminNum = adminNum;
		this.adminName = adminName;
		this.adminPsw = adminPsw;
		this.adminOrg = adminOrg;
		this.adminDep = adminDep;
		this.adminClass = adminClass;
		this.adminPhone = adminPhone;
		this.adminQq = adminQq;
		this.adminPermission = adminPermission;
	}

	public Admin() {
		super();
	}

}