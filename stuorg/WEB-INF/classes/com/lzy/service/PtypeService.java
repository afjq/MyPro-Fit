package com.lzy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.lzy.domain.Ptype;
import com.lzy.mapper.PtypeMapper;

@Service(value = "PtypeService")
public class PtypeService {

	@Autowired
	private PtypeMapper ptypeMapper;

	@Transactional(propagation = Propagation.REQUIRED, readOnly = true)
	public List<Ptype> findAll() {
		System.out.println("PtypeService.findAll run....");
		try {
			return this.ptypeMapper.findAll();
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

	@Transactional(propagation = Propagation.REQUIRED, readOnly = true)
	public Ptype findById(Integer ptypeId) {
		System.out.println("PtypeService.findAll run....");
		try {
			return this.ptypeMapper.findById(ptypeId);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}
}
