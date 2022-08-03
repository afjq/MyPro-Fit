package com.lzy.domain;

import lombok.Data;
import lombok.ToString;

@Data // get set
@ToString // toString
public class Place {
	private Integer placeId;

	private String placeName;

	private Integer placeCapacity;

	private Byte placeUsed;
//	对一，一个场地属于一种类型	
	private Ptype placeType;

	public Place(Integer placeId, String placeName, Integer placeCapacity, Byte placeUsed) {
		super();
		this.placeId = placeId;
		this.placeName = placeName;
		this.placeCapacity = placeCapacity;
		this.placeUsed = placeUsed;
	}

	public Place() {
		super();
	}
}