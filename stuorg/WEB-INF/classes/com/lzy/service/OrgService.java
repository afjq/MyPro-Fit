package com.lzy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.lzy.domain.Org;
import com.lzy.mapper.OrgMapper;

@Service(value = "OrgService")
public class OrgService {

	@Autowired
	private OrgMapper orgMapper;

//	查找所有组织
	@Transactional(propagation = Propagation.REQUIRED, readOnly = true)
	public List<Org> findAll() {
		System.out.println("OrgService.findAll run....");
		try {
			return this.orgMapper.findAll();
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

//	通过组织Id查找一个组织
	@Transactional(propagation = Propagation.REQUIRED, readOnly = true)
	public Org findById(Integer orgId) {
		System.out.println("OrgService.findById run....");
		try {
			return this.orgMapper.findById(orgId);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

//	插入一个组织
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int insertOrg(Org org) {
		System.out.println("OrgService.insertOrg run....");
		try {
			return this.orgMapper.insertOrg(org);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

//	通过id删除组织
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int delOrgById(Integer orgId) {
		System.out.println("OrgService.delOrgById run....");
		try {
			return this.orgMapper.delOrgById(orgId);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

//	通过id修改组织信息
//	多个参数@Param注解
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int updateOrg(Org org) {
		System.out.println("OrgService.updateById run....");
		try {
//			找到这个要修改的组织
//			Integer orgId = org.getOrgId();
//			Org org1 = this.orgMapper.findById(orgId);
//			org.setOrgName(org.getOrgName());
			int i = this.orgMapper.updateOrg(org);
			System.out.println(i);
			return i;
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}
}
