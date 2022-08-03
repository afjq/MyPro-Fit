package com.lzy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.lzy.domain.Org;

@Mapper
public interface OrgMapper {
//	查找所有组织
	List<Org> findAll();

//	通过组织Id查找一个组织
	Org findById(Integer orgId);

//	插入一个组织
	int insertOrg(Org org);

//	通过id删除组织
	int delOrgById(Integer orgId);

//	通过id修改组织信息
//	多个参数@Param注解
	int updateOrg(Org org);
}