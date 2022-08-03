package com.lzy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.lzy.domain.Active;
import com.lzy.mapper.ActiveMapper;

@Service(value = "ActiveService")
public class ActiveService {
	@Autowired
	private ActiveMapper aciveMapper;

	@Transactional(propagation = Propagation.REQUIRED, readOnly = true)
	public List<Active> findAll() {
		System.out.println("AdminService.findByAdminNum run....");
		try {
			List<Active> active = this.aciveMapper.findAll();
			System.out.println("activeService找到的active：" + active);
			return active;
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}
}
