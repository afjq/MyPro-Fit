package com.lzy.service;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.lzy.domain.Admin;
import com.lzy.mapper.AdminMapper;

@Service(value = "AdminService")
public class AdminService {
	@Autowired
	private AdminMapper adminMapper;

//	管理员登录，根据adminNum查找管理员
	@Transactional(propagation = Propagation.REQUIRED, readOnly = true)
	public Admin findByAdminNum(@Param("adminNum") String adminNum) {
		System.out.println("AdminService.findByAdminNum run....");
		try {
			Admin admin = this.adminMapper.findByAdminNum(adminNum);
			System.out.println("AdminService找到的admin：" + admin);
			return admin;
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}
}
