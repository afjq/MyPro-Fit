package com.lzy.domain;

import lombok.Data;
import lombok.ToString;

@Data // get set
@ToString // toString
public class User {
	private Integer userId;

	private String userNum;

	private String userName;

	private String userPsw;
//	对一，一个成员只属于一个组织
	private Org userOrg;
//	对一，一个成员只属于一个部门
	private Dep userDep;
//	对一，一个成员只属于一个班级
	private Clas userClass;

	private String userPhone;

	private String userQq;

	private Byte userPermission;

	public User() {
		super();
	}

	public User(Integer userId, String userNum, String userName, String userPsw, Org userOrg, Dep userDep,
			Clas userClass, String userPhone, String userQq, Byte userPermission) {
		super();
		this.userId = userId;
		this.userNum = userNum;
		this.userName = userName;
		this.userPsw = userPsw;
		this.userOrg = userOrg;
		this.userDep = userDep;
		this.userClass = userClass;
		this.userPhone = userPhone;
		this.userQq = userQq;
		this.userPermission = userPermission;
	}

}