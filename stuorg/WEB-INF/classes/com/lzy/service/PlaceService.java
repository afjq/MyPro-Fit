package com.lzy.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.lzy.domain.Place;
import com.lzy.mapper.PlaceMapper;

@Service(value = "PlaceService")
public class PlaceService {
	@Autowired
	private PlaceMapper placeMapper;

//	通过场地ID查找
	@Transactional(propagation = Propagation.REQUIRED, readOnly = true)
	public Place findById(Integer placeId) {
		System.out.println("PlaceService.updateById run....");
		try {
			return this.placeMapper.findById(placeId);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

//	通过场地ID修改场地
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int updateById(Integer placeId) {
		System.out.println("PlaceService.updateById run....");
		try {
			return this.placeMapper.updateById(placeId);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

//	通过场地ID删除场地
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int delById(Integer placeId) {
		System.out.println("PlaceService.delById run....");
		try {
			return this.placeMapper.delById(placeId);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

//	新增场地
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int insertPlace(@Param("place") Place place) {
		System.out.println("PlaceService.insertPlace run....");
		try {
			return this.placeMapper.insertPlace(place);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

//	通过场地类型ID查找场地
	@Transactional(propagation = Propagation.REQUIRED, readOnly = true)
	public List<Place> findByPtypeId(Integer ptypeId) {
		System.out.println("PlaceService.updateById run....");
		try {
			return this.placeMapper.findByPtypeId(ptypeId);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

}
