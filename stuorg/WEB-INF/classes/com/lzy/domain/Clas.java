package com.lzy.domain;

import java.util.List;

import lombok.Data;
import lombok.ToString;

@Data // get set
@ToString // toString
public class Clas {

	private Integer classId;

	private String className;
//	对多，一个班级有多个成员
	private List<User> userOfClass;

//	对多，一个班级有多个管理员
	private List<Admin> adminOfClass;

	public Clas(Integer classId, String className, List<User> userOfClass, List<Admin> adminOfClass) {
		super();
		this.classId = classId;
		this.className = className;
		this.userOfClass = userOfClass;
		this.adminOfClass = adminOfClass;
	}

	public Clas() {
		super();
	}

}