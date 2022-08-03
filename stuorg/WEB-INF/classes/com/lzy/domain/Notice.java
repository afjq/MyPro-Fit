package com.lzy.domain;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;
import lombok.ToString;

@Data // get set
@ToString // toString
public class Notice {
	private Integer noticeId;

//	notice_title
	private String noticeTitle;

	private String noticeContent;
//	前端请求后台时
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
//	后台返回给前端时，@ResponseBody，可以代替日期配置文件 
//	如果没有设置timezone，默认为伦敦时间
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
	private Date noticeTime;
//	对一，由一个人发布
	private Admin noticePerson;
//	对一，由一个部门发出
	private Dep noticeDep;

//	对多，一个通知里可以附带多个文件
	private List<Filee> noticeFile;

	public Notice() {
		super();
	}

	public Notice(Integer noticeId, String noticeTitle, String noticeContent, Date noticeTime, Admin noticePerson,
			Dep noticeDep, List<Filee> noticeFile) {
		super();
		this.noticeId = noticeId;
		this.noticeTitle = noticeTitle;
		this.noticeContent = noticeContent;
		this.noticeTime = noticeTime;
		this.noticePerson = noticePerson;
		this.noticeDep = noticeDep;
		this.noticeFile = noticeFile;
	}

}