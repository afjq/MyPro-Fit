package com.lzy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.lzy.domain.User;

@Mapper
public interface UserMapper {
//	根据User的Num学号查找User的pwd
	User findByNum(@Param("userNum") String userNum);

//	根据部门Id查找User
	List<User> findByDepId(@Param("depId") Integer depId);

//	根据用户Id查找User
	User findById(@Param("userId") Integer userId);

//	根据用户Id删除一个用户
	int delUser(@Param("userId") Integer userId);

//	插入一个用户,@Param注释没事加上好用一点，省得找错误找半天
	int insertUser(@Param("user") User user);

//	通过用户Id更新用户信息
	int updateById(@Param("user") User user);
}