package com.lzy.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;
import lombok.ToString;

@Data // get set
@ToString // toString
public class Comment {
	private Integer commentId;
//	对一个活动
	private Active commentActive;
//	对一
	private User commentPerson;
//	前端请求后台时
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
//	后台返回给前端时，@ResponseBody，可以代替日期配置文件 
//	如果没有设置timezone，默认为伦敦时间
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
	private Date commentTime;

	private String commentContent;

	public Comment(Integer commentId, Active commentActive, User commentPerson, Date commentTime,
			String commentContent) {
		super();
		this.commentId = commentId;
		this.commentActive = commentActive;
		this.commentPerson = commentPerson;
		this.commentTime = commentTime;
		this.commentContent = commentContent;
	}

	public Comment() {
		super();
	}

}