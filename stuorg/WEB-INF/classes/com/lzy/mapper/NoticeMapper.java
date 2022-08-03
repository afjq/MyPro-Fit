package com.lzy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.lzy.domain.Notice;

@Mapper
public interface NoticeMapper {

	List<Notice> findAll();

//	通过noticeId删除Notice
	int delById(Integer noticeId);

//	发布notice：插入
	int insertNotice(@Param("notice") Notice notice);

//	查找最新的noticeId
	Notice findMaxId();
}