package com.lzy.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.lzy.domain.User;
import com.lzy.mapper.UserMapper;

@Service(value = "UserService")
public class UserService {
	@Autowired
	private UserMapper userMapper;

//	根据User的Num学号查找User的pwd
	@Transactional(propagation = Propagation.REQUIRED, readOnly = true)
	public User findByNum(@Param("userNum") String userNum) {
		System.out.println("UserService.findByNum run....");
		try {
			User user = this.userMapper.findByNum(userNum);
			System.out.println("UserService找到的User：" + user);
			return user;
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

//	根据部门Id查找User
	@Transactional(propagation = Propagation.REQUIRED, readOnly = true)
	public List<User> findByDepId(@Param("depId") Integer depId) {
		System.out.println("UserService.findByDepId run....");
		try {
			return this.userMapper.findByDepId(depId);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

//	根据用户Id查找User
	@Transactional(propagation = Propagation.REQUIRED, readOnly = true)
	public User findById(@Param("userId") Integer userId) {
		System.out.println("UserService.findById run....");
		try {
			return this.userMapper.findById(userId);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

//	根据用户Id删除一个用户
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int delUser(@Param("userId") Integer userId) {
		System.out.println("UserService.delUser run....");
		try {
			return this.userMapper.delUser(userId);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

//	插入一个用户,@Param注释没事加上好用一点，省得找错误找半天
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int insertUser(@Param("user") User user) {
		System.out.println("UserService.insertUser run....");
		try {
			return this.userMapper.insertUser(user);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

//	通过用户Id更新用户信息
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int updateById(@Param("user") User user) {
		System.out.println("UserService.updateById run....");
		try {
			return this.userMapper.updateById(user);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

}
