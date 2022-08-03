package com.lzy.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;
import lombok.ToString;

@Data // get set
@ToString // toString
public class Active {
	private Integer activeId;
//	对一
	private User activePerson;

	private String activeContent;

	private String activePicture;

//	active_random
	private String activeRandom;

//	前端请求后台时
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
//	后台返回给前端时，@ResponseBody，可以代替日期配置文件 
//	如果没有设置timezone，默认为伦敦时间
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
	private Date activeTime;

	public Active() {
		super();
	}

	public Active(Integer activeId, User activePerson, String activeContent, String activePicture, String activeRandom,
			Date activeTime) {
		super();
		this.activeId = activeId;
		this.activePerson = activePerson;
		this.activeContent = activeContent;
		this.activePicture = activePicture;
		this.activeRandom = activeRandom;
		this.activeTime = activeTime;
	}

}