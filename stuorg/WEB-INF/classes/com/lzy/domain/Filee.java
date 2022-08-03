package com.lzy.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;
import lombok.ToString;

@Data // get set
@ToString // toString
public class Filee {
	private Integer fileId;

	private String fileName;

	private String fileRandom;
//	对一：上传者：管理员
	private Admin fileUploader;
//	对一：上传部门
	private Dep fileDep;
//	对一 一个文件属于一个通知
	private Notice fileNotice;
//	前端请求后台时
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
//	后台返回给前端时，@ResponseBody，可以代替日期配置文件 
//	如果没有设置timezone，默认为伦敦时间
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
	private Date fileDate;

	public Filee(Integer fileId, String fileName, String fileRandom, Admin fileUploader, Dep fileDep, Date fileDate) {
		super();
		this.fileId = fileId;
		this.fileName = fileName;
		this.fileRandom = fileRandom;
		this.fileUploader = fileUploader;
		this.fileDep = fileDep;
		this.fileDate = fileDate;
	}

	public Filee() {
		super();
	}

}