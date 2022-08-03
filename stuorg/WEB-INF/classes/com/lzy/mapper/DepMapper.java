package com.lzy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.lzy.domain.Dep;

@Mapper
public interface DepMapper {
//	查找某组织下的所有部门
	List<Dep> findAll(Integer orgId);

//	通过部门id删除部门，不需要提供组织Id因为所有部门都在同一张表里，具有自己的唯一标识dep_id
	int delDepById(Integer depId);

//	根据部门Id修改一个部门名
	int updateDepById(@Param("depId") Integer depId, @Param("depName") String depName);

//	需要确定组织Id，给dep_org赋值
	int insertDep(@Param("depName") String depName, @Param("orgId") Integer orgId);

//	根据部门Id查找部门
	Dep findById(@Param("depId") Integer depId);
}