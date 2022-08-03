package com.lzy.domain;

import java.util.List;

import lombok.Data;
import lombok.ToString;

@Data // get set
@ToString // toString
public class Org {
	private Integer orgId;

	private String orgName;
//	对多，一个组织下有多个部门
	private List<Dep> orgDep;

	public Org(Integer orgId, String orgName, List<Dep> orgDep) {
		super();
		this.orgId = orgId;
		this.orgName = orgName;
		this.orgDep = orgDep;
	}

	public Org() {
		super();
	}

}