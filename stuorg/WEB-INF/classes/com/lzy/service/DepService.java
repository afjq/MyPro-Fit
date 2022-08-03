package com.lzy.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.lzy.domain.Dep;
import com.lzy.mapper.DepMapper;

@Service(value = "DepService")
public class DepService {
	@Autowired
	private DepMapper depMapper;

//	查找某组织下的所有部门
	@Transactional(propagation = Propagation.REQUIRED, readOnly = true)
	public List<Dep> findAll(Integer orgId) {
		System.out.println("DepService.findAll run....");
		try {
			return this.depMapper.findAll(orgId);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

//	通过部门id删除部门，不需要提供组织Id因为所有部门都在同一张表里，具有自己的唯一标识dep_id
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int delDepById(Integer depId) {
		System.out.println("DepService.delDepById run....");
		try {
			return this.depMapper.delDepById(depId);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

//	根据部门Id修改一个部门名
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int updateDepById(@Param("depId") Integer depId, @Param("depName") String depName) {
		System.out.println("DepService.updateDepById run....");
		try {
			return this.depMapper.updateDepById(depId, depName);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

//	需要确定组织Id，给dep_org赋值
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int insertDep(@Param("depName") String depName, @Param("orgId") Integer orgId) {
		System.out.println("DepService.insertDep run....");
		try {
			return this.depMapper.insertDep(depName, orgId);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

//	根据部门Id查找部门
	@Transactional(propagation = Propagation.REQUIRED, readOnly = true)
	public Dep findById(Integer depId) {
		System.out.println("DepService.findById run....");
		try {
			return this.depMapper.findById(depId);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}
}
