package com.lzy.domain;

import java.util.List;

import lombok.Data;
import lombok.ToString;

@Data // get set
@ToString // toString
public class Dep {
	private Integer depId;

	private String depName;
//	对一，一个部门只属于一个组织
	private Org depOrg;

//	一个部门下有多个成员
	private List<User> depUser;

//	一个部门下有多个成员
	private List<Admin> depAdmin;

	public Dep(Integer depId, String depName, Org depOrg, List<User> depUser, List<Admin> depAdmin) {
		super();
		this.depId = depId;
		this.depName = depName;
		this.depOrg = depOrg;
		this.depUser = depUser;
		this.depAdmin = depAdmin;
	}

	public Dep() {
		super();
	}

}