package com.lzy.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;
import lombok.ToString;

@Data // get set
@ToString // toString
public class Pused {
	private Integer pusedId;

	private String pusedFor;

//	前端请求后台时
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
//	后台返回给前端时，@ResponseBody，可以代替日期配置文件 
//	如果没有设置timezone，默认为伦敦时间
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
	private Date pusedApplyTime;

//	前端请求后台时
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
//	后台返回给前端时，@ResponseBody，可以代替日期配置文件 
//	如果没有设置timezone，默认为伦敦时间
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
	private Date pusedAllowTime;

//	前端请求后台时
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
//	后台返回给前端时，@ResponseBody，可以代替日期配置文件 
//	如果没有设置timezone，默认为伦敦时间
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
	private Date pusedStartTime;

//	前端请求后台时
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
//	后台返回给前端时，@ResponseBody，可以代替日期配置文件 
//	如果没有设置timezone，默认为伦敦时间
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
	private Date pusedEndTime;

//   对一，申请的部门
	private Dep pusedDep;
//	对一，审批的老师
	private Admin pusedTeacher;
//	对一
	private Place pusedPlace;

	public Pused(Integer pusedId, String pusedFor, Date pusedApplyTime, Date pusedAllowTime, Date pusedStartTime,
			Date pusedEndTime, Dep pusedDep, Admin pusedTeacher, Place pusedPlace) {
		super();
		this.pusedId = pusedId;
		this.pusedFor = pusedFor;
		this.pusedApplyTime = pusedApplyTime;
		this.pusedAllowTime = pusedAllowTime;
		this.pusedStartTime = pusedStartTime;
		this.pusedEndTime = pusedEndTime;
		this.pusedDep = pusedDep;
		this.pusedTeacher = pusedTeacher;
		this.pusedPlace = pusedPlace;
	}

	public Pused() {
		super();
	}

}