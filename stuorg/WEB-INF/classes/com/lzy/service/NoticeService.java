package com.lzy.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.lzy.domain.Notice;
import com.lzy.mapper.NoticeMapper;

@Service(value = "NoticeService")
public class NoticeService {

	@Autowired
	private NoticeMapper noticeMapper;

//	查找最新的noticeId
	@Transactional(propagation = Propagation.REQUIRED, readOnly = true)
	public Notice findMaxId() {
		System.out.println("NoticeService.findMaxId run....");
		try {
			return this.noticeMapper.findMaxId();
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

//	查找所有文件
	@Transactional(propagation = Propagation.REQUIRED, readOnly = true)
	public List<Notice> findAll() {
		System.out.println("NoticeService.findAll run....");
		try {
			return this.noticeMapper.findAll();
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

//	通过noticeId删除Notice
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int delById(Integer noticeId) {
		System.out.println("NoticeService.delById run....");
		try {
			return this.noticeMapper.delById(noticeId);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

//	发布notice：插入
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int insertNotice(@Param("notice") Notice notice) {
		System.out.println("NoticeService.insertNotice run....");
		try {
			return this.noticeMapper.insertNotice(notice);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}
}
