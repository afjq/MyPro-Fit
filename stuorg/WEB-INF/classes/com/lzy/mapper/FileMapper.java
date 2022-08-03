package com.lzy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.lzy.domain.Filee;

@Mapper
public interface FileMapper {
//	根据通知ID查找文件
	List<Filee> findByNoticeId(Integer noticeId);

//	查找所有文件
	public List<Filee> findAll();

//	通过文件原始名称查找文件
	public Filee findById(Integer fileId);

//	文件上传
	int save(@Param("file") Filee file);

//	删除文件
	int delFile(Integer fileId);
}