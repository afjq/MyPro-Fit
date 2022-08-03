package com.lzy.domain;

import java.util.List;

import lombok.Data;
import lombok.ToString;

@Data // get set
@ToString // toString
public class Ptype {
	private Integer ptypeId;

	private String ptypeName;
//	对多，一种场地类型下，可以有很多场地
	private List<Place> ptypePlace;

	public Ptype(Integer ptypeId, String ptypeName, List<Place> ptypePlace) {
		super();
		this.ptypeId = ptypeId;
		this.ptypeName = ptypeName;
		this.ptypePlace = ptypePlace;
	}

	public Ptype() {
		super();
	}

}