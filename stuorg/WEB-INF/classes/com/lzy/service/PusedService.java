package com.lzy.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.lzy.domain.Pused;
import com.lzy.mapper.PusedMapper;

@Service(value = "PusedService")
public class PusedService {
	@Autowired
	private PusedMapper pusedMapper;

	@Transactional(propagation = Propagation.REQUIRED, readOnly = true)
	public List<Pused> findByPlaceId(Integer placeId) {
		System.out.println("PusedService.findByPlaceId run....");
		try {
			return this.pusedMapper.findByPlaceId(placeId);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int insertPused(@Param("pused") Pused pused) {
		System.out.println("PusedService.findByPlaceId run....");
		try {
			return this.pusedMapper.insertPused(pused);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

}
