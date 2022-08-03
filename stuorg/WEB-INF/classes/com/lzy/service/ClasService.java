package com.lzy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.lzy.domain.Clas;
import com.lzy.mapper.ClasMapper;

@Service(value = "ClasService")
public class ClasService {
	@Autowired
	ClasMapper clasMapper;

//	单纯查找所有班级
	@Transactional(propagation = Propagation.REQUIRED, readOnly = true)
	public List<Clas> findAll() {
		System.out.println("ClasService.findAll run....");
		try {
			return this.clasMapper.findAll();
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

//	根据Id找一个班级
	@Transactional(propagation = Propagation.REQUIRED, readOnly = true)
	public Clas findById(Integer classId) {
		System.out.println("ClasService.findById run....");
		try {
			return this.clasMapper.findById(classId);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}
}
