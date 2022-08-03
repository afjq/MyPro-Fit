package com.lzy.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.lzy.domain.Filee;
import com.lzy.mapper.FileMapper;

@Service(value = "FileService")
public class FileService {

	@Autowired
	private FileMapper fileMapper;

//	根据通知ID查找文件
	@Transactional(propagation = Propagation.REQUIRED, readOnly = true)
	public List<Filee> findByNoticeId(Integer noticeId) {
		System.out.println("FileService.findByNoticeId run....");
		try {
			return this.fileMapper.findByNoticeId(noticeId);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

//	删除文件
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int delFile(Integer fileId) {
		System.out.println("FileService.delFile run....");
		try {
			return this.fileMapper.delFile(fileId);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

//	通过组织Id插入文件，文件上传时
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int save(@Param("file") Filee file) {
		System.out.println("FileService.save run....");
		try {
			return this.fileMapper.save(file);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

//	查找所有文件
	@Transactional(propagation = Propagation.REQUIRED, readOnly = true)
	public List<Filee> findAll() {
		System.out.println("FileService.findAll run....");
		try {
			return this.fileMapper.findAll();
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

//	通过文件原始名称查找文件
	@Transactional(propagation = Propagation.REQUIRED, readOnly = true)
	public Filee findById(Integer fileId) {
		System.out.println("FileService.findById run....");
		try {
			return this.fileMapper.findById(fileId);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}
}
