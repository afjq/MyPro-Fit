package com.lzy.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.lzy.domain.Admin;

@Mapper
public interface AdminMapper {

//	管理员登录，根据adminNum查找管理员
	Admin findByAdminNum(@Param("adminNum") String adminNum);

//	根据ID查找
//	Admin findById(Integer adminId);
}